Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE4EC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2AE20EDD
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwrUmpG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgJMTTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJMTTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:19:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE470C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:19:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q5so926943wmq.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YyCIS8vIG7m31N87xRViZLlkCPdpNXznA0XKuGpEy04=;
        b=gwrUmpG+lwKkEcoaTStU0FxJ2dCCLz6dz2xIs5P1Mr6s1yT90nSJXfRbTOvuHRG1ro
         fV8wHACtJ8UJSGSvV+2veqWT1IjdL/46SXTbLtfsyzmcMcE6AS+8BjoNGgGV/9Wh2lGA
         EipYZfwswYahHS2lfVGJQ599X57XHcz/QB0B5bkZyBN3b4RLLQhbZv75Th9Z5Fo+buR3
         4WJdRFWUY8+80dJWP9G+Amr4g6ozn8SAUFGJcRR+K0eBSaYb7QB4uM8yHHZc+L1jnV0R
         P0xwNSk18dMZauQuR3i3HeInoqScI50hncchrNSRfxgWFsmemM+cjHT5GoqrVNGRs6oF
         nSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YyCIS8vIG7m31N87xRViZLlkCPdpNXznA0XKuGpEy04=;
        b=OsAxZpIzoX0iWCldxnVgeAPazcfwZEiFcyWSjDMoYN877ex4JM5Nmk0VYZ+WUbuwjg
         FvBXC9E+rS8EQgh/i9L9U6bOSQP1QrYFAmbgvsJoOw4EPiAKZzFf9RsQy7lKwmey6pSG
         oMXGqgtGYGpw+kKgk/5UHAn6DHaDfwSi6f2aEaL5Bk2wVBenqSGpoUAhk4VWNRMFLYKA
         NqfmF8GvKIcZBHj36mo6/o1qw2u9nuuvjhD2ndhZKWy3A0qJABWwt1BH8TL7QSXcVpbt
         0pHsFiY5Q/2knJSQDi8d1lfHcjERdPovdE7CWuJBQDIK2Qu23M5RzYZWL5pL4mgeOjto
         OgFw==
X-Gm-Message-State: AOAM530OvZEgYceIcVJkSNfx+3Wwo1KDfeAv6oxescrFJVWuWb745zfk
        +8lUcI7Ihad16Fp42mgNp/KnxYLjP4g=
X-Google-Smtp-Source: ABdhPJyI610YIzI+G4hlU50WxSkoBgXS0QgAwyjM8ApyMIbR2lc+ydksHbbmq+M587Df+riHUdTz4g==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr1228724wmc.184.1602616788182;
        Tue, 13 Oct 2020 12:19:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a127sm939388wmh.13.2020.10.13.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:19:47 -0700 (PDT)
Message-Id: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 19:19:43 +0000
Subject: [PATCH v2 0/3] Make test selection easier by specifying description substrings instead of
 just numeric counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
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

Changes since v1:

 * Modified the documentation slightly to combine a separate sentence into
   the previous paragraph and avoid confusion around whether negation
   applies to substring selections (pointed out by Taylor)
 * Simplified the output for skipped tests even further, as suggested by
   Taylor.

Elijah Newren (3):
  test-lib: allow selecting tests by substring/regex with --run
  t6006, t6012: adjust tests to use 'setup' instead of synonyms
  test-lib: reduce verbosity of skipped tests

 t/README                     | 29 ++++++++++++++++---------
 t/t0000-basic.sh             | 41 ++++++++++++++++++++++--------------
 t/t6006-rev-list-format.sh   |  2 +-
 t/t6012-rev-list-simplify.sh |  2 +-
 t/test-lib.sh                | 14 ++++++------
 5 files changed, 53 insertions(+), 35 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v2
Pull-Request: https://github.com/git/git/pull/878

Range-diff vs v1:

 1:  46fce3a844 ! 1:  41e2528e83 test-lib: allow selecting tests by substring/regex with --run
     @@ t/README: For an individual test suite --run could be used to specify that
      -been included.  You may omit the first or the second number to
      -mean "from the first test" or "up to the very last test"
      -respectively.
     +-
     +-Optional prefix of '!' means that the test or a range of tests
     +-should be excluded from the run.
      +The argument for --run, <test-selector>, is a list of description
      +substrings or regexes or individual test numbers or ranges with an
     -+optional negation prefix that define what tests in a test suite to
     -+include in the run.  A range is two numbers separated with a dash and
     -+matches a range of tests with both ends been included.  You may omit
     -+the first or the second number to mean "from the first test" or "up to
     -+the very last test" respectively.
     ++optional negation prefix (of '!') that define what tests in a test
     ++suite to include (or exclude, if negated) in the run.  A range is two
     ++numbers separated with a dash and matches a range of tests with both
     ++ends been included.  You may omit the first or the second number to
     ++mean "from the first test" or "up to the very last test" respectively.
       
     - Optional prefix of '!' means that the test or a range of tests
     - should be excluded from the run.
     + If --run starts with an unprefixed number or range the initial
     + set of tests to run is empty. If the first item starts with '!'
      @@ t/README: test in the test suite except from 7 up to 11:
       
           $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
 2:  d1d73400e8 = 2:  8f1a4420f4 t6006, t6012: adjust tests to use 'setup' instead of synonyms
 3:  bb2317972a ! 3:  85a4ca164a test-lib: reduce verbosity of skipped tests
     @@ t/test-lib.sh: test_skip () {
       		fi
       
      -		say_color skip >&3 "skipping test: $@"
     -+		say_color skip >&3 "skipping test: $1"
       		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
       		: true
       		;;

-- 
gitgitgadget
