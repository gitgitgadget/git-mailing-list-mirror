Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380FA1F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeEKVPo (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:44 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:27712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751903AbeEKVPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cUDuIN6kr7XJwNakeLQOMu7uXhxSIFdEdMbxjucsII=;
 b=h+XY3upQhjfEFocC4L7Yat+13yiIn4r5Gs752OcnASoD9EGZdGRieo/q6w+TrBXka02tmvbNiGi/DUy2SN9B46mLT68LuGRHpbTnxztLUk30y8tnfBjDDb7Y+AtjhiGZ0Q4IDXKhStur8/DFRUy874gM0w9dh2wKTWaaVp1EXec=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:34 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:34 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 11/12] gc: automatically write commit-graph files
Thread-Topic: [PATCH v2 11/12] gc: automatically write commit-graph files
Thread-Index: AQHT6W0t94WKya4d0EWsnlp+P5NWew==
Date:   Fri, 11 May 2018 21:15:24 +0000
Message-ID: <20180511211504.79877-12-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
In-Reply-To: <20180511211504.79877-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:404:8e::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:6VRhfVGk7OZSXHJTbVdh+uG9AijZqWP8n8wSA2qpNP32PUranUyvQ8pQ8P/PHCOmhDxWOdsv80QgD3maqjEroW/OUiBzRT2k5xwoMnGO50cQtAaPm51MUSQ9Qog56YkyDqvDIfleI+eeWqn6/jetIG3AV9J9CH4wUfJl0u90cqCBSEzYntbeHn92/A6rAmpztoyCEf4NsbGf1zpxa5HwFdcEcIvdwwEzWRSUqc1nWI3KS6FF7LEbOG3lJ77A17i4;20:xjylWwf+WlAo3TnhfHMSjcN1lfL0rXij2k7qYqRUv3NBRlDDyX9P4SEKrxuvR3UGkHToTNs0Gs9uIN46TfkRHgCbZB7NpsTlg1qeySLg2IkVAcnstcM2slA1Gk9J+WN5y833lo9AzpvQ0VvgeICUemAos25Dqgc250/MBy326t8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096294155D7F7F838B69BEC6A19F0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(5660300001)(39060400002)(316002)(305945005)(6116002)(7736002)(6506007)(52116002)(386003)(81166006)(81156014)(186003)(3660700001)(5640700003)(46003)(76176011)(54906003)(1730700003)(68736007)(6436002)(446003)(102836004)(3280700002)(1076002)(59450400001)(97736004)(2351001)(11346002)(22452003)(106356001)(99286004)(2616005)(476003)(2501003)(36756003)(14454004)(2906002)(8936002)(6666003)(105586002)(107886003)(4326008)(8676002)(86612001)(6486002)(486006)(25786009)(10090500001)(53936002)(478600001)(2900100001)(86362001)(6916009)(6512007)(10290500003)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oHM3X/htrZWmWvujvucyDVAj9N0c3HApKifIxo+pGoE3OqYRkq16RuDjtBnRtOsDEIeiI/7VlxDUCVjwINWGl17repbtwbiqe09XuNGa+yCUChDG277zXrA7eaVHiZjBLeMCEZVuUbg+DI3uWHeYuBsuR7CJ58TX3gz8+LHlSfedTnUz30kaqBvLGaFHc5z0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ac5a1c8f-e09b-468b-6082-08d5b7844fbe
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5a1c8f-e09b-468b-6082-08d5b7844fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:24.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file is a very helpful feature for speeding up git
operations. In order to make it more useful, write the commit-graph file
by default during standard garbage collection operations.

Add a 'gc.commitGraph' config setting that triggers writing a
commit-graph file after any non-trivial 'git gc' command. Defaults to
false while the commit-graph feature matures. We specifically do not
want to turn this on by default until the commit-graph feature is fully
integrated with history-modifying features like shallow clones.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 6 ++++++
 Documentation/git-gc.txt | 4 ++++
 builtin/gc.c             | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 11f027194e..9a3abd87e7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1553,6 +1553,12 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
=20
+gc.commitGraph::
+	If true, then gc will rewrite the commit-graph file after any
+	change to the object database. If '--auto' is used, then the
+	commit-graph will not be updated unless the threshold is met.
+	See linkgit:git-commit-graph[1] for details.
+
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
 	unless that file is more than 'gc.logExpiry' old.  Default is
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7e3c..17dd654a59 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -119,6 +119,10 @@ The optional configuration variable `gc.packRefs` dete=
rmines if
 it within all non-bare repos or it can be set to a boolean value.
 This defaults to true.
=20
+The optional configuration variable 'gc.commitGraph' determines if
+'git gc' runs 'git commit-graph write'. This can be set to a boolean
+value. This defaults to false.
+
 The optional configuration variable `gc.aggressiveWindow` controls how
 much time is spent optimizing the delta compression of the objects in
 the repository when the --aggressive option is specified.  The larger
diff --git a/builtin/gc.c b/builtin/gc.c
index 77fa720bd0..8403445738 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -34,6 +34,7 @@ static int aggressive_depth =3D 50;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
+static int gc_commit_graph =3D 0;
 static int detach_auto =3D 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire =3D "1.day.ago";
@@ -46,6 +47,7 @@ static struct argv_array repack =3D ARGV_ARRAY_INIT;
 static struct argv_array prune =3D ARGV_ARRAY_INIT;
 static struct argv_array prune_worktrees =3D ARGV_ARRAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
+static struct argv_array commit_graph =3D ARGV_ARRAY_INIT;
=20
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
@@ -121,6 +123,7 @@ static void gc_config(void)
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
+	git_config_get_bool("gc.commitgraph", &gc_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
@@ -374,6 +377,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
 	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL)=
;
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
+	argv_array_pushl(&commit_graph, "commit-graph", "write", "--reachable", N=
ULL);
=20
 	/* default expiry time, overwritten in gc_config */
 	gc_config();
@@ -480,6 +484,10 @@ int cmd_gc(int argc, const char **argv, const char *pr=
efix)
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
=20
+	if (gc_commit_graph)
+		if (run_command_v_opt(commit_graph.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, commit_graph.argv[0]);
+
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
--=20
2.16.2.329.gfb62395de6

