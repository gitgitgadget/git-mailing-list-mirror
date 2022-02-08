Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F7C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350627AbiBHIk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350670AbiBHIkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8DC03FECC
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:19 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f2-20020a17090a4a8200b001b7dac53bd6so11404428pjh.4
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aOKoxMtNyA0xhNibVJgaFQ9E2qSM8PrWwJbEr/7dtj0=;
        b=EhYJBWAzyDky9IAL6bKqEhfO2bdgcFuPJjTUXMAvL9Um4WxEobNZ+uz05gO0HnO+FW
         WprhKfXmbnK7YYJO3VldEUn94hL7Nm2IinaXeh9wU30Bf2I0+7GPq+Bxzjo0Vm3W5erJ
         3dCY9UvNIO7maGf3XfimXQCMfB+nWhj0NpEYwcbuPLo3SQWOnZxqsrdc/tQ6um8cUuzX
         6MLx88JzSlLmMFi/1pBLU7fB1RXjGplnTnU+fDGDnPam6OZOas12peuO7NQ1xaMxEgSZ
         trT7DEvf1Rs+w4n8uG224F91H8umaVS8oobN1GU6n8pbJY1xOWEa2OWidBfb+Yi8wOyJ
         6kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aOKoxMtNyA0xhNibVJgaFQ9E2qSM8PrWwJbEr/7dtj0=;
        b=a8g2j8szoycwrVG7s6c4g+9sn040+OGDzESs0wEtE5PBy2NR1K+wl7r9lr6rLRT+SC
         VgtsEfzacCK1kMHDo2DR9AnVz5Jwfm4xbu0G17zy9rUmtfAVrDbT7ecL+tVp91blh9Ux
         +Qxi91ih3NmODXlRk/52DtPVa+7G733m2Zav+EXmsa9Z+dUO0WWAl/VsygYomUQZ7toT
         aRPXgLUT08II4m+t0kKE54VBXzaLFCgP4n8hPUqh4AOtp7lb3EUDhmwdDB69Sgg6Cc/5
         3ySOExJOMijbEv8GNkEJyURLvm9LAldVTaCg9Y45GpieFUHv8KOYer0raqJL0UOoZ1as
         KV4A==
X-Gm-Message-State: AOAM533G5J6jYQdro2XGUv2M8axipnlODCcRG8JR2H4x8regRxHAwxbO
        TBRFNYS+KnDn/+E1b29O/Km0jSIIjKwjD1jAeFy5HcyVgn2pZhilArk3cWoX076TJxjbRsCj49z
        Vq8DKEYPW5C2Y6o01gyAOjkePZxFWIPjDA11oohBkQ0RbLnVR3haVQcr+D+RdmO0=
X-Google-Smtp-Source: ABdhPJwEno20MHcwgHB/yRuzCgJnhLLbZd034ubY0e2ZCqbbj3ieFWu/34skyFobcaKTuXtENRBDGU5f5iXJSA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:300d:: with SMTP id
 o13mr3501263pla.27.1644309618743; Tue, 08 Feb 2022 00:40:18 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:45 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-10-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 09/16] submodule--helper: remove update-module-mode
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is dead code - it has not been used since c51f8f94e5
(submodule--helper: run update procedures from C, 2021-08-24).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4a0890954e..e0cc1c1b79 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1965,29 +1965,6 @@ static void determine_submodule_update_strategy(struct repository *r,
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
@@ -3388,7 +3365,6 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
-- 
2.33.GIT

