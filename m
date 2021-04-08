Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D31C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93566115B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhDHUly (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhDHUlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:41:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29DCC061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q3so3665733qkq.12
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DffCOz+Ock6QePmxrPLDPN3bWn1VOqXtiAhStrQzeq0=;
        b=UZW+r5zW1fueUisrxR3EoJCEquJRe9qyv5Wsu5vm1eDeb5rReXl7giXQNk4xfpNxdu
         6+9HxMUhQeAnH9yVgAktoCpNnE11DfpXSx4vxjvyYMWiNtC7ssqMBInLYjTJe1xVzoD9
         BqcTPjHktwoJUVQvC3vMnqjK7Lim6uaNMXsnfCjr9kv7WAHl4+UOUHz7Ksh2nv0RV9I4
         VVDQf4zHeNlyOcj2GvtQU7hLFxpvd/Ma6MDAKJPzE2IjEt25m1zytbPgW89WEpw6+Z1S
         HQLy2OTpzMS7B1mHDAc0euUYm5x0R+dyN2HejUhs21M05djjFgDGHN8O7ZVXp8lOYQ4R
         UlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DffCOz+Ock6QePmxrPLDPN3bWn1VOqXtiAhStrQzeq0=;
        b=H20f0+Wmc3Ywx5WQk+JCEQdRjlLfsj9r5hvZeA1Z1cC0Xf8PMZXyiG1ycCcX9eA82b
         bzFg3Z1Jtx2SGHhgUof+GV82gOI5N6KmCt+D0jHRZzJSPr9D/XWMBCKnrTXL+eBZXCBb
         W9AN0HsXa/JTAzEmVAStGuuG2/8XE+AXbJyeqkm9lnpapXsZOtLptCzXfoVC4wBeYEsv
         zldRHiYRZGULh3Hb5Xs27Ziw2nR6i80F5gyU39tWmr9GMeg2a58aGhkS9/+XJTg4kjoO
         g6c/80jBFHQ5lxHYSxqUBIjd51ZnIZAfUzoQwjujwsATAGaEFgxMr8xf6+QbXrF8S5MU
         GsGQ==
X-Gm-Message-State: AOAM533/1SlISzRvC9CWlOa4MyXbnzL92KdHLRWHVGPXX2/yOWtzbZKO
        5+OIIe5T41IFFsLtKB1QfHv0hXeTQbVQKg==
X-Google-Smtp-Source: ABdhPJyFIF1gOyVN3o4+x8AiKna2mJbnK9fOytIRmPzlvXKeXjaGN1YJrbB5E86oFGTSMQpPoJWaBw==
X-Received: by 2002:a37:a016:: with SMTP id j22mr10587478qke.486.1617914500727;
        Thu, 08 Apr 2021 13:41:40 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:40 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 3/7] add: make --chmod and --renormalize honor sparse checkouts
Date:   Thu,  8 Apr 2021 17:41:24 -0300
Message-Id: <565c7d34606da681fbf6cf4e292efe7134616c79.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
References: <cover.1617914011.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c                  | 5 +++++
 t/t3705-add-sparse-checkout.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 24ed7e25f3..5fec21a792 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -46,6 +46,9 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 		struct cache_entry *ce = active_cache[i];
 		int err;
 
+		if (ce_skip_worktree(ce))
+			continue;
+
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 
@@ -144,6 +147,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
+		if (ce_skip_worktree(ce))
+			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
 		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 6c5b8be863..00b10ac877 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -78,14 +78,14 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	test_cmp before after
 '
 
-test_expect_failure 'git add --chmod does not update sparse entries' '
+test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
 	git add --chmod=+x sparse_entry &&
 	test_sparse_entry_unchanged &&
 	! test -x sparse_entry
 '
 
-test_expect_failure 'git add --renormalize does not update sparse entries' '
+test_expect_success 'git add --renormalize does not update sparse entries' '
 	test_config core.autocrlf false &&
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
-- 
2.30.1

