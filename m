Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E3A1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDQSLL (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:11:11 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:53856
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752730AbeDQSKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=91h2zaE896Q+xKcJtS6aXiHCBh4zm0n7aykPcpRobhE=;
 b=PUHF21izrFXf1WqzuQyJVfJDHj/2d5Gr2mfNraOgelcZBLlzzkkUDecWufMACYpEnfg1+Wxb0UiGqwQfSZEyoxaRNKzBv7Ge/Y/AFgh0RcW6ZJMKiYaYOUOyZFeR1u1xtZathx3l2oLQ4pYnVOpBWIPla4vWnf7up0prXRfySno=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:39 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:39 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 02/12] commit-graph: add 'check' subcommand
Thread-Topic: [RFC PATCH 02/12] commit-graph: add 'check' subcommand
Thread-Index: AQHT1ndjcW5scq9j+EOFLahfA7F3pg==
Date:   Tue, 17 Apr 2018 18:10:39 +0000
Message-ID: <20180417181028.198397-3-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:TPlJuse7msGqSDzp9h39j0P86gxfr5/ruU6UPMtGEItM9Oupw0aHaf4DvJAaiH3x33PDaSycoN6iTrOUfgFiL/+ro1rAaVqNWI1CJqA1CzSbgtdylhQB7R8BuBmf+OqycROo/kaRwCz91eDlDnf2YN+gtK5puYq0XF1wO7ANNMFsjP9g3WMNUpKohuD8IP+NBfcVKEOTGg3JgFiXHiMDHU88rwhGtTUcZObsx6ULsSRIW1PE0kCmdflDfrH5XeCO;20:nw1TtEhm5wbvRNMJ56ugHEMN/AITfMc1zUlecNjQ+UuqyzB5OQDOUfkL10NkmCxXCNtm3YxodYUbe6ruPzYiPW3+3b4fnv73XHWqMdESocXb5AaDw5jJFgmz3Lh/GO8+DP8wHFtT0aG/wmeDZCxdgHsq9zsur8ocRpyEn2eEQGI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1027391F8A32A6A738FCA2B1A1B70@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(6512007)(5660300001)(186003)(107886003)(6916009)(2900100001)(478600001)(10290500003)(105586002)(106356001)(2906002)(86612001)(86362001)(99286004)(53936002)(25786009)(22452003)(575784001)(54906003)(316002)(5250100002)(6486002)(6506007)(97736004)(4326008)(8936002)(14454004)(102836004)(3660700001)(6436002)(36756003)(5640700003)(3280700002)(305945005)(10090500001)(81156014)(59450400001)(68736007)(446003)(76176011)(2501003)(52116002)(2351001)(11346002)(8676002)(476003)(1076002)(386003)(81166006)(2616005)(7736002)(486006)(46003)(6116002)(1730700003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YRClAHYmwM3PcgtbE+fje12wj33M0KhD1Pf0yFTj4fhfKlfj+26kaLbaAyr6BRxJHK/g6ZJBjPkr73grePog+wwqQ5SxnbHNgAhYDFXjFASiEEI2QnuCXrxxntDBIvcIzTdZSiYIInqvc0n9jBEURadoo92kTrM+cMM/7AUg2Gc0RXS9Zr7HH4BjLcuds+h9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 91d88cd7-3fa5-4a3f-f47e-08d5a48e863b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d88cd7-3fa5-4a3f-f47e-08d5a48e863b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:39.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the commit-graph file becomes corrupt, we need a way to verify
its contents match the object database. In the manner of 'git fsck'
we will implement a 'git commit-graph check' subcommand to report
all issues with the file.

Add the 'check' subcommand to the 'commit-graph' builtin and its
documentation. Add a simple test that ensures the command returns
a zero error code.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  7 +++++-
 builtin/commit-graph.c             | 38 ++++++++++++++++++++++++++++++
 commit-graph.c                     |  5 ++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            |  5 ++++
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index 4c97b555cc..93c7841ba2 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,10 +9,10 @@ git-commit-graph - Write and verify Git commit graph file=
s
 SYNOPSIS
 --------
 [verse]
+'git commit-graph check' [--object-dir <dir>]
 'git commit-graph read' [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
=20
-
 DESCRIPTION
 -----------
=20
@@ -52,6 +52,11 @@ existing commit-graph file.
 Read a graph file given by the commit-graph file and output basic
 details about the graph file. Used for debugging purposes.
=20
+'check'::
+
+Read the commit-graph file and verify its contents against the object
+database. Used to check for corrupted data.
+
=20
 EXAMPLES
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 37420ae0fd..77c1a04932 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -7,11 +7,17 @@
=20
 static char const * const builtin_commit_graph_usage[] =3D {
 	N_("git commit-graph [--object-dir <objdir>]"),
+	N_("git commit-graph check [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
 	NULL
 };
=20
+static const char * const builtin_commit_graph_check_usage[] =3D {
+	N_("git commit-graph check [--object-dir <objdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_read_usage[] =3D {
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	NULL
@@ -29,6 +35,36 @@ static struct opts_commit_graph {
 	int append;
 } opts;
=20
+
+static int graph_check(int argc, const char **argv)
+{
+	struct commit_graph *graph =3D 0;
+	char *graph_name;
+
+	static struct option builtin_commit_graph_check_options[] =3D {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			   N_("dir"),
+			   N_("The object directory to store the graph")),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, NULL,
+			     builtin_commit_graph_check_options,
+			     builtin_commit_graph_check_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir =3D get_object_directory();
+
+	graph_name =3D get_commit_graph_filename(opts.obj_dir);
+	graph =3D load_commit_graph_one(graph_name);
+
+	if (!graph)
+		die("graph file %s does not exist", graph_name);
+	FREE_AND_NULL(graph_name);
+
+	return check_commit_graph(graph);
+}
+
 static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph =3D NULL;
@@ -160,6 +196,8 @@ int cmd_commit_graph(int argc, const char **argv, const=
 char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	if (argc > 0) {
+		if (!strcmp(argv[0], "check"))
+			return graph_check(argc, argv);
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
diff --git a/commit-graph.c b/commit-graph.c
index 3f0c142603..cd0634bba0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -819,3 +819,8 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc =3D 0;
 	oids.nr =3D 0;
 }
+
+int check_commit_graph(struct commit_graph *g)
+{
+	return !g;
+}
diff --git a/commit-graph.h b/commit-graph.h
index 96cccb10f3..e8c8d99dff 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
=20
+int check_commit_graph(struct commit_graph *g);
+
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 77d85aefe7..e91053271a 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -230,4 +230,9 @@ test_expect_success 'perform fast-forward merge in full=
 repo' '
 	test_cmp expect output
 '
=20
+test_expect_success 'git commit-graph check' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph check >output
+'
+
 test_done
--=20
2.17.0.39.g685157f7fb

