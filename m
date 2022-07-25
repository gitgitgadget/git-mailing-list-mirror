Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C22C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiGYMkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiGYMjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526E21BEA3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so20224728ejc.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFdKEyn/kVf5y+uRB/tof3pJI/v4H9cQLb05gvMBudw=;
        b=gJBL0eynE19PrjWZ7NHXzshW1aslOyw6dyKe7PPIM0VstH7LPoC+EmQxdeXU8L0a5G
         Lz2lqVp92vAl157VStmn4udAARdjivDryuSRSbQ+6PGhPCFfFqeOfb3L96hz6FC+AOHF
         gMlcZaiUEaVQFCOr7joYQrtKAlTqtFfVJ0GX91+bMVj0miGKxmX70h11y23detRZmw/k
         h7dV/NKKJQvGW8uNVHGQWQdnxuNSRwPOzWFVzbzCxF81e7fcoB68A2fth1inlNax9gQX
         HrhsDWfGh3tgQVyZLgUK9v7Jduto22Y0HSjk5fJ5ymf1atGjfMmmcNZ6VdjMRNAxpUPX
         uYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFdKEyn/kVf5y+uRB/tof3pJI/v4H9cQLb05gvMBudw=;
        b=yapAxal1joNdjh0oCh/KgKrzn4NFUiGSaKRLLo7FD8T04E16ZxFj9C6bLBE9rMATZL
         NrQV6qIqDTUkpxho777eBmMFsFYdT3FF5y4ff/TELiF+hUzysRjVctOc6xvK16ND005s
         WBumV+us1zsAll2/4D7r5NzRvTE7PnWT0iv0sS+tsi2NuB2lBhr4zhUpnT3c554m/98V
         uJUEKe86knrtYaAH0zJMtg0YZfn+Vn+46RbzhnnERQDAKLTWYQilGAnXw+r3QVDZKhdz
         0mk2ftOXeiSNensVLyWKzWiuQH826adVTxJcCJzd00BIfipsDzzdl/IxF/f2/8Yy4Ij2
         QLBA==
X-Gm-Message-State: AJIora+U2h4NQPIa3O1eFM76aG40taiw3x2Y31C5zzx9KPySsXFRmWom
        JMSBjUrJaBNSImyfm0Y8ApXzySKBuUY=
X-Google-Smtp-Source: AGRyM1uvZsbt+wtkVrSvOr46DbXKTPsz4+Udr8p+KWpOdYU8H280iW/uE4LadAd9GmH1BTid6w0tSw==
X-Received: by 2002:a17:907:3f02:b0:6f3:5c42:321a with SMTP id hq2-20020a1709073f0200b006f35c42321amr9675755ejc.521.1658752774416;
        Mon, 25 Jul 2022 05:39:34 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id o15-20020a056402438f00b0043b986751a7sm7170236edc.41.2022.07.25.05.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 20/20] builtin/worktree.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:57 +0200
Message-Id: <20220725123857.2773963-21-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git worktree' parses its subcommands with a long list of if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/worktree.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index cd62eef240..c6710b2552 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1112,31 +1112,24 @@ static int repair(int ac, const char **av, const char *prefix)
 
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("add", &fn, add),
+		OPT_SUBCOMMAND("prune", &fn, prune),
+		OPT_SUBCOMMAND("list", &fn, list),
+		OPT_SUBCOMMAND("lock", &fn, lock_worktree),
+		OPT_SUBCOMMAND("unlock", &fn, unlock_worktree),
+		OPT_SUBCOMMAND("move", &fn, move_worktree),
+		OPT_SUBCOMMAND("remove", &fn, remove_worktree),
+		OPT_SUBCOMMAND("repair", &fn, repair),
 		OPT_END()
 	};
 
 	git_config(git_worktree_config, NULL);
 
-	if (ac < 2)
-		usage_with_options(worktree_usage, options);
 	if (!prefix)
 		prefix = "";
-	if (!strcmp(av[1], "add"))
-		return add(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "prune"))
-		return prune(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "list"))
-		return list(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "lock"))
-		return lock_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "unlock"))
-		return unlock_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "move"))
-		return move_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "remove"))
-		return remove_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "repair"))
-		return repair(ac - 1, av + 1, prefix);
-	usage_with_options(worktree_usage, options);
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	return fn(ac, av, prefix);
 }
-- 
2.37.1.633.g6a0fa73e39

