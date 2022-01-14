Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D4C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiANP7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiANP7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D41C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e9so16405010wra.2
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GatrIb0aS+vGnK1GynLVlbLSEFhnJuTB5yplhwd1UwE=;
        b=aTlZdcx4nwaAMBdpJd9HpY+cENFkIZBqPDG0KrBCHz9aVK1HG43iQ6W4v7jFFCELeY
         ZHmP0SfKSSNgBEn4t324tDtecTe0z2sc2PbRv9cWKv5kO/RhR8LuUK4GhIoF0X1opir0
         W1kNr+S7MjMYixGR/CPfN/ZNTGPWIweyEtKJA6w4izrRdXG2SASny7VwVahuDzICOvRP
         395ddruw8oaok2LWBvPejfEvPSBATSgkJ31+U8zYotaz/F3Vj8l9kee0pCpH8dgB1IHX
         Hqeqstzy22239GG1k/cQIbR609OLzA7Akeo+sKYO9m/kCiFiKAX1vzXpT0fdK1NcQOEO
         wZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GatrIb0aS+vGnK1GynLVlbLSEFhnJuTB5yplhwd1UwE=;
        b=rHaW0pnbwtUpQsWLdbf0mSH5NVgIAJVTZr7mM+0nNB+TG+00PtMQGizQbDfEYr+gWg
         WTjJfbeqUwGqnigYssek+Rp5xtfWE9qdQutT7iZz06tTwkam4aQw9gz4F1UN1sV7m1kz
         O5m5DLbDGLkvgCfH+nFo6b/y43Ve5wXBSUnjyAk/c8hqbSj4oiLig03ixm0n7vHV38pD
         pjOzwtyv6/ufLC5i++0v+NuV/XM1K0jBcnEvUzvGCrx3l70VSF8CrLrc38QbTrblHQZG
         WsQZNLFA7A5i6+Tmgy3wARA138XgqP5MzJF4n27UWC0iYQ8OhwJ0wyUpmJbloFsGpA4q
         Gr6Q==
X-Gm-Message-State: AOAM531KVf8T2gGUDfzmGLhe4WL09jNypyrMoOYPS0JfF9W+FrWrn2mo
        4l3TcZe1XIHprvf22gVvtdV6ZZo3Ngk=
X-Google-Smtp-Source: ABdhPJwDd1v6F/25vHPT5pdyn4Cb6saiRJWk1ZuXhdpjlpk8g8RylbM8CYCLzofo7e+XjX1sWvXuFg==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr9016047wri.525.1642175986484;
        Fri, 14 Jan 2022 07:59:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c22sm11676437wmr.27.2022.01.14.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:59:46 -0800 (PST)
Message-Id: <206c638fa904842def0ebe325747464ad58da7f1.1642175983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
        <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 15:59:40 +0000
Subject: [PATCH v2 2/5] unpack-trees: fix accidental loss of user changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
index 360844bda3a..96525d2ec26 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2065,7 +2065,9 @@ static int verify_uptodate_1(const struct cache_entry *ce,
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

