Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803851F406
	for <e@80x24.org>; Fri, 11 May 2018 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeEKM4o (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 08:56:44 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:52779
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753063AbeEKM4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 08:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xyf8o+qKwtzUzUGtPjP5kaahUAxmJL0QZcQ8Xq5uchc=;
 b=Y098kmqVzScVRhrlWHjNFAEdJHVmRUA2wZ6Y6g2+JvfiIGM+u6DAKmNSzmkAPiJQ7uThfA+1Tvx+CDpnesNGB+r6r70i/6dgBNhI+b+zT+kcyeLWV/CsPPPmx8GsdHXTZcYcZXTxFufJAPj1DjXQgareDDt++pUxkH4MCeByaGc=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0805.namprd21.prod.outlook.com (10.167.105.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.4; Fri, 11 May 2018 12:56:39 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::8836:b0d9:a86:ba1d]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::8836:b0d9:a86:ba1d%4]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 12:56:39 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3] add status config and command line options for rename
 detection
Thread-Topic: [PATCH v3] add status config and command line options for rename
 detection
Thread-Index: AQHT6SeAvv3n7bSlHEuB1vp4LykOPw==
Date:   Fri, 11 May 2018 12:56:39 +0000
Message-ID: <20180511125623.6068-1-benpeart@microsoft.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
In-Reply-To: <20180509144213.18032-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN6PR2001CA0044.namprd20.prod.outlook.com
 (2603:10b6:405:16::30) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:fEycszKKQWUWWwN0pY+YMAE2eQL+KBXUg1Ng0nkRRSTfH7Wu5c37ANI2mw4EY+OOxIkDj3/Xn1b0C0mPO+ANB5DIM53OimiuCo5DotPqRjJOqiRuepWZ8X4FZ9epMQ6WGsP6PwpBl3Eq1Gbtxpke75t+jE3j2fwdabLsMNQA29ThQG/BvzecMaGi74YEdTjwgoOLwboUrdgRlq01/aSJasyIx8w4PIc89PBAY9YgV12ZL6glaJzuedMY7KqSiIKs;20:tEvtmG7tnry8JlBJ3XzjFuwv2vDqeYZPq8TsNL3Bj8bpdSUyJxX028GTJNs8q7m202sMW2PGIhwvXMh3wZR46ImKHCAzw6TG5ET1li0/w8PaNwC7dY2bn1aUYutQi0N5wGPCtsri48Ciz3+nv2emmzVpum+q4GUySprIFi6e9Ek=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB08051D191BE3CB15225F9B48F49F0@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(189003)(199004)(14454004)(54906003)(22452003)(316002)(25786009)(386003)(102836004)(6916009)(6436002)(6486002)(66066001)(8656006)(2351001)(52116002)(59450400001)(106356001)(2900100001)(76176011)(99286004)(105586002)(6506007)(3660700001)(2501003)(3280700002)(68736007)(26005)(2906002)(4326008)(107886003)(7736002)(486006)(39060400002)(446003)(11346002)(2616005)(476003)(5660300001)(97736004)(186003)(53936002)(6306002)(478600001)(6512007)(5640700003)(72206003)(966005)(1730700003)(3846002)(53946003)(8936002)(81156014)(81166006)(5250100002)(1076002)(8666007)(86612001)(50226002)(10290500003)(575784001)(10090500001)(8676002)(6116002)(36756003)(305945005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1hVp3btT5oaW6XwudTC/SbdEfdl/0glp/r38Vyf0NMlls90VvtBYqFfGl01DwzWVJaTjos+5V3SmeI7Uk8Ldb0Jvqkfb/A36WcSKMJvznRqCOUGX7zA9AL2eBBK8qgPkrmQ3ZdLXTxlKGzCNyhQM/grJfKH0Gzo+kHu1Z4Fkkb83UlJgqYF5gphtGy8hl9aP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5ae42c20-8536-4c2f-2580-08d5b73ea2ae
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae42c20-8536-4c2f-2580-08d5b73ea2ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 12:56:39.7345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After performing a merge that has conflicts git status will, by default,
attempt to detect renames which causes many objects to be examined.  In a
virtualized repo, those objects do not exist locally so the rename logic
triggers them to be fetched from the server. This results in the status cal=
l
taking hours to complete on very large repos vs seconds with this patch.

Add a new config status.renames setting to enable turning off rename detect=
ion
during status and commit.  This setting will default to the value of
diff.renames.

Add a new config status.renamelimit setting to to enable bounding the time
spent finding out inexact renames during status and commit.  This setting w=
ill
default to the value of diff.renamelimit.

Add --no-renames command line option to status that enables overriding the
config setting from the command line. Add --find-renames[=3D<n>] command li=
ne
option to status that enables detecting renames and optionally setting the
similarity index.

This patch depends on em/status-rename-config

Original-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: commit dc6b1d92ca9c0c538daa244e3910bb8b2a50d959 (em/status-re=
name-config)
    Web-Diff: https://github.com/benpeart/git/commit/5bac43610b
    Checkout: git fetch https://github.com/benpeart/git status-renames-v3 &=
& git checkout 5bac43610b
   =20
    ### Interdiff (v2..v3):
   =20
    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index 9c8eca05b1..88884f1ead 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -3120,14 +3120,16 @@ status.displayCommentPrefix::
     	Defaults to false.
   =20
     status.renameLimit::
    -	The number of files to consider when performing rename detection;
    -	if not specified, defaults to the value of diff.renameLimit.
    +	The number of files to consider when performing rename detection
    +	in linkgit:git-status[1] and linkgit:git-commit[1]. Defaults to
    +	the value of diff.renameLimit.
   =20
     status.renames::
    -	Whether and how Git detects renames.  If set to "false",
    -	rename detection is disabled. If set to "true", basic rename
    -	detection is enabled.  If set to "copies" or "copy", Git will
    -	detect copies, as well.  Defaults to the value of diff.renames.
    +	Whether and how Git detects renames in linkgit:git-status[1] and
    +	linkgit:git-commit[1] .  If set to "false", rename detection is
    +	disabled. If set to "true", basic rename detection is enabled.
    +	If set to "copies" or "copy", Git will detect copies, as well.
    +	Defaults to the value of diff.renames.
   =20
     status.showStash::
     	If set to true, linkgit:git-status[1] will display the number of
    diff --git a/builtin/commit.c b/builtin/commit.c
    index db886277f4..b50e33ef48 100644
    --- a/builtin/commit.c
    +++ b/builtin/commit.c
    @@ -1373,6 +1373,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
     	if (no_renames !=3D -1)
     		s.detect_rename =3D !no_renames;
     	if ((intptr_t)rename_score_arg !=3D -1) {
    +		if (s.detect_rename < DIFF_DETECT_RENAME)
     			s.detect_rename =3D DIFF_DETECT_RENAME;
     		if (rename_score_arg)
     			s.rename_score =3D parse_rename_score(&rename_score_arg);
    diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
    old mode 100644
    new mode 100755
    index 311df8038a..ef8b1b3078
    --- a/t/t7525-status-rename.sh
    +++ b/t/t7525-status-rename.sh
    @@ -10,14 +10,13 @@ test_expect_success 'setup' '
     	git commit -m"Adding original file." &&
     	mv original renamed &&
     	echo 2 >> renamed &&
    -	git add .
    -'
    -
    -cat >.gitignore <<\EOF
    +	git add . &&
    +	cat >.gitignore <<-\EOF
     	.gitignore
     	expect*
     	actual*
     	EOF
    +'
   =20
     test_expect_success 'status no-options' '
     	git status >actual &&
    @@ -63,7 +62,18 @@ test_expect_success 'status status.renames=3Dtrue' '
     	test_i18ngrep "renamed:" actual
     '
   =20
    -test_expect_success 'status config overriden' '
    +test_expect_success 'commit honors status.renames=3Dfalse' '
    +	git -c status.renames=3Dfalse commit --dry-run >actual &&
    +	test_i18ngrep "deleted:" actual &&
    +	test_i18ngrep "new file:" actual
    +'
    +
    +test_expect_success 'commit honors status.renames=3Dtrue' '
    +	git -c status.renames=3Dtrue commit --dry-run >actual &&
    +	test_i18ngrep "renamed:" actual
    +'
    +
    +test_expect_success 'status config overridden' '
     	git -c status.renames=3Dtrue status --no-renames >actual &&
     	test_i18ngrep "deleted:" actual &&
     	test_i18ngrep "new file:" actual
    @@ -87,4 +97,17 @@ test_expect_success 'status score=3D01%' '
     	test_i18ngrep "renamed:" actual
     '
   =20
    +test_expect_success 'copies not overridden by find-rename' '
    +	cp renamed copy &&
    +	git add copy &&
    +
    +	git -c status.renames=3Dcopies status -M=3D01% >actual &&
    +	test_i18ngrep "copied:" actual &&
    +	test_i18ngrep "renamed:" actual &&
    +
    +	git -c status.renames=3Dcopies status --find-rename=3D01% >actual &&
    +	test_i18ngrep "copied:" actual &&
    +	test_i18ngrep "renamed:" actual
    +'
    +
     test_done
   =20
    ### Patches

 Documentation/config.txt     |  12 ++++
 Documentation/git-status.txt |  10 ++++
 builtin/commit.c             |  42 +++++++++++++
 diff.c                       |   2 +-
 diff.h                       |   1 +
 t/t7525-status-rename.sh     | 113 +++++++++++++++++++++++++++++++++++
 wt-status.c                  |  12 ++++
 wt-status.h                  |   4 +-
 8 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100755 t/t7525-status-rename.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..88884f1ead 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3119,6 +3119,18 @@ status.displayCommentPrefix::
 	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
 	Defaults to false.
=20
+status.renameLimit::
+	The number of files to consider when performing rename detection
+	in linkgit:git-status[1] and linkgit:git-commit[1]. Defaults to
+	the value of diff.renameLimit.
+
+status.renames::
+	Whether and how Git detects renames in linkgit:git-status[1] and
+	linkgit:git-commit[1] .  If set to "false", rename detection is
+	disabled. If set to "true", basic rename detection is enabled.
+	If set to "copies" or "copy", Git will detect copies, as well.
+	Defaults to the value of diff.renames.
+
 status.showStash::
 	If set to true, linkgit:git-status[1] will display the number of
 	entries currently stashed away.
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index c16e27e63d..c4467ffb98 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -135,6 +135,16 @@ ignored, then the directory is not shown, but all cont=
ents are shown.
 	Display or do not display detailed ahead/behind counts for the
 	branch relative to its upstream branch.  Defaults to true.
=20
+--renames::
+--no-renames::
+	Turn on/off rename detection regardless of user configuration.
+	See also linkgit:git-diff[1] `--no-renames`.
+
+--find-renames[=3D<n>]::
+	Turn on rename detection, optionally setting the similarity
+	threshold.
+	See also linkgit:git-diff[1] `--find-renames`.
+
 <pathspec>...::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 5240f11225..b50e33ef48 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -143,6 +143,16 @@ static int opt_parse_m(const struct option *opt, const=
 char *arg, int unset)
 	return 0;
 }
=20
+static int opt_parse_rename_score(const struct option *opt, const char *ar=
g, int unset)
+{
+	const char **value =3D opt->value;
+	if (arg !=3D NULL && *arg =3D=3D '=3D')
+		arg =3D arg + 1;
+
+	*value =3D arg;
+	return 0;
+}
+
 static void determine_whence(struct wt_status *s)
 {
 	if (file_exists(git_path_merge_head()))
@@ -1259,11 +1269,31 @@ static int git_status_config(const char *k, const c=
har *v, void *cb)
 			return error(_("Invalid untracked files mode '%s'"), v);
 		return 0;
 	}
+	if (!strcmp(k, "diff.renamelimit")) {
+		if (s->rename_limit =3D=3D -1)
+			s->rename_limit =3D git_config_int(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.renamelimit")) {
+		s->rename_limit =3D git_config_int(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "diff.renames")) {
+		if (s->detect_rename =3D=3D -1)
+			s->detect_rename =3D git_config_rename(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.renames")) {
+		s->detect_rename =3D git_config_rename(k, v);
+		return 0;
+	}
 	return git_diff_ui_config(k, v, NULL);
 }
=20
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
+	static int no_renames =3D -1;
+	static const char *rename_score_arg =3D (const char *)-1;
 	static struct wt_status s;
 	int fd;
 	struct object_id oid;
@@ -1297,6 +1327,10 @@ int cmd_status(int argc, const char **argv, const ch=
ar *prefix)
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked=
. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns"=
)),
+		OPT_BOOL(0, "no-renames", &no_renames, N_("do not detect renames")),
+		{ OPTION_CALLBACK, 'M', "find-renames", &rename_score_arg,
+		  N_("n"), N_("detect renames, optionally set similarity index"),
+		  PARSE_OPT_OPTARG, opt_parse_rename_score },
 		OPT_END(),
 	};
=20
@@ -1336,6 +1370,14 @@ int cmd_status(int argc, const char **argv, const ch=
ar *prefix)
 	s.ignore_submodule_arg =3D ignore_submodule_arg;
 	s.status_format =3D status_format;
 	s.verbose =3D verbose;
+	if (no_renames !=3D -1)
+		s.detect_rename =3D !no_renames;
+	if ((intptr_t)rename_score_arg !=3D -1) {
+		if (s.detect_rename < DIFF_DETECT_RENAME)
+			s.detect_rename =3D DIFF_DETECT_RENAME;
+		if (rename_score_arg)
+			s.rename_score =3D parse_rename_score(&rename_score_arg);
+	}
=20
 	wt_status_collect(&s);
=20
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
index d29560f822..dedac472ca 100644
--- a/diff.h
+++ b/diff.h
@@ -324,6 +324,7 @@ extern int git_diff_ui_config(const char *var, const ch=
ar *value, void *cb);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int, const=
 char *);
 extern void diff_setup_done(struct diff_options *);
+extern int git_config_rename(const char *var, const char *value);
=20
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
new file mode 100755
index 0000000000..ef8b1b3078
--- /dev/null
+++ b/t/t7525-status-rename.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description=3D'git status rename detection options'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 1 >original &&
+	git add . &&
+	git commit -m"Adding original file." &&
+	mv original renamed &&
+	echo 2 >> renamed &&
+	git add . &&
+	cat >.gitignore <<-\EOF
+	.gitignore
+	expect*
+	actual*
+	EOF
+'
+
+test_expect_success 'status no-options' '
+	git status >actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_expect_success 'status --no-renames' '
+	git status --no-renames >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'status.renames inherits from diff.renames false' '
+	git -c diff.renames=3Dfalse status >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'status.renames inherits from diff.renames true' '
+	git -c diff.renames=3Dtrue status >actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_expect_success 'status.renames overrides diff.renames false' '
+	git -c diff.renames=3Dtrue -c status.renames=3Dfalse status >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'status.renames overrides from diff.renames true' '
+	git -c diff.renames=3Dfalse -c status.renames=3Dtrue status >actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_expect_success 'status status.renames=3Dfalse' '
+	git -c status.renames=3Dfalse status >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'status status.renames=3Dtrue' '
+	git -c status.renames=3Dtrue status >actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_expect_success 'commit honors status.renames=3Dfalse' '
+	git -c status.renames=3Dfalse commit --dry-run >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'commit honors status.renames=3Dtrue' '
+	git -c status.renames=3Dtrue commit --dry-run >actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_expect_success 'status config overridden' '
+	git -c status.renames=3Dtrue status --no-renames >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'status score=3D100%' '
+	git status -M=3D100% >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual &&
+
+	git status --find-rename=3D100% >actual &&
+	test_i18ngrep "deleted:" actual &&
+	test_i18ngrep "new file:" actual
+'
+
+test_expect_success 'status score=3D01%' '
+	git status -M=3D01% >actual &&
+	test_i18ngrep "renamed:" actual &&
+
+	git status --find-rename=3D01% >actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_expect_success 'copies not overridden by find-rename' '
+	cp renamed copy &&
+	git add copy &&
+
+	git -c status.renames=3Dcopies status -M=3D01% >actual &&
+	test_i18ngrep "copied:" actual &&
+	test_i18ngrep "renamed:" actual &&
+
+	git -c status.renames=3Dcopies status --find-rename=3D01% >actual &&
+	test_i18ngrep "copied:" actual &&
+	test_i18ngrep "renamed:" actual
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 32f3bcaebd..172f07cbb0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -138,6 +138,9 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_stash =3D 0;
 	s->ahead_behind_flags =3D AHEAD_BEHIND_UNSPECIFIED;
 	s->display_comment_prefix =3D 0;
+	s->detect_rename =3D -1;
+	s->rename_score =3D -1;
+	s->rename_limit =3D -1;
 }
=20
 static void wt_longstatus_print_unmerged_header(struct wt_status *s)
@@ -592,6 +595,9 @@ static void wt_status_collect_changes_worktree(struct w=
t_status *s)
 	}
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
+	rev.diffopt.detect_rename =3D s->detect_rename >=3D 0 ? s->detect_rename =
: rev.diffopt.detect_rename;
+	rev.diffopt.rename_limit =3D s->rename_limit >=3D 0 ? s->rename_limit : r=
ev.diffopt.rename_limit;
+	rev.diffopt.rename_score =3D s->rename_score >=3D 0 ? s->rename_score : r=
ev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 }
@@ -625,6 +631,9 @@ static void wt_status_collect_changes_index(struct wt_s=
tatus *s)
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data =3D s;
+	rev.diffopt.detect_rename =3D s->detect_rename >=3D 0 ? s->detect_rename =
: rev.diffopt.detect_rename;
+	rev.diffopt.rename_limit =3D s->rename_limit >=3D 0 ? s->rename_limit : r=
ev.diffopt.rename_limit;
+	rev.diffopt.rename_score =3D s->rename_score >=3D 0 ? s->rename_score : r=
ev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 }
@@ -982,6 +991,9 @@ static void wt_longstatus_print_verbose(struct wt_statu=
s *s)
 	setup_revisions(0, NULL, &rev, &opt);
=20
 	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
+	rev.diffopt.detect_rename =3D s->detect_rename >=3D 0 ? s->detect_rename =
: rev.diffopt.detect_rename;
+	rev.diffopt.rename_limit =3D s->rename_limit >=3D 0 ? s->rename_limit : r=
ev.diffopt.rename_limit;
+	rev.diffopt.rename_score =3D s->rename_score >=3D 0 ? s->rename_score : r=
ev.diffopt.rename_score;
 	rev.diffopt.file =3D s->fp;
 	rev.diffopt.close_file =3D 0;
 	/*
diff --git a/wt-status.h b/wt-status.h
index 430770b854..1673d146fa 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -89,7 +89,9 @@ struct wt_status {
 	int show_stash;
 	int hints;
 	enum ahead_behind_flags ahead_behind_flags;
-
+	int detect_rename;
+	int rename_score;
+	int rename_limit;
 	enum wt_status_format status_format;
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
=20

base-commit: dc6b1d92ca9c0c538daa244e3910bb8b2a50d959
--=20
2.17.0.windows.1

