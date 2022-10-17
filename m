Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A93C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJQRuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJQRto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0EC15FDE
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a10so19541695wrm.12
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNskV7eshI778L5zHkGD0goQmmiCiGjkSQk99xb7+p0=;
        b=SrIv3vCWleB5mW+cLUgF5O3qU8+66/Kft7PVjn2XSDwpbcSU0GSE5ZqO/4LDVvKYdU
         rtjbthtMQv2aCIEGbOo8+ZAsPAMYzETO1TU6Wg8G9hstx34HwwuOjZfHtaKZq6Qk0m24
         7vLlumscXzszAsradCywmIRu2QORen8vo22XK4rDwr+QkkjNE5qTpSNho0kqKtGU8EKz
         zVj/HV4XcdXEihi4X7AvZPalTKS87yM055z9PrinpTt3X3dhzuUF57JxWAsyWl+paxku
         0KQdG1UMTeIoc9QS5mS5CL+jPHXcshc5ozbm8RVyFieV8bEDWOZDjiFx7qs1SK9nx/7x
         IFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNskV7eshI778L5zHkGD0goQmmiCiGjkSQk99xb7+p0=;
        b=pwlGvT3qnTKQzELGf7POJvzLvQJwHpmlZ+GX0ugBaR6ViQELYaNuyxpanwAzNer0ei
         vIlb0B7hTFBez8YLAzTZKdv13zfw2CDi/1VF6sZUvVucpQVCl+RY/jUReP5vi8qwrbO6
         CijRhMfiSLgcp4OGkWFIJsADbnW6PS8bQ8ROqdFR5N9Eg/NyhxoStI4Fjc0KEEOElIlX
         foRsuXmM8YEZanFE3nGktm52b9lDDTkI5ImFW8tAH+zvE134jU4p5Rt+0881HFx06iT8
         914v6Up6ZCXfq2vOP3yr6LJnNDB16oFEUK4B5YlPytKE+J04z3PKjbjQppz+QAr6jFax
         oKnQ==
X-Gm-Message-State: ACrzQf3c9ZiRZ9HKYhrbNaUZMRANU7s+ODqgshIyU6PhVITb/teLhbsS
        OnYqFdO6MEila+KPL3tfK3DCVnEvfon6+w==
X-Google-Smtp-Source: AMsMyM6v9Gdjw6ZzmJkqWxqv0RqrcmR0sbnbjmLbI34/3S8IQwzmu32QT/2OMSKcdrrgwdwHNw31Wg==
X-Received: by 2002:a5d:6d06:0:b0:232:b56c:e5c3 with SMTP id e6-20020a5d6d06000000b00232b56ce5c3mr6548072wrq.506.1666028974209;
        Mon, 17 Oct 2022 10:49:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] run-command API & diff.c: remove run_command_v_opt_cd_env()
Date:   Mon, 17 Oct 2022 19:49:18 +0200
Message-Id: <patch-v2-07.10-3b3d3777232-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we'll see in subsequent commits most of the run_command_v_opt_*()
API users are a bad fit for what we'd like to do with that API. The
ideal use-case for it is something where we already have an "argv",
and don't want the one-shot semantics of run_command().

In the case of run_command_v_opt_cd_env() there was only user of it,
and that user was just accumulating complexity by not using
run_command() directly.

By not having to maintain its own "argv" and "env" it doesn't have to
strvec_clear() them both, which in the case of run_command() will be
done by child_process_clear() before it returns.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c        | 26 ++++++++++++--------------
 run-command.c |  7 +------
 run-command.h |  3 +--
 tmp-objdir.h  |  6 ++++--
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/diff.c b/diff.c
index 648f6717a55..392530016fa 100644
--- a/diff.c
+++ b/diff.c
@@ -4278,35 +4278,33 @@ static void run_external_diff(const char *pgm,
 			      const char *xfrm_msg,
 			      struct diff_options *o)
 {
-	struct strvec argv = STRVEC_INIT;
-	struct strvec env = STRVEC_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
+	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	strvec_push(&argv, pgm);
-	strvec_push(&argv, name);
+	strvec_push(&cmd.args, pgm);
+	strvec_push(&cmd.args, name);
 
 	if (one && two) {
-		add_external_diff_name(o->repo, &argv, name, one);
+		add_external_diff_name(o->repo, &cmd.args, name, one);
 		if (!other)
-			add_external_diff_name(o->repo, &argv, name, two);
+			add_external_diff_name(o->repo, &cmd.args, name, two);
 		else {
-			add_external_diff_name(o->repo, &argv, other, two);
-			strvec_push(&argv, other);
-			strvec_push(&argv, xfrm_msg);
+			add_external_diff_name(o->repo, &cmd.args, other, two);
+			strvec_push(&cmd.args, other);
+			strvec_push(&cmd.args, xfrm_msg);
 		}
 	}
 
-	strvec_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
-	strvec_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
+	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
+	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
-	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
+	cmd.use_shell = 1;
+	if (run_command(&cmd))
 		die(_("external diff died, stopping at %s"), name);
 
 	remove_tempfile();
-	strvec_clear(&argv);
-	strvec_clear(&env);
 }
 
 static int similarity_index(struct diff_filepair *p)
diff --git a/run-command.c b/run-command.c
index f9a0b13f62f..25a978fb027 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1038,7 +1038,7 @@ static int run_command_v_opt_1(struct child_process *cmd, int opt)
 
 int run_command_v_opt(const char **argv, int opt)
 {
-	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
+	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
 }
 
 int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
@@ -1046,11 +1046,6 @@ int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
 	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
 }
 
-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
-}
-
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 				 const char *const *env, const char *tr2_class)
 {
diff --git a/run-command.h b/run-command.h
index 0af01bd9b67..2574d46cb70 100644
--- a/run-command.h
+++ b/run-command.h
@@ -152,7 +152,7 @@ struct child_process {
 /**
  * The functions: child_process_init, start_command, finish_command,
  * run_command, run_command_l_opt, run_command_v_opt,
- * run_command_v_opt_cd_env, child_process_clear do the following:
+ * child_process_clear do the following:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnostic
  *   is printed.
@@ -263,7 +263,6 @@ int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class);
  * env (the environment) is to be formatted like environ: "VAR=VALUE".
  * To unset an environment variable use just "VAR".
  */
-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 				 const char *const *env, const char *tr2_class);
 
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 76efc7edee5..c96aa77396d 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -10,9 +10,11 @@
  *
  * Example:
  *
+ *	struct child_process cmd = CHILD_PROCESS_INIT;
+ *	...
  *	struct tmp_objdir *t = tmp_objdir_create("incoming");
- *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
- *	    !tmp_objdir_migrate(t))
+ *      strvec_pushl(&cmd.env, tmp_objdir_env(t));
+ *	if (!run_command(&cmd) && !tmp_objdir_migrate(t))
  *		printf("success!\n");
  *	else
  *		die("failed...tmp_objdir will clean up for us");
-- 
2.38.0.1091.gf9d18265e59

