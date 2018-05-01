Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D3F215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755581AbeEAMrS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:18 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:57326
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755507AbeEAMrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=66k2xPrTrv0AEjDrdD1c7TBcGR7kmqkMDKNaKGXspbU=;
 b=LlAzvROkZ2BMKwPYtJUBvztP0Bigsr0xZxlrlOqUc2l58aEawwo5FMd5mdbn4X41AKWwWmJzrPXa4+wNIEYyoKfgfq5Nq/iqAll+CtbP6H9lwA0SjwP5CjgECSA4qqa0SQOXR3//PFpd6NnQlNMbcIr1P89kYrpXHLaTbU/xtNI=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:13 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:13 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 05/11] commit-graph: always load commit-graph information
Thread-Topic: [PATCH v5 05/11] commit-graph: always load commit-graph
 information
Thread-Index: AQHT4UqHn75X4d5s0EyECeijBfUhPQ==
Date:   Tue, 1 May 2018 12:47:13 +0000
Message-ID: <20180501124652.155781-6-dstolee@microsoft.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
 <20180501124652.155781-1-dstolee@microsoft.com>
In-Reply-To: <20180501124652.155781-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:403:2::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:Y7+tcvnh1urx0i2DK5JBHtvdpWMPJm3xcpK1RiJULEJlnJ9edHed9y4KAfV8Eg6Zj+rFWnGspKtmqlz/yTBGS5iP9nbhV0m4rJiMikzR37WbqO5SqfKlLklygMAkwq19rMCu8Hb17Kqux4h6jO9XVgvilQG05nAdRV4vzURS3QIxP8VRxpgmellEmuBEgqP9xNppA+3t7TekMiRn0n12QQ0tZOkZjMPervZsyCdmtaLJ0SxLApjeqUODawDZQ3Je;20:6MASlon8In5MbK6w2a/qgpVDegPWDVHHrMbGI7IYKtUJjW2ibH0ocKWgEyIikv5Pyn1Fkh6311wrbl25o6aVjsUGee21Ai4RXDGYk5+Jk3kXKWJyxdOansdTRqrLaiqsfO380qurhN0zhGE1WHgQkmHC/CodIXTr5pINz+lUme4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB10429BB45326DBE07711C730A1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(575784001)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: Px8isbd74sHHUPwgtcBKePP2PiCrMvjToM8k/SHaDMfLdpg5YGFLts9N3nIzUyy9AV8VI/pfCfPDOuN5iZwKdFVAwSNEaBxeOA3+0XKs3Q5H0Vy4jWlcBw/mBxuvL7faIXHLWbIQaebzCU4ZxHkV2Q3rUyU3BKr4NIqdqh+nKqiA5ujeb2OTXGzWq0oa6S54
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1cb6726c-eaf0-4ed8-2daf-08d5af61a98d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb6726c-eaf0-4ed8-2daf-08d5af61a98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:13.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most code paths load commits using lookup_commit() and then
parse_commit(). In some cases, including some branch lookups, the commit
is parsed using parse_object_buffer() which side-steps parse_commit() in
favor of parse_commit_buffer().

With generation numbers in the commit-graph, we need to ensure that any
commit that exists in the commit-graph file has its generation number
loaded.

Create new load_commit_graph_info() method to fill in the information
for a commit that exists only in the commit-graph file. Call it from
parse_commit_buffer() after loading the other commit information from
the given buffer. Only fill this information when specified by the
'check_graph' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 46 +++++++++++++++++++++++++++++++---------------
 commit-graph.h |  8 ++++++++
 commit.c       |  7 +++++--
 commit.h       |  2 +-
 object.c       |  2 +-
 sha1_file.c    |  2 +-
 6 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 36d765e10a..a8c337dd77 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -245,6 +245,13 @@ static struct commit_list **insert_parent_or_die(struc=
t commit_graph *g,
 	return &commit_list_insert(c, pptr)->next;
 }
=20
+static void fill_commit_graph_info(struct commit *item, struct commit_grap=
h *g, uint32_t pos)
+{
+	const unsigned char *commit_data =3D g->chunk_commit_data + GRAPH_DATA_WI=
DTH * pos;
+	item->graph_pos =3D pos;
+	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
+}
+
 static int fill_commit_in_graph(struct commit *item, struct commit_graph *=
g, uint32_t pos)
 {
 	uint32_t edge_value;
@@ -292,31 +299,40 @@ static int fill_commit_in_graph(struct commit *item, =
struct commit_graph *g, uin
 	return 1;
 }
=20
+static int find_commit_in_graph(struct commit *item, struct commit_graph *=
g, uint32_t *pos)
+{
+	if (item->graph_pos !=3D COMMIT_NOT_FROM_GRAPH) {
+		*pos =3D item->graph_pos;
+		return 1;
+	} else {
+		return bsearch_graph(g, &(item->object.oid), pos);
+	}
+}
+
 int parse_commit_in_graph(struct commit *item)
 {
+	uint32_t pos;
+
 	if (!core_commit_graph)
 		return 0;
 	if (item->object.parsed)
 		return 1;
-
 	prepare_commit_graph();
-	if (commit_graph) {
-		uint32_t pos;
-		int found;
-		if (item->graph_pos !=3D COMMIT_NOT_FROM_GRAPH) {
-			pos =3D item->graph_pos;
-			found =3D 1;
-		} else {
-			found =3D bsearch_graph(commit_graph, &(item->object.oid), &pos);
-		}
-
-		if (found)
-			return fill_commit_in_graph(item, commit_graph, pos);
-	}
-
+	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
+		return fill_commit_in_graph(item, commit_graph, pos);
 	return 0;
 }
=20
+void load_commit_graph_info(struct commit *item)
+{
+	uint32_t pos;
+	if (!core_commit_graph)
+		return;
+	prepare_commit_graph();
+	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
+		fill_commit_graph_info(item, commit_graph, pos);
+}
+
 static struct tree *load_tree_for_commit(struct commit_graph *g, struct co=
mmit *c)
 {
 	struct object_id oid;
diff --git a/commit-graph.h b/commit-graph.h
index 260a468e73..96cccb10f3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -17,6 +17,14 @@ char *get_commit_graph_filename(const char *obj_dir);
  */
 int parse_commit_in_graph(struct commit *item);
=20
+/*
+ * It is possible that we loaded commit contents from the commit buffer,
+ * but we also want to ensure the commit-graph content is correctly
+ * checked and filled. Fill the graph_pos and generation members of
+ * the given commit.
+ */
+void load_commit_graph_info(struct commit *item);
+
 struct tree *get_commit_tree_in_graph(const struct commit *c);
=20
 struct commit_graph {
diff --git a/commit.c b/commit.c
index 4d00b0a1d6..39a3749abd 100644
--- a/commit.c
+++ b/commit.c
@@ -331,7 +331,7 @@ const void *detach_commit_buffer(struct commit *commit,=
 unsigned long *sizep)
 	return ret;
 }
=20
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned =
long size)
+int parse_commit_buffer(struct commit *item, const void *buffer, unsigned =
long size, int check_graph)
 {
 	const char *tail =3D buffer;
 	const char *bufptr =3D buffer;
@@ -386,6 +386,9 @@ int parse_commit_buffer(struct commit *item, const void=
 *buffer, unsigned long s
 	}
 	item->date =3D parse_commit_date(bufptr, tail);
=20
+	if (check_graph)
+		load_commit_graph_info(item);
+
 	return 0;
 }
=20
@@ -412,7 +415,7 @@ int parse_commit_gently(struct commit *item, int quiet_=
on_missing)
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret =3D parse_commit_buffer(item, buffer, size);
+	ret =3D parse_commit_buffer(item, buffer, size, 0);
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
 		return 0;
diff --git a/commit.h b/commit.h
index 64436ff44e..b5afde1ae9 100644
--- a/commit.h
+++ b/commit.h
@@ -72,7 +72,7 @@ struct commit *lookup_commit_reference_by_name(const char=
 *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const cha=
r *ref_name);
=20
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned =
long size);
+int parse_commit_buffer(struct commit *item, const void *buffer, unsigned =
long size, int check_graph);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/object.c b/object.c
index e6ad3f61f0..efe4871325 100644
--- a/object.c
+++ b/object.c
@@ -207,7 +207,7 @@ struct object *parse_object_buffer(const struct object_=
id *oid, enum object_type
 	} else if (type =3D=3D OBJ_COMMIT) {
 		struct commit *commit =3D lookup_commit(oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size))
+			if (parse_commit_buffer(commit, buffer, size, 1))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
diff --git a/sha1_file.c b/sha1_file.c
index 1b94f39c4c..0fd4f0b8b6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1755,7 +1755,7 @@ static void check_commit(const void *buf, size_t size=
)
 {
 	struct commit c;
 	memset(&c, 0, sizeof(c));
-	if (parse_commit_buffer(&c, buf, size))
+	if (parse_commit_buffer(&c, buf, size, 0))
 		die("corrupt commit");
 }
=20
--=20
2.17.0.39.g685157f7fb

