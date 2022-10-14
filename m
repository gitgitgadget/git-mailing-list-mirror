Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F51BC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiJNPlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJNPkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141C111463
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w18so8160254wro.7
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8303stTuwgLVqHRzW06UPCvIrmHu/7v7E3qPwvU07jU=;
        b=lLuj5mUp4jXZQ+Z+p7NdYsXqrsCjZBv4Sajp7LVtaLj3q8MGC6ijuntMtao6orAN1v
         dnkApPYmFrvXJ+gx2+r2IhDnYxCmWnGdBinmA4WQxgFMa9Gqx53g4NXYlZI8aBHuemYf
         4UIeZiy1dta2iDynhtLmOeTwj4NRc39usbk14RegJZ7LXnxILQAjJYSo8th1llHWGj1f
         YsWhYFPFt9wYlA83a0nWXhLt9NW5uIzIxnUkhLu0ovcnLnmW3eP7+EKJfhUgqi6nTlw+
         YtbN1NgnDwmO8LKwS7ppAhQvWO4X6AN4yCUC9vH77LAdw0T6xoej2WUSxzLObbmgTks+
         E+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8303stTuwgLVqHRzW06UPCvIrmHu/7v7E3qPwvU07jU=;
        b=i5P1gURvaq4SPAYtqooL2FXyHjZRERQITNeOi19bIYtNCXR2a7kVsZOkWuOIHYLM63
         ewwjCmCZ9GvmEyCfbX5Gbvqq/KX9arWobT6mYRX/vMz+N/9SppjnaeomQrc1BWoUX0fg
         nxhCXra4EbEqbUH9cFEzerQAocm5E/dZhdSCjG7TQLdAqZiTKCZNvE1ZzIK+Kfuc+1Pq
         YSHVsXVd8x1rsDITmfxnBYdeHoXmuy2mytaxiThwVLVpV6vnJT0yoJH5cQ+Imrs3zZv5
         i3yYwXG498zHJCEfH/j6nW9O2mi6U6AO8s4RKsKlYV1Pprt2tTe3+anLlLdJpClDtHkK
         afXA==
X-Gm-Message-State: ACrzQf1ag8C80APw6Ests+in8d8DaSROYgiHkYmGvhN3lkoxdHaXAK4l
        GgTwiddRLABhCkh7RD6z40xdvVYdI3N0kg==
X-Google-Smtp-Source: AMsMyM4RPj2R34PEIVvBCcB5amMSS+23neLmI7I8xjEJzsOX91TrFLlMrPjMyoddwDaRgdoJ/np5YA==
X-Received: by 2002:a05:6000:a11:b0:22e:3dab:537c with SMTP id co17-20020a0560000a1100b0022e3dab537cmr3926636wrb.638.1665762034638;
        Fri, 14 Oct 2022 08:40:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] run-command API & diff.c: remove run_command_v_opt_cd_env()
Date:   Fri, 14 Oct 2022 17:40:19 +0200
Message-Id: <patch-07.10-31e8536f28c-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
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
index fe1b4a0b650..6132a9f19f0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1032,7 +1032,7 @@ int run_command_l_opt(int opt, ...)
 
 int run_command_v_opt(const char **argv, int opt)
 {
-	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
+	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
 }
 
 int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
@@ -1040,11 +1040,6 @@ int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
 	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
 }
 
-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
-}
-
 static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, int opt,
 					  const char *dir,
 					  const char *const *env,
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
2.38.0.1092.g8c0298861b0

