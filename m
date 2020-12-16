Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0EC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270EB233A0
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgLPUgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgLPUgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:36:03 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0FC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 3so3666447wmg.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zg5yKtrWXdJxI34EizbWKhcr7X9pVdf85ID8P4I9sws=;
        b=Pv4iigejrPbrCL6BNqUMwEmNg1UZovXv3cEVNzallYpPqkLFFk5MyorZrKhmmoFPPR
         bCL86wdJ7IdSY0t6F67hkhIBBtmf2+yCDai11sINH4ZF18b0r2N1XrA/rpgOYWGzTPkz
         nGmVkhQLPY7nAf28YvQL45afZ7v3DeLviYFXltoU160aTDpaI1oeODfpScpxVTgvtxFP
         /mK2c4tp/TSVpaaxN7lLSsKeQG2RHOdWuOe0rJ2RG0KPxWmMq6caOUE4kGjdkHtBxjeH
         ms/QqJfdXP+MUm4A8gSJFKTPxg7M/8t/Q7SPesXd/xFDVYqTTV31pJND3redUH2WGjQw
         J84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zg5yKtrWXdJxI34EizbWKhcr7X9pVdf85ID8P4I9sws=;
        b=m0ftTFsmeFQscUGFQNXWViT+/UU1p94lefoI9QGO91uSeZFeS+2GG0OAIWyYonAsa2
         6RrY8HhePlWS/JMrTbgZ0OuHlvh5CYdEDjlxtsdo8OzTkLcLG9ctjxvwqQJUJx1Uevqy
         J88yDqmfgSIkphHsBznzJsUWMO7WeHT1J8JD0kUlDq/IZaxhRUuOTUX//vyDSZK85S5X
         uixtAG0YymOPhqtlMFaKD0JxNAR2Fs26q/3vYYWpHu8Yw7gmY6cFSi8vXzmXDm/R5Cyc
         XC00Xnz7w8fS1Tbsi9UTollzJPpZ4I5i8ncWrH8eOXTlPGPBoUMb9A2bwz8N9JG7CO6X
         indg==
X-Gm-Message-State: AOAM531W9z6WWQMFRg/T/C/NcRAOBcu4NZOm2pquu6nlvw5bCH3I/TQI
        2mHy7TyUoUHynx29TRtoS9cjzi40dc4=
X-Google-Smtp-Source: ABdhPJyf9yA5vAaN3PDcb4iuZ61WLrg+8RoDq+39B/B6cviytTK4NmEaQBBupGUu3Ae6afsSoqPs8g==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr2727238wmj.61.1608150920867;
        Wed, 16 Dec 2020 12:35:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b73sm7804963wmb.0.2020.12.16.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:35:20 -0800 (PST)
Message-Id: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
References: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 20:35:16 +0000
Subject: [PATCH v4 0/3] merge-ort: implement recursive merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does NOT depend on en/merge-ort-3
and can thus be reviewed/merged independently of it).

This short series adds handling of recursive merges (merging of multiple
merge-bases to create a virtual merge base) to merge-ort. With this short
series the number of test failures under GIT_TEST_MERGE_ALGORITHM=ort drops
by 801 (from 1448 to 647).

Changes since v3:

 * remove the confusing portions of the merge_incore_recursive() API around
   opt->ancestor that were designed to accommodate merge_recursive_generic()
   or some function like it. If that stuff is really needed, we can add it
   later, but it may be better to simply adjust merge_recursive_generic()
   and/or its callers when we get to that point in the porting process.

Elijah Newren (3):
  merge-ort: copy a few small helper functions from merge-recursive.c
  merge-ort: make clear_internal_opts() aware of partial clearing
  merge-ort: implement merge_incore_recursive()

 merge-ort.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++---
 merge-ort.h |  10 ++++
 2 files changed, 135 insertions(+), 7 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-814%2Fnewren%2Fort-recursive-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-814/newren/ort-recursive-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/814

Range-diff vs v3:

 1:  dcf28565ad3 = 1:  dcf28565ad3 merge-ort: copy a few small helper functions from merge-recursive.c
 2:  bffc45c6570 = 2:  bffc45c6570 merge-ort: make clear_internal_opts() aware of partial clearing
 3:  59216a155ae ! 3:  f622d6905d0 merge-ort: implement merge_incore_recursive()
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
      +		merged_merge_bases = make_virtual_commit(opt->repo, tree,
      +							 "ancestor");
      +		ancestor_name = "empty tree";
     -+	} else if (opt->ancestor && !opt->priv->call_depth) {
     -+		ancestor_name = opt->ancestor;
      +	} else if (merge_bases) {
      +		ancestor_name = "merged common ancestors";
      +	} else {
     @@ merge-ort.c: void merge_incore_recursive(struct merge_options *opt,
       			    struct merge_result *result)
       {
      -	die("Not yet implemented");
     -+	/*
     -+	 * merge_incore_nonrecursive() exists for cases where we always
     -+	 * know there is a well-defined single merge base.  However,
     -+	 * despite a similar structure, merge-recursive.c noted that some
     -+	 * callers preferred to call the recursive logic anyway and still
     -+	 * set a special name for opt->ancestor that would appear in
     -+	 * merge.conflictStyle=diff3 output.
     -+	 *
     -+	 * git-am was one such example (it wanted to set opt->ancestor to
     -+	 * "constructed merge base", since it created a fake merge base);
     -+	 * it called the recursive merge logic through a special
     -+	 * merge_recursive_generic() wrapper.
     -+	 *
     -+	 * Allow the same kind of special case here.
     -+	 */
     -+	int num_merge_bases_is_1 = (merge_bases && !merge_bases->next);
     -+	assert(opt->ancestor == NULL || num_merge_bases_is_1);
     ++	/* We set the ancestor label based on the merge_bases */
     ++	assert(opt->ancestor == NULL);
      +
      +	merge_start(opt, result);
      +	merge_ort_internal(opt, merge_bases, side1, side2, result);

-- 
gitgitgadget
