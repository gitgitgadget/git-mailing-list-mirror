Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBEFC43467
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD31B22257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ibxrxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbgJOB7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbgJOB7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE97C0613E9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s9so657464wro.8
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aTtd8VKSYihQkRziiuPnswcAjCf43+c80hW5mkse1bw=;
        b=K1ibxrxRPUgiM5oduv0BJEtX9pfaSaGCoa69f0nzIm+m56Np+UugpMdfexLVJ7bsbY
         uVMeSFMvMD1RJ0ptUH9ape+HVxruxDCm3LbLPwhuclF/XF3XPG967kV6Wvk35r+pW/2V
         wnCr9gZ0Vf1Pksnl83J0OsUNbe6+23234xQ58ve3xD2SoPq1IXF59t998l9mbanvnNW/
         X74BdJnAhh331ALg7+yk/hpVPxjiviMbfutYvPXylm1yfpA1RXNmTPuvTZt7qojfB9M9
         WEQZJ1CceZ6/AFlJRh0Ma/OAjQyigr9r17jy3uo5kgucin+yXXSZYKv5ImXftOvBmvTw
         SiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aTtd8VKSYihQkRziiuPnswcAjCf43+c80hW5mkse1bw=;
        b=HuIyfK/SN03+FHYZ/l71Sg8lSMTWedjFApnvk35SjR9TzGOSRS6dadqfj86xSCZB5N
         lvrPso4VelrT5Hn5qfaUBobC8imbmL1w4H52uf8LGPgQRTSSVQE8QGNgghkEpI8onclD
         /4JHG9oq6Icg2XU10sL5pEUYQapH4P5aOhlgh+CixE2D1hebXXdSYB35EakH55YkWv4A
         8JJPFXB2P3suaTWpwUdxTO1mW24UGBlrkiTeXtmUjP24WEBxxI6C5XpExedIiM3NsZV/
         6DO8khSZ4cIcbZbYlXawrViVQE2bVL33Dm+hJ2bGWL5Eo/ZgJHac6tV6EZSEDsnIjqhZ
         iP4A==
X-Gm-Message-State: AOAM532I/1KHvGqhTtvxE+irnweAqkeF4l3o91dMGxnPojrlVjgcuUGY
        589MpEXQc5VVnQWLsHIkVbyopGSdQeI=
X-Google-Smtp-Source: ABdhPJzAb5quI4Bi6Wzvflyr+JyhsJ4axyAPAcYLWTj4zEOj7B/7RpyEiLdzDi3Di4+Q2p5nk46b4g==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr676499wrr.304.1602710026468;
        Wed, 14 Oct 2020 14:13:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm859419wrt.53.2020.10.14.14.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:13:45 -0700 (PDT)
Message-Id: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Oct 2020 21:13:42 +0000
Subject: [PATCH v3 0/3] Make test selection easier by specifying description substrings instead of
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

Changes since v2:

 * Use a glob rather than a regex for selecting tests
 * Touched up the commit message in patch 3 to mention that the TAP output
   line is still included for skipped tests and already included the word
   "skip" to highlight the fact that the test was skipped.
 * Fixed a bug where -run="!rename" would run all tests instead of skipping
   the ones with 'rename' in the description

Elijah Newren (3):
  test-lib: allow selecting tests by substring/glob with --run
  t6006, t6012: adjust tests to use 'setup' instead of synonyms
  test-lib: reduce verbosity of skipped tests

 t/README                     | 29 ++++++++++++++++---------
 t/t0000-basic.sh             | 41 ++++++++++++++++++++++--------------
 t/t6006-rev-list-format.sh   |  2 +-
 t/t6012-rev-list-simplify.sh |  2 +-
 t/test-lib.sh                | 17 +++++++++------
 5 files changed, 56 insertions(+), 35 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v3
Pull-Request: https://github.com/git/git/pull/878

Range-diff vs v2:

 1:  41e2528e83 ! 1:  9c8b6a1a94 test-lib: allow selecting tests by substring/regex with --run
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    test-lib: allow selecting tests by substring/regex with --run
     +    test-lib: allow selecting tests by substring/glob with --run
      
          Many of our test scripts have several "setup" tests.  It's a lot easier
          to say
     @@ t/README: For an individual test suite --run could be used to specify that
      -Optional prefix of '!' means that the test or a range of tests
      -should be excluded from the run.
      +The argument for --run, <test-selector>, is a list of description
     -+substrings or regexes or individual test numbers or ranges with an
     ++substrings or globs or individual test numbers or ranges with an
      +optional negation prefix (of '!') that define what tests in a test
      +suite to include (or exclude, if negated) in the run.  A range is two
      +numbers separated with a dash and matches a range of tests with both
     @@ t/README: test in the test suite except from 7 up to 11:
       
      +Sometimes there may be multiple tests with e.g. "setup" in their name
      +that are needed and rather than figuring out the number for all of them
     -+we can just use "setup" as a substring/regex to match against the test
     ++we can just use "setup" as a substring/glob to match against the test
      +description:
      +
      +    $ sh ./t0050-filesystem.sh --run=setup,9-11
     @@ t/test-lib.sh: match_test_selector_list () {
      -					echo "error: $title: invalid non-numeric in test" \
      -						"selector: '$orig_selector'" >&2
      -					exit 1
     -+					echo "$title" | grep -q "$selector" && return
     ++					case "$title" in *${selector}*)
     ++						include=$positive
     ++						;;
     ++					esac
      +					continue
       				fi
       		esac
 2:  8f1a4420f4 = 2:  6479d73603 t6006, t6012: adjust tests to use 'setup' instead of synonyms
 3:  85a4ca164a ! 3:  24f6febde6 test-lib: reduce verbosity of skipped tests
     @@ Commit message
          When using the --run flag to run just two or three tests from a test
          file which contains several dozen tests, having every skipped test print
          out dozens of lines of output for the test code for that skipped test
     -    adds up to hundreds or thousands of lines of irrelevant output that make
     -    it very hard to fish out the relevant results you were looking for.
     -    Simplify the output for skipped tests down to just showing the one-line
     -    descriptions.
     +    (in addition to the TAP output line) adds up to hundreds or thousands of
     +    lines of irrelevant output that make it very hard to fish out the
     +    relevant results you were looking for.  Simplify the output for skipped
     +    tests to remove this extra output, leaving only the TAP output line
     +    (i.e. the line reading "ok <number> # skip <test-description>", which
     +    already mentions that the test was "skip"ped).
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      

-- 
gitgitgadget
