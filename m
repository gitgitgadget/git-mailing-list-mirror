Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC02C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiJNPkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJNPkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFEBBC44C
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n9so3332024wms.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nlRzpzET1+ufxozcZfKhB82cr+VhjsGGBOSlyx+bfk=;
        b=GEXnOaFquxSmy8P0LpwUvoXr4H9EsC0z0X1EAgjcecwCNHNz0ygfdaAmgyMuHe2G5k
         IeEjya1lJGvSZMb71qMKtca1/esi1thsv3m0CVlXkDWU21175GiRY4SNkMqkaBG9nmWV
         o80tdnOKPSubaCbVI1euIZn5eK9MbS3Lxi+HqaN5ygo39ejCb/Ml9hQKshkQpy7XiLQE
         dm7ER6Vl0Hoq43kqFxayEX8fUBzc8+FarpDOvoxmDHMkciTUOcipkXPvecbaLxMMVRDZ
         bhwHjv+B9X212JmlKAarZ64YcoZGmjZanhs2/nXY9J7GK2uIAgv2RUUWTWJJuyvMEamV
         OoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nlRzpzET1+ufxozcZfKhB82cr+VhjsGGBOSlyx+bfk=;
        b=wqSY0ULeKm/QkbyRbFZliQTG/CB/AbqBno2IYHQB2wEzoaEEICEwD7JHEx2Fp9be0E
         Za++G3HvT9Om6Zt9iMG0tLF48AgKDBiUSBfamloROsmuWX/FNhGiFwGWKIVLnH0NHy72
         3zfj5QnB9nyvLX1bZiI9++rStSrJmsaTIQfvFhinyRT7wDDRowc5f8KvTc8nVnA9HuI+
         9XJ5Pb/mifKXG5IjmSz6B8rvegWWkmT3dZeuPHqg6at8w0ySiNn/jnFFPxpBC4Ls1jSc
         LO22yeZkTiMx6P8AVF18rXJ5RpmUuHohQ157XJLyANP2S9tBkkw2Rd/Kkk/1PvDTe34a
         wvzA==
X-Gm-Message-State: ACrzQf0qEglBllAAvD47f72Y2rderRcJYS4LbWJqYWmH20fxQCG38EJD
        1imVQzifmGmSsG8uxjDKy7JjUOyahPi6RQ==
X-Google-Smtp-Source: AMsMyM53vIUqZkSegUWCIeK8eZi/MYXJBpgPeyLxHcfp0JLQQX9kESNAZVtmhE8rTcEeRyQyzZQ7kQ==
X-Received: by 2002:a05:600c:4f53:b0:3b4:9aad:7845 with SMTP id m19-20020a05600c4f5300b003b49aad7845mr4102139wmq.159.1665762027471;
        Fri, 14 Oct 2022 08:40:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] run-command.c: refactor run_command_*_tr2() to internal helpers
Date:   Fri, 14 Oct 2022 17:40:13 +0200
Message-Id: <patch-01.10-c1f701af6e8-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
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
 run-command.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5ec3a46dccf..cf4a431c839 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1004,6 +1004,18 @@ int run_command(struct child_process *cmd)
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
 int run_command_v_opt(const char **argv, int opt)
 {
 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
@@ -1019,24 +1031,26 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
 }
 
+static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, int opt,
+					  const char *dir,
+					  const char *const *env,
+					  const char *tr2_class)
+{
+	run_command_set_opts(cmd, opt);
+	cmd->dir = dir;
+	if (env)
+		strvec_pushv(&cmd->env, (const char **)env);
+	cmd->trace2_child_class = tr2_class;
+	return run_command(cmd);
+}
+
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 				 const char *const *env, const char *tr2_class)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+
 	strvec_pushv(&cmd.args, argv);
-	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
-	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
-	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
-	cmd.silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
-	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
-	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
-	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
-	cmd.close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
-	cmd.dir = dir;
-	if (env)
-		strvec_pushv(&cmd.env, (const char **)env);
-	cmd.trace2_child_class = tr2_class;
-	return run_command(&cmd);
+	return run_command_v_opt_cd_env_tr2_1(&cmd, opt, dir, env, tr2_class);
 }
 
 #ifndef NO_PTHREADS
-- 
2.38.0.1092.g8c0298861b0

