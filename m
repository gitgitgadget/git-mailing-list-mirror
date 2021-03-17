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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FEDC43331
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4BB64F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhCQV2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhCQV2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D24C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x16so3313030wrn.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eGphsfSLxSih+gC6ig10Nu03y71Itud2yHKKHLi8FMQ=;
        b=ExOeyMe0nkU6fkjB5QQXXjF64xkNi5TNDnl5iiXtuIICKXogu22ij8GI2X65/zXBja
         u0UZZ4PnkE1D6dN7AOU71FXFxm7SzX6zbO6l9vch4BSq7oaz3lVVWCQ5QZDpbsOKfEop
         bEVQ6UmRqIyaxDaMu2e+jPQWLO8hXnCnjQhIr9dxF+RzKYtX/tNjo3XgEMUd6oOG1k76
         gql2V04mMHdOaZf9OPDpL/W6ikEprpSQXkYNEWYg9iUrCjOjfVqMsH4pgp6mByZe4hR5
         7HKTflziHvJ6tAwWE0xKX0q/jfPaoa/Zkq2iYQLNfzT0vASOuGpqkOig+jnzL9S9mG4c
         EwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eGphsfSLxSih+gC6ig10Nu03y71Itud2yHKKHLi8FMQ=;
        b=SiIhYTp2VDcDlQDjfNfIdoH+wCM9mF2uZyrOSZ1WnaDj+/oxlMH9f4XmlqfqhAYzF+
         oFlYU8C0vjvUxJP4besXmIgDR8YHXiiQCvPFbF95/4MVMiRzalDEmGFrjkKUDEcK1Rgn
         hy+AMb3crPuMuQ0/e2Iccn2WHx7p6q/TFzOB8fGZqV6ISbY3vwXnzSNPm7IMa+xbKX89
         AlXGJpL/1py9IOaLexR1+3p2JGmBnpo093DanCdrEDpemcSbF6uVivt3jE6yaNBf0EvR
         DeUF5x0OMufoWposzxVGv4ybQV3IRrAKT8ciIwR4i6xwY41xm6DF1WQHs6nktl8jgL3s
         XBBA==
X-Gm-Message-State: AOAM533ZMex7VuN+UZJSqG5GS7l/pGJrmmxRRQlfQ4GZTDWF85lwmw6S
        LCVZ4n/CvQhNufqkvcS9t/YPhYy40YI=
X-Google-Smtp-Source: ABdhPJxw5LobavjyBSY7SamgQ2srGUoRGHEBtz4vHF1Cjfc6yDUsdSL60zNMFJACW/We/o4GogZsMg==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr4492673wry.48.1616016490932;
        Wed, 17 Mar 2021 14:28:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm262499wru.6.2021.03.17.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:10 -0700 (PDT)
Message-Id: <fe3baf696785c4b7bee8ae93e4567c2ee2a03492.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:59 +0000
Subject: [PATCH v2 07/13] merge-ort: implement CE_SKIP_WORKTREE handling with
 conflicted entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When merge conflicts occur in paths removed by a sparse-checkout, we
need to unsparsify those paths (clear the SKIP_WORKTREE bit), and write
out the conflicted file to the working copy.  In the very unlikely case
that someone manually put a file into the working copy at the location
of the SKIP_WORKTREE file, we need to avoid overwriting whatever edits
they have made and move that file to a different location first.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                       | 43 +++++++++++++++++++++----------
 t/t6428-merge-conflicts-sparse.sh |  4 +--
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c4fe234d8972..303e89414274 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3369,23 +3369,27 @@ static int checkout(struct merge_options *opt,
 	return ret;
 }
 
-static int record_conflicted_index_entries(struct merge_options *opt,
-					   struct index_state *index,
-					   struct strmap *paths,
-					   struct strmap *conflicted)
+static int record_conflicted_index_entries(struct merge_options *opt)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
+	struct index_state *index = opt->repo->index;
+	struct checkout state = CHECKOUT_INIT;
 	int errs = 0;
 	int original_cache_nr;
 
-	if (strmap_empty(conflicted))
+	if (strmap_empty(&opt->priv->conflicted))
 		return 0;
 
+	/* If any entries have skip_worktree set, we'll have to check 'em out */
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+	state.istate = index;
 	original_cache_nr = index->cache_nr;
 
 	/* Put every entry from paths into plist, then sort */
-	strmap_for_each_entry(conflicted, &iter, e) {
+	strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
 		const char *path = e->key;
 		struct conflict_info *ci = e->value;
 		int pos;
@@ -3426,9 +3430,23 @@ static int record_conflicted_index_entries(struct merge_options *opt,
 			 * the higher order stages.  Thus, we need override
 			 * the CE_SKIP_WORKTREE bit and manually write those
 			 * files to the working disk here.
-			 *
-			 * TODO: Implement this CE_SKIP_WORKTREE fixup.
 			 */
+			if (ce_skip_worktree(ce)) {
+				struct stat st;
+
+				if (!lstat(path, &st)) {
+					char *new_name = unique_path(&opt->priv->paths,
+								     path,
+								     "cruft");
+
+					path_msg(opt, path, 1,
+						 _("Note: %s not up to date and in way of checking out conflicted version; old copy renamed to %s"),
+						 path, new_name);
+					errs |= rename(path, new_name);
+					free(new_name);
+				}
+				errs |= checkout_entry(ce, &state, NULL, NULL);
+			}
 
 			/*
 			 * Mark this cache entry for removal and instead add
@@ -3478,8 +3496,6 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv == NULL);
 	if (result->clean >= 0 && update_worktree_and_index) {
-		struct merge_options_internal *opti = result->priv;
-
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -3489,13 +3505,14 @@ void merge_switch_to_result(struct merge_options *opt,
 		trace2_region_leave("merge", "checkout", opt->repo);
 
 		trace2_region_enter("merge", "record_conflicted", opt->repo);
-		if (record_conflicted_index_entries(opt, opt->repo->index,
-						    &opti->paths,
-						    &opti->conflicted)) {
+		opt->priv = result->priv;
+		if (record_conflicted_index_entries(opt)) {
 			/* failure to function */
+			opt->priv = NULL;
 			result->clean = -1;
 			return;
 		}
+		opt->priv = NULL;
 		trace2_region_leave("merge", "record_conflicted", opt->repo);
 	}
 
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 1bb52ff6f38c..7e8bf497f821 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -76,7 +76,7 @@ test_setup_numerals () {
 	)
 }
 
-test_expect_merge_algorithm success failure 'conflicting entries written to worktree even if sparse' '
+test_expect_success 'conflicting entries written to worktree even if sparse' '
 	test_setup_numerals plain &&
 	(
 		cd numerals_plain &&
@@ -112,7 +112,7 @@ test_expect_merge_algorithm success failure 'conflicting entries written to work
 	)
 '
 
-test_expect_merge_algorithm failure failure 'present-despite-SKIP_WORKTREE handled reasonably' '
+test_expect_merge_algorithm failure success 'present-despite-SKIP_WORKTREE handled reasonably' '
 	test_setup_numerals in_the_way &&
 	(
 		cd numerals_in_the_way &&
-- 
gitgitgadget

