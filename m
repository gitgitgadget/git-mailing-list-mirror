Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2FFC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A494208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaXMgUFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgEAPai (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgEAPag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A99C061A0E
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so69550wma.4
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x66f/l6dg9MdFk6I1G8R1RCsPQYocuzB8OBGQ6pwrrs=;
        b=EaXMgUFpA7nDR9gVQEXpDBx5f2IptBrEp7dJuI3tuC3GrDIbBlHmCHrCVvqTMNQSmD
         racuglqD8ct/BJOhvwOBKiOQ+EMY63z8r6IFzryWvQDOeHQim7Sn38+x3QQWvDaiwjdF
         f53wWlHDxMWmme8fKiswmd/SQkULTjH7gLMF6BF+hHbSDcbhnOyIZzyTS2zqSCr5cvxF
         Mv7c4l9rVWHDD7HKGOe74otVJzVPFNGAIP19BrU4bJffW+hjhEpt8f3qEu4G4/ZmY5N0
         0g3SaNbdjJHejGekC1qixjw7Cm2b6eMILljbx4+d+nMo+m4sDYQTpPx/2UaXHVzojbFN
         FBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x66f/l6dg9MdFk6I1G8R1RCsPQYocuzB8OBGQ6pwrrs=;
        b=OA40nQoPJsGvlJLedhyY+goMUpqq2byBtM2K3MM0Tha7+PpCfU86/apPwduk3Vad8K
         VeGMSXvujq+uycIIuElKBGOnHXN2ppu+CoDsTdwdihlk5PVx4Y79TNuHSlF5rB+C/Vn5
         7Gd7BsLH1GIKS2SAR2PqXSjNHxp1KV2LKaG6XUNHmsmPFK4FyeBMGosdi9RcaRz22P00
         p9K3wCKM/vvd79JIWw63/bu6QVUYlxr/i/PEw+5a7MgRVwplwJideDQ1iu6pzEKlP3N1
         5lldverLkVWdjDeesazXAAn2QaeKwthSe3C/vqaHJTJNE27agxLR0bSVmyrTQWJEXxwJ
         U52w==
X-Gm-Message-State: AGi0PuabaZGjCga9fz46riAp7j933dUm87hWiPRBBbAEoWrwU1SsbFGk
        Nh76nbBeK+zgBg9bGsSsaxV0tcWU
X-Google-Smtp-Source: APiQypJv8r+ei+4KTMvt+zedk+/QIA3xwpSJ3H9ELDDSV38wJOIDUmvxWRclGvuUr6ChzZxZCOkjeQ==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr78800wmn.81.1588347033935;
        Fri, 01 May 2020 08:30:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm73075wmb.43.2020.05.01.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:33 -0700 (PDT)
Message-Id: <07d0a25f1c438f02d71918e4ca05f2901eb802be.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:21 +0000
Subject: [PATCH 04/12] bloom: de-duplicate directory entries
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
index 2e3e0f5037b..eb08571c628 100644
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
@@ -203,25 +216,29 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
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

