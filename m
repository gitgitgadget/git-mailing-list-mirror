Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D861FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761676AbdDSJdb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:33:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36304 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761667AbdDSJd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 05:33:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id v14so1781571pfd.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tLzkuncYEkYzgbvLu2vsVYkP7N57Zsq3f0KcEYVcdQk=;
        b=sEbDQvu8Luex7QLPuKXGUWYAHteCsEOcAivZoO8CVFEwIapx6e8/ZwEs9Sd9e47tOQ
         8nV/T+d1uygbE6IGW8m/X+gkdcMr3Kntyi1mIa/Y73UL8b0WyLlwoj9O+9zf4Kgll5LC
         Fm+fieXBZw5FNmuRTF9yz1Xz7yDBbAxRIrhTVDksL7vgbMUSueWHrpbZE8Ur7wg5AoYr
         41UNPAUtL428/bBP/5fUL9W9441pG0C6bsej78UIisebzZILv8ZyW2KEDABThUPDtVwx
         ZAh+ICqWIywCYFX6SVdhsOZidMSdSLx2/TLo+LcYIHa4sgVv04EPnV9PME4q2/fc+Vma
         dzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tLzkuncYEkYzgbvLu2vsVYkP7N57Zsq3f0KcEYVcdQk=;
        b=GEOrYqMweTa4gsdQk5JUOh3qkuNYuSq9XEa8V+pUkcT0xLjZ2aGWkJpAugwzTffwjx
         9PDlt6BpBgkWikoA3oAU67HhRejE17gRyKqX72txtjTqm7zimd01mLzwh0/5svSgPs+d
         TFCy1krRVBZTF3wumMTX24Mt1zYxjdl6cdwfYlfXezzA6gsg1F93mjRKne2JxQ+Ip+Ve
         tMvSzLJv/Ye4WuRovSNr05sQRl5t0RGe1lJ8WJthXMUDnqmZJYZohbaMZOu3to0JO7nn
         J8MJwXqd6Zjsmr4+PFcO3VWb+ZOcqxY5BxVApAZKvr2vy+0hB/S7yhi6qgeyvVsDocXv
         B5DQ==
X-Gm-Message-State: AN3rC/5DP+AjaY/gM5FyZK3pvGwIodkOOOEMmQO+HSodBSaPgcjpY5HS
        sj25yaw+jMj8ne3T
X-Received: by 10.99.212.69 with SMTP id i5mr2104649pgj.36.1492594407662;
        Wed, 19 Apr 2017 02:33:27 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id e22sm3409829pgn.11.2017.04.19.02.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 02:33:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 16:33:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, avarab@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] split-index: add and use unshare_split_index()
Date:   Wed, 19 Apr 2017 16:33:14 +0700
Message-Id: <20170419093314.4454-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When split-index is being used, we have two cache_entry arrays in
index_state->cache[] and index_state->split_index->base->cache[].

index_state->cache[] may share the same entries with base->cache[] so
we can quickly determine what entries are shared. This makes memory
management tricky, we can't free base->cache[] until we know
index_state->cache[] does not point to any of those entries.

unshare_split_index() is added for this purpose, to find shared
entries and either duplicate them in index_state->cache[], or discard
them. Either way it should be safe to free base->cache[] after
unshare_split_index().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Sorry for the delay. Somehow I put this commit on a branch named
 "custom-decorate" and couldn't find it in "git branch" listing
 for obvious reason. Luckily "git log --patch --all" came and saved
 the day.

 The idea is well explained in the commit message, I hope. I'll have
 to look at it again (it's been six months since it's written) to see
 if it still makes sense.

 Anyway Christian, feel free to take over ;-)

 read-cache.c  | 10 ++--------
 split-index.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-------------
 split-index.h |  1 +
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e447751823..ae2d02a687 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1734,15 +1734,9 @@ int discard_index(struct index_state *istate)
 {
 	int i;
 
-	for (i = 0; i < istate->cache_nr; i++) {
-		if (istate->cache[i]->index &&
-		    istate->split_index &&
-		    istate->split_index->base &&
-		    istate->cache[i]->index <= istate->split_index->base->cache_nr &&
-		    istate->cache[i] == istate->split_index->base->cache[istate->cache[i]->index - 1])
-			continue;
+	unshare_split_index(istate, 1);
+	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
-	}
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
diff --git a/split-index.c b/split-index.c
index f519e60f87..49bd197f71 100644
--- a/split-index.c
+++ b/split-index.c
@@ -73,10 +73,17 @@ void move_cache_to_base_index(struct index_state *istate)
 	int i;
 
 	/*
-	 * do not delete old si->base, its index entries may be shared
-	 * with istate->cache[]. Accept a bit of leaking here because
-	 * this code is only used by short-lived update-index.
+	 * If "si" is shared with another index_state (e.g. by
+	 * unpack-trees code), we will need to duplicate split_index
+	 * struct. It's not happening now though, luckily.
 	 */
+	assert(si->refcount <= 1);
+
+	unshare_split_index(istate, 0);
+	if (si->base) {
+		discard_index(si->base);
+		free(si->base);
+	}
 	si->base = xcalloc(1, sizeof(*si->base));
 	si->base->version = istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
@@ -275,11 +282,41 @@ void finish_writing_split_index(struct index_state *istate)
 	istate->cache_nr = si->saved_cache_nr;
 }
 
+void unshare_split_index(struct index_state *istate, int discard)
+{
+	struct split_index *si = istate->split_index;
+	int i;
+
+	if (!si || !si->base)
+		return;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		struct cache_entry *new = NULL;
+
+		if (!ce->index ||
+		    ce->index > si->base->cache_nr ||
+		    ce != si->base->cache[ce->index - 1])
+			continue;
+
+		if (!discard) {
+			int len = ce_namelen(ce);
+			new = xcalloc(1, cache_entry_size(len));
+			copy_cache_entry(new, ce);
+			memcpy(new->name, ce->name, len);
+			new->index = 0;
+		}
+		istate->cache[i] = new;
+	}
+}
+
+
 void discard_split_index(struct index_state *istate)
 {
 	struct split_index *si = istate->split_index;
 	if (!si)
 		return;
+	unshare_split_index(istate, 0);
 	istate->split_index = NULL;
 	si->refcount--;
 	if (si->refcount)
@@ -328,14 +365,8 @@ void add_split_index(struct index_state *istate)
 
 void remove_split_index(struct index_state *istate)
 {
-	if (istate->split_index) {
-		/*
-		 * can't discard_split_index(&the_index); because that
-		 * will destroy split_index->base->cache[], which may
-		 * be shared with the_index.cache[]. So yeah we're
-		 * leaking a bit here.
-		 */
-		istate->split_index = NULL;
-		istate->cache_changed |= SOMETHING_CHANGED;
-	}
+	if (!istate->split_index)
+		return;
+	discard_split_index(istate);
+	istate->cache_changed |= SOMETHING_CHANGED;
 }
diff --git a/split-index.h b/split-index.h
index df91c1bda8..65c0f09b2b 100644
--- a/split-index.h
+++ b/split-index.h
@@ -33,5 +33,6 @@ void finish_writing_split_index(struct index_state *istate);
 void discard_split_index(struct index_state *istate);
 void add_split_index(struct index_state *istate);
 void remove_split_index(struct index_state *istate);
+void unshare_split_index(struct index_state *istate, int discard);
 
 #endif
-- 
2.11.0.157.gd943d85

