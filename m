Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3DF1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbeGXTJZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:09:25 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com ([104.47.36.114]:41376
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388407AbeGXTJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgGkTf/5yK08bnnezHet958hgA7MvqX9KcXe+p41E+s=;
 b=Sup5EO7+YfLFV0Kj1HNVFs1/b4SmeBNAQtkd394ZJCGb2gQ4PARVaOGYe7qgMp+gQnYCAFVgG09OulSOyAHWkUdd/Vf4n19DkpCeNfki7BnerQANfi/9CJRUZMcIU31Qo1r0BP1pkNPtxInRQfB7KVaBNRwS2Vyf8gt/tP8bj9c=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0969.namprd21.prod.outlook.com (52.132.146.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.1; Tue, 24 Jul 2018 18:01:40 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd%4]) with mapi id 15.20.1017.000; Tue, 24 Jul 2018
 18:01:40 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
Thread-Topic: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
Thread-Index: AQHUI3he1Lfn1Ku7fE6LN1M29YfMUg==
Date:   Tue, 24 Jul 2018 18:01:39 +0000
Message-ID: <20180724180122.29212-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: CY4PR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:903:151::21) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;6:56Pq511+lFtuabavWgTyAaaNpcTEIDtk17NkuLOaYofFrdKuQD9xXFNqYCGN7c5lgCfsSabllpoA/84guEbIuZbZrMOM3K32noi2Ml1mhakuiiMQ6D7L7LnrQMHezov0UQpRG89kk336B6MbUfM/YYb1fm//8xvNs4bYsViy0zIxOp+gI7S+XU8J97/zyc41Ky6lny/wq/uF60Q3uTcto3+NEAViylmN9S3ebN/BnbsNmgWjvHYB4slq+LVSaXtv6zbBaDfYq8pjqC/rPhculZACFFD4VjnQKcq0T+TK/Wovq3JyUpZiZy5iAyTNNVpb1wrtp0K2PxtGYODgY+1xbnclpdgdZJZFo7sIujtLhvzQJeSmnHPIJ/2MXTGN8yIzacaphW/oGYY1muLwhaFxIZbCTVt0lDzVOgyiheaAlPoSpELYjqQZyEfr9PylLEAcfJqK5r4RRzGwKSqOXJyjoA==;5:4HXyteesShW43J0hqagrLhGLKcntDT/Tgnlt0iwF2kQwV2Mk4LSAOpdddvAEK1GEmBaNuJ6h3lB24alyI4tDJdoe4we6LhC49z1ARV4hhypvnrcECG3B9NHJa8MG5YPyElLaShfSScNhlAfh1w+j6pNzuJmX01EIySI2vdJiGn0=;7:HQUriAg2hPbQ+DqO+RUeFuRrtT3qWfh3TLE61Br0DOrzvJlUASX9rjB/J4LWci08mtL5NrV51u7QZPFSBcS1KoQUO6tAvYPHh2siok5MeDAUIUt7Eskh/ORMXDDCONKRnwWpM2HzYYhSAwB92T/MOHV1kbkpyCwT3NYX45VxcJIVEYKcZlFPKEWY/jmmaVxooiLYVMEAvp5yYT76aIDLC037ZtAMfpFTN1YnM3DeKQ7MS8ZATmENABV6H5juUgvU
x-ms-office365-filtering-correlation-id: 5005296e-9c32-400d-0fd5-08d5f18f8139
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB0969AA60ADA08578B2E4151DF4550@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(2501003)(8676002)(106356001)(2351001)(102836004)(7736002)(2616005)(486006)(476003)(478600001)(2900100001)(305945005)(105586002)(256004)(10290500003)(14444005)(1076002)(99286004)(5250100002)(54906003)(36756003)(52116002)(50226002)(14454004)(6116002)(3846002)(72206003)(86612001)(5660300001)(26005)(68736007)(966005)(10090500001)(6436002)(25786009)(97736004)(6486002)(6306002)(6512007)(4326008)(5640700003)(66066001)(186003)(2906002)(22452003)(316002)(107886003)(53936002)(81166006)(386003)(1730700003)(6916009)(81156014)(6506007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N7tCEkURiCecDpsn4vgUXU6IR77HOq/YNVY/b91zVN4ClLYRWKjDJCttr0Za2+AFB1i5FARq0c+qFACNVQS7wnwOxyKQs8HaeOMki1sNjPREzC2RGnuVCAwJHWHGY3/y1+9pPRcbAaqSUoxmtRkEBp43saaSEA1BLnYB1/f9s3ldbIUV/s62cLbfIWMRAVFVtFhM7wTK+7tsX0fitSUH7rXUxt8sF03nCsDt7pkpRef2By//eu4c7DASwJUgOpwUIEfXrP9aVvFgWICzze1SRwVJUSZlR37MUO7k6supAsrctQAIZwJ51ENMlNxv7kN+88dcfSRDRxfkL/vprBVGldwV+HsqB3IyIVLmoz19MmI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5005296e-9c32-400d-0fd5-08d5f18f8139
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 18:01:39.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <Ben.Peart@microsoft.com>

If the new core.optimizecheckout config setting is set to true, speed up
"git checkout -b foo" by avoiding the work to merge the working tree.  This
is valid because no merge needs to occur - only creating the new branch/
updating the refs. Any other options force it through the old code path.

This change in behavior is off by default and behind the config setting so
that users have to opt-in to the optimized behavior.

We've been running with this patch internally for a long time but it was
rejected when I submitted it to the mailing list before because it
implicitly changes the behavior of checkout -b. Trying it again configured
behind a config setting as a potential solution for other optimizations to
checkout that could change the behavior as well.

https://public-inbox.org/git/20180724042740.GB13248@sigill.intra.peff.net/T=
/#m75afe3ab318d23f36334cf3a6e3d058839592469

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/f43d934ce7
    Checkout: git fetch https://github.com/benpeart/git checkout-b-v1 && gi=
t checkout f43d934ce7

 Documentation/config.txt |  6 +++
 builtin/checkout.c       | 94 ++++++++++++++++++++++++++++++++++++++++
 cache.h                  |  1 +
 config.c                 |  5 +++
 environment.c            |  1 +
 5 files changed, 107 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a32172a43c..2c4f513bf1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -911,6 +911,12 @@ core.commitGraph::
 	Enable git commit graph feature. Allows reading from the
 	commit-graph file.
=20
+core.optimizedCheckout
+	Speed up "git checkout -b foo" by skipping much of the work of a
+	full checkout command.  This changs the behavior as it will skip
+	merging the trees and updating the index and instead only create
+	and switch to the new ref.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28627650cd..b186a3201e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -41,6 +41,10 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	/*
+	 * If new checkout options are added, needs_working_tree_merge
+	 * should be updated accordingly.
+	 */
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -471,6 +475,88 @@ static void setup_branch_path(struct branch_info *bran=
ch)
 	branch->path =3D strbuf_detach(&buf, NULL);
 }
=20
+static int needs_working_tree_merge(const struct checkout_opts *opts,
+	const struct branch_info *old_branch_info,
+	const struct branch_info *new_branch_info)
+{
+	/*
+	 * We must do the merge if we are actually moving to a new
+	 * commit tree.
+	 */
+	if (!old_branch_info->commit || !new_branch_info->commit ||
+		oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->o=
bject.oid))
+		return 1;
+
+	/*
+	 * opts->patch_mode cannot be used with switching branches so is
+	 * not tested here
+	 */
+
+	/*
+	 * opts->quiet only impacts output so doesn't require a merge
+	 */
+
+	/*
+	 * Honor the explicit request for a three-way merge or to throw away
+	 * local changes
+	 */
+	if (opts->merge || opts->force)
+		return 1;
+
+	/*
+	 * --detach is documented as "updating the index and the files in the
+	 * working tree" but this optimization skips those steps so fall through
+	 * to the regular code path.
+	 */
+	if (opts->force_detach)
+		return 1;
+
+	/*
+	 * opts->writeout_stage cannot be used with switching branches so is
+	 * not tested here
+	 */
+
+	/*
+	 * Honor the explicit ignore requests
+	 */
+	if (!opts->overwrite_ignore || opts->ignore_skipworktree ||
+		opts->ignore_other_worktrees)
+		return 1;
+
+	/*
+	 * opts->show_progress only impacts output so doesn't require a merge
+	 */
+
+	/*
+	 * If we aren't creating a new branch any changes or updates will
+	 * happen in the existing branch.  Since that could only be updating
+	 * the index and working directory, we don't want to skip those steps
+	 * or we've defeated any purpose in running the command.
+	 */
+	if (!opts->new_branch)
+		return 1;
+
+	/*
+	 * new_branch_force is defined to "create/reset and checkout a branch"
+	 * so needs to go through the merge to do the reset
+	 */
+	if (opts->new_branch_force)
+		return 1;
+
+	/*
+	 * A new orphaned branch requrires the index and the working tree to be
+	 * adjusted to <start_point>
+	 */
+	if (opts->new_orphan_branch)
+		return 1;
+
+	/*
+	 * Remaining variables are not checkout options but used to track state
+	 */
+
+	return 0;
+}
+
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
@@ -479,6 +565,14 @@ static int merge_working_tree(const struct checkout_op=
ts *opts,
 	int ret;
 	struct lock_file lock_file =3D LOCK_INIT;
=20
+	/*
+	 * Skip merging the trees, updating the index, and work tree only if we
+	 * are simply creating a new branch via "git checkout -b foo."  Any
+	 * other options or usage will continue to do all these steps.
+	 */
+	if (core_optimize_checkout && !needs_working_tree_merge(opts, old_branch_=
info, new_branch_info))
+		return 0;
+
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
 		return error(_("index file corrupt"));
diff --git a/cache.h b/cache.h
index 8b447652a7..7f2b386c67 100644
--- a/cache.h
+++ b/cache.h
@@ -815,6 +815,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
+extern int core_optimize_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/config.c b/config.c
index 7968ef7566..b59a303e52 100644
--- a/config.c
+++ b/config.c
@@ -1319,6 +1319,11 @@ static int git_default_core_config(const char *var, =
const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.optimizecheckout")) {
+		core_optimize_checkout =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode =3D git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 013e845235..1991fb4855 100644
--- a/environment.c
+++ b/environment.c
@@ -68,6 +68,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_commit_graph;
 int core_apply_sparse_checkout;
+int core_optimize_checkout;
 int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition() *=
/
 unsigned long pack_size_limit_cfg;

base-commit: b7bd9486b055c3f967a870311e704e3bb0654e4f
--=20
2.17.0.gvfs.1.123.g449c066

