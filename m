Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE87DC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiAMQn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiAMQnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 11:43:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05813C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c66so4283693wma.5
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mTcAzTV+TNFIZfO+bBIgYrhvWWXIkrL3H7jY+ZZLcls=;
        b=VpDqk5DELVlvOpA7xxmp57xKfd1mjme3vvnYR0P+zmY4KySKmabLfTUsgmAQaHmRlE
         sqxqr7FVuCwEzaqOLvES2S4FSeh9VUCAfShJQnqx3dM0b0urW5+TDLSVwSbLFZ47L0GX
         u/0eJW3Zw7dE/Q5bAppVFmlVhOpymFAGy/TjW6oinL0Dn3DKoVJ8dJjb/pzd/GXoHGNU
         oMX+4c2E0n9SYTMGyFp1t6ugIKCjbrGA+Um0btQQHofZ5pzinI7IjpsPeuvRjYQ002k6
         9mcv9S7rvlcwP4/ETyHtXJEgLREoV/EayTTxS3zLxR4uWUurYe1cKXbNLsUVM8cDu1Fe
         nzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mTcAzTV+TNFIZfO+bBIgYrhvWWXIkrL3H7jY+ZZLcls=;
        b=0mB06EdewxZmNd8ziMdDvHE77CWbMmxCXh3v5WPP/zCeCxWHZZ/migSrvfJfLbHzx8
         f6usruU3AuC45Pojn4PxnXDwsRzUwAR5rbIx87jjL8rZwcI6wTbALuZAjxYxiFwNXf+X
         4KNNoGmlrwHGg2mTv46UIkuQz7gmFuevwPsRd5gDzeLv0lbc0FNOYAqvfMq1E93+6HBh
         Rz0ezMddiyJ1DBJm0WIyEQ92/QcR32wn94UaUdJ4r+nSCUglXp5uSOmfpwRWx/r7Tiq8
         bK28VU1w1sGbnHKc4wSl0OXicvZspAwsYgNLvCtWctoybjj1k+Oc5ogW9iAnlFdQ3iJ/
         c/5g==
X-Gm-Message-State: AOAM531LtTUq89u8M/uV4bqhkc4xGDx3x9IeCZEIAJKTX8BWbXgEvt/W
        RqbD/uXa0UaOdHQla6vD8XOEIu4xQCs=
X-Google-Smtp-Source: ABdhPJz0q+h3riPsUdc805Z3/y/OfZmslAWjXoy16dpk8qdR2+aD7tO1ahm8X+U0txndcRfUiIjF8Q==
X-Received: by 2002:a05:600c:4e53:: with SMTP id e19mr8790318wmq.15.1642092233488;
        Thu, 13 Jan 2022 08:43:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi24sm8009734wmb.9.2022.01.13.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:43:53 -0800 (PST)
Message-Id: <1e3958576e2a132180f8c5d20acc1315d3062119.1642092230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 16:43:47 +0000
Subject: [PATCH 2/5] unpack-trees: fix accidental loss of user changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For sparse-checkouts, we don't want unpack-trees to error out on files
that are missing from the worktree, so there has traditionally been
logic to make it skip the verify_uptodate() check for these.
Unfortunately, it was skipping the verify_uptodate() check for files
that were expected to *become* SKIP_WORKTREE.  For files that were not
already SKIP_WORKTREE, that can cause us to later delete the file in
apply_sparse_checkout().  Only skip the check for files that were
already SKIP_WORKTREE as well to avoid lightly discarding important
changes users may have made to files.

Note 1: unpack-trees.c is already a bit complex, and the logic around
CE_SKIP_WORKTREE and CE_NEW_SKIP_WORKTREE in that file are no exception.
I also tried just replacing CE_NEW_SKIP_WORKTREE with CE_SKIP_WORKTREE
in the verify_uptodate() check instead of checking for both flags, and
found that it also fixed this bug and passed all the tests.  I also
attempted to devise a few testcases that might trip either variant of my
fix and was unable to find any problems.  It may be that just checking
CE_SKIP_WORKTREE is a better fix, but I'm not sure.  I thought it
was a bit safer to strictly reduce the number of cases where we skip the
up-to-date check rather than just toggling which kind of cases skip it,
and thus went with the current variant of the fix.

Note 2: I also wondered if verify_absent() might have a similar bug, but
despite my attempts to try to devise a testcase that would trigger such
a thing, I couldn't find any problematic testcases.  Thus, this patch
makes no attempt to apply similar changes to verify_absent() and
verify_absent_if_directory().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 2 +-
 unpack-trees.c                       | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 1b2395b8a82..4ed0885bf2f 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -197,7 +197,7 @@ test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
 	grep -q dirty init.t
 '
 
-test_expect_failure 'read-tree will not throw away dirty changes, sparse' '
+test_expect_success 'read-tree will not throw away dirty changes, sparse' '
 	echo "/*" >.git/info/sparse-checkout &&
 	read_tree_u_must_succeed -m -u HEAD &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 98e2f2e0e6f..6d9d89c662a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2059,7 +2059,9 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o)
 {
-	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
+	if (!o->skip_sparse_checkout &&
+	    (ce->ce_flags & CE_SKIP_WORKTREE) &&
+	    (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
 	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
 }
-- 
gitgitgadget

