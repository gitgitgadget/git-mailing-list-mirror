Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD75C43219
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301F160F6B
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhISIFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhISIFY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:05:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0576C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:03:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a194-20020a1c98cb000000b0030b41ac389fso5109770wme.2
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1s3fh47EvG5r7BkUmAAkocbvCYH6beRZIOp6ZGk7Ho=;
        b=IfZ0/nZGm6Yib0bZwVBmCySJMFiUFQ5YqEa+iSZfSCNNd7/wRbK9lG94NNaI1uDk6z
         lYIE0bxbmBYQuRp7RzRxEBbGvsGObR8jYQd2/1YBjDZk0WHtpnLmiannhXWvNjvCQKoB
         XPXg3FecaRzb7VPB1raPjbw94Djfm9btTWO3qiRqtwGk/S0e7036ofrFIfY3Wai9/KDJ
         uuX/frZ4ARKVvq9r7++RcTweQyYejOI3vFNsBlVtXjuW7h4aCRUfHU/VIozmg0yqg7s0
         MGT5nrAXDpSjyaZzZdr17E/3MyPHcUXs0PRYnWZDx8TaDDNFUoSbTex9+v4XwsNQ1H5G
         eR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1s3fh47EvG5r7BkUmAAkocbvCYH6beRZIOp6ZGk7Ho=;
        b=nu6dn0e4wkNaJJzEbRWLoMguslx78dhkXO8mJZ6dJOAsWFRRHyIRSvtxliqrdX7HRs
         aisgjfkM0zE0CP0zslhM8lXi53ZFzwA6pG+F7T26ZhqzY9bHiR1fhuOg7mieF4CecRvJ
         9Ka3wW4VePeLCEghEio69gYKVoQ2CYvh10muOeNPydrbcphBnQ2JC5zpUXFJ2ObfPh3B
         1URgcXx9EDwqPInLgY5Uwt6YonvKy9hB3+rg6Sr5clbk58ZEfkE+aK1+JLmh/jvSTstw
         YSSXiu/8Z1XvmsREsScAsaGJrJiuT3KqYczeGN8YHoJy6EU2EjdK9tayQymIOVYqsYHQ
         hXlA==
X-Gm-Message-State: AOAM532zuad1hf+W80c5XVIg/vYIg3xiF6V241A8o1DkfEX4Bs82RvC/
        YUA7zhqxyfxJGd0BsD5vV8UBHH1cee8=
X-Google-Smtp-Source: ABdhPJz5sojTupoUpEHKazY2DwnFfcRPDEabrz/qgmKg17e2LSVh3HVyZslltgyt+L9r4dj7pLL/uw==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr18295798wmf.58.1632038638222;
        Sun, 19 Sep 2021 01:03:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm14887692wmc.24.2021.09.19.01.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:03:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/2] add a test mode for SANITIZE=leak, run it in CI
Date:   Sun, 19 Sep 2021 10:03:52 +0200
Message-Id: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com>
References: <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a small beachhead of tests we run in CI that we
assert to be memory-leak free with the SANITIZE=leak test mode. Once
it lands the intent is to expand the parts of the test suite we
whitelist as memory-leak free.

This v7 of the "test with SANITIZE=leak in CI" topic should be ready
for merging down. The v6 got marked as "Will merge to 'next'?", but as
Carlo points out[1] there were concurrent regresisons in
t0000-basic.sh that caused the tests to faile. There's proposed fixes
to those[2] as well as Carlo's own series to fix other issues with
it[3].

All of those are worth doing, but the reason I picked t0000-basic.sh
was that it would hopefully stay leak free through the
seen->next->master cycle.

Let's not pick that one, but instead a few of the very small and basic
tests in t00*.sh.

These all run cleanly on top of master, and also when merged with next
and seen (except for the semantic "seen" failure due to merging with
v6 of this topic, and therefore t0000-basic.sh being run in the test
mode).

For v6 of this topic see:
https://lore.kernel.org/git/cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com

1. https://lore.kernel.org/git/CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEWH4AcU7Q@mail.gmail.com/
2. https://lore.kernel.org/git/pull.1092.git.git.1631972978.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/20210916023706.55760-1-carenas@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
  tests: add a test mode for SANITIZE=leak, run it in CI

 .github/workflows/main.yml |  3 +++
 Makefile                   |  5 +++++
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  |  9 ++++++++-
 ci/run-build-and-tests.sh  |  2 +-
 t/README                   |  7 +++++++
 t/t0004-unwritable.sh      |  3 ++-
 t/t0011-hashmap.sh         |  2 ++
 t/t0016-oidmap.sh          |  2 ++
 t/t0017-env-helper.sh      |  1 +
 t/t0018-advice.sh          |  1 +
 t/t0030-stripspace.sh      |  1 +
 t/t0063-string-list.sh     |  1 +
 t/t0091-bugreport.sh       |  1 +
 t/test-lib.sh              | 21 +++++++++++++++++++++
 15 files changed, 57 insertions(+), 4 deletions(-)

Range-diff against v6:
1:  fc7ba4cb1c3 = 1:  fc7ba4cb1c3 Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
2:  8dcb1269881 ! 2:  56592952db5 tests: add a test mode for SANITIZE=leak, run it in CI
    @@ Commit message
         regression tests under that mode. Memory leaks have only been fixed as
         one-offs without structured regression testing.
     
    -    This change adds CI testing for it. We'll now build and test
    -    t000[04]*.sh under Linux with a new job called "linux-leaks".
    +    This change adds CI testing for it. We'll now build and small set of
    +    whitelisted t00*.sh tests under Linux with a new job called
    +    "linux-leaks".
     
         The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
         mode. When running in that mode, we'll assert that we were compiled
    @@ t/README: excluded as so much relies on it, but this might change in the future.
      default to n.
      
     
    - ## t/t0000-basic.sh ##
    -@@ t/t0000-basic.sh: swapping compression and hashing order, the person who is making the
    - modification *should* take notice and update the test vectors here.
    - '
    + ## t/t0004-unwritable.sh ##
    +@@
    + 
    + test_description='detect unwritable repository and fail correctly'
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - try_local_xy () {
    + test_expect_success setup '
     
    - ## t/t0004-unwritable.sh ##
    + ## t/t0011-hashmap.sh ##
     @@
    + #!/bin/sh
      
    - test_description='detect unwritable repository and fail correctly'
    + test_description='test hashmap and string hash functions'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_hashmap() {
    +
    + ## t/t0016-oidmap.sh ##
    +@@
    + #!/bin/sh
      
    + test_description='test oidmap'
    ++
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - test_expect_success setup '
    + # This purposefully is very similar to t0011-hashmap.sh
    +
    + ## t/t0017-env-helper.sh ##
    +@@
    + 
    + test_description='test env--helper'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + 
    +
    + ## t/t0018-advice.sh ##
    +@@
    + 
    + test_description='Test advise_if_enabled functionality'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'advice should be printed when config variable is unset' '
    +
    + ## t/t0030-stripspace.sh ##
    +@@
    + 
    + test_description='git stripspace'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + t40='A quick brown fox jumps over the lazy do'
    +
    + ## t/t0063-string-list.sh ##
    +@@
    + 
    + test_description='Test string list functionality'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_split () {
    +
    + ## t/t0091-bugreport.sh ##
    +@@
    + 
    + test_description='git bugreport'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # Headers "[System Info]" will be followed by a non-empty line if we put some
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: then
-- 
2.33.0.1092.g44c994ea1be

