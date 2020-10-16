Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB94C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA03720EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwtdvuC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411023AbgJPT25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408018AbgJPT24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:28:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC6C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:28:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q5so4176099wmq.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5MAjbbNl89UU4kONfbdHe1YQZzgvG9SOsxJaPYx+1hw=;
        b=KwtdvuC/4Aa2n/0McokNcsCuxgER6nU1tfYjAFn0OXTzSHWO2b276TFiXpkPwbaO1v
         E7AKTUnharymW+WtSKegXAgTO+4c3U7+XlUARwVTL68zc1OIHT7urXOqf92cU8pydeCJ
         NheRjyk+JwT0EvPuBg5elgwkvF3JIhepOkQZlEo5sOWt+nR1uKyA6ou8xeICjxx1XMS0
         wE/QZOkZB/rur4bsUR5kYpAq4Wck3oeM9fmnoUxtrwviAzQgqjy0jf8coidUPpXu/YGg
         BteF8EkWDg65zQdlHMWmolARnAg9jlNK315yoF2vaXCfgwUiWuSfJ6Y0rJ31nSEYQS+r
         E2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5MAjbbNl89UU4kONfbdHe1YQZzgvG9SOsxJaPYx+1hw=;
        b=Sk1rwisdqzkqTSXG5UbaFicNam+5rn7wYebUAZC0MYoDxx7FNUj2SQxe4rb++VRM0z
         /0REW6tdPxxOdYFYfmw88xdeNFOXxV44MUpQJTP2GS9tZp4+epcS/C8qaoE9Pnttp+5U
         AIykKliXh83myArF22OWKmHNt9U0aA2logVyaQsv4UMTmItBY3F43FZWON53Sl+57i3Z
         OBYi38zrYwg2JHZjz/4yUVXCjTHTcdOiudRanGns1USUG5GVr3PpnpZ9j8RhRQJRA8qp
         6UlwLCJFEyLy5nnlAsiXtoXKoVLTU1WFee353FdajCB6Z7PxcQXL0sb5kU9zmatvdRin
         XoyQ==
X-Gm-Message-State: AOAM5336fIXPve8wfcjXC7po76b6dkyZOPtEg9KuuzIXwAb2xG8Kz/8V
        M+PrYTUB46gv0jUtpnz77Sg/vvawjS8=
X-Google-Smtp-Source: ABdhPJygaZ3zoGwgvYnLJST/MSMV1zsoBPOE3uq0nSBd+R3mawFQm5YhXBflUBIYybCD9tdju/MuHg==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr5197554wmh.156.1602876533508;
        Fri, 16 Oct 2020 12:28:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm4663825wrm.69.2020.10.16.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:28:52 -0700 (PDT)
Message-Id: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
References: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 19:28:49 +0000
Subject: [PATCH v4 0/3] Make test selection easier by specifying description substrings instead of
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

Changes since v3:

 * Added text to the README explaining what to do if the substring you want
   to search on includes a comma or whitespace (namely, use the '?' glob
   character instead)

Elijah Newren (3):
  test-lib: allow selecting tests by substring/glob with --run
  t6006, t6012: adjust tests to use 'setup' instead of synonyms
  test-lib: reduce verbosity of skipped tests

 t/README                     | 37 +++++++++++++++++++++++---------
 t/t0000-basic.sh             | 41 ++++++++++++++++++++++--------------
 t/t6006-rev-list-format.sh   |  2 +-
 t/t6012-rev-list-simplify.sh |  2 +-
 t/test-lib.sh                | 17 +++++++++------
 5 files changed, 64 insertions(+), 35 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v4
Pull-Request: https://github.com/git/git/pull/878

Range-diff vs v3:

 1:  9c8b6a1a94 ! 1:  8f5d4ad318 test-lib: allow selecting tests by substring/glob with --run
     @@ t/README: For an individual test suite --run could be used to specify that
      +numbers separated with a dash and matches a range of tests with both
      +ends been included.  You may omit the first or the second number to
      +mean "from the first test" or "up to the very last test" respectively.
     ++
     ++The argument to --run is split on commas and whitespace into separate
     ++strings, numbers, and ranges, and picks all tests that match any of
     ++the individual selection criteria.  If the substring of the
     ++description text that you want to match includes a comma or space, use
     ++the glob character '?' instead.  For example --run='unnecessary?update
     ++timing' would match on all tests that match either the glob
     ++*unnecessary?update* or the glob *timing*.
       
       If --run starts with an unprefixed number or range the initial
       set of tests to run is empty. If the first item starts with '!'
 2:  6479d73603 = 2:  bbae029cc8 t6006, t6012: adjust tests to use 'setup' instead of synonyms
 3:  24f6febde6 = 3:  0e1a1125f7 test-lib: reduce verbosity of skipped tests

-- 
gitgitgadget
