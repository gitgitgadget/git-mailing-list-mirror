Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E261F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeFFLhC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:37:02 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:10314
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752036AbeFFLgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2O+8iZir+gsvNpz1djDQNEEBAIcbxKLBxaN2Oftfmo=;
 b=MKQAVj5dH8MPMuywdlQD1VY5dd7jzrL09Y9qSS2KlozaDehWlZeg896RS7RHFA2Y0YzERr8EXumuqF7hJgpMzLOJq6t6zr5DuJQMtAU1lABCzFESUwjjZkFus61i7T3wHEupU1XhIBSKqAJNky/IHBDHDtzLEMZevd/nj37ct88=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 18/21] commit-graph: use string-list API for input
Thread-Topic: [PATCH v5 18/21] commit-graph: use string-list API for input
Thread-Index: AQHT/Yqhj9OAOUHvmUKV2oj7qDmCOg==
Date:   Wed, 6 Jun 2018 11:36:37 +0000
Message-ID: <20180606113611.87822-19-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
In-Reply-To: <20180606113611.87822-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:403:1::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:DiqVj4vcVk95hLDhSQZqueQWiqLTzLjGNBMswq0F7OR+z8ZEHWxcrVTUn+XYDi2eEb5tipmWEOAugNkjieN8hkUWiLJtSAMt2eYm0Z7dD7fIJX9vkBvGEQn2Y6OKF1GFLYQ1dyInVJRfHIju64MB3SLPCdiTDc5rpmZCqgXh+xevdU5jtORCOOiOicorgW8MigPmfLEMr6K+NlTyDZval9JrbHeIL1O+UJaCBBYwesa0m6FZbcMpD4PvfmcICvHy
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1044BE1DA792BF84D1DCFC93A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s5f2vCnT2Y99sL+Uiep6SFRZt5r0GF0jwuQfsgca95IJ6bSM9EfdHMBbaZu62bg3pz3hiv0CRAJSKtvK7OZDODq//Rzf8aoSwHREqYVVZzkpauabaot6tCu1+37VxuXS5yhFF7jFB4QzJSPCz2cFyXn9jEjuL3hvIj2QwnsTEagTYeaXksGFxNcszmHgu4ny
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7743ca36-e069-4f38-8f78-08d5cba1c3ac
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7743ca36-e069-4f38-8f78-08d5cba1c3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:37.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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
index 3079cde6f9..d8eb8278b3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -118,13 +118,9 @@ static int graph_read(int argc, const char **argv)
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
@@ -150,32 +146,23 @@ static int graph_write(int argc, const char **argv)
=20
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
+		string_list_init(&lines, 0);
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
index 0f93d5d864..f23bf4cf50 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -656,10 +656,8 @@ static void compute_generation_numbers(struct packed_c=
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
@@ -700,10 +698,10 @@ void write_commit_graph(const char *obj_dir,
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
@@ -716,12 +714,13 @@ void write_commit_graph(const char *obj_dir,
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
index 71a39c5a57..66661e1fc5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,6 +2,7 @@
 #define COMMIT_GRAPH_H
=20
 #include "git-compat-util.h"
+#include "string-list.h"
=20
 char *get_commit_graph_filename(const char *obj_dir);
=20
@@ -47,10 +48,8 @@ struct commit_graph {
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
 int verify_commit_graph(struct commit_graph *g);
--=20
2.18.0.rc1

