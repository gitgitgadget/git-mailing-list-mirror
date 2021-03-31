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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083EAC43140
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD1061057
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhCaTKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhCaTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F86C061763
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1665868wmq.4
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygl/YpHkMLTy596wppNGmrM3dZ34k/E54IQsArTTQ6E=;
        b=n8GGvsKQyJ1ogHeFENa+GmX3wSFZ5y8TFvOE8CV6cNFTw901y1ujryMccp0AGrGJbB
         tcW13sWYg+iS0LMInuoQeXnVbbrDCrvkG42xQ5RroF8btO2/2xuG7KW/OKmYK1YPV9BR
         KKr5o8mWnrJJCpglcSYOUnT8HYHYzmw+mamCzDCSsB794DzZNGg4kLSZUCUgcVQbDXbc
         Zz4KmT/Jjx6FlgP/44iN0uPWxU/bWs81Ru78wt7jmWjfJcaSoDXc7v8c1BnUvOAs351P
         Gagy6glSYA4DzhbDgZ1XxAwnSBTyTbgktjsBGSu+i8Lw7gwj0WddsjjSYa3x9W6kYBkK
         r4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygl/YpHkMLTy596wppNGmrM3dZ34k/E54IQsArTTQ6E=;
        b=CiXTzTyI11esAuAqb/zTL0OND1wNotvdKW6z9K0wyiWvL5kJIf1mw6LIkcjGFsnWen
         rW9pUcx8J12QJmDcGzBIRqeNkLiVachjLdCKkwlgI62jO52mi3EYk2aZCkCqzmRd/+Fe
         S2QukjaK4IuO8FxhW4wVFT/KqVrWQx7RP+EArGJM7XISyWmQM/TVvaOVAs9mE3+G4M8/
         1qLxVReWRcAjd8Vt0i7ufo3SIf1AE6fbvQMX1vHq/91lqqhFQFPDPIfR5Mjf9TFvBXUx
         PpSFFWJLs6N0DwTPr/6lymwK+Gu2a+05iYecf8/mMEO/twRHLl4lwl2xioDLRbMAemCe
         nUFQ==
X-Gm-Message-State: AOAM531oRPgVRZKU9E+xJ2A9CVUdRKNR1BE6ftebjrUI3tN/tLCECwhM
        zkuhIHVcFLiNtY4sCTkLtD4EvdUE0rz9Kw==
X-Google-Smtp-Source: ABdhPJzdP+EuhFRCHiQmFxQiCpHdTHhJ9xey//pJJGSnJBax0FYknYFYiCD7WEGJISRueX1xhapiBw==
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr4293742wmh.105.1617217805316;
        Wed, 31 Mar 2021 12:10:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:10:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 18/18] tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
Date:   Wed, 31 Mar 2021 21:09:46 +0200
Message-Id: <patch-18.19-e961a0e8b5b-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the recent split of the get_tree_entry() function, rename the
tree_entry_extract() function to *_mode() in preparation for adding
other variants of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        | 2 +-
 match-trees.c | 4 ++--
 tree-diff.c   | 4 ++--
 tree-walk.c   | 2 +-
 tree-walk.h   | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b358..b1d802cc30a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -673,7 +673,7 @@ static int fsck_tree(const struct object_id *oid,
 		const char *name, *backslash;
 		const struct object_id *oid;
 
-		oid = tree_entry_extract(&desc, &name, &mode);
+		oid = tree_entry_extract_mode(&desc, &name, &mode);
 
 		has_null_sha1 |= is_null_oid(oid);
 		has_full_path |= !!strchr(name, '/');
diff --git a/match-trees.c b/match-trees.c
index 240922f7080..23ff89be2b2 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -146,7 +146,7 @@ static void match_trees(const struct object_id *hash1,
 		unsigned short mode;
 		int score;
 
-		elem = tree_entry_extract(&one, &path, &mode);
+		elem = tree_entry_extract_mode(&one, &path, &mode);
 		if (!S_ISDIR(mode))
 			goto next;
 		score = score_trees(elem, hash2);
@@ -202,7 +202,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		unsigned short mode;
 		int len = tree_entry_len(&desc.entry);
 
-		tree_entry_extract(&desc, &name, &mode);
+		tree_entry_extract_mode(&desc, &name, &mode);
 		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
diff --git a/tree-diff.c b/tree-diff.c
index b7a76cc2620..31f8a9331b1 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -196,7 +196,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 	if (t) {
 		/* path present in resulting tree */
-		oid = tree_entry_extract(t, &path, &mode);
+		oid = tree_entry_extract_mode(t, &path, &mode);
 		pathlen = tree_entry_len(&t->entry);
 		isdir = S_ISDIR(mode);
 	} else {
@@ -207,7 +207,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		 * 1) all modes for tp[i]=tp[imin] should be the same wrt
 		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract(&tp[imin], &path, &mode);
+		tree_entry_extract_mode(&tp[imin], &path, &mode);
 		pathlen = tree_entry_len(&tp[imin].entry);
 
 		isdir = S_ISDIR(mode);
diff --git a/tree-walk.c b/tree-walk.c
index d0dc0c35318..533cb6a26b4 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -567,7 +567,7 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 		struct object_id oid;
 		int entrylen, cmp;
 
-		oidcpy(&oid, tree_entry_extract(t, &entry, mode));
+		oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
 		entrylen = tree_entry_len(&t->entry);
 		update_tree_entry(t);
 		if (entrylen > namelen)
diff --git a/tree-walk.h b/tree-walk.h
index 52eb0d6b5b3..ec1d6927205 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -44,11 +44,11 @@ struct tree_desc {
  * "struct name_entry" you'd like. You always need a pointer to an
  * appropriate variable to fill in (NULL won't do!):
  *
- * tree_entry_extract(): const char *path, unsigned int mode
+ * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
-							 const char **pathp,
-							 unsigned short *modep)
+static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
+							      const char **pathp,
+							      unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.1.474.g72d45d12706

