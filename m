Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366BC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24D361102
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhHELBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHELBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 07:01:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0E2C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 04:01:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l18so5980044wrv.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MgrcmNuWLRyPg4u84oYVqKdKxZVFspqf6uqmg7WdLc=;
        b=k53CFJHzHTvzaAYJ+bjlD9DB3y9Mnxe/ClfzKf6Mz+ZiVupInDSSlqHP6CCfZAyBTB
         T0M2qt+DLq8jBDACMDn983t/7CHpFHcOT3nHvMX5UQy2KkUVIx72UWexHnAtQRjJla4Q
         EJCSGImiTGeXC/ZlCTt15LNBnZJwWFIdWtrVmJGdfD8mMQLXrByXtnP7vaQcSOmVqi0I
         sEvmnpYYU1pHUTSMN98O944f77j1SKJWdCBZtHNWczqwItnah3A4paqtWjAZJX/XszO1
         p3Q0wrNZCFxmbhdCC33aPzyTc1ur9Y/eDAJ0/jqsTiaFvYFyaQFb26acmG1JXdOAJIxw
         HjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MgrcmNuWLRyPg4u84oYVqKdKxZVFspqf6uqmg7WdLc=;
        b=kVEVy+64xFCE1akLr7yYSmti2uqUOUX6Ohk/NVxztGPVjlqherCvSGMRglX1b1SVZ4
         V1UzfPLJh2KAKCAbmiMhLFvVPb5fRDw/sYNSC17mrbPvSfpic0A0iaSPrdxBXgxvobrn
         +WSDORMoKjHh6R5kVLVJMeoGXzqbXd8uUv9+JlGNVbtqJzEWwOKf4ZitbBgH4+9st7uF
         kQiJLyVSuteWKRV5dkVHCyzNY65+Eh9Vkw5/2T2yN8dIv2x/eTbB99UeEtNsJ4AlntJM
         strKwv/L5RTvf3+AMysqicjUHYgs9Z+CmiEi9kgSeB2NTCas/o5uJX+NVzaaBcvenXDv
         FVcQ==
X-Gm-Message-State: AOAM531MWh6bgSbgB2u/S8DKyUQbARl8jt7jD21/DUg514kUeh2mG1GP
        NPswf2k4qFcHvAJVAphXq4HaPg1YByePxA==
X-Google-Smtp-Source: ABdhPJztXK1/NW90fm35l8qL2TVoRmDEZKwpNe2ExkzTL+S00nNIaAAavOdC+zS7x9czGKH3TX8Mcw==
X-Received: by 2002:adf:e548:: with SMTP id z8mr4517433wrm.57.1628161276532;
        Thu, 05 Aug 2021 04:01:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i10sm8836641wmq.21.2021.08.05.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:01:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] progress.c API users: fix bogus counting
Date:   Thu,  5 Aug 2021 13:01:10 +0200
Message-Id: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a split-off from the larger topic these were submitted as part of
[1] and which didn't get picked up. As I pointed out in [2] that
larger topic had some hidden untested-for flaws.

But these patches are just fixes to bogus progress bar output from
that topic. Let's consider them in isolation...

Since v1 the only changes are to the commit messages, in response to
SZEDER's feedback at
https://lore.kernel.org/git/20210802210759.GD23408@szeder.dev/ and
https://lore.kernel.org/git/20210802214827.GE23408@szeder.dev/;
Hopefully this update addresses all of those outstanding comments.

1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
2. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/

SZEDER Gábor (2):
  commit-graph: fix bogus counter in "Scanning merged commits" progress
    line
  entry: show finer-grained counter in "Filtering content" progress line

Ævar Arnfjörð Bjarmason (1):
  midx: don't provide a total for QSORT() progress

 commit-graph.c | 2 +-
 entry.c        | 7 +++----
 midx.c         | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  832a6c1f78 ! 1:  bcb13be500 commit-graph: fix bogus counter in "Scanning merged commits" progress line
    @@ Commit message
         This happens because while iterating over an array the loop variable
         is passed to display_progress() as-is, but while C arrays (and thus
         the loop variable) start at 0 and end at N-1, the progress counter
    -    must end at N.  This causes the failures of the tests
    -    'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
    -    in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=1.
    +    must end at N. Fix this by passing 'i + 1' to display_progress(), like
    +    most other callsites do.
     
    -    Fix this by passing 'i + 1' to display_progress(), like most other
    -    callsites do.
    +    There's an RFC series to add a GIT_TEST_CHECK_PROGRESS=1 mode[1] which
    +    catches this issue in the 'fetch.writeCommitGraph' and
    +    'fetch.writeCommitGraph with submodules' tests in
    +    't5510-fetch.sh'. The GIT_TEST_CHECK_PROGRESS=1 mode is not part of
    +    this series, but future changes to progress.c may add it or similar
    +    assertions to catch this and similar bugs elsewhere.
    +
    +    1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
2:  3411fe0515 = 2:  8e67712c48 midx: don't provide a total for QSORT() progress
3:  f65001627a ! 3:  c70e554e46 entry: show finer-grained counter in "Filtering content" progress line
    @@ Commit message
             paths to process, then the counter shown in the "done" progress
             line will not match the expected total.
     
    -        This would cause a BUG() in an upcoming change that adds an
    -        assertion checking if the "total" at the end matches the last
    -        progress bar update..
    -
    -        This is because both use only one filter.  (The test 'delayed
    -        checkout in process filter' uses two filters but the first one
    -        does all the work, so that test already happens to succeed even
    -        with such an assertion.)
    +        The partially-RFC series to add a GIT_TEST_CHECK_PROGRESS=1
    +        mode[1] helps spot this issue. Under it the 'missing file in
    +        delayed checkout' and 'invalid file in delayed checkout' tests in
    +        't0021-conversion.sh' fail, because both use only one
    +        filter.  (The test 'delayed checkout in process filter' uses two
    +        filters but the first one does all the work, so that test already
    +        happens to succeed even with GIT_TEST_CHECK_PROGRESS=1.)
     
           - The progress counter is updated only once per filter, not once per
             processed path, so if a filter has a lot of paths to process, then
    @@ Commit message
         path.
     
         After this change the 'invalid file in delayed checkout' in
    -    't0021-conversion.sh' would succeed with the future BUG() assertion
    -    discussed above but the 'missing file in delayed checkout' test would
    -    still fail, because its purposefully buggy filter doesn't process any
    -    paths, so we won't execute that inner loop at all (this will be fixed
    -    in a subsequent commit).
    +    't0021-conversion.sh' would succeed with the GIT_TEST_CHECK_PROGRESS=1
    +    assertion discussed above, but the 'missing file in delayed checkout'
    +    test would still fail.
    +
    +    It'll fail because its purposefully buggy filter doesn't process any
    +    paths, so we won't execute that inner loop at all, see [2] for how to
    +    spot that issue without GIT_TEST_CHECK_PROGRESS=1. It's not
    +    straightforward to fix it with the current progress.c library (see [3]
    +    for an attempt), so let's leave it for now.
    +
    +    1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
    +    2. http://lore.kernel.org/git/20210802214827.GE23408@szeder.dev
    +    3. https://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

