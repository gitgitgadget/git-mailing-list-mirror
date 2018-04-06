Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D071F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDFTJw (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:09:52 -0400
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:53886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751543AbeDFTJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8n/w/waS/QbdeOPTEhjBLyKHQE8uHKZpKVliXd1o+cM=;
 b=fPi8S+gmlbxWJO0+d20QBqrQDYNGutIIkS3nPoEDvllGgiHLdNHcazRfjr7yTsjB5XvWPzkZPF7pb2vvxRTWBmSK4tfi9BNJOW3Djuucc7FLgy/ipnb1eEi8VdFXIl897zreglJPifPJpGUh4o38dcd7jJ+IORiAP/WOsZdAATs=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1108.namprd21.prod.outlook.com (52.132.24.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Fri, 6 Apr 2018 19:09:47 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.000; Fri, 6 Apr 2018
 19:09:47 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 4/4] commit-graph: lazy-load trees for commits
Thread-Topic: [PATCH v2 4/4] commit-graph: lazy-load trees for commits
Thread-Index: AQHTzdrT/0nhjuEbSUWG04Ig+JUoDg==
Date:   Fri, 6 Apr 2018 19:09:46 +0000
Message-ID: <20180406190919.167092-5-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
In-Reply-To: <20180406190919.167092-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:400:4::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1108;7:xNEF5HDokLkJrIjJMWtEmdf4ETAHDkA2Vh+t/JT060qqHQ5pKO5MzbBcxVM0tDtX4pN73oHuvAKJIE8HNwsGfmb6aMEkd0zQ2oyGxbylF08R0hXbjW5c4r2rrYc3fz3F659igVDhq/lkY6Bydq00GWjgZ2udOsfS98f4oxT9e9cdo5NB6paxcWZUS10rD9+B1l0W5Ka01KX5Hbd2ezLAnesR7jXjLYOLwI35UNAj8fUBmiy8N/cIdhUQDTguG9X8;20:Z2qAaDJ1yZq9M7rKA1Pvxp79EN40ZMNVyoFhFYdu13uy5ndyK24RtJ1PjHcEuD99b5i70t3pxJIJF3ayPXkOBUauiE7KRBT5pPkwhzu94YYe3+9TxLT2PnD3DsRw7TngCRczRBTblWGhwoYURGGqABEnp+gnp2igeahWNndTYcw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c74c4eb2-5f76-438c-07f3-08d59bf1f3bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1108;
x-ms-traffictypediagnostic: BL0PR2101MB1108:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1108181428F499861EAC1359A1BA0@BL0PR2101MB1108.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1108;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1108;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(22452003)(105586002)(316002)(2906002)(2501003)(5250100002)(76176011)(59450400001)(25786009)(54906003)(3280700002)(106356001)(3660700001)(14454004)(102836004)(486006)(46003)(478600001)(52116002)(99286004)(4326008)(5660300001)(6506007)(386003)(2616005)(446003)(11346002)(10290500003)(476003)(86362001)(186003)(6486002)(2900100001)(97736004)(107886003)(39060400002)(5640700003)(6436002)(36756003)(8656006)(10090500001)(305945005)(7736002)(8676002)(6116002)(6916009)(53936002)(8936002)(1076002)(81166006)(1730700003)(86612001)(81156014)(6512007)(2351001)(68736007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1108;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7KkJZIxqd54vZ7FY764VTQyKHcYe+vUrK2bQQ+b9wU92YPTghIoHAhXffT8llW+sHOi389hrJGPy5y9MkqzigNDhre7Esw4PdpCXmOwwQUYTyLz3JfXg3t72XqlZ7cJju+jiuPdpR+sBB8tuxKxHuE6LmxHyuwxAs88VKojMc+ve3b+GTuV9jzjQ2mt1EvTGwzEKX2MsZoBKRQMSrQmsFmEmRwtzMrknNFXf06iuNwSZBuyrMAOd+likHGIhIR6zOwZq7F9lGIb/scLcwcDH8uI8fNs4f7mMX0XHz86Q4EA4/z+i+AIuBb8NLUaoqmCPKDqgHBEnVhzXvgL4WfLRPvqCLQw/s7O0XPGVfJE9RYuQzd7wBxihCYIMegA2ZdUDEjLd/ELD01O8zXUDxOui7Ks6nywEv8lVabBt4lSOu54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74c4eb2-5f76-438c-07f3-08d59bf1f3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 19:09:47.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file provides quick access to commit data, including
the OID of the root tree for each commit in the graph. When performing
a deep commit-graph walk, we may not need to load most of the trees
for these commits.

Delay loading the tree object for a commit loaded from the graph
until requested via get_commit_tree(). Do not lazy-load trees for
commits not in the graph, since that requires duplicate parsing
and the relative peformance improvement when trees are not needed
is small.

On the Linux repository, performance tests were run for the following
command:

    git log --graph --oneline -1000

    Before: 0.92s
    After:  0.66s
    Rel %: -28.3%

Adding '-- kernel/' to the command requires loading the root tree
for every commit that is walked. There was no measureable performance
change as a result of this patch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 26 +++++++++++++++++++++++---
 commit-graph.h |  2 ++
 commit.c       |  8 +++++++-
 commit.h       |  6 ++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9f37d84209..a5de6f3102 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -247,7 +247,6 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
=20
 static int fill_commit_in_graph(struct commit *item, struct commit_graph *=
g, uint32_t pos)
 {
-	struct object_id oid;
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
@@ -257,8 +256,7 @@ static int fill_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	item->object.parsed =3D 1;
 	item->graph_pos =3D pos;
=20
-	hashcpy(oid.hash, commit_data);
-	item->maybe_tree =3D lookup_tree(&oid);
+	item->maybe_tree =3D NULL;
=20
 	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low =3D get_be32(commit_data + g->hash_len + 12);
@@ -317,6 +315,28 @@ int parse_commit_in_graph(struct commit *item)
 	return 0;
 }
=20
+static struct tree *load_tree_for_commit(struct commit_graph *g, struct co=
mmit *c)
+{
+	struct object_id oid;
+	const unsigned char *commit_data =3D g->chunk_commit_data +
+					   GRAPH_DATA_WIDTH * (c->graph_pos);
+
+	hashcpy(oid.hash, commit_data);
+	c->maybe_tree =3D lookup_tree(&oid);
+
+	return c->maybe_tree;
+}
+
+struct tree *get_commit_tree_in_graph(const struct commit *c)
+{
+	if (c->maybe_tree)
+		return c->maybe_tree;
+	if (c->graph_pos =3D=3D COMMIT_NOT_FROM_GRAPH)
+		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
+
+	return load_tree_for_commit(commit_graph, (struct commit *)c);
+}
+
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
 				     int nr_commits)
diff --git a/commit-graph.h b/commit-graph.h
index e1d8580c98..260a468e73 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -17,6 +17,8 @@ char *get_commit_graph_filename(const char *obj_dir);
  */
 int parse_commit_in_graph(struct commit *item);
=20
+struct tree *get_commit_tree_in_graph(const struct commit *c);
+
 struct commit_graph {
 	int graph_fd;
=20
diff --git a/commit.c b/commit.c
index aea2ca1f8b..711f674c18 100644
--- a/commit.c
+++ b/commit.c
@@ -298,7 +298,13 @@ void free_commit_buffer(struct commit *commit)
=20
 struct tree *get_commit_tree(const struct commit *commit)
 {
-	return commit->maybe_tree;
+	if (commit->maybe_tree || !commit->object.parsed)
+		return commit->maybe_tree;
+
+	if (commit->graph_pos =3D=3D COMMIT_NOT_FROM_GRAPH)
+		BUG("commit has NULL tree, but was not loaded from commit-graph");
+
+	return get_commit_tree_in_graph(commit);
 }
=20
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/commit.h b/commit.h
index dc4bf97d9f..23a3f364ed 100644
--- a/commit.h
+++ b/commit.h
@@ -22,6 +22,12 @@ struct commit {
 	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
+
+	/*
+	 * If the commit is loaded from the commit-graph file, then this
+	 * member may be NULL. Only access it through get_commit_tree()
+	 * or get_commit_tree_oid().
+	 */
 	struct tree *maybe_tree;
 	uint32_t graph_pos;
 };
--=20
2.17.0

