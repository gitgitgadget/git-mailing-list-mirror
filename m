Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DFEC433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DA66115C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhJDBOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhJDBOA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:14:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1283AC061782
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so7377770wmj.2
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lN7L+4lHq/KYd3KjJqC2UNzO0Nq5OpIFE7MUYs/MQ6I=;
        b=JbW4nGVNzAXb6mB/wn3LpQAM5cUL9nkD+wSZkQ6b6LKwnEtqhTr/8bvjxnVJI6ustj
         pjWAD7HCdr1g036wWUQ4y3YA1UTcyx90qwgG6217bDkGJFr5T43QhFy1kIYmZqIrx6a9
         PYBeJpp3M5aHm1ls4tOaSatYgaZ+9BnI7eBZTCU6a2z7zwiKgb3M+YQaczYQCSCCfHhD
         PXF2yCQJvlgNtt/aHW5Z6NPI+QH1rYcD5uVjezByrJzM5KHWTbBxZMLMkk+ZUnKJueQX
         AVOHEjwtgND1giLUqWzgZDr5ibfIkLjCLS+3jw4OBEFyNFlCkmUCuNNnKBJGZZn0ntfH
         Ktjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lN7L+4lHq/KYd3KjJqC2UNzO0Nq5OpIFE7MUYs/MQ6I=;
        b=aQR6TqRc/zc9VO8pdluXbGcxBkXNrV2FSg1SKfdgkynaloONoBMd6JqHtaY4tJ4j4v
         q6d8yZpKBOTGlBOXWw7IwV0eTZ3G2u2ZE50EecxQ1aP2/plNcrEwWl/3vfiBq9URLwzX
         qoFgPrsRBFrTlorAn/NoRNk+OaarNDVOt8YTPbB+UXCvY5CKMsE+nj/9IECLW28GLIuQ
         Ci1KjsuikPKTBcg1XznKMrFgFapH6qFrA860hZsNQr8K/xhMpPEieeC16YuyYgFzUmkR
         1mlFYDUUylIMcrC8M5I8vfvMWOqOiqlnZi2n0a4tTV3PRb8jcZmbRFlYq71UR2ZCo4LG
         bnYw==
X-Gm-Message-State: AOAM533fIqBcQy12OZ9bLnpgSujDaKTYcVDcscmV2pnNuWRbbb0iD7G2
        5mLHNN0T4vSouC7UM9bud2MW8Zjpy3OK3A==
X-Google-Smtp-Source: ABdhPJxyQttXaGwSC6kkqsDgq3sZWJ3cM3ys4Bnx9goXO4Ofq7Gs721mxfERQGhHGcHCJpBKIg6xGA==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr16018450wmo.192.1633309928384;
        Sun, 03 Oct 2021 18:12:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 07/10] unpack-trees: avoid nuking untracked dir in way of unmerged file
Date:   Mon,  4 Oct 2021 03:11:56 +0200
Message-Id: <RFC-patch-v4-07.10-b6769f629ae-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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
index 37f769030ab..8408a8fcfff 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2173,9 +2173,15 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
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
@@ -2209,6 +2215,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 	}
 
+	/* If we only care about directories, then we can remove */
+	if (absent_type == ABSENT_ANY_DIRECTORY)
+		return 0;
+
 	/*
 	 * The previous round may already have decided to
 	 * delete this path, which is in a subdirectory that
@@ -2229,6 +2239,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
+			   enum absent_checking_type absent_type,
 			   struct unpack_trees_options *o)
 {
 	int len;
@@ -2255,7 +2266,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 								NULL, o);
 			else
 				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-							 &st, error_type, o);
+							 &st, error_type,
+							 absent_type, o);
 		}
 		free(path);
 		return ret;
@@ -2270,7 +2282,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
-					  error_type, o);
+					  error_type, absent_type, o);
 	}
 }
 
@@ -2280,14 +2292,23 @@ static int verify_absent(const struct cache_entry *ce,
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
@@ -2361,6 +2382,12 @@ static int merged_entry(const struct cache_entry *ce,
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
2.33.0.1404.g83021034c5d

