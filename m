Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D29C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D65610FF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbhIGMBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbhIGMBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ACBC0613A3
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so7989871pff.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ma+3ZQkbryirWqLE5MTJFhQAqIjUzJdy8FXpa8QwWms=;
        b=cgSNBEstG+TI9oJp+dhw8fu07oMX+AIIDyOprhwK2fcR4sy2Crxv9rtVjE26EuPOTm
         Ixf/IZ+08Fb4lS8jBhSnhykDecD6dt423s/wZDzXoVVOQZMOTZ93kCeflWpJcYUa83NK
         XseuEwECJAFzGUEnIX+fMGSjCQ3OFCsgFY2wUkGKd8gmrgg6FlgfKABTOuxHT3D9oLdn
         //hVU8bGYJgBJ7mG3WF7g/Em9AdTWzaV3rbL5UbGBO9XF/FnZYXF5Vfxvo0IB71kXiwH
         rHzpbYvAh8330+paVhNLNIU6cZlwfp+dVJcMUIDC9sZas6ghJ+GB6I0W2HuFoT2r8Jzv
         KWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ma+3ZQkbryirWqLE5MTJFhQAqIjUzJdy8FXpa8QwWms=;
        b=fBRABg6glloHjgYkdOJ1Q/l2tdsnXMLQH+FeXUwpVr5gec/RFrCbM2RZgsDTtNIjeN
         r8yRfObisw+FOgOFMU5ExR/FQm4ePQjIyp1Ipy2YywgTCKH1046C4SXoehLa9lZeHZwW
         xtnd4s3B1Fke71DM6L/zR4r9DTLR/R9gD9UHxDkYvmPiIM9/zlxjZcYzzzOwsOrO/1s5
         h3HKgq4qqvpA44Tg4HW0meWm1scg71+zSPxLk35Q2L474lfagU4P8WbVsiqS05W/5G99
         nXlgYT6pZ+VFSA6YlRLKUFRulLHrHp3jxjTKVHodC6FLggMoP973+SKxLq/lTrtn8Dnr
         4kcA==
X-Gm-Message-State: AOAM5324vqBxTI5OviDg00Q+7yoc0fkf7DccD39r0wuGrMTUtFcE2bQU
        uCyq1VgrOJm7YqK37cZrKXS1fK9qayA=
X-Google-Smtp-Source: ABdhPJz7vxCzXVHfwlAvzVkZYBl2V8YWZgBE9z6P9kc6Ee0lLKKYQRfiKwZwkb57IBl0tgPWdx1VAQ==
X-Received: by 2002:a63:9d4c:: with SMTP id i73mr16467863pgd.216.1631016023667;
        Tue, 07 Sep 2021 05:00:23 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:23 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 09/13] submodule--helper: remove update-module-mode subcommand
Date:   Tue,  7 Sep 2021 17:29:28 +0530
Message-Id: <20210907115932.36068-10-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This subcommand was once useful for 'submodule update', but now that we
have converted the shell code to C, it is no longer used.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a628660d6b..e3e85600c3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1993,29 +1993,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	free(key);
 }
 
-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
-{
-	const char *path, *update = NULL;
-	int just_cloned;
-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
-
-	if (argc < 3 || argc > 4)
-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
-
-	just_cloned = git_config_int("just_cloned", argv[1]);
-	path = argv[2];
-
-	if (argc == 4)
-		update = argv[3];
-
-	determine_submodule_update_strategy(the_repository,
-					    just_cloned, path, update,
-					    &update_strategy);
-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
-
-	return 0;
-}
-
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -3463,7 +3440,6 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
-	{"update-module-mode", module_update_module_mode, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-- 
2.32.0

