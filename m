Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F9EC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75368206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ9PL51N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgEKL4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729867AbgEKL42 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB7C05BD09
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so18866638wmc.5
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/UrFoHLJsDovcEFwyOh3Hz+jH6bBy1+djgRQTt6/Nhg=;
        b=RZ9PL51N/zXNgrH5nRwKY+3NsjrKFcsuvv18/Yc8sbFruTUzsPADqQ/NdmPz77klnQ
         RmegJehTz1pb5SHKC6W7d43MBT+md7u4rO193rUziuVDHtmozK/XdOqXBO8wgCJV1H/T
         JBti4QKSlyTV9FtM9kDyjHvcLNRbuEmoSkXnECynICVF5wl+ldjjrFy+TnU48SxVnjys
         5AfY2fJz9Q6LdxVuxY8qUPml1z8+BiXbRkQfrXVHBFI8als+046Wsh0JMIm1rDDIqIMh
         UQkYEK5LwzPEnM7rwearUCGhlvq0a2tkyeOE4hmBrITR9aNQ0cJShvvnFbEoX/DEIaQb
         /AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/UrFoHLJsDovcEFwyOh3Hz+jH6bBy1+djgRQTt6/Nhg=;
        b=sDp/unB9PJ+6mDvcSQiR95QRkThxDGH5xqVYBcvs5y3Fc6q80XWsPJMC6bUruz1TSj
         mzEVis6KYY4uH6jqLH2STt+JhwISlIFXE+2rm7wDdjZH4Yo0eXxvJ52mRr09lNqnvRux
         JocgtlgOCBrpQg3g0GHU9bZtufU26hIZ42enzbdYG4ur/5+KQ1P6fdRYwGm9W9KzzGex
         CA7mbJ9P/OU6E2gLqc5GGIT86bJtg/utphtqplOFLfGtPeFTe5jKrGfJ1cpJx+hag04R
         F06N5ve1W+tpX4fnZwFfBJtPIU4DX2dJHDEa1fIz7ivluJGT9UHd5hzPc4GTnBjcQRH4
         zRTA==
X-Gm-Message-State: AGi0PuboxvW/zrYHoMctS4g0vHE/shBa+s3J5atyJZEjp/XTgJnPEX8M
        WsJ3jgsG3tpuZFJXipLgKPBvTsBo
X-Google-Smtp-Source: APiQypI2hPAC1DTrfWDVCet0/YYCRJcIJ6wV4uZRYBLROW0LTbsX+cRNTo+ipXkDOKJ0hupcZ8X4og==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr29602921wmb.116.1589198185488;
        Mon, 11 May 2020 04:56:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm16010180wrh.20.2020.05.11.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:24 -0700 (PDT)
Message-Id: <ba0d8c1f539751d9cfd556dac4eeda97758cf12e.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:12 +0000
Subject: [PATCH v2 05/12] bloom: de-duplicate directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When computing a changed-path Bloom filter, we need to take the
files that changed from the diff computation and extract the parent
directories. That way, a directory pathspec such as "Documentation"
could match commits that change "Documentation/git.txt".

However, the current code does a poor job of this process. The paths
are added to a hashmap, but we do not check if an entry already
exists with that path. This can create many duplicate entries and
cause the filter to have a much larger length than it should. This
means that the filter is more sparse than intended, which helps the
false positive rate, but wastes a lot of space.

Properly use hashmap_get() before hashmap_add(). Also be sure to
include a comparison function so these can be matched correctly.

This has an effect on a test in t0095-bloom.sh. This makes sense,
there are ten changes inside "smallDir" so the total number of
paths in the filter should be 11. This would result in 11 * 10 bits
required, and with 8 bits per byte, this results in 14 bytes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c          | 35 ++++++++++++++++++++++++++---------
 t/t0095-bloom.sh |  4 ++--
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/bloom.c b/bloom.c
index 96792782719..196cda0a1bd 100644
--- a/bloom.c
+++ b/bloom.c
@@ -158,6 +158,19 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }
 
+static int pathmap_cmp(const void *hashmap_cmp_fn_data,
+		       const struct hashmap_entry *eptr,
+		       const struct hashmap_entry *entry_or_key,
+		       const void *keydata)
+{
+	const struct pathmap_hash_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct pathmap_hash_entry, entry);
+	e2 = container_of(entry_or_key, const struct pathmap_hash_entry, entry);
+
+	return strcmp(e1->path, e2->path);
+}
+
 struct bloom_filter *get_bloom_filter(struct repository *r,
 				      struct commit *c,
 				      int compute_if_not_present)
@@ -206,25 +219,29 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
-		hashmap_init(&pathmap, NULL, NULL, 0);
+		hashmap_init(&pathmap, pathmap_cmp, NULL, 0);
 
 		for (i = 0; i < diff_queued_diff.nr; i++) {
 			const char *path = diff_queued_diff.queue[i]->two->path;
 
 			/*
-			* Add each leading directory of the changed file, i.e. for
-			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
-			* the Bloom filter could be used to speed up commands like
-			* 'git log dir/subdir', too.
-			*
-			* Note that directories are added without the trailing '/'.
-			*/
+			 * Add each leading directory of the changed file, i.e. for
+			 * 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
+			 * the Bloom filter could be used to speed up commands like
+			 * 'git log dir/subdir', too.
+			 *
+			 * Note that directories are added without the trailing '/'.
+			 */
 			do {
 				char *last_slash = strrchr(path, '/');
 
 				FLEX_ALLOC_STR(e, path, path);
 				hashmap_entry_init(&e->entry, strhash(path));
-				hashmap_add(&pathmap, &e->entry);
+
+				if (!hashmap_get(&pathmap, &e->entry, NULL))
+					hashmap_add(&pathmap, &e->entry);
+				else
+					free(e);
 
 				if (!last_slash)
 					last_slash = (char*)path;
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 8f9eef116dc..6defeb544f1 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -89,8 +89,8 @@ test_expect_success 'get bloom filter for commit with 10 changes' '
 	git add smallDir &&
 	git commit -m "commit with 10 changes" &&
 	cat >expect <<-\EOF &&
-	Filter_Length:25
-	Filter_Data:82|a0|65|47|0c|92|90|c0|a1|40|02|a0|e2|40|e0|04|0a|9a|66|cf|80|19|85|42|23|
+	Filter_Length:14
+	Filter_Data:02|b3|c4|a0|34|e7|fe|eb|cb|47|fe|a0|e8|72|
 	EOF
 	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
 	test_cmp expect actual
-- 
gitgitgadget

