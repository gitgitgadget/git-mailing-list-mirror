Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CB421847
	for <e@80x24.org>; Wed,  2 May 2018 16:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeEBQBW (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 12:01:22 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:10962
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750954AbeEBQBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 12:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yBJQHBpjs2YNt+19DAohgoIvylK8N71wH019lh9wCX4=;
 b=gp1lcOP6pm2B65X3mgG6VIjL0kj+4H4jP8v+5+izHaBkzixfAz3cPszfnNzpgY3ZpczEwtkZAA0naJMDCY/gSy/UIVDUWPT9TKYODFzyIW32POfxvk0gyg+KfIS1i6Le5L1mB0+LgiPAJwRrNlhRqRQZ83GPs7gx/rYx5oteMUE=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (52.132.133.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Wed, 2 May 2018 16:01:14 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0755.002; Wed, 2 May 2018
 16:01:14 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: [PATCH v4 2/3] merge: Add merge.renames config setting
Thread-Topic: [PATCH v4 2/3] merge: Add merge.renames config setting
Thread-Index: AQHT4i7MkXRRMSvFsE+77C7PZ8yGGg==
Date:   Wed, 2 May 2018 16:01:14 +0000
Message-ID: <20180502160056.5836-3-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180502160056.5836-1-benpeart@microsoft.com>
In-Reply-To: <20180502160056.5836-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:403:2::26) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:PNV1+nNzP6YtDZBJHXfdzEpFjota8ayGYYkWtqRa0/9/wK14sj58JCAuLfyOvtdhsTnA/nQC4gG5hhHQp1vODHdBWONAgy0P7MLZjTO82Z0i8iOxKS/jyZl2oUL4M2OhzNpv8wSbbeSbrBD46uzDgppFRLLMLqWnsFN6G6d2DYQwrDYfCREVIo1cMThOntfQzN2EqOL17GzwFqt3SbqW0u1Gu3aP5bIvu9vlKELhy9yyPGxlZJN2Yf4wkcVTeGI2;20:fAwxY17vf+W/6nn211k1gUs2Fhi52iI3syRayBeAa8Wlwqd1iFlL8nfGnTMrpWSvaBOSl+gFGaEG3/CmVezrlmOPa3iAs7JCU+P1Npd6rKQ2aZFF5Wtfz7BHoa7JUfl2ycrbGBuhfBntTFidngq7zTkdOG/YCU7Ldbc5mJc0mnw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
x-microsoft-antispam-prvs: <DM5PR2101MB10157AF3134EC6DFB539B73BF4800@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(36756003)(39060400002)(102836004)(6346003)(486006)(26005)(25786009)(81166006)(81156014)(1730700003)(8676002)(14454004)(5640700003)(68736007)(316002)(54906003)(22452003)(11346002)(476003)(186003)(2616005)(52116002)(6116002)(76176011)(2906002)(59450400001)(386003)(6506007)(66066001)(3846002)(1076002)(446003)(86612001)(2351001)(53936002)(6486002)(478600001)(50226002)(6436002)(3280700002)(10090500001)(7736002)(8656006)(72206003)(305945005)(10290500003)(99286004)(5250100002)(4326008)(8936002)(105586002)(2900100001)(106356001)(97736004)(2501003)(8666007)(5660300001)(6512007)(3660700001)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: mtL2+aeZcOrsQb3BrV9eoRWOf9yA6c19ge7NbJaDKsHlBPw5mDrozf/FecTQ1Xl+bAplryzBvE279tWkjCZXbC7tJS8SOgsVWT2EsIhJNuSI2ydju3gD8hJvvq8a9yZ0EGo1hwZNs3xFKArf62UYkHxOA6Kp4rzmuGnIc7VVd13FPUetnK7rKz1l0WKckn0X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bb0be15c-6a61-4797-07a6-08d5b045ee8e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0be15c-6a61-4797-07a6-08d5b045ee8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 16:01:14.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to control rename detection for merge via a config setting.
This setting behaves the same and defaults to the value of diff.renames but=
 only
applies to merge.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/merge-config.txt            |  5 ++++
 Documentation/merge-strategies.txt        | 11 ++++++---
 diff.c                                    |  2 +-
 diff.h                                    |  1 +
 merge-recursive.c                         | 30 ++++++++++++++++++-----
 merge-recursive.h                         |  8 +++++-
 t/t3034-merge-recursive-rename-options.sh | 18 ++++++++++++++
 7 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 48ee3bce77..662c2713ca 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -38,6 +38,11 @@ merge.renameLimit::
 	diff.renameLimit. This setting has no effect if rename detection
 	is turned off.
=20
+merge.renames::
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enabled.  Defaults to the value of diff.renames.
+
 merge.renormalize::
 	Tell Git that canonical representation of files in the
 	repository has changed over time (e.g. earlier commits record
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strat=
egies.txt
index fd5d748d1b..30acc99232 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -23,8 +23,9 @@ recursive::
 	causing mismerges by tests done on actual merge commits
 	taken from Linux 2.6 kernel development history.
 	Additionally this can detect and handle merges involving
-	renames.  This is the default merge strategy when
-	pulling or merging one branch.
+	renames, but currently cannot make use of detected
+	copies.  This is the default merge strategy when pulling
+	or merging one branch.
 +
 The 'recursive' strategy can take the following options:
=20
@@ -84,12 +85,14 @@ no-renormalize;;
 	`merge.renormalize` configuration variable.
=20
 no-renames;;
-	Turn off rename detection.
+	Turn off rename detection. This overrides the `merge.renames`
+	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
=20
 find-renames[=3D<n>];;
 	Turn on rename detection, optionally setting the similarity
-	threshold.  This is the default.
+	threshold.  This is the default. This overrides the
+	'merge.renames' configuration variable.
 	See also linkgit:git-diff[1] `--find-renames`.
=20
 rename-threshold=3D<n>;;
diff --git a/diff.c b/diff.c
index fb22b19f09..e744b35cdc 100644
--- a/diff.c
+++ b/diff.c
@@ -177,7 +177,7 @@ static int parse_submodule_params(struct diff_options *=
options, const char *valu
 	return 0;
 }
=20
-static int git_config_rename(const char *var, const char *value)
+int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
 		return DIFF_DETECT_RENAME;
diff --git a/diff.h b/diff.h
index 7cf276f077..966fc8fce6 100644
--- a/diff.h
+++ b/diff.h
@@ -321,6 +321,7 @@ extern int git_diff_ui_config(const char *var, const ch=
ar *value, void *cb);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int, const=
 char *);
 extern void diff_setup_done(struct diff_options *);
+extern int git_config_rename(const char *var, const char *value);
=20
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
diff --git a/merge-recursive.c b/merge-recursive.c
index 5f42c677d5..372ffbbacc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1524,7 +1524,15 @@ static struct diff_queue_struct *get_diffpairs(struc=
t merge_options *o,
 	diff_setup(&opts);
 	opts.flags.recursive =3D 1;
 	opts.flags.rename_empty =3D 0;
-	opts.detect_rename =3D DIFF_DETECT_RENAME;
+	opts.detect_rename =3D merge_detect_rename(o);
+	/*
+	 * We do not have logic to handle the detection of copies.  In
+	 * fact, it may not even make sense to add such logic: would we
+	 * really want a change to a base file to be propagated through
+	 * multiple other files by a merge?
+	 */
+	if (opts.detect_rename > DIFF_DETECT_RENAME)
+		opts.detect_rename =3D DIFF_DETECT_RENAME;
 	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_rename_limi=
t :
 			    o->diff_rename_limit >=3D 0 ? o->diff_rename_limit :
 			    1000;
@@ -2564,7 +2572,7 @@ static int handle_renames(struct merge_options *o,
 	ri->head_renames =3D NULL;
 	ri->merge_renames =3D NULL;
=20
-	if (!o->detect_rename)
+	if (!merge_detect_rename(o))
 		return 1;
=20
 	head_pairs =3D get_diffpairs(o, common, head);
@@ -3241,9 +3249,18 @@ int merge_recursive_generic(struct merge_options *o,
=20
 static void merge_recursive_config(struct merge_options *o)
 {
+	char *value =3D NULL;
 	git_config_get_int("merge.verbosity", &o->verbosity);
 	git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
 	git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
+	if (!git_config_get_string("diff.renames", &value)) {
+		o->diff_detect_rename =3D git_config_rename("diff.renames", value);
+		free(value);
+	}
+	if (!git_config_get_string("merge.renames", &value)) {
+		o->merge_detect_rename =3D git_config_rename("merge.renames", value);
+		free(value);
+	}
 	git_config(git_xmerge_config, NULL);
 }
=20
@@ -3256,7 +3273,8 @@ void init_merge_options(struct merge_options *o)
 	o->diff_rename_limit =3D -1;
 	o->merge_rename_limit =3D -1;
 	o->renormalize =3D 0;
-	o->detect_rename =3D 1;
+	o->diff_detect_rename =3D -1;
+	o->merge_detect_rename =3D -1;
 	merge_recursive_config(o);
 	merge_verbosity =3D getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
@@ -3307,16 +3325,16 @@ int parse_merge_opt(struct merge_options *o, const =
char *s)
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize =3D 0;
 	else if (!strcmp(s, "no-renames"))
-		o->detect_rename =3D 0;
+		o->merge_detect_rename =3D 0;
 	else if (!strcmp(s, "find-renames")) {
-		o->detect_rename =3D 1;
+		o->merge_detect_rename =3D 1;
 		o->rename_score =3D 0;
 	}
 	else if (skip_prefix(s, "find-renames=3D", &arg) ||
 		 skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg !=
=3D 0)
 			return -1;
-		o->detect_rename =3D 1;
+		o->merge_detect_rename =3D 1;
 	}
 	else
 		return -1;
diff --git a/merge-recursive.h b/merge-recursive.h
index d863cf8867..c1d9b5b3d9 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -18,7 +18,8 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-	int detect_rename;
+	int diff_detect_rename;
+	int merge_detect_rename;
 	int diff_rename_limit;
 	int merge_rename_limit;
 	int rename_score;
@@ -55,6 +56,11 @@ struct collision_entry {
 	struct string_list source_files;
 	unsigned reported_already:1;
 };
+inline int merge_detect_rename(struct merge_options *o)
+{
+	return o->merge_detect_rename >=3D 0 ? o->merge_detect_rename :
+		o->diff_detect_rename >=3D 0 ? o->diff_detect_rename : 1;
+}
=20
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-recu=
rsive-rename-options.sh
index b9c4028496..3d9fae68c4 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -309,4 +309,22 @@ test_expect_success 'last wins in --find-renames=3D<m>=
 --rename-threshold=3D<n>' '
 	check_threshold_0
 '
=20
+test_expect_success 'merge.renames disables rename detection' '
+	git read-tree --reset -u HEAD &&
+	git -c merge.renames=3Dfalse merge-recursive $tail &&
+	check_no_renames
+'
+
+test_expect_success 'merge.renames defaults to diff.renames' '
+	git read-tree --reset -u HEAD &&
+	git -c diff.renames=3Dfalse merge-recursive $tail &&
+	check_no_renames
+'
+
+test_expect_success 'merge.renames overrides diff.renames' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git -c diff.renames=3Dfalse -c merge.renames=3Dtrue merge-=
recursive $tail &&
+	$check_50
+'
+
 test_done
--=20
2.17.0.windows.1

