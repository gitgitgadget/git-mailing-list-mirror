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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C9C4332B
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D58A6528C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCIGZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhCIGYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7435C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so13929319wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NM88Nfi1AIKhUrakbJSoo/O1G5Kw+XIno49R7rZ2qXg=;
        b=FC0eT62DnYg3OoESu4eGEi/LI6zibiLvfXq/x/mwjzRjnkxjCaemzyk3ku4TA+a8vE
         Tfnnixmn2Z96ipvbHe95hxvzp3u1w6cM/QvfMZY2Hff0bRUk5mj54uuVJOM7pMe8+Jro
         Xy8Qtp4axseOrLibms03c36AwVNMt+UQvyuOx5Rs/pqxcYiraW/gYayQVcwyl5N3gh9N
         faugp1zK4MCFfAiXF/oQ8H1ySxYGEWrhrjjLDDDSuBPJT1N2Nz/sfph7go6D1gjoudEW
         Yzw8G8c5B/C9SqRxTKVL0KD8xBgiLH81X/Ke6g5YrWyay4u6iKzr2RbahOH1H4vnZ4cT
         1N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NM88Nfi1AIKhUrakbJSoo/O1G5Kw+XIno49R7rZ2qXg=;
        b=VvYyzrpgfjiwOcOZwEtNrmyeqmO7B1w1jxwWDs2tNmGZZH8ovGAF5PXCOshTK6zGXe
         25rKfGTEGBs20WrOZvFLCtx7Yr4gxe8Sn3XTmM6lrHHTBul5M8lQf1FS5Sb8z9EZAiCC
         sZpz5ml4oZNFR9JodhmSpQgzJKbGR+8wt07E7OHWFpYuRZZrg7IOb+9fUIZ9KGipqmEX
         NHvRU9p/I+hRzE2u10eyT//qInJbUXND45VIZkIoL8dKJOOGRLVW6ehda7HyU3Y79L1I
         /EpD+ub6pbX7T0zMrFDpYp4GkUoabdNrIpaJjLVx84rIku02OQTB2annRfaFSCmzi2jY
         pgJg==
X-Gm-Message-State: AOAM533O/9O79ZymOFS5pIhzndT8kVSqHVQNILZ2S4WMTc1ZKYUdw5pr
        ZpPC+yvnpGTO7wCqQM9sKm/6LjHc8WY=
X-Google-Smtp-Source: ABdhPJxNZvR0uZ0apBqoi8IaT0ow0z4QMbIH2q8zhmWYQH7j1Ay2tPudKxoPWAK8dAgnsV4ay+W5Fg==
X-Received: by 2002:a5d:4bcd:: with SMTP id l13mr14643225wrt.56.1615271091764;
        Mon, 08 Mar 2021 22:24:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm21834081wrx.79.2021.03.08.22.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:51 -0800 (PST)
Message-Id: <90a57ade629d66e557f6f7b142e87cbeba8ca25e.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:42 +0000
Subject: [PATCH v2 07/10] merge-ort: implement CE_SKIP_WORKTREE handling with
 conflicted entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index cfd956a3f435..040287e3a998 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3234,23 +3234,27 @@ static int checkout(struct merge_options *opt,
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
@@ -3291,9 +3295,23 @@ static int record_conflicted_index_entries(struct merge_options *opt,
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
@@ -3343,8 +3361,6 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv == NULL);
 	if (result->clean >= 0 && update_worktree_and_index) {
-		struct merge_options_internal *opti = result->priv;
-
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -3354,13 +3370,14 @@ void merge_switch_to_result(struct merge_options *opt,
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

