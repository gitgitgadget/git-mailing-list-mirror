Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371911F424
	for <e@80x24.org>; Thu, 26 Apr 2018 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756708AbeDZUw1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 16:52:27 -0400
Received: from mail-cys01nam02on0128.outbound.protection.outlook.com ([104.47.37.128]:23432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756394AbeDZUwY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 16:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wFsTgzH4mkBoMukoa1w3/3x972sbpXBUj0qgVKP26Zg=;
 b=Rdq2VPtlxdSNI6jQwSwoWx4upu2tovPq7DoeK9tf9BUhL3uOEljxjlrwla5wSru3I4iA2+33ZBxccv2g7Hl8nwhG+eMyuKm/IYnNgnOiGECEwWHe/aXOnyPNt265nQP30YaPk/8Y7YADsWHdNSwdoSTqOoBbsnQWhWFz0Hidapw=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0997.namprd21.prod.outlook.com (52.132.133.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.5; Thu, 26 Apr 2018 20:52:21 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.006; Thu, 26 Apr 2018
 20:52:21 +0000
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
Subject: [PATCH v3 2/3] merge: Add merge.renames config setting
Thread-Topic: [PATCH v3 2/3] merge: Add merge.renames config setting
Thread-Index: AQHT3aB4+RZmxwfcyEKGFcN7toWi4w==
Date:   Thu, 26 Apr 2018 20:52:21 +0000
Message-ID: <20180426205202.23056-3-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com>
In-Reply-To: <20180426205202.23056-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0084.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::44) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:7U/R7UBsBToLtNz1nctWb3QYP0kCHe1YZsZFg2yqpVpe8JEN0/TXJ7DoNklNRQuRBm/ozcsPVg3ZxK0AM3jr2OMARu8O6i39RwlBmnxhGsoYYZyyf8+iIENOcePlXqAVTlgQQhw6E2v4Hrp2F+ETpE5e+6nFbiShj3bFNVmGky6ZIjS+z8XprlKVhtZRKsuMqQqn/vUCKcTbJw+0oGJEtpR1zhizyXXrhIQt8hHEvUJ1igelOikBxqCsyEltBgzp;20:p2KlPu421OR1uP9MoJ+/vVBe4UOrFbDQfu9Ha0Owvl1FJpW7e87YzTYP0zsZuKn7JNIIGtKNQJzrXpNM5r61FkrzfWOo+IvlC07rryufcuWQyeFBLtfpZCYdkf0UM8kVCDGwUYRHEBGRzhYDXh/VHD14PlHzVh8uyxXhvoi1qiY=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09971270524F4B4FA319EF0DF48E0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(39380400002)(199004)(189003)(3846002)(39060400002)(106356001)(6116002)(97736004)(6916009)(81166006)(66066001)(2616005)(14454004)(53936002)(50226002)(6486002)(1730700003)(5640700003)(8676002)(6512007)(5250100002)(81156014)(1076002)(26005)(10090500001)(305945005)(8936002)(10290500003)(105586002)(25786009)(575784001)(4326008)(68736007)(54906003)(2906002)(52116002)(7736002)(86612001)(22452003)(5660300001)(478600001)(102836004)(186003)(72206003)(6436002)(446003)(2351001)(11346002)(386003)(8666007)(8656006)(76176011)(99286004)(486006)(316002)(6506007)(3280700002)(36756003)(3660700001)(59450400001)(2501003)(2900100001)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JkxNWDGO3nJliKkpf6jU4QSomRUen1bBzsSDGgljHEXCMkju4knmjXfYNTeDDOj+XOZlupJq+Fnnne0eR2in5mTQ24E2A2ZXPQBS5y551Q/1GYNbWtQF8pe6EWlL9u5McXnq05NEc+VgYkbGIGU+gjsUi1ll3L44LmR5uN/2UNYARbS/C0YZsdbhxHYyvnqI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cccbd075-ecaf-420b-a4ba-08d5abb79ac9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccbd075-ecaf-420b-a4ba-08d5abb79ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 20:52:21.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to control rename detection for merge via a config setting.
This setting behaves the same and defaults to the value of diff.renames but=
 only
applies to merge.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/merge-config.txt            |  6 ++++++
 Documentation/merge-strategies.txt        |  6 ++++--
 diff.c                                    |  2 +-
 diff.h                                    |  2 ++
 merge-recursive.c                         | 23 +++++++++++++++++------
 merge-recursive.h                         |  8 +++++++-
 t/t3034-merge-recursive-rename-options.sh | 18 ++++++++++++++++++
 7 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 48ee3bce77..59848e5634 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -38,6 +38,12 @@ merge.renameLimit::
 	diff.renameLimit. This setting has no effect if rename detection
 	is turned off.
=20
+merge.renames::
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enabled.  If set to "copies" or "copy", Git will
+	detect copies, as well.  Defaults to the value of diff.renames.
+
 merge.renormalize::
 	Tell Git that canonical representation of files in the
 	repository has changed over time (e.g. earlier commits record
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strat=
egies.txt
index 4a58aad4b8..1e0728aa12 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -84,12 +84,14 @@ no-renormalize;;
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
index 1289df4b1f..5dfc24aa6d 100644
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
index d29560f822..806faee2b3 100644
--- a/diff.h
+++ b/diff.h
@@ -324,6 +324,8 @@ extern int git_diff_ui_config(const char *var, const ch=
ar *value, void *cb);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int, const=
 char *);
 extern void diff_setup_done(struct diff_options *);
+extern int git_config_rename(const char *var, const char *value);
+
=20
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624d..2637d34d87 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -555,13 +555,13 @@ static struct string_list *get_renames(struct merge_o=
ptions *o,
 	struct diff_options opts;
=20
 	renames =3D xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
+	if (!merge_detect_rename(o))
 		return renames;
=20
 	diff_setup(&opts);
 	opts.flags.recursive =3D 1;
 	opts.flags.rename_empty =3D 0;
-	opts.detect_rename =3D DIFF_DETECT_RENAME;
+	opts.detect_rename =3D merge_detect_rename(o);
 	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_rename_limi=
t :
 			    o->diff_rename_limit >=3D 0 ? o->diff_rename_limit :
 			    1000;
@@ -2232,9 +2232,18 @@ int merge_recursive_generic(struct merge_options *o,
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
@@ -2244,10 +2253,11 @@ void init_merge_options(struct merge_options *o)
 	memset(o, 0, sizeof(struct merge_options));
 	o->verbosity =3D 2;
 	o->buffer_output =3D 1;
+	o->diff_detect_rename =3D -1;
+	o->merge_detect_rename =3D -1;
 	o->diff_rename_limit =3D -1;
 	o->merge_rename_limit =3D -1;
 	o->renormalize =3D 0;
-	o->detect_rename =3D 1;
 	merge_recursive_config(o);
 	merge_verbosity =3D getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
@@ -2298,18 +2308,19 @@ int parse_merge_opt(struct merge_options *o, const =
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
+
 	return 0;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 80d69d1401..0c5f7eff98 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -17,7 +17,8 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-	int detect_rename;
+	int diff_detect_rename;
+	int merge_detect_rename;
 	int diff_rename_limit;
 	int merge_rename_limit;
 	int rename_score;
@@ -28,6 +29,11 @@ struct merge_options {
 	struct hashmap current_file_dir_set;
 	struct string_list df_conflict_file_set;
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

