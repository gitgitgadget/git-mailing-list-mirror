Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60111F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeHTVlp (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:41:45 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:10688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbeHTVlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzwvE3JiGb8Wnu3Kf7DJX/k7pTUDsZB8t/Q4jEkmt58=;
 b=hsFIXt+9Nz32NVcK5BV5iB6bwnB58FGUq5AuhOdk6LNHX3YlRA2rIqhfj19BBDAF8kA9sSOvKWzTDo3f6OPpmcCShDtscpT8adn/wu7t12/ur6Jd3+on+OGRBvIkfqxTJAU54UJQCjaczCqF0Y5r5JadcRVMyvY5bcwaGTU038E=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.1; Mon, 20 Aug 2018 18:24:27 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:27 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 5/8] commit-graph: not compatible with replace objects
Thread-Topic: [PATCH v2 5/8] commit-graph: not compatible with replace objects
Thread-Index: AQHUOLMHRyZkAC1e1keN1hyYMjgTIw==
Date:   Mon, 20 Aug 2018 18:24:27 +0000
Message-ID: <20180820182359.165929-6-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;6:H3/s1DjnxyO1fJsAH2aIkQj5tackJd8mgc6twW9ZZ3k2nXLWc4S2VHuCybDQg/pYWf9Lq2LLj9o93jSbNz50Ldf5ualG4YnPqwKu9yCm9czHg2I1p8wY/3E870NF4H7MuuWvBF8zPYoazovAUSm3+d2bSOnUF+I3y1nT9VnIrGr3U8MOeLZCOs81lYxMr0O4JfM6U3Fztfrg188eok6OTINv4V9K8A0Erpg0MQav7hJthtP4sHeWu5rx2lnoUwtjjk3au19qn4rbINUWLNplnrMY2+KZQCJWQ31wQZX0yfpvZ8dwIcc8c6Krfgb/c9vtDinGxFfDayHvtpiy/9ZUEcmAf8DJfUUyLwWXXLvqQcJG/ICAyYLs3HOAyB8Raeap2DqWnoSQNmcS03wvAPYuRgJpn6WYihY1nbBjW9Ves9OBVCZEGR7uS8qte2r6qec6v8jJCIl1Igkx5D4h8CrRiw==;5:jDZenRUBySuFQCj2PtQ187664e9yHZAd4Wk7qHpuBXnKn8HNfVs5evj6NSCrGbLnzXlcrbYkMgcRqBWSR1HVEl4GQvKzs/6iNzjg2YphJMoljz4UZ7oWPBrGRUbsxoiMJ5Qql+EG01SJ7KK0LXon/F1Yc3/C9mWZ7lloh67psrA=;7:tjRf03ZFUiiPUCfZAAKT0CxuA2J9LysXk7owUrlyl765l70KcekZmcK6R1Ws9O8js3yEPB0LJUu4L6bTciB/ESKIVCCV1MCHsQCZwM/zO9MH3qSyc+YE3hdzFyEGEeyaY+OUIn2RyqSwXECSBxSp5wiO6Xt7LAWCAFzi/qVtZDjsUL+gyQHX5IO6q5xareA2HwFyAxqqmBsuIr77s/hqH/tu8t+aOLOq4OLh3mkxCQzgLJ6R4Tn5J1YGq1Xu8DbE
x-ms-office365-filtering-correlation-id: 19c37d24-9ab6-4cea-c5e3-08d606ca2964
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09950BDDE3037C059BE618C1A1320@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(1076002)(4326008)(8936002)(2616005)(105586002)(86362001)(575784001)(6486002)(5640700003)(6436002)(106356001)(5660300001)(10090500001)(8676002)(11346002)(446003)(486006)(14454004)(39060400002)(305945005)(81166006)(86612001)(81156014)(10290500003)(7736002)(6916009)(1730700003)(478600001)(6116002)(107886003)(102836004)(25786009)(476003)(2906002)(46003)(68736007)(53936002)(6512007)(2900100001)(5250100002)(2501003)(97736004)(2351001)(99286004)(22452003)(52116002)(14444005)(36756003)(256004)(76176011)(316002)(386003)(186003)(54906003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fifmpRShZsZrOYfZcT6iHEuTpVBjJ2nUgqefj0T12CbqdZVORKcsVyN8muSXU+xCspOwDsSZ3u14aTC87HEOOLUNemfcgJKVFfnXWq+NZ21kJ84kMIXg0/y5cDiAY73pNRsk5jRl89AAORNECs8wp8eqfimUkxzq/T2UR4FHW9MGdP09ZocRboCKLb24i3oOK+lTIJ8tR9J821616TTNehgnvwrKlgnWZ/yA6Xr4bFSJuvklwfRTSbgn+m8uRK5oDWkJce0+1FsY2ZIvPo6D+QYcFNlfF1gHp7qPydwvJPJ3edVKLWCcsM3sTO5btj6Z6Fuxl9rfotl7W6mZftZ6Wz28bKdP0o7Yv9jkqIqomU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c37d24-9ab6-4cea-c5e3-08d606ca2964
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:27.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create new method commit_graph_compatible(r) to check if a given
repository r is compatible with the commit-graph feature. Fill the
method with a check to see if replace-objects exist. Test this
interaction succeeds, including ignoring an existing commit-graph and
failing to write a new commit-graph. However, we do ensure that
we write a new commit-graph by setting read_replace_refs to 0, thereby
ignoring the replace refs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c  |  4 ++++
 commit-graph.c          | 21 +++++++++++++++++++++
 replace-object.c        |  2 +-
 replace-object.h        |  2 ++
 t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0bf0c48657..da737df321 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -120,6 +120,8 @@ static int graph_read(int argc, const char **argv)
 	return 0;
 }
=20
+extern int read_replace_refs;
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list *pack_indexes =3D NULL;
@@ -150,6 +152,8 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir =3D get_object_directory();
=20
+	read_replace_refs =3D 0;
+
 	if (opts.reachable) {
 		write_commit_graph_reachable(opts.obj_dir, opts.append);
 		return 0;
diff --git a/commit-graph.c b/commit-graph.c
index b0a55ad128..2c01fa433f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -13,6 +13,8 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "alloc.h"
+#include "hashmap.h"
+#include "replace-object.h"
=20
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -56,6 +58,19 @@ static struct commit_graph *alloc_commit_graph(void)
 	return g;
 }
=20
+extern int read_replace_refs;
+
+static int commit_graph_compatible(struct repository *r)
+{
+	if (read_replace_refs) {
+		prepare_replace_object(r);
+		if (hashmap_get_size(&r->objects->replace_map->map))
+			return 0;
+	}
+
+	return 1;
+}
+
 struct commit_graph *load_commit_graph_one(const char *graph_file)
 {
 	void *graph_map;
@@ -223,6 +238,9 @@ static int prepare_commit_graph(struct repository *r)
 		 */
 		return 0;
=20
+	if (!commit_graph_compatible(r))
+		return 0;
+
 	obj_dir =3D r->objects->objectdir;
 	prepare_commit_graph_one(r, obj_dir);
 	prepare_alt_odb(r);
@@ -693,6 +711,9 @@ void write_commit_graph(const char *obj_dir,
 	int num_extra_edges;
 	struct commit_list *parent;
=20
+	if (!commit_graph_compatible(the_repository))
+		return;
+
 	oids.nr =3D 0;
 	oids.alloc =3D approximate_object_count() / 4;
=20
diff --git a/replace-object.c b/replace-object.c
index 3c17864eb7..9821f1477e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -32,7 +32,7 @@ static int register_replace_ref(struct repository *r,
 	return 0;
 }
=20
-static void prepare_replace_object(struct repository *r)
+void prepare_replace_object(struct repository *r)
 {
 	if (r->objects->replace_map)
 		return;
diff --git a/replace-object.h b/replace-object.h
index 9345e105dd..16528df942 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -10,6 +10,8 @@ struct replace_object {
 	struct object_id replacement;
 };
=20
+void prepare_replace_object(struct repository *r);
+
 /*
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4f17d7701e..e0c3c60f66 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -259,6 +259,28 @@ test_expect_success 'check that gc computes commit-gra=
ph' '
 	test_cmp commit-graph-after-gc $objdir/info/commit-graph
 '
=20
+test_expect_success 'replace-objects invalidates commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	test_when_finished rm -rf replace &&
+	git clone full replace &&
+	(
+		cd replace &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph &&
+		git replace HEAD~1 HEAD~2 &&
+		git -c core.commitGraph=3Dfalse log >expect &&
+		git -c core.commitGraph=3Dtrue log >actual &&
+		test_cmp expect actual &&
+		git commit-graph write --reachable &&
+		git -c core.commitGraph=3Dfalse --no-replace-objects log >expect &&
+		git -c core.commitGraph=3Dtrue --no-replace-objects log >actual &&
+		test_cmp expect actual &&
+		rm -rf .git/objects/info/commit-graph &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph
+	)
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
--=20
2.18.0.118.gd4f65b8d14

