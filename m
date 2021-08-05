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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F3C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A2D61008
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhHEHlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhHEHlr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:41:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AD2C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k2so6016433plk.13
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUGNEGv5b7iiJ5jGiHKZnJPiC1v9derrDbJFJLo+EPU=;
        b=HN/AJoWhrDEm1RKtjsgcDK0KFjApGPlEmepXkYf1gUQ8ioq15yD7syk7ogCHvJ6lPP
         h+wrA9KvFQusuYe9JO3xfCr6+Tbrl/Hk1YG6+5KXP2iAkxszbYKuKoDWQE1z2ktQC0tE
         wSFRA+gyWR8/LSwBk/qHhFRVSURiLNr0Dtcwi1mc2GGuLor4SP59gZhMpUP9OyzkQgTI
         0R7gaQiK3+sp0zB4FcHUwETex8rMBnEstyzcr4PMqSOyHiC0T8g7eINMROwve06uruvL
         2ao0EfJhzdv7rK2TQn5PIPEIMt3v2UKykZqkz4a7ZkFoBIW5fI9JWcr4OYO4Wns24IWk
         vw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUGNEGv5b7iiJ5jGiHKZnJPiC1v9derrDbJFJLo+EPU=;
        b=MbvriNig47OLagOkfrTcbDZVkNGGAcuutBuEhaRYKgnKYwMF0r7GPgnTruOuXh7KMw
         yNNxR8AHOR1Fo2rGlLTdOKIV/TYUiUV3VQW3kywddNmvByaQeGQ7lxnZ93ImI71tnToP
         dattzR9Vb6yTu0y3PcO9ElCqiakzQcXde/L2EXMoloZdWDtMNKB2H9+4SPTJoC4a9Jua
         OZRqSR92+/cOCWzeooGa/GrIQQgTFL+GS2jDJNcq1unI96YGEM5Cv3xPK5S/k1EFNy+f
         VqcY5I6i4Q+GFZK0pc9iKb+SJi2vfA8Ma25IXWYNacmf5+ou+URVJcebNI4XfthR2Mkm
         Sthw==
X-Gm-Message-State: AOAM5301Yemls8mZsePcv0BpZSj178x9pK94iG8ISKoDuMB+gj8vQ/Hl
        a+JHfXjKn8pt2k2GN7CLfcc=
X-Google-Smtp-Source: ABdhPJxfaMT3farVGMXscXyE8YMGeuiZmcG4fzGIF46kgs7hW3MJjx7lxLr0VdyP64iMNUixpuufDA==
X-Received: by 2002:a17:90a:ba82:: with SMTP id t2mr13991729pjr.143.1628149291603;
        Thu, 05 Aug 2021 00:41:31 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:31 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 1/9] submodule--helper: add options for compute_submodule_clone_url()
Date:   Thu,  5 Aug 2021 13:10:46 +0530
Message-Id: <20210805074054.29916-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's modify the interface to `compute_submodule_clone_url()` function
by adding two more arguments, so that we can reuse this in various parts
of `submodule--helper.c` that follow a common pattern, which is--read
the remote url configuration of the superproject and then call
`relative_url()`.

This function is nearly identical to `resolve_relative_url()`, the only
difference being the extra warning message. We can add a quiet flag to
it, to suppress that warning when not needed, and then refactor
`resolve_relative_url()` by using this function, something we will do in
the next patch.

Having this functionality factored out will be useful for converting the
rest of `submodule add` in subsequent patches.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6891480013..2d2d8ac637 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -590,7 +590,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static char *compute_submodule_clone_url(const char *rel_url)
+static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
 {
 	char *remoteurl, *relurl;
 	char *remote = get_default_remote();
@@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
 
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (git_config_get_string(remotesb.buf, &remoteurl)) {
-		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		if (!quiet)
+			warning(_("could not look up configuration '%s'. "
+				  "Assuming this repository is its own "
+				  "authoritative upstream."),
+				remotesb.buf);
 		remoteurl = xgetcwd();
 	}
-	relurl = relative_url(remoteurl, rel_url, NULL);
+	relurl = relative_url(remoteurl, rel_url, up_path);
 
 	free(remote);
 	free(remoteurl);
@@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
-			url = compute_submodule_clone_url(oldurl);
+			url = compute_submodule_clone_url(oldurl, NULL, 0);
 			free(oldurl);
 		}
 
@@ -2134,7 +2138,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (starts_with_dot_slash(sub->url) ||
 		    starts_with_dot_dot_slash(sub->url)) {
-			url = compute_submodule_clone_url(sub->url);
+			url = compute_submodule_clone_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
-- 
2.32.0

