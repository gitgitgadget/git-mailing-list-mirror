Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E19C1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDQSK5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:57 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:13488
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752786AbeDQSKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SAPsprOYBP0pNRABoosKeK0wyaNoeJLJkvtsEw82wZY=;
 b=ZPAUSmJ/xS6bZ1EPUHTQ3LO9iU8+MTyrlOMcwkAQSFM4dgNIbimMcNngysWHD4mtD+skOuvSkqbUNuFVd74uiBsvhN4jjj0l1NLHYljrGQBIcwCHUa57Qt3RYKdKij9IvmHxUqzk1wwMx+UDjRrVbp0mB1rZLg/xZg4zT6tmgdQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:45 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:45 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 11/12] gc: automatically write commit-graph files
Thread-Topic: [RFC PATCH 11/12] gc: automatically write commit-graph files
Thread-Index: AQHT1ndn8wLNzKyUB02ZPNnjsaHxtQ==
Date:   Tue, 17 Apr 2018 18:10:45 +0000
Message-ID: <20180417181028.198397-12-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:eeDzGB1SSeMteg+HnuVRYIJnVP9/v9SmIFBWmNUmVWPwM8QyoE3S5PDGrr+2pKoxiYLYybYaOfJpOndjbivU/qMoZEcg/a1gT8aSF9Se4C8X5EDVHqxCZpt3qTS7I/542YGfsIeRjpvwh4fOT5Gl+XbB9UiAql0arpL0n28JqYOky8K1hYZUSEh7+vulX8j9ahkqAJkdZ36/CNtvffluysems+n32nOt/m9uOjagWyPE8oijLDGIzlNq/ArcTrNI;20:D7Lwf+hhZ71/oGvNfj921XXto+/k4b9kxaY7W4MOl47GxER0ymMFmHxj7SB8baWcygHXDfYdmKBNCZseRkO/FDocaPA/MVS3vjz0qGGx0jYnla9Vu8S849lUCuamHCvn6KF3eCBAQYhObIGekI/TQWm20q+zk10dWmekkTnyRhU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB099473B8C02935EAE1AF52E3A1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(59450400001)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EwQ/s30Zkhx67NNqm6M5SvfmotEHwB7LVkkK55DSkamuNaizJwitb/S55kJUclWfjxRoql08MNnVW5BGgl+iSI9lYttjDwWnml6D6+uhZG8nsIpRdmkJtO7AcoPzstZ3LgnPZSI8fbNBTPlGN8/rxH06DFK0zT3mUAraiDeQjxFAwUB1x9ubqNkciY5f3NA0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3c37562c-bbce-482b-9e43-08d5a48e89eb
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c37562c-bbce-482b-9e43-08d5a48e89eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:45.2907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file is a very helpful feature for speeding up git
operations. In order to make it more useful, write the commit-graph file
by default during standard garbage collection operations.

Add a 'gc.commitGraph' config setting that triggers writing a
commit-graph file after any non-trivial 'git gc' command.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-gc.txt | 4 ++++
 builtin/gc.c             | 8 ++++++++
 2 files changed, 12 insertions(+)

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
index 77fa720bd0..070f2a7a3d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -34,6 +34,7 @@ static int aggressive_depth =3D 50;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
+static int gc_commit_graph =3D 1;
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
2.17.0.39.g685157f7fb

