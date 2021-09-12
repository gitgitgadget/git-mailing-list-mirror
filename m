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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F0DC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BAA610F9
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhILNZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbhILNYz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9273BC0613CF
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so5232366wrq.4
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nh2RD3Yg/rudV33Lfw2h4WjGPfRbyKyvhLRmZNtCiNE=;
        b=FwARVdagbi6bHGlNS7mgsydgnnDdMRReb9mdwObqVcY2ff07O2RRuXtrlZTjdm849C
         aMzq8xIUOA1KY9I8heiSaCdDpFsK4jmNASuu8pjDzVN7PlBnCGdSSL6K+/e6tJAfrjOQ
         Al8/yivHv/C3ZJ4YZlOq9mAHNG6wkv23tjVvooW17OCoal5bqlFmvPtQQIIYPiwoOosZ
         5+YOJwQ6PBF1uS1c7M4jJtsR6FHXpqpdTpfeBNNO507ikp95TGkO8oMponis0g+GCEx7
         qQBK9pxookqWtCWUGvvCFXZ30H+GUio6bOaDvQVfvO9jKSLgZ8aimBg3yekwUsFCV6kr
         yTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nh2RD3Yg/rudV33Lfw2h4WjGPfRbyKyvhLRmZNtCiNE=;
        b=P40vuaRIMQNKTZnxS4+ovg9C8sbP0BgIT3u7F69tZ03R5FN/PyxVoivc3MRa7vudho
         0LWnRo/XsUNqoxRlFXhDHzUL9oahYyvqciNgW2BI3ycfkvBLF7bC+a0TkSNqRQ1Lp9Go
         FSkVQd1IyAtjsF17nhI2KRp/IQDw3EAxHHFNIst6E8ubSzqtg+ZNe8Ql41l1TBE6ACPJ
         /dOiuq6OffBpvuOE6IXI13omeWdKmaVJANW7he3QXsc62kH3sBXyF3HJSf7VLvsjbPiA
         b9rp00s3ZGmxEP6qItEyEp9ROxJgKsR8wLe9XG9jHFyU68glSLsUc1gvkGOKcb2/Ixd/
         /JMg==
X-Gm-Message-State: AOAM530b8E8mhv8Pakwj3jV8kiest40ADEQUe7b/QyBE/WH3HRmqA1Nl
        JPLfvXXjJPBu2BZ85jhlAwvyhlQnHlw=
X-Google-Smtp-Source: ABdhPJzhLSLj3NsFVQ1JP/Fqepr5r+vMx03Ny+xpRg7qMbPoBkZDBg7qL3B0I+UyclPjIzEtzXTBKg==
X-Received: by 2002:adf:c501:: with SMTP id q1mr7523845wrf.150.1631453019227;
        Sun, 12 Sep 2021 06:23:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm4461807wrn.85.2021.09.12.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:38 -0700 (PDT)
Message-Id: <de0c9d09ef774b25e9d587610f482c08032683aa.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:28 +0000
Subject: [PATCH v2 12/14] rm: skip sparse paths with missing SKIP_WORKTREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a path does not match the sparse-checkout cone but is somehow missing
the SKIP_WORKTREE bit, then 'git rm' currently succeeds in removing the
file. One reason a user might be in this situation is a merge conflict
outside of the sparse-checkout cone. Removing such a file might be
problematic for users who are not sure what they are doing.

Add a check to path_in_sparse_checkout() when 'git rm' is checking if a
path should be considered for deletion. Of course, this check is ignored
if the '--sparse' option is specified, allowing users who accept the
risks to continue with the removal.

This also removes a confusing behavior where a user asks for a directory
to be removed, but only the entries that are within the sparse-checkout
definition are removed. Now, 'git rm <dir>' will fail without '--sparse'
and will succeed in removing all contained paths with '--sparse'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rm.c                  |  4 +++-
 t/t3602-rm-sparse-checkout.sh | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4208f3f9a5f..a6da03da2be 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -301,7 +301,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 493c8f636b8..5f92b60a56a 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -37,9 +37,13 @@ done
 test_expect_success 'recursive rm does not remove sparse entries' '
 	git reset --hard &&
 	git sparse-checkout set sub/dir &&
-	git rm -r sub &&
+	test_must_fail git rm -r sub &&
+	git rm --sparse -r sub &&
 	git status --porcelain -uno >actual &&
-	echo "D  sub/dir/e" >expected &&
+	cat >expected <<-\EOF &&
+	D  sub/d
+	D  sub/dir/e
+	EOF
 	test_cmp expected actual
 '
 
@@ -87,4 +91,15 @@ test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
 	git ls-files --error-unmatch b
 '
 
+test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	git update-index --no-skip-worktree b &&
+	test_must_fail git rm b 2>stderr &&
+	test_cmp b_error_and_hint stderr &&
+	git rm --sparse b 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing b
+'
+
 test_done
-- 
gitgitgadget

