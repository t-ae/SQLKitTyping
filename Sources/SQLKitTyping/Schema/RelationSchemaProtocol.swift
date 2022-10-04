import Foundation

protocol RelationSchemaProtocol: SchemaProtocol {
    associatedtype ID1: IDType
    associatedtype ID2: IDType
    var relation: PivotJoinRelation<Self, ID1, ID2> { get }
}

public struct PivotJoinRelation<RelationSchema: SchemaProtocol,
                                FromID: IDType,
                                ToID: IDType> {
    var schema: RelationSchema
    var from: KeyPath<RelationSchema, TypedSQLColumn<RelationSchema, FromID>>
    var to: KeyPath<RelationSchema, TypedSQLColumn<RelationSchema, ToID>>
    public init(
        _ through: RelationSchema,
        from: KeyPath<RelationSchema, TypedSQLColumn<RelationSchema, FromID>>,
        to: KeyPath<RelationSchema, TypedSQLColumn<RelationSchema, ToID>>
    ) {
        self.schema = through
        self.from = from
        self.to = to
    }

    var swapped: PivotJoinRelation<RelationSchema, ToID, FromID> {
        .init(schema, from: to, to: from)
    }
}
