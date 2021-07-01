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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C1C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A3261461
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhGADsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B647C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso3467832wme.0
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=T33dRsIIzpJZqn/Sm6YCeJMy2Wrq9H2mNrXW4jBhvVs=;
        b=g9Tve7xkkznQvCsy9/U/wUX5Kp96vU546y8EtYKzntesgRpjamH04Z1yEsvHxGKrsO
         JhsVYvV5QFky/lVBt9Uv1vxAm5LjpckToDPPzmaETzt2yWjRILFlS/3siyW32C40x/rC
         7L7sln+v8uQCOl1TQ2qJf87dG3Lf76nDYNJuOyx/GV4E9KitOlkxnW5pXk0rIrgcOw3T
         qHK90JMa1kXszq2rW+iyfMUZspmHIM+oJfmS0T6MCBDPdvpIGIRsihFssEFecdsO7d3h
         GffTWetILszRkHKt03MhQ1us0dbkW+1mcyst4fAXvCASgQpd3Ce5EtmoU0CcDZ0CwPNa
         B/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=T33dRsIIzpJZqn/Sm6YCeJMy2Wrq9H2mNrXW4jBhvVs=;
        b=sIFEYORGbdQG60RemyQiY4y/W67W59gP5A8wJrmex+KXc8c2H6D/csyD3J3r7nUgTM
         uACO9IkA+QGf/1LEcsOsdt25e5y2lqJ9mXRiaPtk1YLpYG1cjmxW8etI/H3SCzVefvld
         9zSjIrTOBouUqNr8/4ezytGXF6I8nhYHeRhBofeWB+xuXDqTiv9gkYs1MOU3GzoFEUEC
         Hodc2vCaKT95FxbIn7nh16MqUhAXEExVTks4nZGfGs74eJNQlLsbaMgmuFAuaLkVQDs4
         GtkIG5iGFNKQ/YmH/JeT1gzszD1QNES+mrU9ilYDHy0OtJn26LBPwBz8VUakgStsd3Nm
         5mlw==
X-Gm-Message-State: AOAM532oMzhFD4YvEXBDKnK43djqXafltfOFg2l+UH8bJRsY9TriTFFa
        jTvoK2sfBGJN9GSmWvu9GL/xLbW5m48=
X-Google-Smtp-Source: ABdhPJxTms64e8PjhZYcmH9FoH7xAe4IbTGow+T4pSYDgtFE8lBh6C/lGnphLCHwOIbQAW/qIkHlKA==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr8336104wme.45.1625111178838;
        Wed, 30 Jun 2021 20:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm8526006wmq.0.2021.06.30.20.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:18 -0700 (PDT)
Message-Id: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:10 +0000
Subject: [PATCH 0/7] Optimization batch 14: trivial directory resolution
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
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
performance results we started with were:

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

 merge-ort.c                         | 403 +++++++++++++++++++++++++++-
 t/t6423-merge-rename-directories.sh |   2 +-
 2 files changed, 393 insertions(+), 12 deletions(-)


base-commit: 2eeee12b02e441ac05054a5a5ecbcea6964a1e6b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-988%2Fnewren%2Fort-perf-batch-14-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-988/newren/ort-perf-batch-14-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/988
-- 
gitgitgadget
