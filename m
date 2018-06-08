Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9293C1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeFHN4o (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:44 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752739AbeFHN4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2QMUibB9vDgGm/l7WnbPvkK8kG7jRCcroFz1Z30D18=;
 b=M+pN0f6HfEuJ258LbS81Tjm09VY3ZbTzx4w19vLzPf1DbjMLdgJborWf1nwj3BtO5DWg6BHfkW/rEKewmzK+FAXP5iJqgs7EiNnjgaNQVLf0HAiNIKkD1jMskMxX4MDGai/jkPCTfIsXd7lzY3lDWgXJvUShfKjKqK1ZvI3rGno=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:28 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:28 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 18/21] commit-graph: use string-list API for input
Thread-Topic: [PATCH v6 18/21] commit-graph: use string-list API for input
Thread-Index: AQHT/zB+u39Fy3h9k0iF4iHOA1JuPA==
Date:   Fri, 8 Jun 2018 13:56:28 +0000
Message-ID: <20180608135548.216405-19-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:wgFc3iCP8zevHkkfVQc2tyCCXIjGg18gD32wW4PpPyMsXbJ8fvq6Z+85qhjsrHynoc2SgOPSAreOOkCkRnWyU8JmqU0sP8lZREJ5zn3VCmsnj9PUzYq82yAqqzcMGhOUoqpX8l0F0yKyp819RQDRSWEJ6V2NQlYm7VYrRuzG+UbyWd04IVl+JKRMQfSojwCA6UbUQMnivpVmNIVl3utJokCTkXDQIFtnfKWGVH+j+AzTP/ZWyAZIUR4Dipl9PgVz
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0963EE0CD78660C1D9D6562CA17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S1UKvFy0AkTyerN4ElTM1cNgVL38qeTIz0gkbE3CxoD4NQB4w7t/9EdBDBkXpgRk7NzHaYOO72TurMHPvH/0kE/Ms/C3iLR/4tmcQgZwhy0uc1caEZxlxaOaJFDMHKLGqa9MxtiJH4O6PKCamSB73aXYk1NGRQkUj0TjVBcJbtpeMtjwYfdE3DVaEyUqyL7U
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9fa6070a-33dd-41a8-f123-08d5cd47a163
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa6070a-33dd-41a8-f123-08d5cd47a163
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:28.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 39 +++++++++++++--------------------------
 commit-graph.c         | 15 +++++++--------
 commit-graph.h         |  7 +++----
 3 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 9d108f43a9..ea28bc311a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -119,13 +119,9 @@ static int graph_read(int argc, const char **argv)
=20
 static int graph_write(int argc, const char **argv)
 {
-	const char **pack_indexes =3D NULL;
-	int packs_nr =3D 0;
-	const char **commit_hex =3D NULL;
-	int commits_nr =3D 0;
-	const char **lines =3D NULL;
-	int lines_nr =3D 0;
-	int lines_alloc =3D 0;
+	struct string_list *pack_indexes =3D NULL;
+	struct string_list *commit_hex =3D NULL;
+	struct string_list lines;
=20
 	static struct option builtin_commit_graph_write_options[] =3D {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -149,34 +145,25 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir =3D get_object_directory();
=20
+	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf =3D STRBUF_INIT;
-		lines_nr =3D 0;
-		lines_alloc =3D 128;
-		ALLOC_ARRAY(lines, lines_alloc);
-
-		while (strbuf_getline(&buf, stdin) !=3D EOF) {
-			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
-			lines[lines_nr++] =3D strbuf_detach(&buf, NULL);
-		}
-
-		if (opts.stdin_packs) {
-			pack_indexes =3D lines;
-			packs_nr =3D lines_nr;
-		}
-		if (opts.stdin_commits) {
-			commit_hex =3D lines;
-			commits_nr =3D lines_nr;
-		}
+
+		while (strbuf_getline(&buf, stdin) !=3D EOF)
+			string_list_append(&lines, strbuf_detach(&buf, NULL));
+
+		if (opts.stdin_packs)
+			pack_indexes =3D &lines;
+		if (opts.stdin_commits)
+			commit_hex =3D &lines;
 	}
=20
 	write_commit_graph(opts.obj_dir,
 			   pack_indexes,
-			   packs_nr,
 			   commit_hex,
-			   commits_nr,
 			   opts.append);
=20
+	string_list_clear(&lines, 0);
 	return 0;
 }
=20
diff --git a/commit-graph.c b/commit-graph.c
index d926c4b59f..a06e7e9549 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -657,10 +657,8 @@ static void compute_generation_numbers(struct packed_c=
ommit_list* commits)
 }
=20
 void write_commit_graph(const char *obj_dir,
-			const char **pack_indexes,
-			int nr_packs,
-			const char **commit_hex,
-			int nr_commits,
+			struct string_list *pack_indexes,
+			struct string_list *commit_hex,
 			int append)
 {
 	struct packed_oid_list oids;
@@ -701,10 +699,10 @@ void write_commit_graph(const char *obj_dir,
 		int dirlen;
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen =3D packname.len;
-		for (i =3D 0; i < nr_packs; i++) {
+		for (i =3D 0; i < pack_indexes->nr; i++) {
 			struct packed_git *p;
 			strbuf_setlen(&packname, dirlen);
-			strbuf_addstr(&packname, pack_indexes[i]);
+			strbuf_addstr(&packname, pack_indexes->items[i].string);
 			p =3D add_packed_git(packname.buf, packname.len, 1);
 			if (!p)
 				die("error adding pack %s", packname.buf);
@@ -717,12 +715,13 @@ void write_commit_graph(const char *obj_dir,
 	}
=20
 	if (commit_hex) {
-		for (i =3D 0; i < nr_commits; i++) {
+		for (i =3D 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
 			struct commit *result;
=20
-			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
+			if (commit_hex->items[i].string &&
+			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
 				continue;
=20
 			result =3D lookup_commit_reference_gently(&oid, 1);
diff --git a/commit-graph.h b/commit-graph.h
index 4359812fb4..a79b854470 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -3,6 +3,7 @@
=20
 #include "git-compat-util.h"
 #include "repository.h"
+#include "string-list.h"
=20
 char *get_commit_graph_filename(const char *obj_dir);
=20
@@ -48,10 +49,8 @@ struct commit_graph {
 struct commit_graph *load_commit_graph_one(const char *graph_file);
=20
 void write_commit_graph(const char *obj_dir,
-			const char **pack_indexes,
-			int nr_packs,
-			const char **commit_hex,
-			int nr_commits,
+			struct string_list *pack_indexes,
+			struct string_list *commit_hex,
 			int append);
=20
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
--=20
2.18.0.rc1

