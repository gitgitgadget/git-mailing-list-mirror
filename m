Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E656FA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ3Luj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Lug (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:50:36 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6B3BF65
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130628; bh=Hq2rQl7gfH4NohPce2Myn+NHwb5z1VuO6g5tTQl9MDY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=YuHwefh5eOAOZhOzyKEOIt1lHABxRFIUdDxWj6z05jC0qOQMoKd0GLjuqoet/ZnHJ
         L9DVD8wQ8JBGHQ/3BxmvtMxGKdyEMJ/U88aK/oG3IQgKQMuD0+UqvzfW4+EJ3RBvc3
         NylPNklRa9zPW6h9RPODCnqaI7Wi4aIm/5k50T0w1J1Fabklan+P/cAq+mY7U1S7pg
         n0HogXRF5ZciHvaWWV7qV217WbwtuQ1cAMvI3Kvm0kXHpKXAHEnkLGt/Fwb7G5cMgW
         EFRclobT9V/JdMMF8UVOkevbNB2CI539o4R1Dc4V5VEUaTQiSd0fPJu8VhGXkHbBen
         4xmfkHDwpXJbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwfU-1oQrt53e7U-00OGSH; Sun, 30
 Oct 2022 12:50:27 +0100
Message-ID: <76272512-1e37-0206-5518-5c9c5e646fe8@web.de>
Date:   Sun, 30 Oct 2022 12:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 07/12] use child_process member "args" instead of string
 array variable
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mj7zfp5m6TSXxzUPIdINoq8zuMKjHbnv+gI9MpsCKabg2Dq0/zh
 5TZiM9V8allRINQlRz5v1VVTUKTi7CSrQeNbPApI2q/1UUrydGjF/9xWubK50z5505FIjS9
 MvqifR0wH0XSr2yYxyVFj9bTTCujXx2Y+gLy8yOkVrJNdAImfGaAXWaz8lHfSr9Bw+ca9W5
 +WddV/+LJwn3ArDrIlqTg==
UI-OutboundReport: notjunk:1;M01:P0:/LKnNlpkl2A=;3UsxPzp4C1n7r3YstH/VvRHEDEs
 u8DftsOJCFc9bMa5YEHhAR++wCYfR66U8hfZ3WdAmeUifwzaJbMpBuoK4YNCbLAfS8nkjaGA4
 PR2ji99JoxtHCxPMYARZPSiJkDoDBpLDIu7K6jeSPE/L5Wplv6gqsAWUvqJXNSuKsR58NI/kW
 Hzsefk1GwNxPLp7VBT3X3nKGDa2zJ32DlXMKD9dx6vkqU81kMtG9N791mYrXOKjaXoZmVhrUV
 kqVwsEfPmfLn+feQCl/QQrImkRSHKIFBk7KfJru7XeqNmEk5y4UxEy1UBLJVbTdJtDhAXfA5n
 YpHKxYDPE6E2xgnGvic7df+vTvzZscfWKhXz16ziOrmO+ZEDFvvTnbOIf6UEU1dBGFCigfOGT
 7L/thx4r00sVzmZS9PwYwRaApwGC1MZatAf6nv9t4ePV5ENTeP3zYmVoUZNFO0pfGixcprNe9
 sN/HeWJm8/TM93GPzUDYn3woKloxwcavCifg++T7VQAvefd03BqqyOmFC0gdb9OFFSSvKGgse
 thAInw/ccwuvgbVEnfEXACYIpWHF245ls2gmpS3XiReug9IiuH+vjI5oktsQK9iHpLDK5bm/3
 iMskT+vljTcTjHnMjDnvzz3a27zTWDFUvmCc2y8klwCtKsfXFoxE7tNtlkTAK56aUKxmBicVH
 9evP0/0asFn3aILpjJNTl+LX3IuFgvRN6gkliQxHJonVnKa565ttE/JqZpejGLOyGWpopdli2
 Ohq/RD80DBYpzOGC+9D9YlEe/SbZa4sbZ1sacHqCnPOeYc1g+W9d/c5WLZiLasgPza5tccSS7
 D9w96o+WPEqjrlB30SDS+IYAIOgY2z2inoQJ16QatTOsZCPFacW3L+M9ZQcAvBEsiqbfzPzRg
 OFLHn4nEZj1QVbkfnRj5f4ZAITg78eKfv2QcUzzBLj0ybnRUzcatejoOKLqurpYMoelF5bjpc
 v2DCyoQkH134Pv71S9N1f7npv+Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use run_command() with a struct child_process variable and populate its
"args" member directly instead of building a string array and passing it
to run_command_v_opt().  This avoids the use of magic index numbers and
makes simplifies the possible addition of more arguments in the future.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/difftool.c       | 17 +++++++++--------
 builtin/merge.c          | 32 ++++++++++++--------------------
 builtin/remote.c         | 14 ++++++++------
 compat/mingw.c           | 11 +++++++----
 ll-merge.c               |  7 ++++---
 t/helper/test-fake-ssh.c |  7 ++++---
 6 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4b10ad1a36..22bcc3444b 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -360,8 +360,8 @@ static int run_dir_diff(const char *extcmd, int symlin=
ks, const char *prefix,
 	struct pair_entry *entry;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
-	int flags =3D RUN_GIT_CMD, err =3D 0;
-	const char *helper_argv[] =3D { "difftool--helper", NULL, NULL, NULL };
+	int err =3D 0;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded =3D 0;

@@ -563,16 +563,17 @@ static int run_dir_diff(const char *extcmd, int syml=
inks, const char *prefix,
 	}

 	strbuf_setlen(&ldir, ldir_len);
-	helper_argv[1] =3D ldir.buf;
 	strbuf_setlen(&rdir, rdir_len);
-	helper_argv[2] =3D rdir.buf;

 	if (extcmd) {
-		helper_argv[0] =3D extcmd;
-		flags =3D 0;
-	} else
+		strvec_push(&cmd.args, extcmd);
+	} else {
+		strvec_push(&cmd.args, "difftool--helper");
+		cmd.git_cmd =3D 1;
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
-	ret =3D run_command_v_opt(helper_argv, flags);
+	}
+	strvec_pushl(&cmd.args, ldir.buf, rdir.buf, NULL);
+	ret =3D run_command(&cmd);

 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&wtindex);
diff --git a/builtin/merge.c b/builtin/merge.c
index 3bb49d805b..3481577145 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -347,33 +347,25 @@ static int save_state(struct object_id *stash)

 static void read_empty(const struct object_id *oid)
 {
-	int i =3D 0;
-	const char *args[7];
-
-	args[i++] =3D "read-tree";
-	args[i++] =3D "-m";
-	args[i++] =3D "-u";
-	args[i++] =3D empty_tree_oid_hex();
-	args[i++] =3D oid_to_hex(oid);
-	args[i] =3D NULL;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "read-tree", "-m", "-u", empty_tree_oid_hex(),
+		     oid_to_hex(oid), NULL);
+	cmd.git_cmd =3D 1;

-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command(&cmd))
 		die(_("read-tree failed"));
 }

 static void reset_hard(const struct object_id *oid)
 {
-	int i =3D 0;
-	const char *args[6];
-
-	args[i++] =3D "read-tree";
-	args[i++] =3D "-v";
-	args[i++] =3D "--reset";
-	args[i++] =3D "-u";
-	args[i++] =3D oid_to_hex(oid);
-	args[i] =3D NULL;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "read-tree", "-v", "--reset", "-u",
+		     oid_to_hex(oid), NULL);
+	cmd.git_cmd =3D 1;

-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command(&cmd))
 		die(_("read-tree failed"));
 }

diff --git a/builtin/remote.c b/builtin/remote.c
index 93285fc06e..f0c11fa301 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -92,13 +92,15 @@ static int verbose;

 static int fetch_remote(const char *name)
 {
-	const char *argv[] =3D { "fetch", name, NULL, NULL };
-	if (verbose) {
-		argv[1] =3D "-v";
-		argv[2] =3D name;
-	}
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_push(&cmd.args, "fetch");
+	if (verbose)
+		strvec_push(&cmd.args, "-v");
+	strvec_push(&cmd.args, name);
+	cmd.git_cmd =3D 1;
 	printf_ln(_("Updating %s"), name);
-	if (run_command_v_opt(argv, RUN_GIT_CMD))
+	if (run_command(&cmd))
 		return error(_("Could not fetch %s"), name);
 	return 0;
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 901375d584..d614f156df 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -196,16 +196,19 @@ static int read_yes_no_answer(void)
 static int ask_yes_no_if_possible(const char *format, ...)
 {
 	char question[4096];
-	const char *retry_hook[] =3D { NULL, NULL, NULL };
+	const char *retry_hook;
 	va_list args;

 	va_start(args, format);
 	vsnprintf(question, sizeof(question), format, args);
 	va_end(args);

-	if ((retry_hook[0] =3D mingw_getenv("GIT_ASK_YESNO"))) {
-		retry_hook[1] =3D question;
-		return !run_command_v_opt(retry_hook, 0);
+	retry_hook =3D mingw_getenv("GIT_ASK_YESNO");
+	if (retry_hook) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		strvec_pushl(&cmd.args, retry_hook, question, NULL);
+		return !run_command(&cmd);
 	}

 	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
diff --git a/ll-merge.c b/ll-merge.c
index a8e2db9336..22a603e8af 100644
=2D-- a/ll-merge.c
+++ b/ll-merge.c
@@ -193,7 +193,7 @@ static enum ll_merge_result ll_ext_merge(const struct =
ll_merge_driver *fn,
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[6];
 	struct strbuf path_sq =3D STRBUF_INIT;
-	const char *args[] =3D { NULL, NULL };
+	struct child_process child =3D CHILD_PROCESS_INIT;
 	int status, fd, i;
 	struct stat st;
 	enum ll_merge_result ret;
@@ -219,8 +219,9 @@ static enum ll_merge_result ll_ext_merge(const struct =
ll_merge_driver *fn,

 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);

-	args[0] =3D cmd.buf;
-	status =3D run_command_v_opt(args, RUN_USING_SHELL);
+	child.use_shell =3D 1;
+	strvec_push(&child.args, cmd.buf);
+	status =3D run_command(&child);
 	fd =3D open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 12beee99ad..2e576bcc11 100644
=2D-- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -8,7 +8,7 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf buf =3D STRBUF_INIT;
 	FILE *f;
 	int i;
-	const char *child_argv[] =3D { NULL, NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	/* First, print all parameters into $TRASH_DIRECTORY/ssh-output */
 	if (!trash_directory)
@@ -25,6 +25,7 @@ int cmd_main(int argc, const char **argv)
 	/* Now, evaluate the *last* parameter */
 	if (argc < 2)
 		return 0;
-	child_argv[0] =3D argv[argc - 1];
-	return run_command_v_opt(child_argv, RUN_USING_SHELL);
+	cmd.use_shell =3D 1;
+	strvec_push(&cmd.args, argv[argc - 1]);
+	return run_command(&cmd);
 }
=2D-
2.38.1
