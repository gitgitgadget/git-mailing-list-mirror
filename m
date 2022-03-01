Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608CC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiCAEm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiCAEmU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:20 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF1F6E352
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 97-20020a17090a09ea00b001bc54996b62so745342pjo.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=GxIsdbQgAQyVrq8wij/eYLOLjSjVSiUnDACjpwQoZSFONadyl5vLIdGLgneTnuLAd3
         BBgQvcNEvs2CbhohyDdtYIzOWz9D/a68nzVoPFvInIgXcJ2Jv4jlZ4JWfYCjtrLsxzkd
         GcUfeC5k3UjuYee7zIL7Prg/BbWIMO5iu3vDdZMsCsAz5+es7PSR12XKlf+kzmkAlQNK
         Z9BpArLwTBceCwng0M7mLKyIcAAwNX2KOr7J388Q1MD6Q7TcXH2MiA0ONCYR84kJ9pxt
         57eAGsuDH+FRTEQQ+2KnjqDSXCjUXNc38CWFmiR1oAruItiQzuYazfhTx2kLR60ib8Qr
         a0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=hTXQQ1+3MEtvgtGYvrNYj+fcofj+t4TGGLzEPS9HOUe+K8KWbRvqpVuByuNv8dOpVU
         cQ2LyWsf8nkm2xf4Q7MkbT7ShsvmWCRmoq+5hioUZ3Walgaa/slYK8XAkegjVKlWpHZ2
         qHa3Fe/70rq/kqnrOoIJhTDp7C3fvrEpwYPBNHWllVapu33lshvBJZuzZPSgMEiSsiit
         flEX3SdmNkonkOzo9Bbg5OSfK92LR/fiDIOkMcKnoDOrRYZgR3pR6dm5k0kB8Qe+BBn2
         N96mxEj/lJVXrFo45iGAPrr+gS1XtGIDuHZ27UUl3+36YjPhedcI5cEKPQ77ZOMdS0HF
         IHww==
X-Gm-Message-State: AOAM533vw0KtKGcMzFG91lGt+U8aJDdCagInl/STS466bhuIOFqWNNUk
        Eh+abzC93IOaeIss5z/2vrHfhZ9vpzFzJNG8vviolOKANYYgWBJk1vY95a2NdreinCLlmdnJ5KH
        djQQIkzQG2jA6ZXu4oDQriU9CpHrWqrrqgTNaY40En5E/MycZARCqs7B0Kxpxq6c=
X-Google-Smtp-Source: ABdhPJw0Hz5Vy0OM2h2OLu5X50MQjkXCvdWhFvJHlzUnpUa/uYdhq5fQ2zeKnn8U24mRKtK9RLQxe1DoG6GZMw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:22cc:b0:4e0:58dc:e489 with SMTP
 id f12-20020a056a0022cc00b004e058dce489mr25421244pfj.58.1646109699730; Mon,
 28 Feb 2022 20:41:39 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:21 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 02/13] submodule--helper: remove update-module-mode
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
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
index eeacefcc38..c11ee1ea2b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1957,29 +1957,6 @@ static void determine_submodule_update_strategy(struct repository *r,
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
@@ -3430,7 +3407,6 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
-- 
2.33.GIT

