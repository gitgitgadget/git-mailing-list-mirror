Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD95C43217
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F3C61A89
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbhKOXUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352952AbhKOXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468FC03E038
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y196so15217101wmc.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jG5CUr2JmRcsZRlVTmanKw6D6Z3HcgQ9CLw3BKoDSog=;
        b=PQQV0rRPVGLghfq/LxIMt04nlkF+LjVmiWd98ztQyTHbmbTl2puW+e6jnkFPmE3Zhr
         xRJbU+PhpEBFxI6NFtK6jVhMASbSbWbjNiWAO/wN0V0mt+eGN2fcitUndCXJEgso6aGY
         9Me6gKgzLk+jMHH/RvUImabr+OH/Ujq90r7WRsDQeanOdd+3fhnA2xA4HxeOtJXn0Sk9
         tCvrAtiuaCjw7AVwjCHZLVELFT4lKKgzQJOhjZXIqRtRKsG8xRIFJUmn/0uC8liEhJYi
         dKry3GhIVVQZhxidSEYHYbVmLM56OvN2UmM7HzgXq1dvR73uuPQr0OKkiDWS3bemtYvs
         /dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jG5CUr2JmRcsZRlVTmanKw6D6Z3HcgQ9CLw3BKoDSog=;
        b=X7ouK90ZBF1hnNTtcsFTAQjJCBBZLt2L2XKRtpzIgZUOW27VXkcLrJS8ST9Q/QnTZP
         uxGh91dWpaiR0KPQ7wdsXZh3YAtJYH05Tg7fuGYXinrGkNK8klgbEz0wPe3wQwN81G8A
         4H64QdB+3WBfYTplqLypB10zFc5WcORMomeQ20u52zhtqqdy6WcJgktyNxJrsNJ4ypND
         7iM3I+U2nJ1NbqW/6ff3nfzVZAHGin2pmMtxkF5JMaFV8pn1yy/mWm6syoysTncI1Evq
         fo2ekKpWaiSSyh6HJNfk+OZEW7XXm2OpKV4pVqUip/4fHBJGLmiQVS5gdvph/Vwi9stk
         TYgg==
X-Gm-Message-State: AOAM533Lu9RHQDifwq34dlvfV4D3QmKXTiH2jG7t1IkhO1J0zPf9SkHA
        shARaPlCdqoqQ3Z7hfEW/jfqcbfWn9Vd+A==
X-Google-Smtp-Source: ABdhPJwlI/oPnmnRsx6hiGzC1D5cej37OWfTZVxg1ZZu6CCUxoVGS4DvdgRIsJjgCTsQTU63eMTbYA==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr2089009wmj.156.1637014721927;
        Mon, 15 Nov 2021 14:18:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 11/21] cache-tree.c: use bug() and BUG_if_bug()
Date:   Mon, 15 Nov 2021 23:18:21 +0100
Message-Id: <RFC-patch-11.21-b4c08efca17-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "BUG" output originally added in a97e4075a16 (Keep
rename/rename conflicts of intermediate merges while doing recursive
merge, 2007-03-31), and later made to say it was a "BUG" in
19c6a4f8369 (merge-recursive: do not return NULL only to cause
segfault, 2010-01-21) to use the new bug() function.

This gets the same job done with less code, this changes the output a
bit, but since we're emitting BUG output let's say it's OK to prefix
every line with the "unmerged index entry" message, instead of
optimizing for readability. doing it this way gets rid of any state
management in the loop itself in favor of BUG_if_bug().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 79d168192d7..944e9709ae0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -692,14 +692,13 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
 		int i;
-		fprintf(stderr, "BUG: There are unmerged index entries:\n");
 		for (i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
 			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
+				bug("unmerged index entry on in-memory index write: %d %.*s",
+				    ce_stage(ce), (int)ce_namelen(ce), ce->name);
 		}
-		BUG("unmerged index entries when writing inmemory index");
+		BUG_if_bug();
 	}
 
 	return lookup_tree(repo, &index_state->cache_tree->oid);
-- 
2.34.0.rc2.809.g11e21d44b24

