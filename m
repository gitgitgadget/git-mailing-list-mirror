Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE6EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D82822CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgLDUsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUsz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:48:55 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D4C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:14 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so6573993wrc.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RuEVM3/ccJrQUcbJln633IlGZilllP1xra5XqO51clQ=;
        b=gnAmkdT6NCHGpQZJopGrXvG08+B3vA0jxIqoyWqbeaK3Bvj06xAuN7gRljXTjpU6KH
         HlQpnwqF3ycdfrxqMkIbs2ZWDuyqfHHyPDVKygD1NvTj1Bch2BPRsc3XyNm8QttLZxuk
         f+2EvXhYcZPV3XjYE3rH8D9o6Xxa7R0ahO1JCTqG7YrWxuZfWfnQ40Rq5knCWYfukglU
         jsOa1moOaDMPoj+WeVW6gFKhEj/5j16vF42kliagvVJvxoZceYDwKgsWdhaF/zrNTicS
         jXwuCQDd4aWJ/PsUPDjvOy0cE7MVkXhwyClaFuBuEh0Lekt8n/K6l7UpNCV38rXgNPp2
         c1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RuEVM3/ccJrQUcbJln633IlGZilllP1xra5XqO51clQ=;
        b=T4AA8Xv9H09asROl2mzCKIwY1roE5Cp1qTQgXNAZTXOMmmKHk6FJCg69/CaU05EIU9
         zSNCjOrxrq0xAp9rWJCegG5SUiGoNNNscrThKWYWq9+8ouTUIE1H9xn8NYU15jThNkH0
         f712VNhGYxALBtBHMyqqKk9uQ8uaa9oQfUZGuHCmTk5x8i+Md3JAqSv1eQf6ZT43Lal5
         Kbj2qvQnGyeBE+BXtu9NrxU6FqHqGPuh0KDXPsz2h99gocvzr1CiYi0VYkERu3bUWQ9O
         0h3K6aaVNg3Z1SMu4qjkVkotiJdvspMfzU6OwlmdcP84T32WouxY98U65A2+kdG6e3XD
         QXXQ==
X-Gm-Message-State: AOAM532+fPhnLhtWjzDfdHIqjYFXTf8pABlg9XfXSmrsFwxtVB1W44G8
        z2jDY0S7lstFNcPfk5NUi9EELDnA+c0=
X-Google-Smtp-Source: ABdhPJz0cvAAr61JD39E1GfrkyBpFWpiu34/KbYC3dTzbiUUdXG9d1NIcFFvbq3Y3eU9IBazq9blOQ==
X-Received: by 2002:a5d:6310:: with SMTP id i16mr6995594wru.284.1607114893040;
        Fri, 04 Dec 2020 12:48:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm4937516wrm.1.2020.12.04.12.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:12 -0800 (PST)
Message-Id: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:50 +0000
Subject: [PATCH v2 00/20] fundamentals of merge-ort implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is actually v4 of this series (the first two rounds depended on topics
that hadn't graduated yet, so I hadn't yet used gitgitgadget for submitting
it). As a reminder, if you need to see the first two rounds before I started
submitting this series with gitgitgadget, you can see them over here: 
https://lore.kernel.org/git/20201102204344.342633-1-newren@gmail.com/

Changes since v3:

 * Made the small tweaks suggested by Ævar
 * Fixed an embarrassing tree ordering bug in commit 13; base_name_compare()
   != strcmp() is important.

(Tree ordering bug found due to the fact that merge-ort, including many
patches not yet submitted to this list, is in live use at $DAYJOB.)

Elijah Newren (20):
  merge-ort: setup basic internal data structures
  merge-ort: add some high-level algorithm structure
  merge-ort: port merge_start() from merge-recursive
  merge-ort: use histogram diff
  merge-ort: add an err() function similar to one from merge-recursive
  merge-ort: implement a very basic collect_merge_info()
  merge-ort: avoid repeating fill_tree_descriptor() on the same tree
  merge-ort: compute a few more useful fields for collect_merge_info
  merge-ort: record stage and auxiliary info for every path
  merge-ort: avoid recursing into identical trees
  merge-ort: add a preliminary simple process_entries() implementation
  merge-ort: have process_entries operate in a defined order
  merge-ort: step 1 of tree writing -- record basenames, modes, and oids
  merge-ort: step 2 of tree writing -- function to create tree object
  merge-ort: step 3 of tree writing -- handling subdirectories as we go
  merge-ort: basic outline for merge_switch_to_result()
  merge-ort: add implementation of checkout()
  tree: enable cmp_cache_name_compare() to be used elsewhere
  merge-ort: add implementation of record_conflicted_index_entries()
  merge-ort: free data structures in merge_finalize()

 merge-ort.c | 1221 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 tree.c      |    2 +-
 tree.h      |    2 +
 3 files changed, 1221 insertions(+), 4 deletions(-)


base-commit: e67fbf927dfdf13d0b21dc6ea15dc3c7ef448ea0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-923%2Fnewren%2Fort-basics-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-923/newren/ort-basics-v2
Pull-Request: https://github.com/git/git/pull/923

Range-diff vs v1:

  1:  2568ec92c6 =  1:  2568ec92c6 merge-ort: setup basic internal data structures
  2:  3a063865c3 !  2:  b658536f59 merge-ort: add some high-level algorithm structure
     @@ merge-ort.c: struct conflict_info {
      +			      struct tree *side1,
      +			      struct tree *side2)
      +{
     ++	/* TODO: Implement this using traverse_trees() */
      +	die("Not yet implemented.");
      +}
      +
  3:  5615f0eecb =  3:  acb40f5c16 merge-ort: port merge_start() from merge-recursive
  4:  564b072ac1 =  4:  22fecf6ccd merge-ort: use histogram diff
  5:  91516799e4 !  5:  6c4c0c15b3 merge-ort: add an err() function similar to one from merge-recursive
     @@ merge-ort.c: struct conflict_info {
       			      struct tree *side1,
       			      struct tree *side2)
       {
     -+	/* TODO: Implement this using traverse_trees() */
     +-	/* TODO: Implement this using traverse_trees() */
       	die("Not yet implemented.");
       }
       
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
       
      -	collect_merge_info(opt, merge_base, side1, side2);
      +	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
     ++		/*
     ++		 * TRANSLATORS: The %s arguments are: 1) tree hash of a merge
     ++		 * base, and 2-3) the trees for the two trees we're merging.
     ++		 */
      +		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
      +		    oid_to_hex(&merge_base->object.oid),
      +		    oid_to_hex(&side1->object.oid),
  6:  ab743967aa !  6:  27268ef8a3 merge-ort: implement a very basic collect_merge_info()
     @@ merge-ort.c: static int err(struct merge_options *opt, const char *err, ...)
       			      struct tree *side1,
       			      struct tree *side2)
       {
     --	/* TODO: Implement this using traverse_trees() */
      -	die("Not yet implemented.");
      +	int ret;
      +	struct tree_desc t[3];
  7:  bff758c5dd =  7:  c6e5621c21 merge-ort: avoid repeating fill_tree_descriptor() on the same tree
  8:  61b3d66fdc =  8:  93fd69fa3c merge-ort: compute a few more useful fields for collect_merge_info
  9:  4e4298fa70 =  9:  decff4b375 merge-ort: record stage and auxiliary info for every path
 10:  3ec087eb68 = 10:  86c661fe1e merge-ort: avoid recursing into identical trees
 11:  0c89cee34e = 11:  aa3b13ffd8 merge-ort: add a preliminary simple process_entries() implementation
 12:  605cbc19d2 = 12:  b54306fd0e merge-ort: have process_entries operate in a defined order
 13:  242c3cab13 = 13:  8ee8561d7a merge-ort: step 1 of tree writing -- record basenames, modes, and oids
 14:  33a5d23c85 ! 14:  6ff56824c3 merge-ort: step 2 of tree writing -- function to create tree object
     @@ merge-ort.c: struct directory_versions {
       	struct string_list versions;
       };
       
     ++static int tree_entry_order(const void *a_, const void *b_)
     ++{
     ++	const struct string_list_item *a = a_;
     ++	const struct string_list_item *b = b_;
     ++
     ++	const struct merged_info *ami = a->util;
     ++	const struct merged_info *bmi = b->util;
     ++	return base_name_compare(a->string, strlen(a->string), ami->result.mode,
     ++				 b->string, strlen(b->string), bmi->result.mode);
     ++}
     ++
      +static void write_tree(struct object_id *result_oid,
      +		       struct string_list *versions,
      +		       unsigned int offset,
     @@ merge-ort.c: struct directory_versions {
      +	 */
      +	relevant_entries.items = versions->items + offset;
      +	relevant_entries.nr = versions->nr - offset;
     -+	string_list_sort(&relevant_entries);
     ++	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
      +
      +	/* Pre-allocate some space in buf */
      +	extra = hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL char */
 15:  29615c366f ! 15:  da4fe90049 merge-ort: step 3 of tree writing -- handling subdirectories as we go
     @@ merge-ort.c: static int string_list_df_name_compare(const char *one, const char
      +	unsigned last_directory_len;
       };
       
     - static void write_tree(struct object_id *result_oid,
     + static int tree_entry_order(const void *a_, const void *b_)
      @@ merge-ort.c: static void record_entry_for_tree(struct directory_versions *dir_metadata,
       			   basename)->util = &mi->result;
       }
 16:  da54fa454a = 16:  8e90d211c5 merge-ort: basic outline for merge_switch_to_result()
 17:  68307f1b67 = 17:  61fada146c merge-ort: add implementation of checkout()
 18:  a3cd563621 = 18:  f5a13a0b08 tree: enable cmp_cache_name_compare() to be used elsewhere
 19:  56b162c609 ! 19:  4efac38116 merge-ort: add implementation of record_conflicted_index_entries()
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      +		pos = index_name_pos(index, path, strlen(path));
      +		SWAP(index->cache_nr, original_cache_nr);
      +		if (pos < 0) {
     -+			if (ci->filemask == 1)
     -+				cache_tree_invalidate_path(index, path);
     -+			else
     ++			if (ci->filemask != 1)
      +				BUG("Conflicted %s but nothing in basic working tree or index; this shouldn't happen", path);
     ++			cache_tree_invalidate_path(index, path);
      +		} else {
      +			ce = index->cache[pos];
      +
 20:  a4f722a46e = 20:  fbeb527d67 merge-ort: free data structures in merge_finalize()

-- 
gitgitgadget
