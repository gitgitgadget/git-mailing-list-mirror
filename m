Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F3C4332F
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A57610A5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbhIRXQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbhIRXQx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A8C061757
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so21525358wrb.3
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SGGB3no4HJnRqYS/bkhEDKZRFKhVocDYyLxbxcSmqFM=;
        b=QysD44TbubAe9CG6IME3cdk5aNjTNfJYWeTEu+CdDjtC6xiMF47KgLDNTUOK+Wuyji
         W+mLtjBngYycEs9tYJeFf98UrDUHplvCZb8/jKql9dkWvlGQew/FOQAp255nISP8LlFz
         M5TbW6//0nz68kAtvneffMZRg3sFlIHDlG6Sgp+nfJljRovBKYkwEsdGBlmYDYBIfsuM
         RSh8UUGEYAd0oTzVpHSGyjve6YifrTIyqVCVrRfqquD6Fvv5OCIOpepIKvOnNA/glzy0
         WZChPdAxD7duVOkkIBWa6tx0KY5MbIV4uszoXVsK18JPCBq7YaJWeUuOz4x4oT99gK1g
         QmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SGGB3no4HJnRqYS/bkhEDKZRFKhVocDYyLxbxcSmqFM=;
        b=xTI2iUrjRfmLDt5SuM7//OINhbBfa6ilUImbjoVyF++gzbcN2477fcI3AMsaV7+21Z
         SZYNCnSPhCTmyQ9Fk3i9ZJZWQLKhhov6c6orcSKYfCSNTha41I0ZoJZl/qPUXj2koapG
         3KrCILZ4DS8Nfz/JzJ+JR+hYR1iWTle0zNdUqQRkZPkxICbjD6Ij2xbTutEY9IXMhjBG
         BNpI4XEvwbjCxS2EoxmoAr3p59cTcbRqNMZGTR+PR1de+bytN4r/Pbo3bD9l4F94CO4P
         XsOlLkaqBR2YWXHB5K9PsUV7Qh+AynEd815tR2HYTDNlVVYctktRslIBMkKrEmgwLsg4
         Pdfg==
X-Gm-Message-State: AOAM533XZBXr/MlrhLd0c7mR+CRLZXuOVKKHvLJ0jXoeIX5/1Nua0G0r
        nLWiDiUh18/7TV2LY3SbcFVARVQuY8o=
X-Google-Smtp-Source: ABdhPJweRoSrS6NNTWXspowa09LP8dpPnpmrmCzzhFk5TTEAiTxk8Gfbk2OUWxz8jnpc8VIEZL7o9Q==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr4791388wri.151.1632006927354;
        Sat, 18 Sep 2021 16:15:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm16241142wmj.0.2021.09.18.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:26 -0700 (PDT)
Message-Id: <a69117a1c9e6dae791e07e0df6701f581623f826.1632006923.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:20 +0000
Subject: [PATCH 3/6] unpack-trees: avoid nuking untracked dir in way of
 unmerged file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
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
index 786ec33d63a..017946a494f 100755
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
index d952eebe96a..3b3d1c0ff40 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2163,9 +2163,15 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
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
@@ -2200,6 +2206,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 	}
 
+	/* If we only care about directories, then we can remove */
+	if (absent_type == ABSENT_ANY_DIRECTORY)
+		return 0;
+
 	/*
 	 * The previous round may already have decided to
 	 * delete this path, which is in a subdirectory that
@@ -2220,6 +2230,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
+			   enum absent_checking_type absent_type,
 			   struct unpack_trees_options *o)
 {
 	int len;
@@ -2245,7 +2256,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 								NULL, o);
 			else
 				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-							 &st, error_type, o);
+							 &st, error_type,
+							 absent_type, o);
 		}
 		free(path);
 		return ret;
@@ -2260,7 +2272,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
-					  error_type, o);
+					  error_type, absent_type, o);
 	}
 }
 
@@ -2270,14 +2282,23 @@ static int verify_absent(const struct cache_entry *ce,
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
@@ -2351,6 +2372,12 @@ static int merged_entry(const struct cache_entry *ce,
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

