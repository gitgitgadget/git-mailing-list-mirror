Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA8CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiGSUsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiGSUrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941BE54078
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so69514wmb.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hO5MHQAb4S/H4eSkGpU0EqhvCbHG3CWcjb3L/IVWxVE=;
        b=jkFEgoJ1ZBbDCoNBw/ZI25uAfGgFcr4nb+EHTCFDjtzj7zFAw0Ra/YY6M76cHYmbgw
         yG01UXT6CJh1yzDcW65JXCKxQIxdq8r6dLkrONJHsI2FktU5dQFv+T4O6EOIxceGu//2
         kNkhHoThb/X+TDIqvPkr3m8mIXT5RwZuFNZ5VN7Qip9wDJsC0lUGVte+R3S8Qqukdqsd
         yB0YfBDxsn2L7TgNsahhHsdsBrkoMABNRZKvzpEDA3afj6gUUZNwbQPCsJfTMSklhSme
         3OYyObeKns5ociqKZt4OtLgGB6XHaY/cyPxgfON+xcnaESXTMz9YN4gfzmgDSwWXTElC
         pPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hO5MHQAb4S/H4eSkGpU0EqhvCbHG3CWcjb3L/IVWxVE=;
        b=rquLv3jHlYyL42AlI6KEeo9J6zKNhBEzoDNgTqx4h1RR2Uaks1oKSABZ2JKleIi2OK
         nlaYl7/3D/8eeTXNTjDbolXS1P+qrffaRCKpjlG6TjqH/K4CyAvv0u5p3froiN8nH27l
         SDcrOx+robZdihbdsVtyuuxrYDrts3409dYr7W9QS8INGg4STWj7LkO4v/qwlkxtASLM
         trdR1Fn+YBPONmL4xGZ+r+nBKLfX+pdU1AOOCnzVr7T6xny8g4SO8IZlSnHdx7UONbVI
         4pAAjQSbs8868MhoR1DX0G6ScYikSkryNAhGz3FAdYH93xo/nD1HKIlG2MzUWi6h+IHb
         gNVw==
X-Gm-Message-State: AJIora9O32QilnrvXmjafCjSaAJnWaLGIeRynKuA8Gm7u1VznS4bUCE6
        lvTX0jvA9sJ/TsELABmp4TQSGeKWd069wQ==
X-Google-Smtp-Source: AGRyM1v5C4i/j5epwGap6/KjOK5tjK9oxGuYI8SAZo9RnCKpbe9AodqyJS2UjCocMeYPIFOhRUfd2w==
X-Received: by 2002:a05:600c:a02:b0:39c:97cc:82e3 with SMTP id z2-20020a05600c0a0200b0039c97cc82e3mr911277wmp.97.1658263659772;
        Tue, 19 Jul 2022 13:47:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/24] submodule--helper: fix obscure leak in module_add()
Date:   Tue, 19 Jul 2022 22:47:06 +0200
Message-Id: <patch-v2-15.24-abd8e2eef3a-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eb2f09d1178..46685bf0610 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3355,6 +3355,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	char *to_free = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
 
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
@@ -3426,20 +3428,16 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
@@ -3455,14 +3453,18 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	add_data.dissociate = !!dissociate;
 
 	if (add_submodule(&add_data)) {
-		free(add_data.sm_path);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
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
2.37.1.1062.g385eac7fccf

