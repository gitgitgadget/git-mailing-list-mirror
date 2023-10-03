Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51BDE75433
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbjJCItl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJCItk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:49:40 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D6DA9
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696322955; x=1696927755; i=l.s.r@web.de;
 bh=k8Z2wGzXE2AHNxb6KPv2FStbietWv6ZAaj3G+DY50p4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=akNlPBEP+9pI+dBurtcWRvAPgzY2bh/YDtHMqBPXy9+aEFVcluFAtUamWSGkzFB6E4u8ATNVqX6
 Gj0d1PSwkkFH1GgQWh0IQ/kaJux+fx5YBp6QJcnTXZqqXpX/BioVnx9H8HCihomkpI/TlF/OVHgyo
 /aNbT+WaCGwlFcdtoCGy5xGT4ET5HWyW77BoBuLMhypuHuT5JOcnn+iM7uK5LRpcW/o1B+0b8cQNO
 /ih9JoQGLNpd6Ks1S0LFbrSs2BZVmc/AS8VvJ/83DA8w2hG2xn9h5qXZIZwGTjeVDyUS91BVTSQPB
 ckG4o3y4AGh8uuywMiQlEDPrrrf99W40TjkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR4R-1rf0UY3ANZ-00sKmE; Tue, 03
 Oct 2023 10:49:15 +0200
Message-ID: <6cb09270-04b9-456e-8d7e-97137e56e9e2@web.de>
Date:   Tue, 3 Oct 2023 10:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g> <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
 <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com> <xmqqedivl832.fsf@gitster.g>
 <000ff1b9-e7a5-4dd6-bc61-4b6761f66997@gmail.com>
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <000ff1b9-e7a5-4dd6-bc61-4b6761f66997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dhJaEqBQuJDy450bwpwsZE9fUNn3kZ/horP94uMzVwTnYHui/d
 CCc/gRPbpfz+/bDCOO515uyrYsbZfM20eTAOctbVGne98gUeUTD/3AdBHX+1Mt/83/WLrjV
 0sxTqiglG2V3zHaXegVPBaDVzKl/4DB9Gu8QaMSys4ZzAx0sFmpfEikYIlbf9cU5eW9RMJC
 GOQXGL7d2e5Di/Q93B05Q==
UI-OutboundReport: notjunk:1;M01:P0:gzlWSFA+YZY=;xJyeYsfNHWz7NJ2qPFhHHKt2D9s
 Z2w2eBO2/rFo/LZI9ZHw28ux+vNRnsgn93uzxECH1Is4K1gSFLGecvv7P6uSOq/LJEaaBgZbG
 SlywIYqN7J/AgTWyWoNmbhKzzNZmFvuPBWN0QugLPUctrSUNPAKgeqXcM62q1HKyGuH7YGgm+
 XU6TcUtAnZsJrR+hwVeVvy5fY5oA46eGXsNNv5La4akyYix2CGH8JmvQTdxOVbypnVnovbm5M
 d07Smgc02R8AtpH/t/HJ5rK9sJKZyBC8XPVs9QXFPV5XEkHtyNsQ2d6MfSjjBM6kAbzFol/vU
 nmbu39p16K1+hOZZ8AdTe+ilOKcJndp5Ub04H8F+kzF8CEJqzf/agRBK2t6F8HQXbhtL7TdTE
 KoUoWZarOKrGwDX/6UxViBiL0HbxKmBqJNAX6Pg2pJSf9QRV7vfmswkt1s2T/YxgDlOPew9iH
 mHzU08SeM9DjZc7I+Mzo3VJkaJnELSmeY6nbbPi+TK34hFgiVV0eYyIFGJsYOmQHo5+NvY7XH
 ZZzsFR23HQNJ3RW4MMYkrmeOishaxwvm/K6I8V0cskN87+HCcDfywzOhWol93SIe1uHKlsfmd
 DXy/Ecn6fmWjoTlzjoVIc6seNGPGNPkOLVadeODcOs+No97/M2uNGbnK+ebxu/6jAYIoYQOYo
 BD9iC14v9rheSJr8JCXoisGdVagMzjfTNKMDJnEYvBDXExUfg2VSG+hzU3XT8a3gaf2BRoVT8
 7dfSmXyvT+bg869BIVTmVmcNuax7FqhIywXjxrTgvcLi0vEYBahPo+VvhF/+RM2IJga12wpad
 TP5aRYEDlR9ZBeryp3HFUP+rs8kIrfEj2Z98Q717glpz1j+38iDqcczS1FG/09lCBYgXju9mo
 DqEoiIiu14kIVWm/1lghAMzsiQzeg330pQ2wmsAROnhlTFEjrkkkshaxSORREAjTdm+cRG6Nq
 17Te9NvtF0M7qwQNsUNer2UgvXk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.09.23 um 21:48 schrieb Phillip Wood:
> On 18/09/2023 18:11, Junio C Hamano wrote:
>>> Then in builtin/am.c at the top level we'd add
>>>
>>> MAKE_CMDMODE_SETTER(resume_type)
>>>
>>> and change the option definitions to look like
>>>
>>> OPT_CMDMODE(0, "continue", resume_type, &resume.mode, ...)
>>
>> Yup, that is ergonomic and corrects "The shape of a particular enum
>> may not match 'int'" issue nicely.=C2=A0 I do not know how severe the
>> problem is that it is not quite type safe that we cannot enforce
>> resume_type is the same as typeof(resume.mode) here, though.
>
> We could use gcc's __builtin_types_compatible_p() if we're prepared to h=
ave two definitions of OPT_CMDMODE_F
>
> #if defined(__GNUC__)
> #define OPT_CMDMODE_F(s, l, n, v, h, i, f) { \
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0.defval (i) + \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUILD_ASSERT_OR_ZERO(__builti=
n_types_compatible_p(enum n, __typeof__(v))), \
> }
> #else
> #define OPT_CMDMODE_F(s, l, n, v, h, i, f) { \
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0.defval (i), \
> }
> #endif
>
> Best Wishes
>
> Phillip

That would work, but we can do a type check without a compiler builtin
by creating a function for that purpose.  How about this?

=2D-- >8 ---
Subject: [PATCH] parse-options: make OPT_CMDMODE type-safe

Some uses of OPT_CMDMODE point to an enum as value, but the option
parser dereferences it as an int pointer.  Depending on the platform,
pointers to int and enums can be incompatible.

Add value accessor functions to struct option to dereference the pointer
safely, use them for PARSE_OPT_CMDMODE error detection and in the new
OPTION_SET_VALUE option type, add a typed version of OPT_CMDMODE named
OPT_CMDMODE_T, make OPT_CMDMODE only accept int and convert enum users
to declare the appropriate type.

The accessor functions for each type must be defined using
DEFINE_OPTION_VALUE_TYPE.  OPT_CMDMODE needs the ones for int, so we
define them centrally in parse-options.h.

builtin/am.c::parse_opt_show_current_patch() uses the value pointer just
to calculate the offset of the enclosing struct resume_mode, making the
pointer type inconsequential.  Use the correct type instead of int *
regardless, for consistency.

The enum used with OPT_CMDMODE in builtin/replace.c was anonymous.  Give
it a name to allow specifying it in DEFINE_OPTION_VALUE_TYPE and then
OPT_CMDMODE_T.

Suggested-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/technical/api-parse-options.txt |  7 ++++
 builtin/am.c                                  | 32 ++++++++++------
 builtin/help.c                                | 37 +++++++++++--------
 builtin/ls-tree.c                             | 18 +++++----
 builtin/rebase.c                              | 33 ++++++++++-------
 builtin/replace.c                             | 37 ++++++++++++-------
 builtin/stripspace.c                          | 14 ++++---
 parse-options.c                               | 20 +++++++++-
 parse-options.h                               | 36 ++++++++++++++++--
 9 files changed, 159 insertions(+), 75 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation=
/technical/api-parse-options.txt
index 61fa6ee167..3958ab7c94 100644
=2D-- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -278,6 +278,13 @@ There are some macros to easily define options:
 	option has already set its value to the same `int_var`.
 	In new commands consider using subcommands instead.

+`OPT_CMDMODE_T(short, long, type_name, &enum_var, description, enum_val)`=
::
+	Same as `OPT_CMDMODE`, but allows specifying an enum variable
+	instead of an int.
+	Requires `DEFINE_OPTION_VALUE_TYPE(type_name, enum_type);` at
+	file scope to declare `type_name`; `enum_type` must be the type
+	of `enum_var`.
+
 `OPT_SUBCOMMAND(long, &fn_ptr, subcommand_fn)`::
 	Define a subcommand.  `subcommand_fn` is put into `fn_ptr` when
 	this subcommand is used.
diff --git a/builtin/am.c b/builtin/am.c
index 6655059a57..4642dc5099 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2268,6 +2268,8 @@ enum resume_type {
 	RESUME_ALLOW_EMPTY,
 };

+DEFINE_OPTION_VALUE_TYPE(resume_type, enum resume_type);
+
 struct resume_mode {
 	enum resume_type mode;
 	enum show_patch_type sub_mode;
@@ -2275,7 +2277,7 @@ struct resume_mode {

 static int parse_opt_show_current_patch(const struct option *opt, const c=
har *arg, int unset)
 {
-	int *opt_value =3D opt->value;
+	enum resume_type *opt_value =3D opt->value;
 	struct resume_mode *resume =3D container_of(opt_value, struct resume_mod=
e, mode);

 	/*
@@ -2388,27 +2390,33 @@ int cmd_am(int argc, const char **argv, const char=
 *prefix)
 			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
-		OPT_CMDMODE(0, "continue", &resume.mode,
+		OPT_CMDMODE_T(0, "continue", resume_type, &resume.mode,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE('r', "resolved", &resume.mode,
+		OPT_CMDMODE_T('r', "resolved", resume_type, &resume.mode,
 			N_("synonyms for --continue"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE(0, "skip", &resume.mode,
+		OPT_CMDMODE_T(0, "skip", resume_type, &resume.mode,
 			N_("skip the current patch"),
 			RESUME_SKIP),
-		OPT_CMDMODE(0, "abort", &resume.mode,
+		OPT_CMDMODE_T(0, "abort", resume_type, &resume.mode,
 			N_("restore the original branch and abort the patching operation"),
 			RESUME_ABORT),
-		OPT_CMDMODE(0, "quit", &resume.mode,
+		OPT_CMDMODE_T(0, "quit", resume_type, &resume.mode,
 			N_("abort the patching operation but keep HEAD where it is"),
 			RESUME_QUIT),
-		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
-		  "(diff|raw)",
-		  N_("show the patch being applied"),
-		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LI=
TERAL_ARGHELP,
-		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
-		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+		{
+			.type =3D OPTION_CALLBACK,
+			.long_name =3D "show-current-patch",
+			OPTION_VALUE(resume_type, &resume.mode),
+			.argh =3D "(diff|raw)",
+			.help =3D N_("show the patch being applied"),
+			.flags =3D PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG |
+				 PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			.callback =3D parse_opt_show_current_patch,
+			.defval =3D RESUME_SHOW_PATCH,
+		},
+		OPT_CMDMODE_T(0, "allow-empty", resume_type, &resume.mode,
 			N_("record the empty patch as an empty commit"),
 			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b98..48437c8636 100644
=2D-- a/builtin/help.c
+++ b/builtin/help.c
@@ -52,6 +52,8 @@ static enum help_action {
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;

+DEFINE_OPTION_VALUE_TYPE(help_action, enum help_action);
+
 static const char *html_path;
 static int verbose =3D 1;
 static enum help_format help_format =3D HELP_FORMAT_NONE;
@@ -59,8 +61,8 @@ static int exclude_guides;
 static int show_external_commands =3D -1;
 static int show_aliases =3D -1;
 static struct option builtin_help_options[] =3D {
-	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
-		    HELP_ACTION_ALL),
+	OPT_CMDMODE_T('a', "all", help_action, &cmd_mode,
+		      N_("print all available commands"), HELP_ACTION_ALL),
 	OPT_BOOL(0, "external-commands", &show_external_commands,
 		 N_("show external commands in --all")),
 	OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all")),
@@ -72,20 +74,23 @@ static struct option builtin_help_options[] =3D {
 			HELP_FORMAT_INFO),
 	OPT__VERBOSE(&verbose, N_("print command description")),

-	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
-		    HELP_ACTION_GUIDES),
-	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
-		    N_("print list of user-facing repository, command and file interfac=
es"),
-		    HELP_ACTION_USER_INTERFACES),
-	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode,
-		    N_("print list of file formats, protocols and other developer inter=
faces"),
-		    HELP_ACTION_DEVELOPER_INTERFACES),
-	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variab=
le names"),
-		    HELP_ACTION_CONFIG),
-	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
-		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
-	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
-		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_T('g', "guides", help_action, &cmd_mode,
+		      N_("print list of useful guides"), HELP_ACTION_GUIDES),
+	OPT_CMDMODE_T(0, "user-interfaces", help_action, &cmd_mode,
+		      N_("print list of user-facing repository, command and file interf=
aces"),
+		      HELP_ACTION_USER_INTERFACES),
+	OPT_CMDMODE_T(0, "developer-interfaces", help_action, &cmd_mode,
+		      N_("print list of file formats, protocols and other developer int=
erfaces"),
+		      HELP_ACTION_DEVELOPER_INTERFACES),
+	OPT_CMDMODE_T('c', "config", help_action, &cmd_mode,
+		      N_("print all configuration variable names"),
+		      HELP_ACTION_CONFIG),
+	OPT_CMDMODE_T_F(0, "config-for-completion", help_action, &cmd_mode, "",
+			HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_T_F(0, "config-sections-for-completion",
+			help_action, &cmd_mode, "",
+			HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
+			PARSE_OPT_HIDDEN),

 	OPT_END(),
 };
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 209d2dc0d5..2e7faf510d 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -339,6 +339,8 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_f=
ormat[] =3D {
 	},
 };

+DEFINE_OPTION_VALUE_TYPE(cmdmode, enum ls_tree_cmdmode);
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
@@ -358,14 +360,14 @@ int cmd_ls_tree(int argc, const char **argv, const c=
har *prefix)
 			LS_SHOW_TREES),
 		OPT_BOOL('z', NULL, &null_termination,
 			 N_("terminate entries with NUL byte")),
-		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
-			    MODE_LONG),
-		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
-			    MODE_NAME_ONLY),
-		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
-			    MODE_NAME_STATUS),
-		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
-			    MODE_OBJECT_ONLY),
+		OPT_CMDMODE_T('l', "long", cmdmode, &cmdmode,
+			      N_("include object size"), MODE_LONG),
+		OPT_CMDMODE_T(0, "name-only", cmdmode, &cmdmode,
+			      N_("list only filenames"), MODE_NAME_ONLY),
+		OPT_CMDMODE_T(0, "name-status", cmdmode, &cmdmode,
+			      N_("list only filenames"), MODE_NAME_STATUS),
+		OPT_CMDMODE_T(0, "object-only", cmdmode, &cmdmode,
+			      N_("list only objects"), MODE_OBJECT_ONLY),
 		OPT_BOOL(0, "full-name", &full_name, N_("use full path names")),
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ed15accec9..50739327bd 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -75,6 +75,8 @@ enum action {
 	ACTION_SHOW_CURRENT_PATCH
 };

+DEFINE_OPTION_VALUE_TYPE(action, enum action);
+
 static const char *action_names[] =3D {
 	"undefined",
 	"continue",
@@ -1116,20 +1118,23 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
 		OPT_BIT(0, "no-ff", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
-		OPT_CMDMODE(0, "continue", &options.action, N_("continue"),
-			    ACTION_CONTINUE),
-		OPT_CMDMODE(0, "skip", &options.action,
-			    N_("skip current patch and continue"), ACTION_SKIP),
-		OPT_CMDMODE(0, "abort", &options.action,
-			    N_("abort and check out the original branch"),
-			    ACTION_ABORT),
-		OPT_CMDMODE(0, "quit", &options.action,
-			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
-		OPT_CMDMODE(0, "edit-todo", &options.action, N_("edit the todo list "
-			    "during an interactive rebase"), ACTION_EDIT_TODO),
-		OPT_CMDMODE(0, "show-current-patch", &options.action,
-			    N_("show the patch file being applied or merged"),
-			    ACTION_SHOW_CURRENT_PATCH),
+		OPT_CMDMODE_T(0, "continue", action, &options.action,
+			      N_("continue"), ACTION_CONTINUE),
+		OPT_CMDMODE_T(0, "skip", action, &options.action,
+			      N_("skip current patch and continue"),
+			      ACTION_SKIP),
+		OPT_CMDMODE_T(0, "abort", action, &options.action,
+			      N_("abort and check out the original branch"),
+			      ACTION_ABORT),
+		OPT_CMDMODE_T(0, "quit", action, &options.action,
+			      N_("abort but keep HEAD where it is"),
+			      ACTION_QUIT),
+		OPT_CMDMODE_T(0, "edit-todo", action, &options.action,
+			      N_("edit the todo list during an interactive rebase"),
+			      ACTION_EDIT_TODO),
+		OPT_CMDMODE_T(0, "show-current-patch", action, &options.action,
+			      N_("show the patch file being applied or merged"),
+			      ACTION_SHOW_CURRENT_PATCH),
 		OPT_CALLBACK_F(0, "apply", &options, NULL,
 			N_("use apply strategies to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..09aebc9de2 100644
=2D-- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -539,27 +539,36 @@ static int convert_graft_file(int force)

 	return -1;
 }
+enum cmdmode {
+	MODE_UNSPECIFIED =3D 0,
+	MODE_LIST,
+	MODE_DELETE,
+	MODE_EDIT,
+	MODE_GRAFT,
+	MODE_CONVERT_GRAFT_FILE,
+	MODE_REPLACE
+};
+
+DEFINE_OPTION_VALUE_TYPE(cmdmode, enum cmdmode);

 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force =3D 0;
 	int raw =3D 0;
 	const char *format =3D NULL;
-	enum {
-		MODE_UNSPECIFIED =3D 0,
-		MODE_LIST,
-		MODE_DELETE,
-		MODE_EDIT,
-		MODE_GRAFT,
-		MODE_CONVERT_GRAFT_FILE,
-		MODE_REPLACE
-	} cmdmode =3D MODE_UNSPECIFIED;
+	enum cmdmode cmdmode =3D MODE_UNSPECIFIED;
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
+		OPT_CMDMODE_T('l', "list", cmdmode, &cmdmode,
+			      N_("list replace refs"), MODE_LIST),
+		OPT_CMDMODE_T('d', "delete", cmdmode, &cmdmode,
+			      N_("delete replace refs"), MODE_DELETE),
+		OPT_CMDMODE_T('e', "edit", cmdmode, &cmdmode,
+			      N_("edit existing object"), MODE_EDIT),
+		OPT_CMDMODE_T('g', "graft", cmdmode, &cmdmode,
+			      N_("change a commit's parents"), MODE_GRAFT),
+		OPT_CMDMODE_T(0, "convert-graft-file", cmdmode, &cmdmode,
+			      N_("convert existing graft file"),
+			      MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit"))=
,
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..82b9a95a4f 100644
=2D-- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -29,6 +29,8 @@ enum stripspace_mode {
 	COMMENT_LINES
 };

+DEFINE_OPTION_VALUE_TYPE(mode, enum stripspace_mode);
+
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -36,12 +38,12 @@ int cmd_stripspace(int argc, const char **argv, const =
char *prefix)
 	int nongit;

 	const struct option options[] =3D {
-		OPT_CMDMODE('s', "strip-comments", &mode,
-			    N_("skip and remove all lines starting with comment character"),
-			    STRIP_COMMENTS),
-		OPT_CMDMODE('c', "comment-lines", &mode,
-			    N_("prepend comment character and space to each line"),
-			    COMMENT_LINES),
+		OPT_CMDMODE_T('s', "strip-comments", mode, &mode,
+			      N_("skip and remove all lines starting with comment character"),
+			      STRIP_COMMENTS),
+		OPT_CMDMODE_T('c', "comment-lines", mode, &mode,
+			      N_("prepend comment character and space to each line"),
+			      COMMENT_LINES),
 		OPT_END()
 	};

diff --git a/parse-options.c b/parse-options.c
index e8e076c3a6..63a2247128 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -85,7 +85,7 @@ static enum parse_opt_result opt_command_mode_error(
 		if (that =3D=3D opt ||
 		    !(that->flags & PARSE_OPT_CMDMODE) ||
 		    that->value !=3D opt->value ||
-		    that->defval !=3D *(int *)opt->value)
+		    that->defval !=3D opt->get_value(opt->value))
 			continue;

 		if (that->long_name)
@@ -122,7 +122,8 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 	 * is not a grave error, so let it pass.
 	 */
 	if ((opt->flags & PARSE_OPT_CMDMODE) &&
-	    *(int *)opt->value && *(int *)opt->value !=3D opt->defval)
+	    opt->get_value(opt->value) &&
+	    opt->get_value(opt->value) !=3D opt->defval)
 		return opt_command_mode_error(opt, all_opts, flags);

 	switch (opt->type) {
@@ -160,6 +161,10 @@ static enum parse_opt_result get_value(struct parse_o=
pt_ctx_t *p,
 		*(int *)opt->value =3D unset ? 0 : opt->defval;
 		return 0;

+	case OPTION_SET_VALUE:
+		opt->set_value(opt->value, unset ? 0 : opt->defval);
+		return 0;
+
 	case OPTION_STRING:
 		if (unset)
 			*(const char **)opt->value =3D NULL;
@@ -483,11 +488,21 @@ static void parse_options_check(const struct option =
*opts)
 		if (opts->type =3D=3D OPTION_SET_INT && !opts->defval &&
 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
+		if (opts->type =3D=3D OPTION_SET_VALUE && !opts->defval &&
+		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
+			optbug(opts, "OPTION_SET_VALUE 0 should not be negatable");
+		if (opts->type =3D=3D OPTION_SET_VALUE &&
+		    (!opts->get_value || !opts->set_value))
+			optbug(opts, "OPTION_SET_VALUE requires accessors");
+		if ((opts->flags & PARSE_OPT_CMDMODE) &&
+		    (!opts->get_value || !opts->set_value))
+			optbug(opts, "PARSE_OPT_CMDMODE requires accessors");
 		switch (opts->type) {
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_SET_INT:
+		case OPTION_SET_VALUE:
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
@@ -611,6 +626,7 @@ static void show_negated_gitcomp(const struct option *=
opts, int show_all,
 		case OPTION_NEGBIT:
 		case OPTION_COUNTUP:
 		case OPTION_SET_INT:
+		case OPTION_SET_VALUE:
 			has_unset_form =3D 1;
 			break;
 		default:
diff --git a/parse-options.h b/parse-options.h
index 57a7fe9d91..764e7f7896 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -20,6 +20,7 @@ enum parse_opt_type {
 	OPTION_BITOP,
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
+	OPTION_SET_VALUE,
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
@@ -158,8 +159,34 @@ struct option {
 	parse_opt_ll_cb *ll_callback;
 	intptr_t extra;
 	parse_opt_subcommand_fn *subcommand_fn;
+	intptr_t (*get_value)(void *);
+	void (*set_value)(void *, intptr_t);
 };

+#define DEFINE_OPTION_VALUE_TYPE(type_name, type) \
+static inline intptr_t type_name##__get(void *void_ptr) \
+{ \
+	type *ptr =3D void_ptr; \
+	return (intptr_t)*ptr; \
+} \
+static inline void type_name##__set(void *void_ptr, intptr_t value) \
+{ \
+	type *ptr =3D void_ptr; \
+	*ptr =3D (type)value; \
+} \
+static inline void *type_name##__check(type *ptr) \
+{ \
+	return ptr; \
+} \
+static inline void *type_name##__check(type *ptr)
+
+DEFINE_OPTION_VALUE_TYPE(int, int);
+
+#define OPTION_VALUE(type_name, v) \
+	.get_value =3D type_name##__get, \
+	.set_value =3D type_name##__set, \
+	.value =3D (1 ? (v) : type_name##__check(v))
+
 #define OPT_BIT_F(s, l, v, h, b, f) { \
 	.type =3D OPTION_BIT, \
 	.short_name =3D (s), \
@@ -256,15 +283,18 @@ struct option {
 	.flags =3D PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, \
 	.defval =3D 1, \
 }
-#define OPT_CMDMODE_F(s, l, v, h, i, f) { \
-	.type =3D OPTION_SET_INT, \
+
+#define OPT_CMDMODE_T_F(s, l, t, v, h, i, f) { \
+	.type =3D OPTION_SET_VALUE, \
 	.short_name =3D (s), \
 	.long_name =3D (l), \
-	.value =3D (v), \
+	OPTION_VALUE(t, (v)), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), \
 	.defval =3D (i), \
 }
+#define OPT_CMDMODE_T(s, l, t, v, h, i) OPT_CMDMODE_T_F(s, l, t, v, h, i,=
 0)
+#define OPT_CMDMODE_F(s, l, v, h, i, f) OPT_CMDMODE_T_F(s, l, int, v, h, =
i, f)
 #define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)

 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
=2D-
2.42.0

