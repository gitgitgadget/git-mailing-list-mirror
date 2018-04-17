Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916AA1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeDQRAq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:46 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:14256
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752952AbeDQRAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JwbhbWWBuzDasVN7PEK6Mtf2/8tlqFkIxb1ZMnHNtiA=;
 b=fzx5kO8ftFzkMgICPwLuxfIxCj361R3ERFqhk2Eb5Q7LfWNZEzXildZo1R4vmbsoIeyTg5rEDGVPi30VTAtNXb1lbzmT6Ql9V4/RunS4oJDfxx/DyvokiGljGnLHTQlwemROtPybFF0TRCef8MfdVTaVZvrF883clEkfBXnH3Tw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:36 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:36 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 8/9] commit-graph: always load commit-graph information
Thread-Topic: [PATCH v3 8/9] commit-graph: always load commit-graph
 information
Thread-Index: AQHT1m2aeKjL7+V6ykCxJAllo1OHmA==
Date:   Tue, 17 Apr 2018 17:00:35 +0000
Message-ID: <20180417170001.138464-9-dstolee@microsoft.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:uSmBBafG9OLYdMDapiWUcL2FTX+uSYgPoaEyDF8Gv9//a1btTL/kXOhGPMUuZQmjICVdpdezwh4aipiWkuhZI3b5i5lGtCOXMyrWxLWE24cweGl88vZ6zc2/eYDq2xmVyXqfTfJOsN75D58IkKqZNHBAhwTr9tDxZTRwB8fsweK1BtV7+FjTnKW+h48Zx0m6RZFMtzC8ie+OucJVj3+i0ZhKtr4oG3pgsrB6WfLFtK7qQIADgcP9pYjSfFLwgqox;20:bIprRu/hHHJo8h3tUXv1IrqJrSEHBE4bx5CiwRDNpWLWwTOTSXs1IPkjWAdsdR3iNb8yLjzPWk/a4zGBejfdfpRBanWwkayJ6mnTrLPKAA3wxCP9dhfQoDpCtT9m0gTsfJMbZkEQd1/mcNaBhHsotTeA36D9pwIXbPMnmqaG6zk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB107401B6FD3C606A6983DF79A1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(575784001)(86362001)(486006)(8656006)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lsLrv57n75SNJ/4ljkipHgoNWuoGyIdQfpHGqwqDti7lVjoIMUVlihIsTFOhz0J6ikuAfwOK6Bw07bq5ZNKmB8Q3NiRw58MHMvu+5ZH2qGg7+j1FyzoN296WlnSa7KzE2CamOJcpfIgivrGWCcEDBIVrEoAE9z/aJPVC5C27kPTRuIuUcuqpC32S7r2oAGEE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6fa3c16c-4d70-42ea-27c4-08d5a484bcb5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa3c16c-4d70-42ea-27c4-08d5a484bcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:35.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
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
'check_graph' parameter. This avoids duplicate work when we already
checked the graph in parse_commit_gently() or when simply checking the
buffer contents in check_commit().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 51 ++++++++++++++++++++++++++++++++------------------
 commit-graph.h |  8 ++++++++
 commit.c       |  7 +++++--
 commit.h       |  2 +-
 object.c       |  2 +-
 sha1_file.c    |  2 +-
 6 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 688d5b1801..21e853c21a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -245,13 +245,19 @@ static struct commit_list **insert_parent_or_die(stru=
ct commit_graph *g,
 	return &commit_list_insert(c, pptr)->next;
 }
=20
+static void fill_commit_graph_info(struct commit *item, struct commit_grap=
h *g, uint32_t pos)
+{
+	const unsigned char *commit_data =3D g->chunk_commit_data + GRAPH_DATA_WI=
DTH * pos;
+	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
+}
+
 static int fill_commit_in_graph(struct commit *item, struct commit_graph *=
g, uint32_t pos)
 {
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	const unsigned char *commit_data =3D g->chunk_commit_data + (g->hash_len =
+ 16) * pos;
+	const unsigned char *commit_data =3D g->chunk_commit_data + GRAPH_DATA_WI=
DTH * pos;
=20
 	item->object.parsed =3D 1;
 	item->graph_pos =3D pos;
@@ -292,31 +298,40 @@ static int fill_commit_in_graph(struct commit *item, =
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
+		return bsearch_graph(commit_graph, &(item->object.oid), pos);
+	}
+}
+
 int parse_commit_in_graph(struct commit *item)
 {
+	uint32_t pos;
+
+	if (item->object.parsed)
+		return 0;
 	if (!core_commit_graph)
 		return 0;
-	if (item->object.parsed)
-		return 1;
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
index a70f120878..9ef6f699bd 100644
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

