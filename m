Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA23B1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfJASRh (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:17:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfJASRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:17:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id a24so10257485pgj.2
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWP0TP1JRIe9x7P0piw3KSRo0/eTeq7vFYkyiV/zDeY=;
        b=Ue3S5NA1YiOhmqOZ0GWN9On7v1V3XpT2eksDktkkkMg22HzpXnv+b8TTY9TksQIIsU
         zcQ2LAHA5eYGsfEHr1yMwjuTjhU7KNI5oMb7pLmby6Fgh7ZkCyFQ3KkQZFNWIyD4F1Bk
         jCRUEvP+6Ajyf1t0Efc+AstXTN7NcLbnm55vmAfrdBVcFD8djHGK24LGVveMBmENjUiS
         eKhLClaU5oB3B/+elG/13NTzuINzvx5jHRns4SBogHjnJEOkhi2pMzb1ams75ULidk1U
         R3BDSGsZ8f6Oi01pgsCf6obg1ieShiuilG15dTNpTwImB/DKUKLZNOUS47PQu61LpMcc
         12fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWP0TP1JRIe9x7P0piw3KSRo0/eTeq7vFYkyiV/zDeY=;
        b=EeArJbuZM7TN8HqvcNtNuARN/5QwA8KAH3sZFAB13A3wQusQjvj4oUxbQY5p1u3zCx
         47n4sORxiOZuoIj4nh1Q03Y36k8KfO3b+OjUr6HZSTuf3F30ivdC11lNoUr3LFoGVdsI
         jc096YPjDMsL7mgjgZLpAd9nfWpS5nUhV3Zx1xLsURMYq2WyMe5zAO/7N1Q/fDix4jXb
         KXfRUHO+cwo34R8Ygo3ppn9I1SinnNqe1klX1rFzXd/Yd6Th8U1jy27Y7I0x0uR0qXeZ
         ILjwsSiolhsgyXelWFPlK+MJAHMzwva54Tpe8q/15ir00dIel34/DMjZQGoX+NjPrT8x
         63Zw==
X-Gm-Message-State: APjAAAXX12oC/NXhmG8I3VCbdyhcaSrsjKcABcfoXVEFn2722v/zT1sy
        /9mXyp5ikwd2/oRpdRtbLhM=
X-Google-Smtp-Source: APXvYqxLyA5fw7iKxd9w2/iFeaDFo1aybbo+gks3xK0TZeyhuG/kTLUr/tMhzkJgFnY76VR3432WHQ==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr7320471pjn.56.1569953852979;
        Tue, 01 Oct 2019 11:17:32 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id u10sm15636931pfh.61.2019.10.01.11.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Oct 2019 11:17:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3] merge-recursive: fix the diff3 common ancestor label for virtual commits
Date:   Tue,  1 Oct 2019 11:17:27 -0700
Message-Id: <20191001181727.16009-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.25.g3f4444bfd7.dirty
In-Reply-To: <20191001144940.GH10875@sigill.intra.peff.net>
References: <20191001144940.GH10875@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 743474cbfa8b ("merge-recursive: provide a better label for
diff3 common ancestor", 2019-08-17), the label for the common ancestor
was changed from always being

         "merged common ancestors"

to instead be based on the number of merge bases:

    >=2: "merged common ancestors"
      1: <abbreviated commit hash>
      0: "<empty tree>"

Unfortunately, this did not take into account that when we have a single
merge base, that merge base could be fake or constructed.  In such
cases, this resulted in a label of "00000000".  Of course, the previous
label of "merged common ancestors" was also misleading for this case.
Since we have an API that is explicitly about creating fake merge base
commits in merge_recursive_generic(), we should provide a better label
when using that API with one merge base.  So, when
merge_recursive_generic() is called with one merge base, set the label
to:

         "constructed merge base"

Note that callers of merge_recursive_generic() include the builtin
commands git-am (in combination with git apply --build-fake-ancestor),
git-merge-recursive, and git-stash.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Note: Applies to the top of en/merge-recursive-cleanup, which is in next.

Changes since v2:
  - Squashed in the testcase Peff provided and changed his attribution
    from Reported-by to Helped-by due to the testcase

Range-diff:
1:  3f4444bfd7 ! 1:  208e69a4eb merge-recursive: fix the diff3 common ancestor label for virtual commits
    @@ Commit message
         commands git-am (in combination with git apply --build-fake-ancestor),
         git-merge-recursive, and git-stash.
     
    -    Reported-by: Jeff King <peff@peff.net>
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      ## merge-recursive.c ##
    @@ merge-recursive.c: int merge_recursive_generic(struct merge_options *opt,
      	}
      
      	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
    +
    + ## t/t6047-diff3-conflict-markers.sh ##
    +@@ t/t6047-diff3-conflict-markers.sh: test_expect_success 'check multiple merge bases' '
    + 	)
    + '
    + 
    ++test_expect_success 'rebase describes fake ancestor base' '
    ++	test_create_repo rebase &&
    ++	(
    ++		cd rebase &&
    ++		test_commit base file &&
    ++		test_commit master file &&
    ++		git checkout -b side HEAD^ &&
    ++		test_commit side file &&
    ++		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
    ++		grep "||||||| constructed merge base" file
    ++	)
    ++'
    ++
    + test_done

 merge-recursive.c                 |  7 ++++++-
 t/t6047-diff3-conflict-markers.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b058741f00..e12d91f48a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3550,6 +3550,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 		merged_merge_bases = make_virtual_commit(opt->repo, tree,
 							 "ancestor");
 		ancestor_name = "empty tree";
+	} else if (opt->ancestor) {
+		ancestor_name = opt->ancestor;
 	} else if (merge_bases) {
 		ancestor_name = "merged common ancestors";
 	} else {
@@ -3689,7 +3691,8 @@ int merge_recursive(struct merge_options *opt,
 {
 	int clean;
 
-	assert(opt->ancestor == NULL);
+	assert(opt->ancestor == NULL ||
+	       !strcmp(opt->ancestor, "constructed merge base"));
 
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
@@ -3741,6 +3744,8 @@ int merge_recursive_generic(struct merge_options *opt,
 					   oid_to_hex(merge_bases[i]));
 			commit_list_insert(base, &ca);
 		}
+		if (num_merge_bases == 1)
+			opt->ancestor = "constructed merge base";
 	}
 
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index 3fb68e0aae..860542aad0 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -186,4 +186,17 @@ test_expect_success 'check multiple merge bases' '
 	)
 '
 
+test_expect_success 'rebase describes fake ancestor base' '
+	test_create_repo rebase &&
+	(
+		cd rebase &&
+		test_commit base file &&
+		test_commit master file &&
+		git checkout -b side HEAD^ &&
+		test_commit side file &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
+		grep "||||||| constructed merge base" file
+	)
+'
+
 test_done
-- 
2.23.0.25.g3f4444bfd7.dirty

