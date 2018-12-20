Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB0A1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeLTNsv (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733297AbeLTNst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so2265306wmc.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DQoyBLG0jWJ5WkdIs3JMwMVgDu/0uCwT7NxVEdvA3k=;
        b=pTcDoZjumtZJ47cjYzP+lgxjH4M6WoFHLfij185JAZk0LIBOHqktwPuwcd4yvYYrR0
         cYMAx3TxCbaikYmeoKGEurk6xKHdHdJu9jh88f/rjR50ma+tcPsqZsNHKBajfmVi5PJ/
         ZPhmoe1B9MbPZYY0WayA60lSQVO8KoMrJzxyBLQbcHP3Tvx49sZThIOFKe9zjFfcp+e3
         Dj64PKLwgFUeIkLxz3OlbrK0UMPy//sxq4J7E97qdRxHvqHBHTyjvqRQyv/m8d0Dabsq
         f/r2EavZYwUSqfY70L44OjT2tr9KrJNDKNO+T3OAO+KYvzjItgLACBhdkG6ynXSfI6y0
         dicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DQoyBLG0jWJ5WkdIs3JMwMVgDu/0uCwT7NxVEdvA3k=;
        b=KygJySkzxV20lk40oNiV4ny9DjvTWE/p7unk1G0ldUJu98yZq+BygMNf/BKsrPdCUV
         RoY3uZvQynrW6QzJ0EGL2hsTyJbMzroJLCmmbbBeqlC4ZtYfl0HHcqlwEvHKkfFm81pv
         sSP9AN/M22sDe1nP15KsUxx9sF2Ht4JdGX/baISdf0DM0lfDhO0emUKC4hv8ls93Adba
         0RRVqpSpMm/H53IS4hIguysZRK3ggJkq4Vj4BXdpAMdVr+WcbpwGAPXy/cVgWaD5Fx0R
         ZjULo0e50C/ZxB3IENg+DgZ1/HI8EN1kwkpHQfbbrmrFq66j6Rb86CZsnQi3Wxa2V/K/
         2Fyw==
X-Gm-Message-State: AA+aEWaH1Wtc3zDzKi53q78blmiE1rcls2vfnnK3BQ8kAl7CTPrlFS9g
        dfYWKAQ1uO7T3P2xg7Sa3C2NeuIbWzU=
X-Google-Smtp-Source: AFSGD/W30lHp8QhOw92DoUSX0g3T+1JXpwdNxVUuMeYgXMEHETts0Gkzf3o2onYRqkbhn+Ip+TZzGg==
X-Received: by 2002:a1c:c87:: with SMTP id 129mr10997452wmm.116.1545313725971;
        Thu, 20 Dec 2018 05:48:45 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id t70sm10856658wmd.36.2018.12.20.05.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:45 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 6/8] checkout: factor out mark_cache_entry_for_checkout function
Date:   Thu, 20 Dec 2018 13:48:18 +0000
Message-Id: <20181220134820.21810-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the code that marks a cache entry as matched for checkout
into a separate function.  We are going to introduce a new mode in
'git checkout' in a subsequent commit, that is going to have a
slightly different logic.  This would make this code unnecessarily
complex.

Moving that complexity into separate functions will make the code in
the subsequent step easier to follow.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/checkout.c | 67 +++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cb166b2e07..32c4b7f897 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -247,6 +247,40 @@ static int checkout_merged(int pos, const struct checkout *state)
 	return status;
 }
 
+static void mark_ce_for_checkout(struct cache_entry *ce,
+				 char *ps_matched,
+				 const struct checkout_opts *opts)
+{
+	ce->ce_flags &= ~CE_MATCHED;
+	if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
+		return;
+	if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
+		/*
+		 * "git checkout tree-ish -- path", but this entry
+		 * is in the original index but is not in tree-ish
+		 * or does not match the pathspec; it will not be
+		 * checked out to the working tree.  We will not do
+		 * anything to this entry at all.
+		 */
+		return;
+	/*
+	 * Either this entry came from the tree-ish we are
+	 * checking the paths out of, or we are checking out
+	 * of the index.
+	 *
+	 * If it comes from the tree-ish, we already know it
+	 * matches the pathspec and could just stamp
+	 * CE_MATCHED to it from update_some(). But we still
+	 * need ps_matched and read_tree_recursive (and
+	 * eventually tree_entry_interesting) cannot fill
+	 * ps_matched yet. Once it can, we can avoid calling
+	 * match_pathspec() for _all_ entries when
+	 * opts->source_tree != NULL.
+	 */
+	if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched))
+		ce->ce_flags |= CE_MATCHED;
+}
+
 static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
@@ -297,37 +331,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
-	for (pos = 0; pos < active_nr; pos++) {
-		struct cache_entry *ce = active_cache[pos];
-		ce->ce_flags &= ~CE_MATCHED;
-		if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
-			continue;
-		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
-			/*
-			 * "git checkout tree-ish -- path" and this entry
-			 * is in the original index, but is not in tree-ish
-			 * or does not match the pathspec; it will not be
-			 * checked out to the working tree.  We will not do
-			 * anything to this entry at all.
-			 */
-			continue;
-		/*
-		 * Either this entry came from the tree-ish we are
-		 * checking the paths out of, or we are checking out
-		 * of the index.
-		 *
-		 * If it comes from the tree-ish, we already know it
-		 * matches the pathspec and could just stamp
-		 * CE_MATCHED to it from update_some(). But we still
-		 * need ps_matched and read_tree_recursive (and
-		 * eventually tree_entry_interesting) cannot fill
-		 * ps_matched yet. Once it can, we can avoid calling
-		 * match_pathspec() for _all_ entries when
-		 * opts->source_tree != NULL.
-		 */
-		if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched))
-			ce->ce_flags |= CE_MATCHED;
-	}
+	for (pos = 0; pos < active_nr; pos++)
+		mark_ce_for_checkout(active_cache[pos], ps_matched, opts);
 
 	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
 		free(ps_matched);
-- 
2.20.1.415.g653613c723

