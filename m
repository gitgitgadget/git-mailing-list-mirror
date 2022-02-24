Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF07C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiBXWfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiBXWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1221E0170
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so1771099wrg.10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7mSb+zu6rC9pt5pwBlBb8vuYb1gbf9awdi602bQWlpQ=;
        b=ZU+REEZ8JqwD4a09ETH6TSUVGeZEUb8TXDbn0S4NDakXAi2g3B+0raNyLflsjZDXz7
         65PIeabBtwH585z3fqzDgYq6U4iS/wXXtgZSrPL5CK/fKnZ6ajQIPql/7JF2/TWKjp5/
         4VBLvhGAt7goq5VsbE5A817Iz0SZiC1SVMVoVdYjJrLKf6tRcRB8xNMfuPUHo/52pkN1
         Wvz5QcFGR6ZTV/39NQbyggp3MTzsBnT7aN1+2h2pNN8epq5ND9KNI65BhgxNtCkVaMcs
         jo7ZuXTrriX8GjhfHEtAp8csBXbxgFisXn5QTf+WLzZ7l7ASkKAQ8fSqg+/fYgawDxtp
         tsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7mSb+zu6rC9pt5pwBlBb8vuYb1gbf9awdi602bQWlpQ=;
        b=Z68j+bjVF1ECw8EnQH2GB34roOmMaxSq0dcxF7lDPOHs+0tcYAIzhviitXrclyY0Q9
         7WbAnxf5+IL1pfCdFx7ldDwx2tWi56gltajVFQq+qJ/BXKKbcIJuKnWHbyvmJaZoJIE0
         DQ4pylJ2BoT4PwvWiPMlMLYMXk1rSC/NAw/SB43F6gMMXSSoQO/9AiilLXaQnF6ItMJc
         k3Dp4gfSnfxTbZEw5vzI0fG/dJNIpiUdlv8LGRRrMQBblzjgdlOQkqLhIcV+azvJjWLJ
         3vpTOoUgAaOwQby5Xim6azllmNIeq66gsD6sPmUktIdvqwywczoY7/Q+GUaz8RBmdNhR
         hIhQ==
X-Gm-Message-State: AOAM53255KwocMMqe8a17ricMEpFqBSkBxzTSpFhGGTgF+07kd/Mwpiu
        /v4uTmyJmZw0bGjkZj443CbdfJFmK3Y=
X-Google-Smtp-Source: ABdhPJztqtsMt+t5fTxScU9OIfD6t32RHi4Tv6mnU2LXRX2w1drvLt6n9jtvIVj1369GipcqyOLw2w==
X-Received: by 2002:adf:fc08:0:b0:1ef:6168:8ed4 with SMTP id i8-20020adffc08000000b001ef61688ed4mr249642wrr.461.1645742080481;
        Thu, 24 Feb 2022 14:34:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm597876wrv.10.2022.02.24.14.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:40 -0800 (PST)
Message-Id: <c4080e99d6ee030d204653e1d6ddc926c7e70eda.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:33 +0000
Subject: [PATCH v2 7/7] read-tree: make three-way merge sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
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
