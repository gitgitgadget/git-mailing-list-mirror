Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340B51F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033641AbeEXQ0Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:24 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033624AbeEXQ0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGZWHevWxj5A1Nh/Ru1hUE+Z/NEU2q9TpLm6KKhWUco=;
 b=Lmc3kzCH1/8IKzeGCewNccyTm1jMAVyl9j7U5oLlwD2L3uMwAERNkZLtCCnZBDNWWALCvCYbUfDNQS3M/bCkCyAsp8/kA26YgIgV/FkeU4Kw2M1z/HHdDFEXFxa6XA1LIqOt5Mb+/+SUfBgURV5ll5e6Q4bK0uOBuVTW/y/klYc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:26:09 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:26:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 19/20] gc: automatically write commit-graph files
Thread-Topic: [PATCH v3 19/20] gc: automatically write commit-graph files
Thread-Index: AQHT83vrd/V24JxD5kC9Vi8yU7aWTg==
Date:   Thu, 24 May 2018 16:26:09 +0000
Message-ID: <20180524162504.158394-20-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:b15n55uksDwRBE79d9ty9dpmEPq2wTRla5+Midu8RcefccCSHNZNfKBqHBZUdGPJekHBx3tOyWHh8emesXF/xop7YsV4L0nvVHqfL6cC8C1/lmlwjN5S7UGNdrqBJ6t+C9f1qSHpMjgcD9nfmgGFqe3imEtFtagRJI6ZIgalh92laT5vd0F5okAPXbYHo2IWkiJR9h3O1mReh0DzaQY3c+SQsgj6mLjopFwixXab+vEDFR4ufWLNI1mj5NjRaMGw;20:kwuhWBwwKpGqbnVDy+qa7eSMLr+lkbM9c+JohtGuEpOs5pUXAd8GMBWH5W4Uav0vTk0y2LSldQoAe46MgOg+MACbYFxlEDoEN4teoqHqZ0QqsSgqH66tk6eWLT67wWn2KPY967iviJ+rKqqfVAZpbpdA9qxC2ii27NHZLlDkIZ8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1091874AE0F3EEAEACFB514BA16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: loF1lazHW73knRuon95glZaIeFeN59+rgRE412l9+PMYgy+Rcrd8z5cjFIXoxIh1IOs8xC5FSqHPZ3fTzJI8JASWESPgD9enG6NFhMantF0iCsalmJhrLKIXEadAE+IFjuDSKrNBO+LZhfIQJf+Hl9Khf7S8vFds6DetSuuugg3tccPC3xu9xtJUOp6frThv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9f53f6b9-916d-483f-3d49-08d5c1930e3d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f53f6b9-916d-483f-3d49-08d5c1930e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:26:09.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
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
 Documentation/config.txt |  6 ++++++
 Documentation/git-gc.txt |  4 ++++
 builtin/gc.c             |  6 ++++++
 t/t5318-commit-graph.sh  | 14 ++++++++++++++
 4 files changed, 30 insertions(+)

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
index 77fa720bd0..efd214a59f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "commit-graph.h"
=20
 #define FAILED_RUN "failed to run %s"
=20
@@ -34,6 +35,7 @@ static int aggressive_depth =3D 50;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
+static int gc_commit_graph =3D 0;
 static int detach_auto =3D 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire =3D "1.day.ago";
@@ -121,6 +123,7 @@ static void gc_config(void)
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
+	git_config_get_bool("gc.commitgraph", &gc_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
@@ -480,6 +483,9 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
=20
+	if (gc_commit_graph)
+		write_commit_graph_reachable(get_object_directory(), 0);
+
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a659620332..d20b17586f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -245,6 +245,20 @@ test_expect_success 'perform fast-forward merge in ful=
l repo' '
 	test_cmp expect output
 '
=20
+test_expect_success 'check that gc clears commit-graph' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit --allow-empty -m "blank" &&
+	git commit-graph write --reachable &&
+	cp $objdir/info/commit-graph commit-graph-before-gc &&
+	git reset --hard HEAD~1 &&
+	git config gc.commitGraph true &&
+	git gc &&
+	cp $objdir/info/commit-graph commit-graph-after-gc &&
+	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
+	git commit-graph write --reachable &&
+	test_cmp commit-graph-after-gc $objdir/info/commit-graph
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
--=20
2.16.2.329.gfb62395de6

