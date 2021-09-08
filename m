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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A35C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B9C61078
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351472AbhIHLZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhIHLZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53235C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u9so2722169wrg.8
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OA5a+Nzw5n7L/bh9CU4DUTznInpgSQyE3gZWdYHJ8dY=;
        b=jqmvYNdNvdvQ3s3t9lKe9pLJetKxfC7PPQYaqBQS+UDnRpmmMPQW80fLJ/R0KqfHMz
         UldHvgNMOvodlV1rKGHvjNVwOJDGkipuT/O4s27XMQIHAP5ID40pXBoBZA9aLIfLGB46
         054EpvWzMvqEJecFr/dBjEeoMVKr+UtqHK70KrIO59TzK6572+3s+XoNHOu4Vt0L7Btf
         2JQOVfH705xB5it5LKWZM9MTziHMxfmx3xhB+PunzO0/kjQgtgJkiVwA19ooCUiCr/S6
         W/avU9EzJxNv1wV/4J15sv3ZqMO+RCpkfk2SV3YcCR7T0cpr68bqbKWbANYocPCbIdTs
         2aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OA5a+Nzw5n7L/bh9CU4DUTznInpgSQyE3gZWdYHJ8dY=;
        b=QyBkH/vdt0TJHsY7FQidoIiPz99Cufsb2o2aM57ac/4yKko2bGeGv0S8gbHQ4Cp1bM
         rBP8kpQI9cZJya/XuoVUZfTEVlv9LR0R/4AIDrUOyYXynNhFhUrfCJbzgN8qtAC/9voq
         Pasc6/XIoeLLzmJUVJ0YAMtU42OzNtQbqVTvP940MUqymK7Ge4E2awqpDD1q1mRNltyA
         S0JuhY3LWBIDblbozSP/k4Eo2AbgpGsobG63TJujDr2Bc6YTLBMJiRZ4lKHR7g5wEiyx
         jV7Bh7ZXCuqOVbJCD7hcxmOnR4vXgi8sB8tUw5krZfnhfc8wQV7wtMc2DjyrGgwIEYQu
         tbLg==
X-Gm-Message-State: AOAM530tmgWcLTTRlAiKA36RxDSIj3fTJgq7mwjwmlmcYqlXS95YFfF7
        uCrMXDCKcwRt2hs7vlk/bYt2MnrolKE=
X-Google-Smtp-Source: ABdhPJwbA/GMIUZKMyp9Qrn9wiNS3NKAd3D3uINkt1/jKv26xS5Et2SAgS8p6T0fqP+c/59QG/rpYg==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr3439181wrc.158.1631100244959;
        Wed, 08 Sep 2021 04:24:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm2163891wmk.2.2021.09.08.04.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:04 -0700 (PDT)
Message-Id: <c3c9ffd855cdbe9b1b44e4b73c7201bb16148525.1631100241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
        <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:23:58 +0000
Subject: [PATCH v3 3/6] merge-ort: expand only for out-of-cone conflicts
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
index 1531b4c94c2..805f7c41397 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4060,11 +4060,18 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 
 	/*
 	 * We are in a conflicted state. These conflicts might be inside
-	 * sparse-directory entries, so expand the index preemptively.
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
index 3b331a6bfe7..36964f52f2f 100755
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

