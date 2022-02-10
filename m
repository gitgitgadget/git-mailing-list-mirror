Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD00C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiBJJ3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiBJJ3G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC559D95
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:07 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q12-20020a17090a2e0c00b001b874772fecso3566332pjd.2
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aOKoxMtNyA0xhNibVJgaFQ9E2qSM8PrWwJbEr/7dtj0=;
        b=DoDhPy2WJQ/naaT++aIqcJzdzALnNm0X2NwEmXY7MNLKWkyOW6vFVhFL13cKdq6c2t
         q4FAtM3Ug5mSjw1xIa89fKTIV62TPYOntOsbiL8jwk2tqgBfScnYYT1nhulnDGaCwQ0p
         8QSoW4YR+mx9KXjhEFEhvxi8tFuo8KaCGppgqxHqkYBvawpXgpSNHIEXc5MFo2rDydeU
         iz+Cd1VTcFZtmjnw2evZqVXqmPkrz1UEdhfgOmu6/EppUO6xoFZcbe06kULVTSitUWdQ
         Lj0lW5nrwHcrm13tVD/hXCyzQMKp9PdIzfvks7nFisXTn++9jraHqtPeGPLbEBp3QvmO
         JBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aOKoxMtNyA0xhNibVJgaFQ9E2qSM8PrWwJbEr/7dtj0=;
        b=wDlBX0LtTye8CNQfChgTMJ8ABFmZRNXQsyHeN17BsdKKtM0sldfvIAI8+w1HHDosQ3
         DjuaO7wHcNCPp83DfLTpuuAQjBo1jrmKQIw6IUAS2zv1Erz5FBlVErru10p0a9glFW+e
         mD8TagJZ3atmW4eQ37m9VvhhjXDa6bZV5fuv1YveEb2zNWaFCJ8AkxTJKA7QhvEMFs5N
         QIBHPG9ZwZT1YdeQAz0KxoQ1dMhUEU9ZynNSt0E91r6WObCss8uXNbhwCVePXeeUiJH9
         ykdpR39enE09dDocCOdJV3KAP7JC7DUrPe4nkM3YEnZE2coK2EFHAcXCTu4lTVhzOlRj
         c3cQ==
X-Gm-Message-State: AOAM5334lihAGD44T2l53gjKT6LlAYPxEPxcLtgJxl3jdUhOOjBHu0bp
        jD698S6N2upvwhuUFRWTOUI+HzQ9895ljITOuenOiubji+emjGqPHCjUjMppCRkEaofoiVSpszL
        c8Rh7pt89QsO18cUr+I6vqfOu+irsxV94XZih+D9UGfw0KmHYQTL4RUFoo6CGSws=
X-Google-Smtp-Source: ABdhPJxvafrG5Ndsuz6CuEjgnbH4KnLaNYMQWPZjEzF5wbjY4Rew8gxCnsbdbrC/CdEdFRuQqYX+va+QqeUCvA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:5206:: with SMTP id
 v6mr1832459pjh.220.1644485347156; Thu, 10 Feb 2022 01:29:07 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:22 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 09/20] submodule--helper: remove update-module-mode
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

