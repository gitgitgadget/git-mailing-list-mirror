Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8528FC46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 09:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjIRJ3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjIRJ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 05:28:56 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6DC10B
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695029312; x=1695634112; i=l.s.r@web.de;
 bh=nmgcw5fxVk7b4cbPLvUaUCSjx9U22nfPsTHPAAYE0n4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=r3NCE4yJ2I39rfyXBeIkq5zmPJr/HoBxMJL1bjT14+m1853VCp5FsNcpTGXqz78Ca1qTP/7Vda/
 N5Q866YHr0J2fBcUNVkCmq0awjS50dJfedC0HCk+Iy7frqlVjSVIq8avGA75wVmzT4j0UI98UUID8
 IgQjgabOM6a9NI52qU29OhYfiLrEQqiAogZd4XkRNXiYISmB5FtZyfgX95Wbq86DoX7d2KjDcgKzH
 p0pKznq23f+snJzj1wRlf0Qg35/hChnPKiBNvjJ8gd0k26Xhp4pn7BV2A1ahazucL09+2PFC4aYkT
 H7DPaPXQ1Yyz7O+x7o29D+gmrkcUX9XiK8xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgyj-1rYtdX0Tkt-00v8Y0; Mon, 18
 Sep 2023 11:28:32 +0200
Message-ID: <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
Date:   Mon, 18 Sep 2023 11:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqa5tmau6e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9KvcY1HcLTTl9oXJtn0blIjWYmtYTITgwwIt0J6eVeLJ6dBcAkX
 mMty6U/NxNa3oewxeT3WIflmH4v69AkwHXZmcuSTApzROHPi0VPuZ+uo3KVCS2RDo/Hp2HI
 lx/+hzj3HHhTpRuQBXIVZNhV5aJKFToZh5wXvZWBHYDxhB7n88AxWa11F0HsHsYexgUq6oQ
 NNPyJ/7y1NUWegbYondGA==
UI-OutboundReport: notjunk:1;M01:P0:jlsADg6WRTs=;pvb407jZUNMwDa+v8y0qNMOUh73
 EFxkOMkv2hIld/xnlvXlgKj/xDeRk0+aQ7/7ReJPhWrUmjEFuUHMq5/TFkLMb3MQi0XOof6OV
 5WcE66BTVWwGW5+fWR/6ZgN7FWiLl11WNrIO+4Z6D6Ewvef3ip0GeWsQ7On5TRNVBZFqLI/zN
 uuZB1IuNIXSWhhXIH+jTKe/dRC9wUP1C8gSHbtinkBolHAdpGe7p/8Btgi/1Fj2dC9bwW0Bbr
 aEtSWB7UnajPR9iAVNjo0OYA9XzxNmfr+byRlaiBgQQWbAIFg9ZE37k31Hxl+FkzQ9yHxueSM
 fR77JRXiDz6ydop2bk7H9P9F5uMwcgNiMrMEJjieGs54CNTJx3Vy7yCi/RbSLO1Re3FRMp9xg
 VN0F0iFx/mTy9rDw9oxbx4CRPkZwI/CH9EM/Q0sIO7d5ye0WDMKZMrTw0qxJK6hbxM1zrx6v5
 knTBwgkbOwnBXQnlf7WEQ9lAgzTiAC2ep8ENaRrG/dF+vu9fRjS0PpREHc2IH9u4t6m1aWOHU
 g2tljvFfgTW6Bul9HYSSPvUr3z2+wyaVommxgBAAZcBQc1lhEHMQHi7Ja0xBB86pP1ByJp6Xa
 FkpCQLmVYJ9OPkfQRclTf7eaTFAiTT95wRwTw/9fNeGeMUUXhLVIHE+7IxgKfLhSlt6is8muV
 uDCD1Yl0WCtwa0ogqPjDTHrtYuhxQkwkB9u0JLV8ifb/w1TIcAqDeOusvUd6PZmi6gu+1T5tJ
 5oNRQ5bN7ZJaKA880vM4ueZFD9PErkEdO3pQAJAHAxTJwxLTgmgwdCscIDXcQljBgkns96mKx
 qIdBztGkxd9wledRqDNmXJ62MXqe5knuOzECcdOjQwxS8QpwiofpxExrVmqsKQe9zhP+LQ/3w
 TV8TLjjJ/CQbf85P1UkP6RfuYePo/tD1iYLysIvZl1zvhy6bXRaaLDNeFDACbf910CueNVo11
 EDo6sMJ7yi14+MT3cCD1CVCvhc4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.09.23 um 19:45 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>>> True.  Though I don't fully understand these warnings (why not then
>>> also warn about if without else?), but taking them away is a bit rude
>>> to those who care.
>>
>> I think losing warnings is unfortunate, but it's just one example.
>> We're losing the type information completely from the values.
>> ...
>>> Or to use an int to point to and then copy into a companion enum
>>> variable to after parsing, which would be my choice.
>>
>> Yeah, I had the same thought. I'm just not sure how to do that in a way
>> that isn't a pain for the callers.
>
> The discussion seems to have petered out around this point.
> What (if anything) do we want to do with this topic?

Here's a version that preserves the enums by using additional int
variables just for the parsing phase.  No tricks.  The diff is long, but
most changes aren't particularly complicated and the resulting code is
not that ugly.  Except for builtin/am.c perhaps, which changes the
command mode value using a callback as well.

=2D-- >8 ---
Subject: [PATCH v2 2/2] parse-options: use and require int pointer for OPT=
_CMDMODE

Some uses of OPT_CMDMODE provide a pointer to an enum.  It is
dereferenced as an int pointer in parse-options.c::get_value().  The two
types are incompatible, though -- the storage size of an enum can vary
between platforms.  C23 would allow us to specify the underlying type of
the diffenrent enums, making them compatible, but with C99 the easiest
safe option is to actually use int as the value type.

Convert the offending OPT_CMDMODE users to point to a new int value and
set the enum value after parsing.  Switch to the typed value_int pointer
in the macro's definition to enforce that type for future users.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c         | 24 +++++++++++++-----------
 builtin/help.c       | 16 +++++++++-------
 builtin/ls-tree.c    | 12 +++++++-----
 builtin/rebase.c     | 15 +++++++++------
 builtin/replace.c    | 12 +++++++-----
 builtin/stripspace.c |  6 ++++--
 parse-options.h      |  2 +-
 7 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 202040b62e..00930e2152 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2270,13 +2270,14 @@ enum resume_type {

 struct resume_mode {
 	enum resume_type mode;
+	int mode_int;
 	enum show_patch_type sub_mode;
 };

 static int parse_opt_show_current_patch(const struct option *opt, const c=
har *arg, int unset)
 {
 	int *opt_value =3D opt->value;
-	struct resume_mode *resume =3D container_of(opt_value, struct resume_mod=
e, mode);
+	struct resume_mode *resume =3D container_of(opt_value, struct resume_mod=
e, mode_int);

 	/*
 	 * Please update $__git_showcurrentpatch in git-completion.bash
@@ -2300,12 +2301,12 @@ static int parse_opt_show_current_patch(const stru=
ct option *opt, const char *ar
 				     "--show-current-patch", arg);
 	}

-	if (resume->mode =3D=3D RESUME_SHOW_PATCH && new_value !=3D resume->sub_=
mode)
+	if (resume->mode_int =3D=3D RESUME_SHOW_PATCH && new_value !=3D resume->=
sub_mode)
 		return error(_("options '%s=3D%s' and '%s=3D%s' "
 					   "cannot be used together"),
 					 "--show-current-patch", "--show-current-patch", arg, valid_modes[re=
sume->sub_mode]);

-	resume->mode =3D RESUME_SHOW_PATCH;
+	resume->mode_int =3D RESUME_SHOW_PATCH;
 	resume->sub_mode =3D new_value;
 	return 0;
 }
@@ -2316,7 +2317,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 	int binary =3D -1;
 	int keep_cr =3D -1;
 	int patch_format =3D PATCH_FORMAT_UNKNOWN;
-	struct resume_mode resume =3D { .mode =3D RESUME_FALSE };
+	struct resume_mode resume =3D { .mode_int =3D RESUME_FALSE };
 	int in_progress;
 	int ret =3D 0;

@@ -2387,27 +2388,27 @@ int cmd_am(int argc, const char **argv, const char=
 *prefix)
 			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
-		OPT_CMDMODE(0, "continue", &resume.mode,
+		OPT_CMDMODE(0, "continue", &resume.mode_int,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE('r', "resolved", &resume.mode,
+		OPT_CMDMODE('r', "resolved", &resume.mode_int,
 			N_("synonyms for --continue"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE(0, "skip", &resume.mode,
+		OPT_CMDMODE(0, "skip", &resume.mode_int,
 			N_("skip the current patch"),
 			RESUME_SKIP),
-		OPT_CMDMODE(0, "abort", &resume.mode,
+		OPT_CMDMODE(0, "abort", &resume.mode_int,
 			N_("restore the original branch and abort the patching operation"),
 			RESUME_ABORT),
-		OPT_CMDMODE(0, "quit", &resume.mode,
+		OPT_CMDMODE(0, "quit", &resume.mode_int,
 			N_("abort the patching operation but keep HEAD where it is"),
 			RESUME_QUIT),
-		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
+		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode_int,
 		  "(diff|raw)",
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LI=
TERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
-		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+		OPT_CMDMODE(0, "allow-empty", &resume.mode_int,
 			N_("record the empty patch as an empty commit"),
 			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -2439,6 +2440,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		am_load(&state);

 	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
+	resume.mode =3D resume.mode_int;

 	if (binary >=3D 0)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long =
time, and\n"
diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b98..d76f88d544 100644
=2D-- a/builtin/help.c
+++ b/builtin/help.c
@@ -51,6 +51,7 @@ static enum help_action {
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
+static int cmd_mode_int;

 static const char *html_path;
 static int verbose =3D 1;
@@ -59,7 +60,7 @@ static int exclude_guides;
 static int show_external_commands =3D -1;
 static int show_aliases =3D -1;
 static struct option builtin_help_options[] =3D {
-	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
+	OPT_CMDMODE('a', "all", &cmd_mode_int, N_("print all available commands"=
),
 		    HELP_ACTION_ALL),
 	OPT_BOOL(0, "external-commands", &show_external_commands,
 		 N_("show external commands in --all")),
@@ -72,19 +73,19 @@ static struct option builtin_help_options[] =3D {
 			HELP_FORMAT_INFO),
 	OPT__VERBOSE(&verbose, N_("print command description")),

-	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
+	OPT_CMDMODE('g', "guides", &cmd_mode_int, N_("print list of useful guide=
s"),
 		    HELP_ACTION_GUIDES),
-	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
+	OPT_CMDMODE(0, "user-interfaces", &cmd_mode_int,
 		    N_("print list of user-facing repository, command and file interfac=
es"),
 		    HELP_ACTION_USER_INTERFACES),
-	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode,
+	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode_int,
 		    N_("print list of file formats, protocols and other developer inter=
faces"),
 		    HELP_ACTION_DEVELOPER_INTERFACES),
-	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variab=
le names"),
+	OPT_CMDMODE('c', "config", &cmd_mode_int, N_("print all configuration va=
riable names"),
 		    HELP_ACTION_CONFIG),
-	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
+	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode_int, "",
 		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
-	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
+	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode_int, "",
 		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),

 	OPT_END(),
@@ -640,6 +641,7 @@ int cmd_help(int argc, const char **argv, const char *=
prefix)
 	argc =3D parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format =3D help_format;
+	cmd_mode =3D cmd_mode_int;

 	if (cmd_mode !=3D HELP_ACTION_ALL &&
 	    (show_external_commands >=3D 0 ||
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 209d2dc0d5..c64b38614a 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -346,7 +346,8 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 	int i, full_tree =3D 0;
 	int full_name =3D !prefix || !*prefix;
 	read_tree_fn_t fn =3D NULL;
-	enum ls_tree_cmdmode cmdmode =3D MODE_DEFAULT;
+	enum ls_tree_cmdmode cmdmode;
+	int cmdmode_int =3D MODE_DEFAULT;
 	int null_termination =3D 0;
 	struct ls_tree_options options =3D { 0 };
 	const struct option ls_tree_options[] =3D {
@@ -358,13 +359,13 @@ int cmd_ls_tree(int argc, const char **argv, const c=
har *prefix)
 			LS_SHOW_TREES),
 		OPT_BOOL('z', NULL, &null_termination,
 			 N_("terminate entries with NUL byte")),
-		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
+		OPT_CMDMODE('l', "long", &cmdmode_int, N_("include object size"),
 			    MODE_LONG),
-		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
+		OPT_CMDMODE(0, "name-only", &cmdmode_int, N_("list only filenames"),
 			    MODE_NAME_ONLY),
-		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
+		OPT_CMDMODE(0, "name-status", &cmdmode_int, N_("list only filenames"),
 			    MODE_NAME_STATUS),
-		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
+		OPT_CMDMODE(0, "object-only", &cmdmode_int, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
 		OPT_BOOL(0, "full-name", &full_name, N_("use full path names")),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -384,6 +385,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
 	options.null_termination =3D null_termination;
+	cmdmode =3D cmdmode_int;

 	if (full_tree)
 		prefix =3D NULL;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..6dbe57f0ac 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1061,6 +1061,7 @@ static int check_exec_cmd(const char *cmd)
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options =3D REBASE_OPTIONS_INIT;
+	int action;
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress =3D 0;
 	int keep_base =3D 0;
@@ -1116,18 +1117,18 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
 		OPT_BIT(0, "no-ff", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
-		OPT_CMDMODE(0, "continue", &options.action, N_("continue"),
+		OPT_CMDMODE(0, "continue", &action, N_("continue"),
 			    ACTION_CONTINUE),
-		OPT_CMDMODE(0, "skip", &options.action,
+		OPT_CMDMODE(0, "skip", &action,
 			    N_("skip current patch and continue"), ACTION_SKIP),
-		OPT_CMDMODE(0, "abort", &options.action,
+		OPT_CMDMODE(0, "abort", &action,
 			    N_("abort and check out the original branch"),
 			    ACTION_ABORT),
-		OPT_CMDMODE(0, "quit", &options.action,
+		OPT_CMDMODE(0, "quit", &action,
 			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
-		OPT_CMDMODE(0, "edit-todo", &options.action, N_("edit the todo list "
+		OPT_CMDMODE(0, "edit-todo", &action, N_("edit the todo list "
 			    "during an interactive rebase"), ACTION_EDIT_TODO),
-		OPT_CMDMODE(0, "show-current-patch", &options.action,
+		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
 		OPT_CALLBACK_F(0, "apply", &options, NULL,
@@ -1233,10 +1234,12 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
 	if (options.type !=3D REBASE_UNSPECIFIED)
 		in_progress =3D 1;

+	action =3D options.action;
 	total_argc =3D argc;
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
+	options.action =3D action;

 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges\n"
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..205c337ad3 100644
=2D-- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -554,12 +554,13 @@ int cmd_replace(int argc, const char **argv, const c=
har *prefix)
 		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
 	} cmdmode =3D MODE_UNSPECIFIED;
+	int cmdmode_int =3D cmdmode;
 	struct option options[] =3D {
-		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
-		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DE=
LETE),
-		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDI=
T),
-		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MO=
DE_GRAFT),
-		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing gra=
ft file"), MODE_CONVERT_GRAFT_FILE),
+		OPT_CMDMODE('l', "list", &cmdmode_int, N_("list replace refs"), MODE_LI=
ST),
+		OPT_CMDMODE('d', "delete", &cmdmode_int, N_("delete replace refs"), MOD=
E_DELETE),
+		OPT_CMDMODE('e', "edit", &cmdmode_int, N_("edit existing object"), MODE=
_EDIT),
+		OPT_CMDMODE('g', "graft", &cmdmode_int, N_("change a commit's parents")=
, MODE_GRAFT),
+		OPT_CMDMODE(0, "convert-graft-file", &cmdmode_int, N_("convert existing=
 graft file"), MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit"))=
,
@@ -572,6 +573,7 @@ int cmd_replace(int argc, const char **argv, const cha=
r *prefix)

 	argc =3D parse_options(argc, argv, prefix, options, git_replace_usage, 0=
);

+	cmdmode =3D cmdmode_int;
 	if (!cmdmode)
 		cmdmode =3D argc ? MODE_REPLACE : MODE_LIST;

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..e8efa0e7ac 100644
=2D-- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -33,13 +33,14 @@ int cmd_stripspace(int argc, const char **argv, const =
char *prefix)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	enum stripspace_mode mode =3D STRIP_DEFAULT;
+	int mode_int =3D mode;
 	int nongit;

 	const struct option options[] =3D {
-		OPT_CMDMODE('s', "strip-comments", &mode,
+		OPT_CMDMODE('s', "strip-comments", &mode_int,
 			    N_("skip and remove all lines starting with comment character"),
 			    STRIP_COMMENTS),
-		OPT_CMDMODE('c', "comment-lines", &mode,
+		OPT_CMDMODE('c', "comment-lines", &mode_int,
 			    N_("prepend comment character and space to each line"),
 			    COMMENT_LINES),
 		OPT_END()
@@ -49,6 +50,7 @@ int cmd_stripspace(int argc, const char **argv, const ch=
ar *prefix)
 	if (argc)
 		usage_with_options(stripspace_usage, options);

+	mode =3D mode_int;
 	if (mode =3D=3D STRIP_COMMENTS || mode =3D=3D COMMENT_LINES) {
 		setup_git_directory_gently(&nongit);
 		git_config(git_default_config, NULL);
diff --git a/parse-options.h b/parse-options.h
index 5e7475bd2d..349c3fca04 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -262,7 +262,7 @@ struct option {
 	.type =3D OPTION_SET_INT, \
 	.short_name =3D (s), \
 	.long_name =3D (l), \
-	.value =3D (v), \
+	.value_int =3D (v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), \
 	.defval =3D (i), \
=2D-
2.42.0
