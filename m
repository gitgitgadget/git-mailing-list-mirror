Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13BDC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA8F61214
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbhIXGix (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbhIXGir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1C3C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so24158556wrb.2
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mWWuuoBbBlW6d/75JEwCHAAjZsKyIzm/UkzOE5BAoiE=;
        b=AxTU7zqsMGJXIB9GCS7VACj8N5gUf7b0QZGQHd7UYeailiYJpIhAUr9m4r9Eskc/x8
         9X9vLeFS8NNdwg7AdnPMVKxvEJaeNr3RHzUmgqX316MwN9rL38PrVh9ZnSblheOAUwcx
         GRhlxJXuu095CAJBOZJ9DidMFvbtFcfjsd+VSahIFn80MXyjzKI4Jdlkdxf5UfiBQnRN
         JWj3qhyCHVqJqV8LM/mmr53Y+AnPOGU48paTQURFWaC65g/WL2p9HeUoH4X/TJ9A9vbe
         wLVimVyl4CtvCwgNj4bMIJKtq5+4c3s6N1NjyHSTpAxmPdHtKhAu97R+yr/Q+c3cmC9g
         CNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mWWuuoBbBlW6d/75JEwCHAAjZsKyIzm/UkzOE5BAoiE=;
        b=wYIvKKf1BEw4E3XvanC439hZh6vPJGH9ut1IkhCVbv2oD84qfZIhjRanBcSZ8ESSf5
         UhU5/n9cg2rLAFdWFY8OJ7II12k4cihBPNxGQ/EtUQGZGYOH9GhfcsQfKGvvT2BTirdI
         ZdDZ9iV6iwDHnaSSikMK7bLx3I3PI3uL/IPGv9+xbMpSnryXPvh7CGvPM605e13eb32o
         gVHQDh+HEh1oGu3oqE6eXk4MeJDKvD8KJ0ujSdNJG9Ue4x/+q6/bFwN3QUCEX/AevoQp
         cb0EQ4G0A+Xo8Nd4Uzjcu/+lj7c+V5Pb4BubAOeCXtAWj7JLgtmEftCU/xWsJfQxrF7n
         twGA==
X-Gm-Message-State: AOAM531vyWAs5cL35YLyZ8SCydYBctyB6CCP+RthfBwZSb6ZrwSTm+/F
        yQvRB7/DgvYP/pAex1uwhcPEFz3ZZHE=
X-Google-Smtp-Source: ABdhPJw96ix4Yattrjk2NPwsUBBpqdoKq6bAUq1UQeAlBQwHv1VhADzEjh89lZIcUK4LwHiFEVQ7Hg==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr279061wmk.21.1632465432844;
        Thu, 23 Sep 2021 23:37:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm7157873wra.92.2021.09.23.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:12 -0700 (PDT)
Message-Id: <208f3b3ebe5898150948155204724c68b46e2fb0.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:06 +0000
Subject: [PATCH v2 3/6] unpack-trees: avoid nuking untracked dir in way of
 unmerged file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh |  2 +-
 unpack-trees.c                   | 35 ++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 18604360df8..5ec66058cfc 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -197,7 +197,7 @@ test_expect_failure 'git stash and untracked files' '
 	)
 '
 
-test_expect_failure 'git am --abort and untracked dir vs. unmerged file' '
+test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 	test_setup_sequencing am_abort_and_untracked &&
 	(
 		cd sequencing_am_abort_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index fcbe63bbed9..f7d0088a4fd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2159,9 +2159,15 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
 	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
+enum absent_checking_type {
+	COMPLETELY_ABSENT,
+	ABSENT_ANY_DIRECTORY
+};
+
 static int check_ok_to_remove(const char *name, int len, int dtype,
 			      const struct cache_entry *ce, struct stat *st,
 			      enum unpack_trees_error_types error_type,
+			      enum absent_checking_type absent_type,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
@@ -2196,6 +2202,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 	}
 
+	/* If we only care about directories, then we can remove */
+	if (absent_type == ABSENT_ANY_DIRECTORY)
+		return 0;
+
 	/*
 	 * The previous round may already have decided to
 	 * delete this path, which is in a subdirectory that
@@ -2216,6 +2226,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
+			   enum absent_checking_type absent_type,
 			   struct unpack_trees_options *o)
 {
 	int len;
@@ -2242,7 +2253,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 								NULL, o);
 			else
 				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-							 &st, error_type, o);
+							 &st, error_type,
+							 absent_type, o);
 		}
 		free(path);
 		return ret;
@@ -2257,7 +2269,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
-					  error_type, o);
+					  error_type, absent_type, o);
 	}
 }
 
@@ -2267,14 +2279,23 @@ static int verify_absent(const struct cache_entry *ce,
 {
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
-	return verify_absent_1(ce, error_type, o);
+	return verify_absent_1(ce, error_type, COMPLETELY_ABSENT, o);
+}
+
+static int verify_absent_if_directory(const struct cache_entry *ce,
+				      enum unpack_trees_error_types error_type,
+				      struct unpack_trees_options *o)
+{
+	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
+		return 0;
+	return verify_absent_1(ce, error_type, ABSENT_ANY_DIRECTORY, o);
 }
 
 static int verify_absent_sparse(const struct cache_entry *ce,
 				enum unpack_trees_error_types error_type,
 				struct unpack_trees_options *o)
 {
-	return verify_absent_1(ce, error_type, o);
+	return verify_absent_1(ce, error_type, COMPLETELY_ABSENT, o);
 }
 
 static int merged_entry(const struct cache_entry *ce,
@@ -2348,6 +2369,12 @@ static int merged_entry(const struct cache_entry *ce,
 		 * Previously unmerged entry left as an existence
 		 * marker by read_index_unmerged();
 		 */
+		if (verify_absent_if_directory(merge,
+				  ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
+			discard_cache_entry(merge);
+			return -1;
+		}
+
 		invalidate_ce_path(old, o);
 	}
 
-- 
gitgitgadget

