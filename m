Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE4C43214
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C649C613CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhHXVx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhHXVxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:53:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA15C06179A
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g138so13674033wmg.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G6KS/UZhmVfAyMCKj43H7GZHhnWEANZJctnnUaSeytA=;
        b=iQCKiQLe5qiBhOdu1JcIuN0a7tNPUyxZB+xAJL2brhO04RxqNRDe1cGJxuVX2CSlYH
         YXszCdUB9yVwBLPzJakx4hmjVaF+5Aglshbk9k+Yw7fdc4CIspzDJ+kcaV9gTJ90H1bb
         NgkOa0/ORK9LYa7fcaLaXJsFU1cwENZsF3HTqhbD8X0DFBOf1h3tzZbWp6WIrA0kESCE
         PvXBVItIF/sCl6mCyiv5vN5BlZyAw/+4TKOubAUNoiRI67ERmVPtE+o3AHkaSipLx+TZ
         Q8PKnofG3clVsjdwaqbJtMZ+pskFTNWQBkElwCYAPSybZVmVRnAU7QPk4+3qQjZAMq61
         apAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G6KS/UZhmVfAyMCKj43H7GZHhnWEANZJctnnUaSeytA=;
        b=CH+FZpgWO7o/67BOe7bFm45FqFm7fdje0NwZUPkl1RQO4XXYtQjNLMxS4CYr3k2XrW
         uIOF2KTWXNFiUYVp2+SMDVFxxDo6s6w1dloegPeagaQsCXsGaqdnsoleqYr1NKJKSYOR
         +BjkYtWXkPr5N3HWkNFivwOxy7K+6uteej3osyEpOfdzGvcbX2KVw6Hr4EyAQDpDNrPL
         fxerXHSofhNIcrRf47ejZZ2bXK3pjX4tQDgpnDypvUBpUzKsMwAjfYldHv2f9orcEekN
         WGllJY6i1pmCHQtsT04uIjWF8yteWfQPwsu4nxdOVplHrvn8G85SirT4gyUU2htSlpiH
         lR0Q==
X-Gm-Message-State: AOAM531HpV/Qac6BSyxVBb1YgF/GobjSANtcaqRCmg3CXq9JR+vPXz1A
        Z484dDse1pEPZ/wIj4Ny/aNg+CcBMaI=
X-Google-Smtp-Source: ABdhPJwu+Q9eNJAgYR0mDAt0QKmvL51d5z1nPvQY8a6dQeIFbuCR5H609DMfxL1G/aq27FQis0VXlA==
X-Received: by 2002:a05:600c:4ba3:: with SMTP id e35mr6017652wmp.130.1629841968765;
        Tue, 24 Aug 2021 14:52:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm3156883wms.33.2021.08.24.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:52:48 -0700 (PDT)
Message-Id: <815b1b1cfbfedae7ccbec51b382053e3dcf197de.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:52:42 +0000
Subject: [PATCH v2 3/6] merge-ort: expand only for out-of-cone conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Merge conflicts happen often enough to want to avoid expanding a sparse
index when they happen, as long as those conflicts are within the
sparse-checkout cone. If a conflict exists outside of the
sparse-checkout cone, then we still need to expand before iterating over
the index entries. This is critical to do in advance because of how the
original_cache_nr is tracked to allow inserting and replacing cache
entries.

Iterate over the conflicted files and check if any paths are outside of
the sparse-checkout cone. If so, then expand the full index.

Add a test that demonstrates that we do not expand the index, even when
we hit a conflict within the sparse-checkout cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c                              | 13 +++++++---
 t/t1092-sparse-checkout-compatibility.sh | 30 ++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8e754b769e1..805f7c41397 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4060,11 +4060,18 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 
 	/*
 	 * We are in a conflicted state. These conflicts might be inside
-	 * sparse-directory entries, so expand the index preemtively.
-	 * Also, we set original_cache_nr below, but that might change if
+	 * sparse-directory entries, so check if any entries are outside
+	 * of the sparse-checkout cone preemptively.
+	 *
+	 * We set original_cache_nr below, but that might change if
 	 * index_name_pos() calls ask for paths within sparse directories.
 	 */
-	ensure_full_index(index);
+	strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
+		if (!path_in_sparse_checkout(e->key, index)) {
+			ensure_full_index(index);
+			break;
+		}
+	}
 
 	/* If any entries have skip_worktree set, we'll have to check 'em out */
 	state.force = 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index dc56252865c..38afdf689a2 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -617,8 +617,17 @@ test_expect_success 'sparse-index is expanded and converted back' '
 ensure_not_expanded () {
 	rm -f trace2.txt &&
 	echo >>sparse-index/untracked.txt &&
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index "$@" &&
+
+	if test "$1" = "!"
+	then
+		shift &&
+		test_must_fail env \
+			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index "$@" || return 1
+	else
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index "$@" || return 1
+	fi &&
 	test_region ! index ensure_full_index trace2.txt
 }
 
@@ -658,6 +667,23 @@ test_expect_success 'sparse-index is not expanded' '
 	)
 '
 
+test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
+	init_repos &&
+
+	for side in right left
+	do
+		git -C sparse-index checkout -b expand-$side base &&
+		echo $side >sparse-index/deep/a &&
+		git -C sparse-index commit -a -m "$side" || return 1
+	done &&
+
+	(
+		sane_unset GIT_TEST_MERGE_ALGORITHM &&
+		git -C sparse-index config pull.twohead ort &&
+		ensure_not_expanded ! merge -m merged expand-right
+	)
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

