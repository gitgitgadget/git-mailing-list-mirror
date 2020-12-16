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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B21C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FB123123
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 05:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgLPFx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLPFx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 00:53:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C324C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 21:52:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a3so1210047wmb.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 21:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w7ZxlnSxKW1FR77dVpNYUgukO9+gYPVuyRbnhXq9zUQ=;
        b=DBpBEH4TMCEx7Yk0w+sQ2hzrHGZlgS6jQCR5LD9QkwDox0fXACIP7fj5UECw1R6RXm
         Up233Un3Iw4KByIbLh8331CLUPaHBqpSPatXKJZ18EAbIUENVj6LMkXANl0j0FJXZhB3
         yFm5nUVCnACshjC/HyXyFA8Wtt1lL4nRQ+Akcr5p+Debs3IiphPbLbRvJbXDGOeEE1Hf
         jSvLzMsHqQtq7MOp6LT/wHFeapOtKXtugQT2YRvvuKTaqzYVpZB8wpD/Rsch6oc4UfLZ
         9LibkydBFESEQQCTTbdh3GJ6pYB6dh2AT7EdGa2j/J9WZOdrONP+hrlTcDIyOLQsPnso
         r17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w7ZxlnSxKW1FR77dVpNYUgukO9+gYPVuyRbnhXq9zUQ=;
        b=UAZZngCVQkL7HS7YChF9zXEr+hCj5DmK0wXZ/40KM0dXvcj1nikP5aTCC9+S51yXZS
         5oxRmYvj2L9EuqnCX8Uo4HCZbfh3jBEvs7MgMMDuK6qdygcz78AXd6Ls+UyIdMip/PtF
         K390Yt3H3cptH7+pa8UdfLV40sLLSdL59bReZSSv78Vk51qb7ak5khj6W670Z0GoJRpx
         0lw3NXEGSRFBkn0WhA6Il3uQPEPmYbw+aXaN1rPHoYBoGf5ULEmnYeiaTYp/+qeW/pIx
         +gAQMtIPx+r12MD0ZO2p4Zfz9CWnfZGxPpeo97WU8d7YC36nI11eircpequEDvnj8Crv
         u7QA==
X-Gm-Message-State: AOAM532CJgsYAwpfnxETSVjLrRslRmm7Pd6v70pCokoJ+E/hEArrMQaH
        I9hJCt/9N1FXiJrWJakhy7L8sD8Fu6A=
X-Google-Smtp-Source: ABdhPJxB4/9tVuzQkCGGrOtRIUyf03+sUe1vezq/BxK1nPTU7Q4nAwx1I/ZRjRHaJYqOV0SosY1FuA==
X-Received: by 2002:a1c:bd43:: with SMTP id n64mr1578856wmf.169.1608097966618;
        Tue, 15 Dec 2020 21:52:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm1036086wmd.47.2020.12.15.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 21:52:45 -0800 (PST)
Message-Id: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.git.1608054807.gitgitgadget@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 05:52:41 +0000
Subject: [PATCH v2 0/3] merge-ort: implement recursive merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does NOT depend on en/merge-ort-3
and can thus be reviewed/merged independently of it).

This short series adds handling of recursive merges (merging of multiple
merge-bases to create a virtual merge base) to merge-ort. With this short
series the number of test failures under GIT_TEST_MERGE_ALGORITHM=ort drops
by 801 (from 1448 to 647).

Changes since v1 (based on review comments from Junio):

 * add documentation on why we reverse the commit_list of merge bases
 * modify the special override for allowing opt->ancestor to be set before
   merge_incore_recursive() and document its rationale

Elijah Newren (3):
  merge-ort: copy a few small helper functions from merge-recursive.c
  merge-ort: make clear_internal_opts() aware of partial clearing
  merge-ort: implement merge_incore_recursive()

 merge-ort.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++---
 merge-ort.h |  10 ++++
 2 files changed, 152 insertions(+), 7 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-814%2Fnewren%2Fort-recursive-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-814/newren/ort-recursive-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/814

Range-diff vs v1:

 1:  0b455bd6fe7 = 1:  0b455bd6fe7 merge-ort: copy a few small helper functions from merge-recursive.c
 2:  fc26c1a11db = 2:  fc26c1a11db merge-ort: make clear_internal_opts() aware of partial clearing
 3:  82a773d8972 ! 3:  d8f79450a40 merge-ort: implement merge_incore_recursive()
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
      +
      +	if (!merge_bases) {
      +		merge_bases = get_merge_bases(h1, h2);
     ++		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
      +		merge_bases = reverse_commit_list(merge_bases);
      +	}
      +
     @@ merge-ort.c: void merge_incore_recursive(struct merge_options *opt,
      -	(void)reverse_commit_list;
      -	(void)make_virtual_commit;
      -	die("Not yet implemented");
     -+	assert(opt->ancestor == NULL ||
     -+	       !strcmp(opt->ancestor, "constructed merge base"));
     ++	/*
     ++	 * merge_incore_nonrecursive() exists for cases where we always
     ++	 * know there is a well-defined single merge base.  However,
     ++	 * despite a similar structure, merge-recursive.c noted that some
     ++	 * callers preferred to call the recursive logic anyway and still
     ++	 * set a special name for opt->ancestor that would appear in
     ++	 * merge.conflictStyle=diff3 output.
     ++	 *
     ++	 * git-am was one such example (it wanted to set opt->ancestor to
     ++	 * "constructed merge base", since it created a fake merge base);
     ++	 * it called the recursive merge logic through a special
     ++	 * merge_recursive_generic() wrapper.
     ++	 *
     ++	 * Allow the same kind of special case here.
     ++	 */
     ++	int num_merge_bases_is_1 = (merge_bases && !merge_bases->next);
     ++	assert(opt->ancestor == NULL || num_merge_bases_is_1);
      +
      +	merge_start(opt, result);
      +	merge_ort_internal(opt, merge_bases, side1, side2, result);
       }
     +
     + ## merge-ort.h ##
     +@@ merge-ort.h: struct merge_result {
     + /*
     +  * rename-detecting three-way merge with recursive ancestor consolidation.
     +  * working tree and index are untouched.
     ++ *
     ++ * merge_bases will be consumed (emptied) so make a copy if you need it.
     ++ *
     ++ * NOTE: empirically, the recursive algorithm will perform better if you
     ++ *       pass the merge_bases in the order of oldest commit to the
     ++ *       newest[1][2].
     ++ *
     ++ *       [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet/
     ++ *       [2] commit 8918b0c9c2 ("merge-recur: try to merge older merge bases
     ++ *           first", 2006-08-09)
     +  */
     + void merge_incore_recursive(struct merge_options *opt,
     + 			    struct commit_list *merge_bases,

-- 
gitgitgadget
