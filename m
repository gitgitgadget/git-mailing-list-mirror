Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE487C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiA0QXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243624AbiA0QXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EFC06174A
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l25so5694576wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7aU/gZ7cPKOMEAFGP4ZSJcP4SETV85kq/0rkq3vOiLE=;
        b=gvfOaPccndpRszBbi0zEVVulnU/0jzp/YVZ+9lM4cdyrayHwj8l9dUM0xuhMV9ZOeJ
         RsStiy244BWi+ubk8GcbHxUauIx+OaEmTu7afw9uaMKmVBWpVTgbY++ALY+Em38uEWPY
         C7fwUB9A+dGFA5dQQ0Xm8yewqXNfWUfDkaN16h5lBRbSrozIJa2eOZtGXXXyC2I8iFaD
         g8abvrqO/HwEN4etkptjJLYuw7XC4W7UMlaMIyy9iujKj6c8LOgtoHioTgwSqd+5gugg
         +b4pCo2A36+5g/LX5DkLmF1s0Zq9HbvpeTrZ+qx+/1NekfQJj/T6sk9AihG6EBXmbnDv
         uArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7aU/gZ7cPKOMEAFGP4ZSJcP4SETV85kq/0rkq3vOiLE=;
        b=miwEfprds6NNNPMbdyijIEePitQpLMVbby+1viz16tFH0vLM8197g6LYSzxS9jjL9b
         Vt0wmASJHwBRgmEyJn25hbTlIDuuZAvq5Isdq/zI7fCA/aq7m7DsbOUo42W9NHRTSmL2
         /ogh0c//EC4gMrfNpg0BnBWW25VmOBjm/JYQ/zbuzcbm3nn2jU76Yce83rgsdCH0fZp1
         pTHu02YXkwvA3gtqsoDcv15fqVZtcy9P5njynGwfQeDt4/wT3JuML49fqkQh6eGP1rFp
         DLlULZM77AaYFaIJJijvZ9jy2tTenZ2l/AOuGUPwoqpxJKP9EOA9ZRGw7vDSc8bkA+ij
         Omzg==
X-Gm-Message-State: AOAM533Hh2EejT7X6ft78nYWF4JJFzbtY9s1LttXeub3h2NIzxR8j6ER
        PUXY2DO60Tg8SLHq9vnkqc3m4IQQ7tamOQ==
X-Google-Smtp-Source: ABdhPJwVeUXJsbD6HBP6lhPFAVeW3Z/Joo+ln0H9/zMyDqgv6U47Fbs9Qh9ZTbC9Qd3BNYhZJqFkvg==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr3479510wrz.17.1643300585990;
        Thu, 27 Jan 2022 08:23:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/7] submodule--helper: run update using child process struct
Date:   Thu, 27 Jan 2022 17:22:53 +0100
Message-Id: <patch-v4-4.7-76c5a826a80-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We switch to using the run-command API function that takes a
'struct child process', since we are using a lot of the options. This
will also make it simple to switch over to using 'capture_command()'
when we start handling the output of the command completely in C.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f8e18820ace..328c6cc87cd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2346,47 +2346,45 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 static int run_update_command(struct update_data *ud, int subforce)
 {
-	struct strvec args = STRVEC_INIT;
-	struct strvec child_env = STRVEC_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
 	int must_die_on_failure = 0;
-	int git_cmd;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
-		git_cmd = 1;
-		strvec_pushl(&args, "checkout", "-q", NULL);
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
-			strvec_push(&args, "-f");
+			strvec_push(&cp.args, "-f");
 		break;
 	case SM_UPDATE_REBASE:
-		git_cmd = 1;
-		strvec_push(&args, "rebase");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_MERGE:
-		git_cmd = 1;
-		strvec_push(&args, "merge");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_COMMAND:
-		git_cmd = 0;
-		strvec_push(&args, ud->update_strategy.command);
+		cp.use_shell = 1;
+		strvec_push(&cp.args, ud->update_strategy.command);
 		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
 		    submodule_strategy_to_string(&ud->update_strategy));
 	}
-	strvec_push(&args, oid);
+	strvec_push(&cp.args, oid);
 
-	prepare_submodule_repo_env(&child_env);
-	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
-				     ud->sm_path, child_env.v)) {
+	cp.dir = xstrdup(ud->sm_path);
+	prepare_submodule_repo_env(&cp.env_array);
+	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-- 
2.35.0.894.g563b84683b9

