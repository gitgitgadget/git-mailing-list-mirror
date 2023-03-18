Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08707C74A5B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCRPrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCRPrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977261E288
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x13so31374249edd.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK7ouLJMt/MfSGEUTqrTl58hiWHNMoKiYdUikLnnHek=;
        b=fzSKGuh//z6yapvgOFXZhIaoXDqb65mIluSfWIqqEpia3QID4myIXO3iAkw6yIieYW
         U8amio5p4I0h2fhWC+wOhJ5qGb9drDHKdfpofRgH5yv6yjS412vdKxegBzNGc/EUoN2h
         ta3l9ekrETDwARcfJQzWwWJoe11YtLCN3v74zSOGJbXD3SN08BgqNCBLbIfaUS/IjaTI
         /styR7jpAHI8Fg/MgkZsV0wMhoXwqvGGgqzyJYcNokSSFZuBVGtW6Nyw3UUroIyunrVM
         MBslxVNOVDTZrmwQfY2HPQ93cbB5NxOTCiApzI0Bhp8ByXLnGDUfE16chgFVduEFFKQZ
         ObqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK7ouLJMt/MfSGEUTqrTl58hiWHNMoKiYdUikLnnHek=;
        b=TpFRoZjItXH8D9D+zdCopLfMppNkCPbV7HyDIGhL2q6ixbXDR5G4C5pa+Nu0HNFxkI
         0f0BQvQ8IajSkvzxxJsWS1J4i7KxbpgGqPtVMDlCLHNski2GzSHhOOjkkPUq50EZeZfV
         v90yPHSG3b2bTcFjndZN+dbLqYf0d88jiqnok2LfGJsL3o7Z8qfNulfeXJRnqT91OGNc
         KfFPLC/w1b05dA7SP3Rm4SACDu4UF/Y9t6RpbG+pfgZ2gzPxzdiU2QGr5mOrGuLMdUaG
         ErbGDrBEbHif/qBLakcQ5bYf5vui/Bd0tJtnlLCyc7BtSj36NXna3u5Bw7i5B5YpD+aw
         /ceA==
X-Gm-Message-State: AO0yUKVdXYLEX60TzppiODc8zuYzbA00A080qZOzCOU+9N3MkENa7gjm
        EnR0/5HLoLoLpNG9l/PuNcCNnfqEzZc010mbMMk=
X-Google-Smtp-Source: AK7set9PaisJo7vjIMoGJsg2EYKLpPiFgO1z+r9Kr5fBbUk5IUvSzSmUCMfBCK7tFsfH/4HecGFOxA==
X-Received: by 2002:a17:907:774c:b0:932:3d1b:b67a with SMTP id kx12-20020a170907774c00b009323d1bb67amr3445625ejc.41.1679154410617;
        Sat, 18 Mar 2023 08:46:50 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:50 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/7] t: fix unused files, part 1
Date:   Sat, 18 Mar 2023 16:46:39 +0100
Message-Id: <20230318154646.131344-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a v2 for various fixes of unused files in t0??? and t1???.
Original cover letter is at
  https://lore.kernel.org/git/20230312201520.370234-1-rybak.a.v@gmail.com/T/#m63071efd1e2f876fdcbd0c384130b0ec7859f885

Changes since v1 address Junio's review:

  - just don't redirect output of mktree in patch 3/7
  - rewritten commit message of patch 6/7, where I'd completely misunderstood
    the code of the tests.

Range diff:

1:  017f1d8173 = 1:  59a868c0b8 t1005: assert output of ls-files
2:  7a75864e00 = 2:  a3514687ad t1006: assert error output of cat-file
3:  e23a16e560 ! 3:  4cb07fa965 t1010: assert empty output of mktree
    @@ Metadata
     Author: Andrei Rybak <rybak.a.v@gmail.com>
     
      ## Commit message ##
    -    t1010: assert empty output of mktree
    +    t1010: don't create unused files
     
         Builtin "git mktree" writes the the object name of the tree object built
         to the standard output.  Tests 'mktree refuses to read ls-tree -r output
    @@ Commit message
         "t1010-mktree.sh" redirect output of "git mktree" to a file, but don't
         use its contents in assertions.
     
    -    Assert that the output of "git mktree" is empty when it refuses to build
    -    a tree object.
    +    Don't redirect output of "git mktree" to file "actual" in tests that
    +    assert that an invocation of "git mktree" must fail.
    +
    +    Output of "git mktree" is empty when it refuses to build a tree object.
    +    So, alternatively, the test could assert that the output is empty.
    +    However, there isn't a good reason for the user to expect the command to
    +    be silent in such cases, so we shouldn't enforce it.  The user shouldn't
    +    use the output of a failing command anyway.
     
         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
     
    @@ t/t1010-mktree.sh: test_expect_success 'allow missing object with --missing' '
      
      test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
     -  test_must_fail git mktree <all >actual
    -+  test_must_fail git mktree <all >actual &&
    -+  test_must_be_empty actual
    ++  test_must_fail git mktree <all
      '
      
      test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
     -  test_must_fail git mktree <all.withsub >actual
    -+  test_must_fail git mktree <all.withsub >actual &&
    -+  test_must_be_empty actual
    ++  test_must_fail git mktree <all.withsub
      '
      
      test_done
4:  462cfa7025 = 4:  1ed6030a4f t1302: don't create unused file
5:  9fa04e479c = 5:  002942d81c t1400: assert output of update-ref
6:  e79566cc32 ! 6:  2e3446fc2f t1404: don't create unused file
    @@ Commit message
     
         Some tests in file t1404-update-ref-errors.sh create file "unchanged" as
         the expected side for a test_cmp assertion at the end of the test for
    -    output of "git for-each-ref".  The filename conveys the expectation that
    -    the output won't change between two invocations of "git for-each-ref".
    +    output of "git for-each-ref".  Test 'no bogus intermediate values during
    +    delete' also creates a file named "unchanged" using "git for-each-ref".
    +    However, the file isn't used for any assertions in the test.  Instead,
    +    "git rev-parse" is used to compare the reference with variable $D.
     
    -    Test 'no bogus intermediate values during delete' also creates a file
    -    named "unchanged".  However, in this test the reference is being
    -    deleted, i.e. it _does change_.  The file itself isn't used for any
    -    assertions in the test.
    -
    -    Don't create the unused and slightly misleading file "unchanged".
    +    Don't create unused file "unchanged" in test 'no bogus intermediate
    +    values during delete' of t1404-update-ref-errors.sh.
     
         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
     
7:  5a7df840a8 = 7:  e11a7d8e02 t1507: assert output of rev-parse


Andrei Rybak (7):
  t1005: assert output of ls-files
  t1006: assert error output of cat-file
  t1010: don't create unused files
  t1302: don't create unused file
  t1400: assert output of update-ref
  t1404: don't create unused file
  t1507: assert output of rev-parse

 t/t1005-read-tree-reset.sh    | 15 ++++++++++-----
 t/t1006-cat-file.sh           |  3 ++-
 t/t1010-mktree.sh             |  4 ++--
 t/t1302-repo-version.sh       |  2 +-
 t/t1400-update-ref.sh         |  3 +++
 t/t1404-update-ref-errors.sh  |  1 -
 t/t1507-rev-parse-upstream.sh |  6 ++++--
 7 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.40.0

