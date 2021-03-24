Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61FC433E4
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE60619EE
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhCXBtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhCXBtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D999C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so285497wmy.5
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJBfD/Q4htj8g5qUfNeQUNNHyWWK2Otu/dnEBccdKbo=;
        b=TgjqPCg6AzmD7B/DQvND1kQxdui/Yrqag7KlAsQbnF/9/r2lDnbFx2G30HbbmRfgJe
         jMUUIJJDDbNEM7JVugNPOmH8JQSXZp45o+Bb0b2Cd1TmTENow40zIIOMJAVWTfd/ik+F
         fcgg6TE50HEbPjTPkrvvNnyISU3nzDhTMvGvEmitn5tASCXB9TBL69IKidtGjlJ1WZdh
         1yYGlqZMeKBU8wI0/rCIc4xd5u2vEPTZ2ciJPqo0/HhrQryCOdgFVtjZxJmIlOzEGsLo
         1hh/82+GZNLyXKTnqxDjmGf0jX0Awavb7UaUMTh7uiR96gh0MlPgYOKjKiuB/pKewcl1
         BiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJBfD/Q4htj8g5qUfNeQUNNHyWWK2Otu/dnEBccdKbo=;
        b=B9/+aRBs73KRhbEfiHr0YVxAXp/F39VqbpDpqucwqjsqmRd6rbq+orDwnl9af71zBa
         3zeUHpttoXg0QsD+629BzLhBTcElaOGad+yzjjTb+thoC/W1sLq42H7l21Q1whs8mDfU
         REunpujEw+0NxnkzpN5zSjUhAWQQeGckagbMwHmk4K/lOAUlDUXpLGqPpywzRK61AwbW
         NjQGe3RgRehszsSsBotv8K7mDlKSNkvyx68tIuZpX0bVhYslJTRfI6Qtlw8Njk9qICBK
         Bbmf2Mt7nMlbffDxBCXcpWZM0lJNiLtBX8H5o8e/Fdiuz2Fjkb/BIYM/scoa05OSOVn9
         G6aA==
X-Gm-Message-State: AOAM531f3I8FPfLplZ3z4CvnufjZO9umho1poSPmInHRjbklLbgd3yjw
        a5DC7TXLLbvDHESihtW5LNveY+hTZ+F0Hw==
X-Google-Smtp-Source: ABdhPJw27lARHG965oCWTyEj7j5zoc92JpywMQ3B4diZO9hRmbqsKFTeqsPF1JYPKC+wgo6uUSUpAw==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr595686wmb.84.1616550554307;
        Tue, 23 Mar 2021 18:49:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/10] userdiff: refactor + test improvements
Date:   Wed, 24 Mar 2021 02:48:42 +0100
Message-Id: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <20210224195129.4004-1-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a restart of the 35-patch v3 of this topic at
https://lore.kernel.org/git/20210224195129.4004-1-avarab@gmail.com/

I still plan on submitting the rest of it, but wanted to start with
the early parts of that series that hasn't been controversial or has
outstanding feedback I haven't addressed.

The range-diff to v3 is just for those patches I'm re-rolling here.

Ævar Arnfjörð Bjarmason (10):
  userdiff: refactor away the parse_bool() function
  userdiff style: re-order drivers in alphabetical order
  userdiff style: declare patterns with consistent style
  userdiff style: normalize pascal regex declaration
  userdiff: add and use for_each_userdiff_driver()
  userdiff tests: explicitly test "default" pattern
  userdiff tests: list builtin drivers via test-tool
  userdiff: remove support for "broken" tests
  blame tests: don't rely on t/t4018/ directory
  blame tests: simplify userdiff driver test

 Makefile                 |   1 +
 t/annotate-tests.sh      |  34 ++++----
 t/helper/test-tool.c     |   1 +
 t/helper/test-tool.h     |   1 +
 t/helper/test-userdiff.c |  31 +++++++
 t/t4018-diff-funcname.sh |  39 ++-------
 t/t4018/README           |   3 -
 userdiff.c               | 178 ++++++++++++++++++++++++---------------
 userdiff.h               |  15 ++++
 9 files changed, 186 insertions(+), 117 deletions(-)
 create mode 100644 t/helper/test-userdiff.c

Range-diff:
 1:  0be132b05e2 =  1:  fb7346cd296 userdiff: refactor away the parse_bool() function
 2:  d1e00a739ac =  2:  149387155bc userdiff style: re-order drivers in alphabetical order
 3:  b99bd158d45 =  3:  faf1a824f05 userdiff style: declare patterns with consistent style
 4:  9ce6d47021c =  4:  1e9ddcd1a9a userdiff style: normalize pascal regex declaration
 5:  369fbdcee83 =  5:  64ea5e8443f userdiff: add and use for_each_userdiff_driver()
 6:  70d62a97211 =  6:  862f6ab5d66 userdiff tests: explicitly test "default" pattern
 7:  792421a2f8b =  7:  22a07591b76 userdiff tests: list builtin drivers via test-tool
 8:  9081e2a152e !  8:  7755db95014 userdiff: remove support for "broken" tests
    @@ Commit message
     
         There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
         Fortran xfuncname regex, 2020-08-12). Let's remove the test support
    -    for them, this is in preparation for a more general refactoring of the
    -    tests.
    +    for them.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 9:  d3652f95d5e !  9:  4e0b4b42e16 blame tests: don't rely on t/t4018/ directory
    @@ Commit message
         with userdiff driver, 2020-11-01) so that the blame tests don't rely
         on stealing the contents of "t/t4018/fortran-external-function".
     
    -    I'm about to change that file in a subsequent commit. Just moving the
    -    relevant test file here inline is the easiest solution, and I think
    -    also the most readable.
    +    I have another patch series that'll possibly (or not) refactor that
    +    file, but having this test inter-dependency makes things simple in any
    +    case by making this test more readable.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
10:  35d12779ea1 ! 10:  ce98c61bf40 blame tests: simplify userdiff driver test
    @@ Commit message
         test_commit, 2021-01-12).
     
         We also did not need the full fortran-external-function content. Let's
    -    cut it down to just the important parts, and further modify it to
    -    demonstrate that the fortran-specific userdiff function is in effect
    -    by adding "DO NOT MATCH ..." and "AS THE ..." lines surrounding the
    -    "RIGHT" one. This is to check that we're using the userdiff "fortran"
    -    driver, as opposed to the default driver.
    +    cut it down to just the important parts.
     
    -    The test also left behind a .gitattributes files, let's clean it up
    -    with "test_when_finished".
    +    I'm modifying it to demonstrate that the fortran-specific userdiff
    +    function is in effect by adding "DO NOT MATCH ..." and "AS THE ..."
    +    lines surrounding the "RIGHT" one.
    +
    +    This is to check that we're using the userdiff "fortran" driver, as
    +    opposed to the default driver which would match on those lines as part
    +    of the general heuristic of matching a line that doesn't begin with
    +    whitespace.
    +
    +    The test had also been leaving behind a .gitattributes file for later
    +    tests to possibly trip over, let's clean it up with
    +    "test_when_finished".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.31.0.366.ga80606b22c1

