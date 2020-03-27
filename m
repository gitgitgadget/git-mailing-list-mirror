Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77855C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5F52074D
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVAtKdH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgC0AtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:23 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39703 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgC0AtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:17 -0400
Received: by mail-wr1-f50.google.com with SMTP id p10so9466428wrt.6
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vfhTeXNId9siyDVXX6qMBmAKDzvOw+NBbx2t6dun4ZI=;
        b=XVAtKdH+4tx1a35FWidcBOQ3EMRQMZgvilE7ROTTWa6O6RMOXEuQ7Ke2ZgDcz0nJoc
         JYursvPmFCE6TOfkSILZ43FiC60NrYFJA6PzmF4Th4VKWTIw5hgCztm40Tv66Gp4mGCV
         f55Mh+CPXTGvnYyAsL8uPJz00uIcdTZKWvXUV6u+k66QHKKyAarep7gXtnrWSM/h91Pj
         gq6J7ILE3AV10pR99g8gdAIEWWP4A+pyekOyxkc25lfFMeYVoat25P4SVenDr2KXUIw1
         v5ajuQBE9Js6l8VYtYb63GdBbJpuQY4FvN2KdqL/zSgMM63C00fzc7Wtn5h/03qtsxku
         q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vfhTeXNId9siyDVXX6qMBmAKDzvOw+NBbx2t6dun4ZI=;
        b=ph2Mo7Nh+eJ4pa1qTOGOgpgoJ4lLZZQS74bISvOMmL6X+iWRsJNHr8eUxqKfISeu3T
         ZiaW1b0IIMQtBEg7UVub/pWLplfGPlBaEC8uwwwWOYd5+oPdIgYm8qiZzaXaZuTmobhL
         YJCbm8cvhQU4k1L7yAs2n/4/JzRgUm8DHkH+HyPzuYfmLLUQQwxemH31ki6O71+1x7iq
         fcBva33B+cSz5p7XRAj2F2OxMc7XB6c9ju2AU7u7XJctW72F2X9tGMZfDOFmOJx6slo1
         Y8JXKtQx+0WlvnjGw0jLpqs93kBXYZVKBdseKLqQRGT+WpqC3iOphsusX955KnFblBF3
         M1AA==
X-Gm-Message-State: ANhLgQ2vxPJbcif5kApFDknt4Rya6azUCLIRfjmsYZh/HJoFKBEcDS5v
        hxCzO5U7YvuorNUEEw9xqLpXP50Q
X-Google-Smtp-Source: ADFU+vsQfXnGpunzVrU68uCLMBWwrgL8mP1jqEQsAo0USttldlSfjBAm8Fd4fHXNg4SmOjZae5sZ7Q==
X-Received: by 2002:adf:df82:: with SMTP id z2mr11451101wrl.46.1585270155584;
        Thu, 26 Mar 2020 17:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t126sm6155599wmb.27.2020.03.26.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:15 -0700 (PDT)
Message-Id: <5d9e8a9d27e13670b56fe05dc36c066ec766b390.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:59 +0000
Subject: [PATCH v3 16/18] unpack-trees: provide warnings on sparse updates for
 unmerged paths too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When sparse-checkout runs to update the list of sparsity patterns, it
gives warnings if it can't remove paths from the working tree because
those files have dirty changes.  Add a similar warning for unmerged
paths as well.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 25 +++++++++++++++++++++++++
 unpack-trees.c                     | 30 ++++++++++++++++++++++++++++++
 unpack-trees.h                     |  1 +
 3 files changed, 56 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index afbde89e605..8e2976bc7b8 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -345,6 +345,31 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	test_path_is_file dirty/folder1/a
 '
 
+test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged status' '
+	git clone repo unmerged &&
+
+	cat >input <<-EOF &&
+	0 0000000000000000000000000000000000000000	folder1/a
+	100644 $(git -C unmerged rev-parse HEAD:folder1/a) 1	folder1/a
+	EOF
+	git -C unmerged update-index --index-info <input &&
+
+	git -C unmerged sparse-checkout init 2>err &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_path_is_file dirty/folder1/a &&
+
+	git -C unmerged sparse-checkout disable 2>err &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C unmerged reset --hard &&
+	git -C unmerged sparse-checkout init &&
+	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
+	git -C unmerged sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 484d30a53a7..dec044339df 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,6 +52,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
 	"Path '%s' not uptodate; will not remove from working tree.",
 
+	/* WARNING_SPARSE_UNMERGED_FILE */
+	"Path '%s' unmerged; will not remove from working tree.",
+
 	/* WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN */
 	"Path '%s' already present; will not overwrite with sparse update.",
 };
@@ -173,6 +176,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 	msgs[WARNING_SPARSE_NOT_UPTODATE_FILE] =
 		_("The following paths are not up to date and were left despite sparse patterns:\n%s");
+	msgs[WARNING_SPARSE_UNMERGED_FILE] =
+		_("The following paths are unmerged and were left despite sparse patterns:\n%s");
 	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
 		_("The following paths were already present and thus not updated despite sparse patterns:\n%s");
 
@@ -548,6 +553,23 @@ static int apply_sparse_checkout(struct index_state *istate,
 	return 0;
 }
 
+static int warn_conflicted_path(struct index_state *istate,
+				int i,
+				struct unpack_trees_options *o)
+{
+	char *conflicting_path = istate->cache[i]->name;
+	int count = 0;
+
+	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
+
+	/* Find out how many higher stage entries at same path */
+	while (++count < istate->cache_nr &&
+	       !strcmp(conflicting_path,
+		       istate->cache[i+count]->name))
+		/* do nothing */;
+	return count;
+}
+
 static inline int call_unpack_fn(const struct cache_entry * const *src,
 				 struct unpack_trees_options *o)
 {
@@ -1793,6 +1815,14 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 	for (i = 0; i < o->src_index->cache_nr; i++) {
 		struct cache_entry *ce = o->src_index->cache[i];
 
+
+		if (ce_stage(ce)) {
+			/* -1 because for loop will increment by 1 */
+			i += warn_conflicted_path(o->src_index, i, o) - 1;
+			ret = UPDATE_SPARSITY_WARNINGS;
+			continue;
+		}
+
 		if (apply_sparse_checkout(o->src_index, ce, o))
 			ret = UPDATE_SPARSITY_WARNINGS;
 
diff --git a/unpack-trees.h b/unpack-trees.h
index dae948205f9..0f7424aec61 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -27,6 +27,7 @@ enum unpack_trees_error_types {
 	NB_UNPACK_TREES_ERROR_TYPES,
 
 	WARNING_SPARSE_NOT_UPTODATE_FILE,
+	WARNING_SPARSE_UNMERGED_FILE,
 	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
 
 	NB_UNPACK_TREES_WARNING_TYPES,
-- 
gitgitgadget

