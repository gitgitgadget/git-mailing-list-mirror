Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CBC433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiGEBdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGEBdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:33:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706687678
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:33:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so10058750wrr.6
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9bEv+bV882AGyzTMn8szkTs4szVKEG7XdIlt23Gvv30=;
        b=HchiFMJqwrEXacbug66VdadGUjB+Xmy7vjenzCsxjJL/X/eLqspI1dSEKha/eM1Y3b
         NAW+UosbARS1x3W5AlLRSDjr031rLLk5kCHopygIin3mZQlj8HZTZQ/iVFBdhK71duce
         sYe/hmxiniD3M/Xv7iiAgAO7cMyfMfSMC8sU71xsuPOidmGEibd8jdFeNYwfWANG9euP
         ss9XdOZUbZq2OnXQiOx0hweuuuYDqe6eo/h3J6RYwymW+HSj0bF3KkTQwBIPUyJMHecO
         mIy6dl4xKkCcQ3hZswzLz+7Ark9oH7iKvqYep8gERe2cjcyAarJA+gtT6n1/oyrTZQjh
         JUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9bEv+bV882AGyzTMn8szkTs4szVKEG7XdIlt23Gvv30=;
        b=ocymrhN1o/ZBGnz7awrH1ui1ssLLAuT88atZub/0NLDr/Z4OA+UHhbxTzvj7lFELLr
         f4OVVCPuLuQGmlCW4bIWUHYRgoRYSx0YaBESYj6TDqvTSrE3zbid638ecg/WcEci9yVv
         3BxxHwTLi1c5ALgeKrjBrK+QnEMQvuRIAcyboFwh+6GFRcFAfHqR9eEgjFh9YiGr/uaI
         yLLjgvFLPKdT2ygF62iXRw104fOPsmPuu7zUfIkWXgLb8ZvxjCi3rICiHzgiVUIyc5PS
         iZk2rIjcCG2OEIcWQP0XP+cJ3Ux8gFCcoxytm/W3J6/EkLYBp6GP9rqmtrkR4KZ3Pt42
         qs5g==
X-Gm-Message-State: AJIora8W/zd52yBFQdVzMnFSNdVFm9mGeldd1A7qSaxS5Wxam1LMjvDm
        0HNRVX5um5etZuA2cL/D8DexxpkD9f8=
X-Google-Smtp-Source: AGRyM1s2+7vWXActkFSVJNxggH10B2jFiDzCr5hxIgeAk8wBOA4ghX9gdIUqErKbkwXbFH2fVBJUOw==
X-Received: by 2002:adf:ea50:0:b0:21d:6547:1154 with SMTP id j16-20020adfea50000000b0021d65471154mr10854690wrn.186.1656984826639;
        Mon, 04 Jul 2022 18:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4522000000b0021d6ac977fasm3957223wra.69.2022.07.04.18.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 18:33:45 -0700 (PDT)
Message-Id: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 01:33:38 +0000
Subject: [PATCH v4 0/5] Fix dual rename into each other plus conflicting adds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds some testcases based on the tensorflow repository issue
reported by Glen Choo at [1], demonstrating bugs in both the ort and
recursive strategies. It also provides a fix for the ort strategy.

Changes since v3:

 * Remove use of for-initializer

Changes since v2:

 * Added a couple preparatory cleanup patches
 * Added a comment about why sub1/newfile is important to the new testcases
 * A couple other minor code cleanups

Changes since v1:

 * Fixed some wording issues in comments, and added a bit more details to
   one of the commit messages

[1]
https://lore.kernel.org/git/kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com/

Elijah Newren (5):
  t6423: add tests of dual directory rename plus add/add conflict
  merge-ort: small cleanups of check_for_directory_rename
  merge-ort: make a separate function for freeing struct collisions
  merge-ort: shuffle the computation and cleanup of potential collisions
  merge-ort: fix issue with dual rename and add/add conflict

 merge-ort.c                         |  74 +++++++++++++-------
 t/t6423-merge-rename-directories.sh | 105 ++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 26 deletions(-)


base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1268%2Fnewren%2Ffix-dual-rename-into-each-other-plus-conflicting-adds-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1268/newren/fix-dual-rename-into-each-other-plus-conflicting-adds-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1268

Range-diff vs v3:

 1:  a16a1c4d947 = 1:  a16a1c4d947 t6423: add tests of dual directory rename plus add/add conflict
 2:  297fef60b19 = 2:  297fef60b19 merge-ort: small cleanups of check_for_directory_rename
 3:  f5f87acbbd2 = 3:  f5f87acbbd2 merge-ort: make a separate function for freeing struct collisions
 4:  d3eac3d0bf6 ! 4:  9d813116112 merge-ort: shuffle the computation and cleanup of potential collisions
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
       	ALLOC_GROW(combined.queue,
       		   renames->pairs[1].nr + renames->pairs[2].nr,
       		   combined.alloc);
     -+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
     ++	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
      +		int other_side = 3 - i;
      +		compute_collisions(&collisions[i],
      +				   &renames->dir_renames[other_side],
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +				 collisions,
       				 &renames->dir_renames[1],
       				 &renames->dir_renames[2]);
     -+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
     ++	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
      +		free_collisions(&collisions[i]);
       	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
       	trace2_region_leave("merge", "directory renames", opt->repo);
 5:  121761e26e2 = 5:  993ac405408 merge-ort: fix issue with dual rename and add/add conflict

-- 
gitgitgadget
