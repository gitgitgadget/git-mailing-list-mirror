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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5703C433E2
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8F061989
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCTAEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhCTAED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F010C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so10757416wrn.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eGphsfSLxSih+gC6ig10Nu03y71Itud2yHKKHLi8FMQ=;
        b=oK2oMPhF4lUk2MiE6WI1Xqp68DOB9x83n5DkehRaGImRUqOfthwsBKhl+sf3m/g9Kl
         QT8QGITFSQawXNJAyf9aP+vJUDHRynlb06GGC8sthP7qE8GyqTSON34IO/w2LMshIkUy
         K2Y+HqC//qwB90QBokOEK7Le51q+yBL1SIPwRyNIBxbeowZmL+by9CVEkKCCGJoJsOmR
         ge58LPw1OAlyRiBf/WTIUQgVFj9qpyiT2nqDbNcdO5Xw6EBVDqdCtHTl9MFEUBawat1v
         4jzLdGbSx2BPXoMat669oItZIsWF+bv6TQOJFNO07CG/p/ggOc6NpdFopQttzbfFnT7X
         WEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eGphsfSLxSih+gC6ig10Nu03y71Itud2yHKKHLi8FMQ=;
        b=U8LQbL/5M2Dxj4vzMVrY1xC6iXQ/XiPcwIC3cAEr7MEO8Vw1oA2/PS/hGyPuyjAdLQ
         VZ6YqmxgIRZHV5Yu6w4+UWisNxie0/MPrUVIhlYs0j7Seiu4aPEhWp/F/7w9PURcaKxB
         J99HmEVK9YZvZS9FzwqlqzhrdWSIFd/EvUf92vmXiqaztKkQ7FatBl/nu7ebO/OGgR0e
         vDeb02bH0QAK4Rk25OPONNLiQnX0KZ0qq0820QqPyRSQqHqyfBRjuX2okM9j0yoOlUJ/
         sx/uCL7YmjTfGWNCGh9IASQV/hh3DKu9TutyxAutSX12qbPte9hqyVTVpRgUT/81VFcF
         b2Iw==
X-Gm-Message-State: AOAM53052F+eNuEbJS1OTC7Byg0VeNZ73CJCW/bkt4RjwA6QfvAnOleP
        R/xpoM0yewtMrLEJ3Uguoh5jocBoUlw=
X-Google-Smtp-Source: ABdhPJy6wFcqYjq3kLHeJmkEnf9wj/Nhy+RA+rFATZH56pWd215n2kVh8/0/VbcC/+SbXZwbkAJdmA==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr6824005wra.179.1616198642026;
        Fri, 19 Mar 2021 17:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm10730663wrj.62.2021.03.19.17.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:01 -0700 (PDT)
Message-Id: <fe3baf696785c4b7bee8ae93e4567c2ee2a03492.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:50 +0000
Subject: [PATCH v3 07/13] merge-ort: implement CE_SKIP_WORKTREE handling with
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

