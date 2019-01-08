Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE8D1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfAHVwp (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfAHVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so5979400wmd.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/EHqfH7jp+WNJcC9c0OBVNEdoH14/obUNsXCaC2I2k=;
        b=rchsb/xb0TqagkONCv4h4l9zw5UGyyG7fofZCnLTpLzPTywgZ2GED2aOhPyApSiTHf
         0m3pS/c0YsvsvMw6+jZ3zyydz3ySAYHY7ffIy6ltlaupvF+A0GokgGhin5FhdZFDhQ9C
         3AF6pg8uzekUmMAsmAGf0CLYSEei5AutZ7oGhpAKVvt0Y5u3dJKSFiEeDnIv0RTqg5pn
         oRwcYCsVKDWGmRonEyxykNjNk96g5dEq1FIa0vDYKahfWF6dZSalT20d8shQOhpaqEof
         9qXvR+wgA5piljwZQvcifac8I3X5qNIpJfPXzJm0X3DTNgp/BPLBpZX4/4+ejF90wUx/
         4rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/EHqfH7jp+WNJcC9c0OBVNEdoH14/obUNsXCaC2I2k=;
        b=PR6rGR1OV4AlGM3i3QyvgE21dIRYqp49v6ZoZXN7SPAXFka5PTuYf460fUhwYZfffk
         QlvdLJybTp2Xkgk4OAoZes/W2c2u9KfMSwyyAd4xQ/a39nuusV5Y6S7IOT7lc3rYm0Xn
         Oa1UrmngII3XJEctIxBFcULwIBhmQRSji94m2NoMfcJvRRcsvr20AtyTBBK4lXNoLeqN
         aOUp6e6d4Fl9GekI2YZNSPqtBgJ6vNXbJH/7zeWmYuoGzU4q4rMRE5ClSBVAZTz4LlUy
         JGx+vQviymxU+LplK+1uiJQinhwjFb8izXEtiCx9CW2Q61f4cHUTCG2KdpaSvrNgpym9
         MyPQ==
X-Gm-Message-State: AJcUukfvz+ljHeDu3uVUCPir6WuHE3fhhmHblSz6HaXkoQGOkIJ9U2pY
        V2/xStO0RxmAXlCbM7T9TtDeMpP6
X-Google-Smtp-Source: ALg8bN45RLTxdQNB4DOiCq9IegPaXXmnO3EaU6aBz9c5Uk0D/8iGYtCX2Wr8V8jPbqJMRcnvKQge7Q==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr2891684wmj.129.1546984361584;
        Tue, 08 Jan 2019 13:52:41 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id q9sm43162451wrv.26.2019.01.08.13.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:40 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 6/8] checkout: factor out mark_cache_entry_for_checkout function
Date:   Tue,  8 Jan 2019 21:52:23 +0000
Message-Id: <20190108215225.3077-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
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
2.20.1.153.gd81d796ee0

