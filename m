Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB35C19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiG1Qax (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiG1Qan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78E1E3CC
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so1283391wmj.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YWDE+SNBa5Vb/I2QMAVgevGI6iD5ueyrzxTK+7x8vq8=;
        b=baIVZmR5D5s4ohxe9bWAX/2VKs76Clsfj12LkAwc5RFHMrI3YP4FcFt3ayxWiNTyxM
         FIDaadQnSST+hsEg/wuJdSMpWjT0NVfE8bXVQU/8aYFlY2tlXqptag0O2HZ4CPuPuIDT
         1BHQ2pMzQcULkN6hFyCpP5bTQXmrjg1JSrUaun0TR8HFD6WiYGWFySilbM2j2BWEj7uq
         SVcDZE68xDfpD86fAtD6gO7IwyMF9rD6WWj0s7g4ZeQ49m+ZjnVJgMminGvL01S6cRCC
         OOTMBQ64Y+thTAGOnK6O3gwCXlChTdhWH8VTKMPEtK+XPw8u9zsyj9zlCAs3E53TBTqu
         +APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YWDE+SNBa5Vb/I2QMAVgevGI6iD5ueyrzxTK+7x8vq8=;
        b=RC9ZAFavKM/+1Wx4p2C0q8dhhmHm9ILPjtQKnBukSRnbJXQGN11eutiUxDgelVcvCh
         aq3z7X5g6dx6L2tsbyYynZBCgvSfxSEy7+/A8M+DBbQIFcwmf2H4Xjp7C6m8L6y9RsPF
         a2QFKNIiIZcB2+5sYgoR5tQL7z12aBaXED5rSgQVZXiSKAXhnlBBCZIVpREogDU+vtQs
         Yz+NQCZmvWu5gw70DQXfF8V1CqnGHlJjSYPKaTQ/DxBG6RUekl8W6HD1dTWN1ViZsCY7
         QXPiit69zV1uRxGOj4EqKtHx9tYu+0QUFDG4aXKHSDi7fN/pRFuuYc7JhbwZY1w4Oig1
         UKuw==
X-Gm-Message-State: AJIora/tRlIqygbZrSjMMG1C/4ZKVPptUH4jhWweYSkdDse513/VMFBb
        /GKwl16Yu0KVNoLcTe2vviMYK5sl/yG6lA==
X-Google-Smtp-Source: AGRyM1sSlBE7sAJ8n4Dogm6CSVvZZtt9XoV5iwRcrn0PG34OOGW6sQwDa6A70NLGtVO/z6wYuShwjg==
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id r14-20020a05600c35ce00b003a31b7fbbd8mr158486wmq.22.1659025830044;
        Thu, 28 Jul 2022 09:30:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/17] submodule--helper: fix obscure leak in module_add()
Date:   Thu, 28 Jul 2022 18:30:06 +0200
Message-Id: <patch-v4-12.17-1adb7b66656-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an obscure leak in module_add(), if the "git add" command we were
piping to failed we'd fail to strbuf_release(&sb). This fixes a leak
introduced in a6226fd772b (submodule--helper: convert the bulk of
cmd_add() to C, 2021-08-10).

In fixing it move to a "goto cleanup" pattern, and since we need to
introduce a "ret" variable to do that let's also get rid of the
intermediate "exit_code" variable. The initialization to "-1" in
a6226fd772b has always been redundant, we'd only use the "exit_code"
value after assigning the return value of pipe_command() to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index debe3a4a2f5..0f6c07e3d1e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3269,6 +3269,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
@@ -3318,21 +3320,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	die_on_repo_without_commits(add_data.sm_path);
 
 	if (!force) {
-		int exit_code = -1;
-		struct strbuf sb = STRBUF_INIT;
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		cp.git_cmd = 1;
 		cp.no_stdout = 1;
 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
 			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
-		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
+		if ((ret = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
 			strbuf_complete_line(&sb);
 			fputs(sb.buf, stderr);
-			free(add_data.sm_path);
-			return exit_code;
+			goto cleanup;
 		}
-		strbuf_release(&sb);
 	}
 
 	if(!add_data.sm_name)
@@ -3347,15 +3345,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	add_data.progress = !!progress;
 	add_data.dissociate = !!dissociate;
 
-	if (add_submodule(&add_data)) {
-		free(add_data.sm_path);
-		return 1;
-	}
+	if (add_submodule(&add_data))
+		goto cleanup;
 	configure_added_submodule(&add_data);
+
+	ret = 0;
+cleanup:
 	free(add_data.sm_path);
 	free(to_free);
+	strbuf_release(&sb);
 
-	return 0;
+	return ret;
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
-- 
2.37.1.1197.g7ed548b7807

