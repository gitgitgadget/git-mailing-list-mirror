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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DEC433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C16500D
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhCEAzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhCEAzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7C2C061764
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so29285wmq.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YNuqdkSwV2cIic9vEbecM9+TnslptJncu2l6f6dvy1g=;
        b=ffwXLIG5I29NKm7Eu0zpHFTGpEAGYF0FUKlqswnnHfYWMVbbI/DHByT4HMCuTwDOf8
         PsBu9O1eG0+8D98er6pLKRntgbIBdlhigu0EPSzrtvg9a11cH1e53DlOPmYUH86pRTUQ
         3E6JAT8rF/c/9J81/gru2jyi2Ak3NEArxlQi8dbNw2j3WfHSIsLFmqZT3EZ02lAXlIyj
         0//Wm/CS+kYXCoFqao3pxS5mWKK89EefkiWD0ZpNVZuWTiIFXyTJz+Ina83ugkpPExDZ
         1SuCscNC1zduMElfsH4Skmibu0BIpF2YqoRUP7v31TZB63ynW4OvJQQ1jPp5GMNJX4Hr
         ldaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YNuqdkSwV2cIic9vEbecM9+TnslptJncu2l6f6dvy1g=;
        b=E3zjkkyn9tCc6854XyscUobRAKZVdSg0/DrjAAKHwWwLLEGxDdiokwlWmIdmrkqBIn
         FzbSPwPjbHXYsIVI2wzfaskdGTsRDEl1X8pk2qRWDBVIN0++7eCR5+DkWtV/CnOyjH0k
         HuBuPKMtBebYe2zm+5+k0bgZJwKuHR3q0RfovDZhYrpY2xF8EAI50StkEm1l39JxE8Bi
         tfzp5dBSnTr9bxL66/6pMdvHdzPdh3H9cHtk3PGKAO+5vp2AKoMOYpEzriT1hb0eNXau
         uadhZMDwas50cyVYe3ikEqiP11QF3jlNRuMBCiSKz8ArsBmNQR7RetEt8Qc/YVDKWQYC
         7kug==
X-Gm-Message-State: AOAM530gUy1F9MAPeLf3nP3uHi/sPIl4/hkF0Igl/3a/sLLyluGS5EAp
        4ZhmMM/NrWijUJAyMP6HNeMS8akd5+Y=
X-Google-Smtp-Source: ABdhPJwUJ0yXwcdInQbdKqYXMB94InypJOPs9eyWbusJTCCEcXLApynnFPdc28Xq4Y3m8iLfXzBLDQ==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr6184668wmb.53.1614905743700;
        Thu, 04 Mar 2021 16:55:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a75sm1804391wme.10.2021.03.04.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:43 -0800 (PST)
Message-Id: <100c0187bdfeef5c560ecd17160ed7c9a3032156.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:34 +0000
Subject: [PATCH 08/11] merge-ort: implement CE_SKIP_WORKTREE handling with
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
index a998f843a1da..37b69cbe0f9a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3235,23 +3235,27 @@ static int checkout(struct merge_options *opt,
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
@@ -3292,9 +3296,23 @@ static int record_conflicted_index_entries(struct merge_options *opt,
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
@@ -3344,8 +3362,6 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv == NULL);
 	if (result->clean >= 0 && update_worktree_and_index) {
-		struct merge_options_internal *opti = result->priv;
-
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -3355,13 +3371,14 @@ void merge_switch_to_result(struct merge_options *opt,
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

