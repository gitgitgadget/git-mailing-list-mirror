Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D6C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiBWS0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiBWS0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:26:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CCF4AE21
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o4so4278937wrf.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7mSb+zu6rC9pt5pwBlBb8vuYb1gbf9awdi602bQWlpQ=;
        b=eEMG33BnehWm6lyqL3ZnXgD5OGQEDBBTbKBxhtWQd9+G9M3cmVohcxWgE/XcqlK3St
         UbFJKahA/XYgod193MciY6Bn5OXVTY0I65uj0v+mWP8rbi8BbBSMp37SXirs15Nl5Cky
         xXCrVHGG7BRXVAmfiO3a6RSymBMmnHTEsCHAu7cwtkVyJEvr+ZwvtRSMSiOI7eorSwI9
         OqMQUh7yzLxLiQiPXRAKhk62jaZVoJWzEFbIU0YR64rHmfMb4slUvoPVYJd0OBmfSPF1
         mBubWyRUcpYKoDxsJF4s2iN68GOdQvfCSFAMn70zZq5b/VJt3QrviXM9PD7BxX9rWx9z
         paRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7mSb+zu6rC9pt5pwBlBb8vuYb1gbf9awdi602bQWlpQ=;
        b=CoF4TCjONZupwpZHbavGaM0ncsCacvSeZ+NZUWlkBWJx7qmf1P/+7f4qVBsxwDmNGa
         mjFzxaUknF6kLVqqkj3nffx+b9pIPh5WmLyQkkz7MD/OIAMU6ONGdH5vFb+wEXiLBHmc
         w38Fh9sgqzVblkIpb8k3CFvEkclFqNEfdpEynGKVilMnJWbBKIhGOQeFNYpCJ/Xt9/Ko
         Knhef2qlSo/+kfMISZGD4nRJD0mmjItEvRmJF+D4Qc/HWBXEFNhNUWwrz40h8OrB4HNK
         rYyETfrkafWgR/ZmqAYaH+VhjNd4QFQ1Uns/7MlXvwOZnFLatGewwdINjVRa+feswn5y
         6VUg==
X-Gm-Message-State: AOAM531apzPBQkomH3y8DYfRJcsRmffX9rZMG+wRVx/NiZ3Mx1BNlVLu
        VWlySorp1btfhz+0EBTlnUz6nfmUmT4=
X-Google-Smtp-Source: ABdhPJzAO2WQ0PYyR20j3z+qNOgX57XpdNcSQnB53AY4PknaakB5njL1GgfQbhF1XTSRaNd5CmkxcA==
X-Received: by 2002:a05:6000:18ab:b0:1e8:f67a:1518 with SMTP id b11-20020a05600018ab00b001e8f67a1518mr685176wri.52.1645640724225;
        Wed, 23 Feb 2022 10:25:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm302815wrr.12.2022.02.23.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:23 -0800 (PST)
Message-Id: <1502e9acb326e03397311f02cf73921e89bbfc35.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:16 +0000
Subject: [PATCH 7/7] read-tree: make three-way merge sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:stolee@gmail.com" <[stolee@gmail.com]@vger.kernel.org>,
        "mailto:newren@gmail.com" <[newren@gmail.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable use of 'merged_sparse_dir' in 'threeway_merge'. As with two-way
merge, the contents of each conflicted sparse directory are merged without
referencing the index, avoiding sparse index expansion.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  5 -----
 t/t1092-sparse-checkout-compatibility.sh |  3 ++-
 unpack-trees.c                           | 16 ++++++++++++----
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 5a421de2629..dc2283fce53 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -230,11 +230,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			break;
 		case 3:
 		default:
-			/*
-			 * TODO: update threeway_merge to handle edit/edit conflicts in
-			 * sparse directories.
-			 */
-			ensure_full_index(&the_index);
 			opts.fn = threeway_merge;
 			break;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d6f19682d65..5447d314632 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1412,7 +1412,8 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 
 	ensure_not_expanded checkout -b test-branch update-folder1 &&
 	for MERGE_TREES in "update-folder2" \
-			   "base update-folder2"
+			   "base update-folder2" \
+			   "base HEAD update-folder2"
 	do
 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
 		ensure_not_expanded reset --hard HEAD || return 1
diff --git a/unpack-trees.c b/unpack-trees.c
index a4ace53904e..9e79cb13bd4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2635,16 +2635,24 @@ int threeway_merge(const struct cache_entry * const *stages,
 	 */
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
-		if (index && !same(index, remote) && !same(index, head))
-			return reject_merge(index, o);
+		if (index && !same(index, remote) && !same(index, head)) {
+			if (S_ISSPARSEDIR(index->ce_mode))
+				return merged_sparse_dir(stages, 4, o);
+			else
+				return reject_merge(index, o);
+		}
 		return merged_entry(remote, index, o);
 	}
 	/*
 	 * If we have an entry in the index cache, then we want to
 	 * make sure that it matches head.
 	 */
-	if (index && !same(index, head))
-		return reject_merge(index, o);
+	if (index && !same(index, head)) {
+		if (S_ISSPARSEDIR(index->ce_mode))
+			return merged_sparse_dir(stages, 4, o);
+		else
+			return reject_merge(index, o);
+	}
 
 	if (head) {
 		/* #5ALT, #15 */
-- 
gitgitgadget
