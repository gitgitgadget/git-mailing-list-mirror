Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B9EE14AA
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 21:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjIIVOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIIVOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 17:14:32 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07232132
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694294061; x=1694898861; i=l.s.r@web.de;
 bh=InENkesgHR1z4KTOzAmymv0/lY8jMQhK0wwyuql7RL8=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=u1YYCGoEi7BuaFqt4N5mUGQTEigrziZ5NCP8BWwcYKpm6NTkkP6+Dcg1LXNzRcJyIb0P1k5
 LC5tyCrfvWWwbFjBRUlTs8UBp9PoR3g0AzfMntI1fri84H8usUXydQu6a6X3yITfE3d84pmxe
 epNg6bFffxwnabmLJJlQMjyeI38VObayfHfvorjSRqWLdr4RX6IFbDhirDA0CO8MEwUFfDOk9
 LPhagcGJa6ey7xuE5deNp2AV/HPasDN6YTV1q63768E7gcphpIMS7PYHY6hzQ2ffeADk8+VAl
 vhbhyNovbOljedZtqFsfo2JGm/df9yeDrMWdqM+OIGYdnV6tGVvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.6]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1q6uhN2X08-00YPqN; Sat, 09
 Sep 2023 23:14:21 +0200
Message-ID: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
Date:   Sat, 9 Sep 2023 23:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
In-Reply-To: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AK72N2/gN1dCkR3kJNBCJicsQul0/93NYv9Xai0MmY8iuEdTIVQ
 kFa9djiyrdiLc9mDiuJRpoT/BGSq3t0SgTY6asX5R9DoO+7R4hwe35MjU78WncdaXI5FzWw
 jfKZwjMh7/oUqIz0k7ZeSqJSErrAMoXCy33stUZfRSO8kHtQ5tZU+R9ze7EHXUWAZzxLYJF
 8Eo7w1huNu25+dbXIW4LQ==
UI-OutboundReport: notjunk:1;M01:P0:w22oSC2mjjc=;OPIVyE6SXMjR7/LViVXNv9kGnRt
 1WLkmIdYQJ8vxu1YTO8HiL0oM7JCzb/IGabl1wKBRjzwg31/bG2lQ0EUinxoIKzKDaa9IdSa/
 bTHkZ/cVB/YdpeQNDrrzsldrBvSNjITSrBSXeykv8fxiMCzLSRPgoZH+KKgM7RDbIFZib4sx4
 3RPis8jPTNHf3pBlrWTRTMCkN5uCIXw3Hua9H/JCQ9Ju87esv907a6G89CTNseez/V8seHnWq
 Q3YY/nscKd1wJyRHD2fgp2GwEnJr8kbOfHWFebs2G4kvt/yiP7zmmmmHM3hkdkqfZMWNVV5nD
 dBSrx9w66AyMER+m4bEe0/6YAzBh0JGM/Q+yuDKc0Y/U7Sucis+5O1hDzRgrgh75EcuMDb8/U
 r2TBEzPadR7ZS9onP1WxMIaNcm2PfRwlZufEdbC+ZwFRChsp8BFsYk9KJDYjBA1aS8kW2Mi7A
 IukHZyMM4rEAnmDgmYXDVffBjld46F4WCShZZ8E7s7ZIsW5DmJykOI5u2g9q8wffWWgAzBFjX
 4jcQhVdu0UWTHpXjjceHMpoEpq+Xjt1yHsgqgaKSENovzSU/Tyioww80RapFehoYgjrUVsIPU
 in8S4oKvEdC1YgCP117jIry+M59YlZ5G5xNhXK7C1/aIiksijvNQFhGMwvZ2ntox6nux/nWDw
 hsKDh4RMDKO/tjSMRQ4V9jVDeWvcMA54Rk8NAJGgOGVjLSqg2KkgxYKctMJGtASFkgBIt2Bez
 SrDZemXxCRdpo2cF21Chd3xFsHQD6+Lqrvn1zW4N4MukmpKiIuoQfWwnzEst6zeEbIM5uRiGc
 DaHCUrN7vYu4q+Dsw6LUYcruYVN3OjXsBivhTqFba4dyVZJn7LLwcEa6lp9XgZZZinponSVIz
 1ZAXNpfGPxVaSaMBBlLRev+8I3F28k/erdVK8EAh/KRcjb+57TLOnD9GTgvmRsajpbZ/EkkqQ
 DQH+dg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some uses of OPT_CMDMODE provide a pointer to an enum.  It is
dereferenced as an int pointer in parse-options.c::get_value().  These
two types are incompatible, though -- the storage size of an enum can
vary between platforms.  C23 would allow us to specify the underlying
type of the different enums, making them compatible, but with C99 the
easiest safe option is to actually use int as the value type.

Convert the offending OPT_CMDMODE users and use the typed value_int
point in the macro's definition to enforce that type for future ones.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c         | 2 +-
 builtin/help.c       | 5 +++--
 builtin/ls-tree.c    | 2 +-
 builtin/rebase.c     | 2 +-
 builtin/replace.c    | 3 ++-
 builtin/stripspace.c | 2 +-
 parse-options.h      | 2 +-
 7 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 202040b62e..ebb72ebaaa 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2269,7 +2269,7 @@ enum resume_type {
 };

 struct resume_mode {
-	enum resume_type mode;
+	int mode;
 	enum show_patch_type sub_mode;
 };

diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b98..e8aedb932c 100644
=2D-- a/builtin/help.c
+++ b/builtin/help.c
@@ -42,7 +42,7 @@ enum show_config_type {
 	SHOW_CONFIG_SECTIONS,
 };

-static enum help_action {
+enum help_action {
 	HELP_ACTION_ALL =3D 1,
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
@@ -50,7 +50,8 @@ static enum help_action {
 	HELP_ACTION_DEVELOPER_INTERFACES,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
-} cmd_mode;
+};
+static int cmd_mode;

 static const char *html_path;
 static int verbose =3D 1;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 209d2dc0d5..6f8c43f729 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -346,7 +346,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 	int i, full_tree =3D 0;
 	int full_name =3D !prefix || !*prefix;
 	read_tree_fn_t fn =3D NULL;
-	enum ls_tree_cmdmode cmdmode =3D MODE_DEFAULT;
+	int cmdmode =3D MODE_DEFAULT;
 	int null_termination =3D 0;
 	struct ls_tree_options options =3D { 0 };
 	const struct option ls_tree_options[] =3D {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..d11e749579 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -111,7 +111,7 @@ struct rebase_options {
 		REBASE_INTERACTIVE_EXPLICIT =3D 1<<4,
 	} flags;
 	struct strvec git_am_opts;
-	enum action action;
+	int action;
 	char *reflog_action;
 	int signoff;
 	int allow_rerere_autoupdate;
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..d0063d3feb 100644
=2D-- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -553,7 +553,8 @@ int cmd_replace(int argc, const char **argv, const cha=
r *prefix)
 		MODE_GRAFT,
 		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
-	} cmdmode =3D MODE_UNSPECIFIED;
+	};
+	int cmdmode =3D MODE_UNSPECIFIED;
 	struct option options[] =3D {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DE=
LETE),
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..f6de0b17dc 100644
=2D-- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -32,7 +32,7 @@ enum stripspace_mode {
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	enum stripspace_mode mode =3D STRIP_DEFAULT;
+	int mode =3D STRIP_DEFAULT;
 	int nongit;

 	const struct option options[] =3D {
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
