Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24377C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75D120878
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+l3emrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439988AbgJRAXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439985AbgJRAXv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 20:23:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A32C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:23:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g12so7444522wrp.10
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r2w4esXpzD/gw/byvlgWZvdDMZnivIZQQWAC5MFfd78=;
        b=u+l3emrhMVJB2uUWcXs2aeicVP0Ckva3/bDAxgWspSVe8fjPR9DfslU8wG/K+XQ+lf
         /i5KD2qgD+l3K6LrHtnIubbYeSA/RBxNdJprJfOm2fAqpoOBu3hyz02ehRqZMZqA3k7P
         SfX8zGK4MVhpk0FaRK5Nb4p+eaDtZTG2OEPD8BihAa5M2mqaepMogFT86Imta4Fozfhe
         1Da7H4jEJEb27JkHorlHT7UspUJqqnAQxofeENtxuDuLNkRb46cnG295ar9b2zgwdqUr
         2zbARkPJYjEdX9tGIP6Ljna5iunF86Ft3LFH49I5fvxjvtvaeHxI6iAayW3eGLkJxRN2
         /DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r2w4esXpzD/gw/byvlgWZvdDMZnivIZQQWAC5MFfd78=;
        b=PTwQ+weGWzLvmIH8Cf0MyP5aqRrtfysrTpVDpoyiKaYPt6sQsqzAQEDIy7QBV6xtWZ
         O5r/cQX70ehcs3y84bSiXgHfLRHFdfKTSB89oKNU8khYhMaHF/TZGJ2j4iPRU20qDiyc
         JUoVuSjZ0JD4s1JmWwwybcua1vGcrCrBqElGWsLbAVlV5rUQeEAS1iiV0ez+roVAPZP9
         UzHVybPcvB5Snk+zi9MyuVLgpyEARezNgYinwnP82GIfs8mehe9g11yM9vmv7rb1j2id
         qqKjX+CCA0apiYHJXWyC+gWn4W47NL4cRw2ga4UOg0sYVV2Hj/ZW2poV0hMXaZaH/XNS
         ulcw==
X-Gm-Message-State: AOAM533jq1qOdoMTk8t1KpmfFxrEjowjG/k/RexJKHSTSuWxcAD9Hhz+
        jN6hbq4O/NmOGbNykt+rAzQVvMXKZ3c=
X-Google-Smtp-Source: ABdhPJzGCy38f40O2m4AuMz1jtOjEpFuixd9PXi8RRt2UCiv4C7jpBRs7tS4f2Xm8MKC3kn1SAsIZA==
X-Received: by 2002:a05:6000:8e:: with SMTP id m14mr12155151wrx.400.1602980629485;
        Sat, 17 Oct 2020 17:23:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm11061373wrn.62.2020.10.17.17.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 17:23:48 -0700 (PDT)
Message-Id: <pull.878.v6.git.git.1602980628.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
References: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Oct 2020 00:23:44 +0000
Subject: [PATCH v6 0/3] Make test selection easier by specifying description substrings instead of
 just numeric counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables me to change

 ./t9999-my-test.sh --run=1-3,5,17,19

into

 ./t9999-my-test.sh --run=setup,rename,symlink

and have it pick out tests with "setup", "rename", or "symlink" in their
description and run those. Saves me a lot of time, especially since numbers
for tests aren't readily accessible. The easiest way for me to get the
numbers corresponding to the tests I want to run, is to run all the tests
and look at the output to match up the descriptions with their numbers --
thus defeating the point of selecting just a subset of the tests to run in
the first place.

Changes since v5:

 * Update comment to match the code (selectors are now only split on commas,
   not on whitespace)

Elijah Newren (3):
  test-lib: allow selecting tests by substring/glob with --run
  t6006, t6012: adjust tests to use 'setup' instead of synonyms
  test-lib: reduce verbosity of skipped tests

 t/README                     | 48 ++++++++++++++++++++------------
 t/t0000-basic.sh             | 53 +++++++++++++++++++++---------------
 t/t6006-rev-list-format.sh   |  2 +-
 t/t6012-rev-list-simplify.sh |  2 +-
 t/test-lib.sh                | 21 ++++++++------
 5 files changed, 76 insertions(+), 50 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v6
Pull-Request: https://github.com/git/git/pull/878

Range-diff vs v5:

 1:  389c2c171a ! 1:  0355c88882 test-lib: allow selecting tests by substring/glob with --run
     @@ t/test-lib.sh: match_pattern_list () {
       	title="$1"
       	shift
       	arg="$1"
     -@@ t/test-lib.sh: match_test_selector_list () {
     + 	shift
     + 	test -z "$1" && return 0
       
     - 	# Both commas and whitespace are accepted as separators.
     +-	# Both commas and whitespace are accepted as separators.
     ++	# Commas are accepted as separators.
       	OLDIFS=$IFS
      -	IFS=' 	,'
      +	IFS=','
 2:  7c7a3d9a34 = 2:  3cc9abf461 t6006, t6012: adjust tests to use 'setup' instead of synonyms
 3:  01494bc0ba = 3:  0af7835487 test-lib: reduce verbosity of skipped tests

-- 
gitgitgadget
