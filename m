Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE831F406
	for <e@80x24.org>; Thu, 10 May 2018 14:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965267AbeEJOQn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:16:43 -0400
Received: from mail-dm3nam03on0098.outbound.protection.outlook.com ([104.47.41.98]:1760
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934609AbeEJOQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GRcL9l4d9hM5+qTCdKGOO2VQecubZzDNoWC38YjIrSM=;
 b=lg8Y2pqIqUI1w/GFZxthRhsLJaoo9c380L7Hp/bewahT31mtiBGtrqyqo8y2wZZi7Ay/P63VXVUl/0a5a64cRuDOnw0yIoa7q5cYKNYGMiE2FALpdIYMQ4G4T7pPqy9/ZID2fBP2BvW+Rq1+9Qo6GH+Uam+jRRXR1vPKKnE1Iz0=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0920.namprd21.prod.outlook.com (52.132.132.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 14:16:37 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::8836:b0d9:a86:ba1d]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::8836:b0d9:a86:ba1d%4]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 14:16:37 +0000
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
Subject: [PATCH v2] add status config and command line options for rename
 detection
Thread-Topic: [PATCH v2] add status config and command line options for rename
 detection
Thread-Index: AQHT6GmBb4bhXYTMXESoBb465AkblA==
Date:   Thu, 10 May 2018 14:16:37 +0000
Message-ID: <20180510141621.9668-1-benpeart@microsoft.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
In-Reply-To: <20180509144213.18032-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0085.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::45) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:LckcO7rptMkQhroXziRWXp+9CtDq8gCWm5PFrV3+ZGCrEbn7817A4M4Zc6TkO3x+f83Ml/f1AmG77cqFrRD+jYQOrLaGQpsiaBBw+vR9nE8kN9Cdwtjl38JVBn8doGjupG52UNQjdt5Q/4inufsG9qckWp1yUjqeOBS6zrWFfFnEVpCWHKdiyP11ATFX7j2S2JPYlzsoa/W75Vpj51cyYOtXryISrAALY3lROtNwOYVu/Q6bnnRDF+e12nvQ0siz;20:c+xukd2sFjhO94tMykC3gkK/A4nZGIthMdNWY4Z4OtT3qb7h6+T2pfTllw/EZLZHmSn60hx/xVWHFDatnOEFZ6D/q1NTog6XQoZHpKdD7duT5ZcLcmmUdqEXYVFHpm0T5jHTsePXIlxwSqdKQt7sTTkjA7nQeKcli58JpuGfeS0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
x-microsoft-antispam-prvs: <DM5PR2101MB092004037B6A1A48D4EAF534F4980@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(8936002)(99286004)(6436002)(52116002)(76176011)(2616005)(102836004)(26005)(446003)(50226002)(6486002)(53936002)(186003)(966005)(3280700002)(25786009)(7736002)(22452003)(10290500003)(3660700001)(54906003)(478600001)(11346002)(6506007)(97736004)(8656006)(86612001)(59450400001)(386003)(2906002)(2900100001)(316002)(486006)(2351001)(6346003)(72206003)(10090500001)(8666007)(2501003)(14454004)(53946003)(5660300001)(68736007)(66066001)(107886003)(36756003)(5250100002)(476003)(39060400002)(6116002)(4326008)(6306002)(106356001)(6512007)(81156014)(1730700003)(3846002)(8676002)(105586002)(5640700003)(305945005)(81166006)(1076002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: kq+/MxIGIrLw8FLYsqul8uSoBJEvCs4K137yDNh4iw7f/5C3EvPMOnxZf2pyux2VPfa6S3/nainx5Z0RgZrOtu/+0VZozMwhNAP4OrwcZdMNQjneI/ILwy5srlHUxuN0TzVy3QH6GM/uhheqYoDQPSRj/ZHFfW/+gvYBC+XrAf9IkfgAaBuXVpfG2lUqFkkN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 49aaadf4-58b5-43c8-94e0-08d5b680a3d2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49aaadf4-58b5-43c8-94e0-08d5b680a3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 14:16:37.1474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After performing a merge that has conflicts, git status will by default att=
empt
to detect renames which causes many objects to be examined.  In a virtualiz=
ed
repo, those objects do not exist locally so the rename logic triggers them =
to be
fetched from the server. This results in the status call taking hours to
complete on very large repos.  Even in a small repo (the GVFS repo) turning=
 off
break and rename detection has a significant impact:

git status --no-renames:
31 secs., 105 loose object downloads

git status --no-breaks
7 secs., 17 loose object downloads

git status --no-breaks --no-renames
1 sec., 1 loose object download

Add a new config status.renames setting to enable turning off rename detect=
ion
during status.  This setting will default to the value of diff.renames.

Add a new config status.renamelimit setting to to enable bounding the time =
spent
finding out inexact renames during status.  This setting will default to th=
e
value of diff.renamelimit.

Add status --no-renames command line option that enables overriding the con=
fig
setting from the command line. Add --find-renames[=3D<n>] to enable detecti=
ng
renames and optionally setting the similarity index from the command line.

Note: I removed the --no-breaks command line option from the original patch=
 as
it will no longer be needed once the default has been changed [1] to turn i=
t off.

[1] https://public-inbox.org/git/20180430093421.27551-2-eckhard.s.maass@gma=
il.com/

Original-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/823212725b
    Checkout: git fetch https://github.com/benpeart/git status-renames-v2 &=
& git checkout 823212725b
   =20
    ### Interdiff (v1..v2):
   =20
    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index b79b83c587..9c8eca05b1 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -3126,7 +3126,8 @@ status.renameLimit::
     status.renames::
     	Whether and how Git detects renames.  If set to "false",
     	rename detection is disabled. If set to "true", basic rename
    -	detection is enabled.  Defaults to the value of diff.renames.
    +	detection is enabled.  If set to "copies" or "copy", Git will
    +	detect copies, as well.  Defaults to the value of diff.renames.
   =20
     status.showStash::
     	If set to true, linkgit:git-status[1] will display the number of
    diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
    index c16e27e63d..c4467ffb98 100644
    --- a/Documentation/git-status.txt
    +++ b/Documentation/git-status.txt
    @@ -135,6 +135,16 @@ ignored, then the directory is not shown, but all =
contents are shown.
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
    index a545096ddd..db886277f4 100644
    --- a/builtin/commit.c
    +++ b/builtin/commit.c
    @@ -109,10 +109,6 @@ static int have_option_m;
     static struct strbuf message =3D STRBUF_INIT;
   =20
     static enum wt_status_format status_format =3D STATUS_FORMAT_UNSPECIFI=
ED;
    -static int diff_detect_rename =3D -1;
    -static int status_detect_rename =3D -1;
    -static int diff_rename_limit =3D -1;
    -static int status_rename_limit =3D -1;
   =20
     static int opt_parse_porcelain(const struct option *opt, const char *a=
rg, int unset)
     {
    @@ -1274,19 +1270,21 @@ static int git_status_config(const char *k, con=
st char *v, void *cb)
     		return 0;
     	}
     	if (!strcmp(k, "diff.renamelimit")) {
    -		diff_rename_limit =3D git_config_int(k, v);
    +		if (s->rename_limit =3D=3D -1)
    +			s->rename_limit =3D git_config_int(k, v);
     		return 0;
     	}
     	if (!strcmp(k, "status.renamelimit")) {
    -		status_rename_limit =3D git_config_int(k, v);
    +		s->rename_limit =3D git_config_int(k, v);
     		return 0;
     	}
     	if (!strcmp(k, "diff.renames")) {
    -		diff_detect_rename =3D git_config_rename(k, v);
    +		if (s->detect_rename =3D=3D -1)
    +			s->detect_rename =3D git_config_rename(k, v);
     		return 0;
     	}
     	if (!strcmp(k, "status.renames")) {
    -		status_detect_rename =3D git_config_rename(k, v);
    +		s->detect_rename =3D git_config_rename(k, v);
     		return 0;
     	}
     	return git_diff_ui_config(k, v, NULL);
    @@ -1372,27 +1370,13 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
     	s.ignore_submodule_arg =3D ignore_submodule_arg;
     	s.status_format =3D status_format;
     	s.verbose =3D verbose;
    -	s.detect_rename =3D no_renames >=3D 0 ? !no_renames :
    -					  status_detect_rename >=3D 0 ? status_detect_rename :
    -					  diff_detect_rename >=3D 0 ? diff_detect_rename :
    -					  s.detect_rename;
    +	if (no_renames !=3D -1)
    +		s.detect_rename =3D !no_renames;
     	if ((intptr_t)rename_score_arg !=3D -1) {
     		s.detect_rename =3D DIFF_DETECT_RENAME;
     		if (rename_score_arg)
     			s.rename_score =3D parse_rename_score(&rename_score_arg);
     	}
    -	s.rename_limit =3D status_rename_limit >=3D 0 ? status_rename_limit :
    -					 diff_rename_limit >=3D 0 ? diff_rename_limit :
    -					 s.rename_limit;
    -
    -	/*
    -	 * We do not have logic to handle the detection of copies.  In
    -	 * fact, it may not even make sense to add such logic: would we
    -	 * really want a change to a base file to be propagated through
    -	 * multiple other files by a merge?
    -	 */
    -	if (s.detect_rename > DIFF_DETECT_RENAME)
    -		s.detect_rename =3D DIFF_DETECT_RENAME;
   =20
     	wt_status_collect(&s);
   =20
    ### Patches

 Documentation/config.txt     | 10 ++++
 Documentation/git-status.txt | 10 ++++
 builtin/commit.c             | 41 ++++++++++++++++
 diff.c                       |  2 +-
 diff.h                       |  1 +
 t/t7525-status-rename.sh     | 90 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 12 +++++
 wt-status.h                  |  4 +-
 8 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 t/t7525-status-rename.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..9c8eca05b1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3119,6 +3119,16 @@ status.displayCommentPrefix::
 	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
 	Defaults to false.
=20
+status.renameLimit::
+	The number of files to consider when performing rename detection;
+	if not specified, defaults to the value of diff.renameLimit.
+
+status.renames::
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enabled.  If set to "copies" or "copy", Git will
+	detect copies, as well.  Defaults to the value of diff.renames.
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
index 5240f11225..db886277f4 100644
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
@@ -1336,6 +1370,13 @@ int cmd_status(int argc, const char **argv, const ch=
ar *prefix)
 	s.ignore_submodule_arg =3D ignore_submodule_arg;
 	s.status_format =3D status_format;
 	s.verbose =3D verbose;
+	if (no_renames !=3D -1)
+		s.detect_rename =3D !no_renames;
+	if ((intptr_t)rename_score_arg !=3D -1) {
+		s.detect_rename =3D DIFF_DETECT_RENAME;
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
new file mode 100644
index 0000000000..311df8038a
--- /dev/null
+++ b/t/t7525-status-rename.sh
@@ -0,0 +1,90 @@
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
+	git add .
+'
+
+cat >.gitignore <<\EOF
+.gitignore
+expect*
+actual*
+EOF
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
+test_expect_success 'status config overriden' '
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

base-commit: a92ae92585d8db14b7871f760f157256cd96742c
--=20
2.17.0.windows.1

