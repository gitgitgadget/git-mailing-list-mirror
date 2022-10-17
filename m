Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D72C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJQRtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJQRt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AA6241
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w18so19588776wro.7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faxuVvn15f5FM2R9CndWqssCYLLiEtQwAFTqilyjCeM=;
        b=L0gmQPqkxsr6QpVAl2T3GrSmDrKB/MVKQo6gFGqQ2w6jdmT7VJ+0EF348Om2hv4U1v
         2UlgTVHXLegCwoaFEBdZe9pmCYdt4uU51SsklLKYYG5ji7H5fuqBem3KJqiel+/xr6Yr
         KC/9REMuPR82+s2T3XkiKyHQPKE1xCK13Oj6JQ1qZtFyEM9+JxhMsimOacz6dzStKHnu
         2GbYVtsv95zHIZiYEVLB1UZjCl7BUOS2yxSfbyboxAlVNYmdTPXCeDmholVk1c9aAZiS
         dpWOOtrYbRawnBsZPpjEaECFaRD00gibLQ9b6AizxitXpHOLow0Ytcmm1qYVgdDeI6hL
         9jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faxuVvn15f5FM2R9CndWqssCYLLiEtQwAFTqilyjCeM=;
        b=oNrsQ9wuxdfIYr61r+mMPw/yf1JkEVMWa/R2YtG9v6t42JY9vA4zaxBh/Z9fXcZ895
         EDXJbFd70zBSAo/kyFutDY+d7od5gTHFW7rOEw9mwHNtNQP6wEtZ/1TFj7Mup2awYwwT
         lTrT5xjHGz8E1V/4EgmM1dvq+eTcZ+F7LWYRmdn7tKSkWbmePgOvonqohNeV5p355lWz
         NF4E6PvthTXx3P9lPo54x6XWxuoQGTjUt5e1dhT1Dw3i4iJv/mQiOkikObEVQopV1ztB
         7UgKwguzroJQlioIznYKpSyrRBuNeXTRt+LEF3NWTwIwbJAub8/uSn3HplbyDTAHYASM
         WNSA==
X-Gm-Message-State: ACrzQf0ye7K+UIhgGbkqEd6pnjpx/otvLqK/X/u+rzREMlZVHCQQCy7y
        biznQb13T4Cr1t+vnJ+3HhE5dLGNhLDv4Q==
X-Google-Smtp-Source: AMsMyM7Mxkz+o+NpIXe12nlvgR48mZeyrDvrvRFwTvYdqrvpWvSyB322OGAHJf3lazjg9CbrCw7ryw==
X-Received: by 2002:a5d:6e8e:0:b0:21d:ea5:710f with SMTP id k14-20020a5d6e8e000000b0021d0ea5710fmr6895269wrz.48.1666028965946;
        Mon, 17 Oct 2022 10:49:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] run-command.c: refactor run_command_*_tr2() to internal helpers
Date:   Mon, 17 Oct 2022 19:49:12 +0200
Message-Id: <patch-v2-01.10-3842204371e-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the run_command_v_opt_cd_env_tr2() function to helpers which
takes a "struct child_process *cmd" argument. This will allow for
adding a helper which won't need to copy a set of arguments to the
"cmd.args" we'd otherwise have to populate from the "argv".

Splitting out the part of the function that sets the various members
from "opt" will help in the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5ec3a46dccf..4e75f83b5e7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1004,6 +1004,24 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+static void run_command_set_opts(struct child_process *cmd, int opt)
+{
+	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
+	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
+	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
+	cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
+	cmd->clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
+	cmd->wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
+	cmd->close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
+}
+
+static int run_command_v_opt_1(struct child_process *cmd, int opt)
+{
+	run_command_set_opts(cmd, opt);
+	return run_command(cmd);
+}
+
 int run_command_v_opt(const char **argv, int opt)
 {
 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
@@ -1024,19 +1042,11 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	strvec_pushv(&cmd.args, argv);
-	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
-	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
-	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
-	cmd.silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
-	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
-	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
-	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
-	cmd.close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
 	cmd.dir = dir;
 	if (env)
 		strvec_pushv(&cmd.env, (const char **)env);
 	cmd.trace2_child_class = tr2_class;
-	return run_command(&cmd);
+	return run_command_v_opt_1(&cmd, opt);
 }
 
 #ifndef NO_PTHREADS
-- 
2.38.0.1091.gf9d18265e59

