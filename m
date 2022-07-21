Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F85DC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiGUTOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiGUTOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BD8E1DF
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so3634558wrc.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+96UJwVCBGEHTJTdAEL2CjrRbrH+GdBWKcuziYdEIWk=;
        b=n5Xw5hCsc5ULmR5zYVE/lg98/EFiXuz7JLzZZq2bFWDBUdf8PJS41L8Awx9F+n9cYM
         /bkF0jOlbIi1yW+Bq9XuEfHOzNa9ug4xs4JYDPj/f5xSoXEQ7qyc0SZDvfY8J1MI/hCK
         LA0QSFG6cMADMbfeayXxeQs5bXPhOc8bGmRXt0GPW5Ax64qZiWq/RYbNCuPJw37rYBMn
         tW97OuBXvv+ccZAPixBcLKER16qiJvmMi1ap32lz6vq11pS1kC7KWtJyGYiRMfjK/yf1
         yyhd0GrMnDypLDZFD5OuPUBRb1v8F6EWVklFAajhNJ0nNg1LeQtgfjqUBZu4RlnWjzzU
         ce3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+96UJwVCBGEHTJTdAEL2CjrRbrH+GdBWKcuziYdEIWk=;
        b=Vqt0B6n5/YtogzbUmkF7RAhtPmDr0Y13YBmjWd8holRRUhlydL2MQ+9TyqjFOjW+RX
         KojRSsmyTW7xRiyQmfHu4yA/TjuDaXNjas4rTu+rLlov2hwl83kQ+mKJt2naphqrVkYL
         ksJdluUkVh/Sngzy5N29u+VTiPs7TO89X3zLu57Ehw4bG0nPukN2ihYuLXb4oVjrr+oS
         V/RU5G107ctA3SkZJAhYdgSK1BcY8tukfUFrE2PoKKk1f0/SoYwQJm9KHwnBv5htQ8zw
         fFGxIq8MCyOqzlTGdh5IQ4yFzIJNTTTTYnAJgAe4lf2FAen1od2vuRzanMqR/Fhs3p3F
         70+A==
X-Gm-Message-State: AJIora8q9JUXTE7k60ViecBD+oeuN1WTbI58sQzVRwgeHizIvWH+AdQA
        lQyuCMwhmjrm8soAvb49ITWrgZ5YDXTifQ==
X-Google-Smtp-Source: AGRyM1swnV4qnSA/BN/ptfnQiDArSWfRaPmwtNn8SYIUe7UO5yQMN/5+O7KIvsEaY28X/0Nr53IA8A==
X-Received: by 2002:a5d:44d1:0:b0:21d:7471:2094 with SMTP id z17-20020a5d44d1000000b0021d74712094mr36148308wrr.374.1658430849663;
        Thu, 21 Jul 2022 12:14:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/26] submodule--helper: fix obscure leak in module_add()
Date:   Thu, 21 Jul 2022 21:13:13 +0200
Message-Id: <patch-v3-17.26-7811bdbf149-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an obscure leak in module_add()< if the "git add" command we were
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
index 80c1c1d4918..04b5141c0f9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3352,6 +3352,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	char *to_free = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 1;
 
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
@@ -3423,20 +3425,16 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
@@ -3451,15 +3449,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
2.37.1.1095.g0bd6f54ba8a

