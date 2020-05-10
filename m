Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D08C54E7E
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A561220CC7
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sQuMNPeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgEJAmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 20:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbgEJAmD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 20:42:03 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E7C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 17:42:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fb4so2658530qvb.7
        for <git@vger.kernel.org>; Sat, 09 May 2020 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1u5R8ggOzlkUTvyNzWaw6inkG2dnrZ9hao4+t/gpAQ=;
        b=sQuMNPeqkRd8srMkhGIRuS7zcB8x7rz0BVK5xxDmfnpu58T6EvVhwjRk4f/oHaDnPB
         OvnyqoqkFwGR2rCiGLat4ZbGXpMKfGmB6PqXwLxPL2loWcJq+TSY+RvirOV5x7nz1mNu
         4lnIDmZGU17awOEKR4B3IFVlcodZfTJRc9Z/pxlUnUNHUhyyklfGq4k4Q1eALZg36Tzg
         dOD3xskzyVlEGMmxrQfXebTWqlVwbWZos0MBb+Rlb6VE9tdR/9s8ZvThaGkMjfwcT4Fu
         TO1o4cfBqcbY12vyrSUCHuWblmA64/Uz4sYQQ2TSgHZCFkV9RHMpynczOcw2qB8ZF+n9
         s/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1u5R8ggOzlkUTvyNzWaw6inkG2dnrZ9hao4+t/gpAQ=;
        b=Tv5DfwAWz1VwQOoASLv4Z9pKzqrivMSCqJBgWUi7cl0JkPL0MR0xFMn1WBB8O+pA/u
         0ruNnew6ondpqIBMsuBmPSZNzzuQ5ZwM0KC3pG0sI4cTNM64vkMQvHBc4wNs2hsTlXNr
         Xb1viLsL1gcMSBtAyHlnwgyagrWEPgoE8N5Sy2idAr/o1EdW9xcitCqoinPUR5xNTQcp
         pW/npqZXTFbJn1hO0J6JX2p9lPxVdwbDFvLT++Xz50i0XAIrjTAmpe6QP74+xsGv1mRh
         830+UdNtnMQSlou5/ESnBs7tjtq4PGajIcCgp7RMMTWqC59O8aBwhgWZL5364hRykmDH
         WH0Q==
X-Gm-Message-State: AGi0Pub3zZaoIy1O3USUqzRbzFuVyFzWEuGrVn/h1qEy6ls6Fr8bE+lW
        KY94YRdfYxAt7M48tHdcP9M2iCzWWRM=
X-Google-Smtp-Source: APiQypIVeTxWvPbi3+6iwtc40gpVwJgP3EaBpJzF7qGSzP3M1utZi7ryR/iKIsf1kTZzez7aVCL31A==
X-Received: by 2002:ad4:4a27:: with SMTP id n7mr9710028qvz.80.1589071321834;
        Sat, 09 May 2020 17:42:01 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id s8sm5615974qtb.0.2020.05.09.17.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:42:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [RFC PATCH v2 2/4] config: load the correct config.worktree file
Date:   Sat,  9 May 2020 21:41:28 -0300
Message-Id: <882310b69fd3df0acc6823a2c73bbe1801d9f6c4.1589058209.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589058209.git.matheus.bernardino@usp.br>
References: <cover.1589058209.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the steps in do_git_config_sequence() is to load the
worktree-specific config file. Although the function receives a git_dir
string, it relies on git_pathdup(), which uses the_repository->git_dir,
to make the path to the file. Thus, when a submodule has a worktree
setting, a command executed in the superproject that recurses into the
submodule won't find the said setting. Such a scenario might not be
needed now, but it will be in the following patch. git-grep will learn
to honor sparse checkouts and, when running with --recurse-submodules,
the submodule's sparse checkout settings must be loaded. As these
settings are stored in the config.worktree file, they would be ignored
without this patch.

The fix is simple, we replace git_pathdup() with mkpathdup(), to format
the path with the given git_dir. This is the same idea used to make the
config.worktree path in setup.c:check_repository_format_gently().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 8db9c77098..a3d0a0d266 100644
--- a/config.c
+++ b/config.c
@@ -1747,8 +1747,9 @@ static int do_git_config_sequence(const struct config_options *opts,
 		ret += git_config_from_file(fn, repo_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
-	if (!opts->ignore_worktree && repository_format_worktree_config) {
-		char *path = git_pathdup("config.worktree");
+	if (!opts->ignore_worktree && repository_format_worktree_config &&
+	    opts->git_dir) {
+		char *path = mkpathdup("%s/config.worktree", opts->git_dir);
 		if (!access_or_die(path, R_OK, 0))
 			ret += git_config_from_file(fn, path, data);
 		free(path);
-- 
2.26.2

