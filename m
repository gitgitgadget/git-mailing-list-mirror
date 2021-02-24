Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF6C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2211064D9A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhBXEGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBXEGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:06:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DEFC06178A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:28 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w6so556005qti.6
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gz5T/diz7OW/xrcnN1TLwub9W5C7atWIzbheTcDORJ8=;
        b=eLukSXnLdejgfkm3wYdKyDuwywEsZwvV3koi0/ViXr8lYnM4The/s5DE0RzPngjdLL
         VPEvfNj2M7kfFVAUQ4RSiCSyKih9C5Jg2XkYahCrbNGYl89JXGYTjNGecQtlmSNJ734U
         rGaM8uV48Qs9mDxQNuEx9r2OpLwpvK0m4be3P2wHQFB8hlwIr9MJs6w0S8E6Sm2YlHfh
         dvH8K0iEUeh9sVkKdzhNSFtWcbF6Datz1T/bgBE8uz1OspQuVz3r3vVHO1bYFTTDHlMP
         GsXllIii2nz6D+gCLSGcKcjyPQZeTkTowdiMlkWB9sTk3TGWGX/VM5O12NFvAdylff0c
         jk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gz5T/diz7OW/xrcnN1TLwub9W5C7atWIzbheTcDORJ8=;
        b=ln97MbgVF7UyO7T+7rrm/P/yaxGvErvJIRUN5Qu4MMTI6k5hZ2eQW4IUd3YPVqvEHh
         8r2xechfHrtar0zQISgnoeo3Y/2FWcz8OtVv2jTZu40iGi+zNGJJ/lI0s9NUXkdNJ2bE
         vzttlOreKdCS78nwUmvr3Hh/iqxjBA1QV6yiKxWoElJ4wVmTEGrf/SWVQfltKjq/5z7U
         StWXWj5gBlARAXlzH1Ds+DU+zWKBHvWO0ub9IOdj5WvEKV8ZRL9jNgbS/xJHjsqO/431
         oq52kmc1VmB8B3TDYp6IDERAW4rvctOpIE9XeFdp4DCuIiAAMetnFX1tN1WamCPGNYhQ
         2aTQ==
X-Gm-Message-State: AOAM532UuqqORWh+CUQzul1THb1J24dXPBOY+yIVi2XtglD4Rj8TcigQ
        l/BAiA3bjdu2Eb8V3L1WAvmG399buQNcPQ==
X-Google-Smtp-Source: ABdhPJwee4Nu9WFL2tna1zOmOvYCGY4ajlnW95jxQjOMpy4pYMB6tOnTVtr6PBc+l20oDYe3dbb+Ow==
X-Received: by 2002:ac8:75ce:: with SMTP id z14mr13390480qtq.286.1614139527831;
        Tue, 23 Feb 2021 20:05:27 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z65sm547878qtd.15.2021.02.23.20.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:05:27 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v2 3/7] add: make --chmod and --renormalize honor sparse checkouts
Date:   Wed, 24 Feb 2021 01:05:08 -0300
Message-Id: <0f03adf241f83dcd97b2be53cd622eedd4695116.1614138107.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
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
index 9bb5dc2389..6781620297 100755
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

