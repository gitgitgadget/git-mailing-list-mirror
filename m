Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6462C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8835E6120A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhGUDnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 23:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhGUDna (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 23:43:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C6C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c15so653947wrs.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=XNc9YwTBbJX1zbd4EPvq9CsCfj25/TfzLcjspNCmPWI=;
        b=eAlkNam2UcrN+NTvCxX8r++F1TB8Oo3NjsVFKriEbOr4bgTnAdcRne7RFgSFEBkIGo
         u9qDlKl8RuhlqFggoGKp43W6qD6G4gHuwXGlzUebkXT9QudtcPTMPFF1Sj98byuFKCBK
         +01QljSaJgb01ME1vi2koAXQNU8EKJZmeBQ5RRNAdzS+LYZk+my2K/qs//3eT3KQICqf
         i54Evmpmo7vLr7CiByl9c3SxqtaiLlFeLtqJqoY6TFPQeyufgErhxHlTGuulaGALnsjF
         1mRtKFRkgh71whqOlAIdpEOBxp+95pFt2uDm9lWwj63tFHGQdL1+YqXB7P8fty4CTXpT
         VbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=XNc9YwTBbJX1zbd4EPvq9CsCfj25/TfzLcjspNCmPWI=;
        b=uKHSTTvqu+k7mG0N6+PkUn1bYcO7luqb7OiLx4Oat+mAECIkVkY6/s55QPgs6eDlZ8
         Ik9m3QUkKKTGPulBiZPLpsB3TmmN1r6ZxANs7zSNQ+nTDPE6LCDuxu94GLWE0cm2l/Wx
         bYuTCU80jsnU8Akh2Y+ukDBskIrPRmfLM/jGi09cB/eufOdTBBwHQlW75cNSmqpULrVL
         bTghtKZSwm8BaVYJLeMETDnKxje4nw8l4k0PjMl2EfCf91fQqenoDUbWf/XclNdOs2JE
         NwAM4iUPuzxSxaHsT682iK+zs2m1x5+YnhIOKgdctQMGriETV1rIYwtxCbqpHLTKM1KR
         cylA==
X-Gm-Message-State: AOAM531x7okafNBMal9fT7scG71mHXM+r8RjgaCuzz2aB3URfAkNhQ++
        73BxQ1pOAprpE3iB+rGTFUVwjCdCOo0=
X-Google-Smtp-Source: ABdhPJxONdwoHYNMIVkou8G9oKf9OFPpcsC8VrmkQhDOkbRP0LFVnBcTRL58qBgMwKNzSeGijNLJhA==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr39816256wrr.55.1626841445878;
        Tue, 20 Jul 2021 21:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm4038326wmo.10.2021.07.20.21.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:24:05 -0700 (PDT)
Message-Id: <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 04:23:57 +0000
Subject: [PATCH v4 0/7] Optimization batch 14: trivial directory resolution
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends textually on ort-perf-batch-12, but is semantically
independent. (It is both semantically and textually independent of
ort-perf-batch-13.)

Most of my previous series dramatically accelerated cases with lots of
renames, while providing comparatively minor benefits for cases with few or
no renames. This series is the opposite; it provides huge benefits when
there are few or no renames, and comparatively smaller (though still quite
decent) benefits for cases with many uncached renames.

Changes since v3:

 * Add Stolee's Acked-by.

Changes since v2, addressing feedback from Stolee:

 * Created a separate struct for three related variables to hint they are
   related
 * Simplified a lengthy comment that was duplicated by the commit message
 * Various other minor cleanups

Changes since v1:

 * Minor tweak to the final patch to correct implicit assumption that rename
   detection running implies all renames were found (rename limits could
   have been exceeded and prevented finding renames)

=== Basic Optimization idea ===

unpack_trees has had a concept of trivial merges for individual files (see
Documentation/technical/trivial-merge.txt). The same idea can be applied in
merge-ort. It'd be really nice to extend that idea to trees as well, as it
could provide a huge performance boost; sadly however, applying it in
general would wreck both regular rename detection (the unmatched side can
have new files that serve as potential destinations in rename detection) and
directory rename detection (the unmatched side could have a new directory
that was moved into it).

If we somehow knew rename detection wasn't needed, we could do trivial
directory resolution. In the past, this wasn't possible. However...

With recent optimizations we have created a possibility to do trivial
directory resolutions in some cases. These came from the addition of the
"skipping irrelevant renames" optimizations (from ort-perf-batch-9 and
ort-perf-batch-10), and in particular noting that we added an ability to
entirely skip rename detection in commit f89b4f2bee ("merge-ort: skip rename
detection entirely if possible", 2021-03-11) when there are no relevant
sources. We can detect if there are no relevant sources without recursing
into the directories in question.

As a cherry on top, the caching of renames (from ort-perf-batch-11) allows
us to cover additional cases.

This series is all about adding all the special checks needed to safely
perform trival directory resolutions.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.235 s ±  0.042 s   204.2  ms ±  3.0  ms
mega-renames:      9.419 s ±  0.107 s     1.076 s ±  0.015 s
just-one-mega:   480.1  ms ±  3.9  ms   364.1  ms ±  7.0  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (for merge-recursive as of git-2.30.0)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


Elijah Newren (7):
  merge-ort: resolve paths early when we have sufficient information
  merge-ort: add some more explanations in collect_merge_info_callback()
  merge-ort: add data structures for allowable trivial directory
    resolves
  merge-ort: add a handle_deferred_entries() helper function
  merge-ort: defer recursing into directories when merge base is matched
  merge-ort: avoid recursing into directories when we don't need to
  merge-ort: restart merge with cached renames to reduce process entry
    cost

 merge-ort.c                         | 399 +++++++++++++++++++++++++++-
 t/t6423-merge-rename-directories.sh |   2 +-
 2 files changed, 389 insertions(+), 12 deletions(-)


base-commit: 2eeee12b02e441ac05054a5a5ecbcea6964a1e6b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-988%2Fnewren%2Fort-perf-batch-14-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-988/newren/ort-perf-batch-14-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/988

Range-diff vs v3:

 1:  5dca982c0b0 ! 1:  7fdfeb159d0 merge-ort: resolve paths early when we have sufficient information
     @@ Commit message
          range of noise.  However, this idea serves as the beginning of some
          bigger optimizations coming in the following patches.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 2:  8aea3713902 ! 2:  7a0085f2da9 merge-ort: add some more explanations in collect_merge_info_callback()
     @@ Commit message
          better.  While we're at it, add a few comments to denote what a few
          boolean '0' or '1' values stand for.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 3:  c2b45fef1d7 ! 3:  d8165740316 merge-ort: add data structures for allowable trivial directory resolves
     @@ Commit message
          Add some data structures that we will use to do these deferrals, with
          some lengthy comments explaining their purpose.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 4:  1cf4a47562a ! 4:  ff568a612f5 merge-ort: add a handle_deferred_entries() helper function
     @@ Commit message
          but a subsequent commit will change that.  Future commits will also make
          the function sometimes resolve directories instead of traversing inside.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 5:  79c51536829 ! 5:  5b01c118f10 merge-ort: defer recursing into directories when merge base is matched
     @@ Commit message
          subdirectories.  The extra conditions are there for such deferred cases
          and will be used more as we do more with those variables.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 6:  572cc5e94d2 ! 6:  7b211271815 merge-ort: avoid recursing into directories when we don't need to
     @@ Commit message
              mega-renames:      9.419 s ±  0.107 s     1.564 s ±  0.010 s
              just-one-mega:   480.1  ms ±  3.9  ms   479.5  ms ±  3.9  ms
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 7:  a9cbc1d4f18 ! 7:  c9ada8369e6 merge-ort: restart merge with cached renames to reduce process entry cost
     @@ Commit message
              mega-renames:      1.564 s ±  0.010 s     1.076 s ±  0.015 s
              just-one-mega:   479.5  ms ±  3.9  ms   364.1  ms ±  7.0  ms
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##

-- 
gitgitgadget
