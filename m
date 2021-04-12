Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D303C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C595E61289
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbhDLLWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbhDLLWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6CC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:21:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so3489803wrt.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01HzS6rktt6lNM+v5o0XaedbykCtFZyuA9Ebz0YJatQ=;
        b=grnCmUCD6G6Whf3bR+edepM/hYUhFhcWHp710BlqZYy6db3YjjAiBVJVYHtVJ92vPI
         rVcp9Ft2TJdUbtYxtTHvH439XsBkcA5uNV9uZAKgOuNPJKbAcNVtB1ByMvPMfjgg7rcO
         pmzb2TwrEPMFKLie2hQ67Hok9GSoRyzDO03klLHYPWta+em1BqpHYJTe3MumfF3xTu8w
         4+50Na/fhTkpdRMc6asGLhi6OoS6RFcV+BsSwny/Cr9R/duh27/0KH5wRJpsfCY0RsI5
         ohYmB79aSQdeAqnit7/YsgAUtC7PADcXVKEE7xlrOQYTzHmmJhtwKoVQqK6gV8hChK9J
         QMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01HzS6rktt6lNM+v5o0XaedbykCtFZyuA9Ebz0YJatQ=;
        b=Q5s0a8nf7JgYrNZBT38jwlfAayxtpWT/mcQqwlHYqWDjmhHvv3tp+b21hcrTyffSOW
         oCV8iGbNbLvAb/nrgqkLWaJHsH8ICE5N2il+iOis0zdis5jwKvEoJmNfNTzozPytu/9p
         5qrto6asD2zmAFvGPCI9r3TLMn244AZCYzRSz4ztt6ZoHy3oDTFWjafpuc4LqoIDAs9x
         DLlrKmUJ7eArMpolyR0Nv2SpJDlSRnJ1p6Cwf+f5ng9ENpNIvA3nKzUMyhVry2OHWbQX
         ev2qY0VhgFZSStHJIK8Tf/Ph1DPqC5S0IjOHue9/XbUnyk9rJM9A4cLQiXOGiwV19Aec
         jUSg==
X-Gm-Message-State: AOAM533ejo5Uaxr6fZWZinLI40l7XCMDHzp8JpThWPEq8H2oqugsJ7QQ
        bM0CJ/sk7D5EfdQdSnP8KZTM3AhnYbKWFA==
X-Google-Smtp-Source: ABdhPJwTKQRNl2Olnyb0RhOQ/kMUOCLx+XEJdYo6m2MTedhdCMReKtUTYxlZBJsLxTMt8kMYKmGMAg==
X-Received: by 2002:a5d:6801:: with SMTP id w1mr15673488wru.335.1618226516238;
        Mon, 12 Apr 2021 04:21:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm14580907wmb.25.2021.04.12.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] describe test fixes
Date:   Mon, 12 Apr 2021 13:21:42 +0200
Message-Id: <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <20210228195414.21372-1-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in v1 we have a test for "git describe" test that tests for
nothing at all, due to being a nested test_expect_success.

This series is based on my "test-lib.sh fixes" series[2] and fixes
that bug, and should address all feedback on v1. In particular:

 * Shell quoting fixes
 * The "nothing should have stderr" general testing is gone per
   Junio's request.
 * Required test-lib.sh fixes moved to [1]
 * We no longer change the return value of
   test_expect_{success,failure} to narrowly catch the bug being fixed
   here.
 * Ejected SVN test fixup patches, needed for the now-ejected
   test_expect_{success,failure} change. Those fixes still make sense,
   but I'll submit them separately (they don't depend on anything
   else).

I think the "catch the bug" is probably a good idea, but Junio's
suggestion of tracking this via some env variable "stack depth" is
something that would probably collide with t0000*.sh changes I have
unsubmitted/outstanding, and I don't have time to pursue it now. So
I've left that out.

1. https://lore.kernel.org/git/20210228195414.21372-1-avarab@gmail.com/#t
2. https://lore.kernel.org/git/cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  describe tests: improve test for --work-tree & --dirty
  describe tests: refactor away from glob matching
  describe tests: don't rely on err.actual from "check_describe"
  describe tests: fix nested "test_expect_success" call
  describe tests: support -C in "check_describe"

 t/t6120-describe.sh | 134 ++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 62 deletions(-)

Range-diff against v1:
 1:  d76214a9171 =  1:  c41a777462e describe tests: improve test for --work-tree & --dirty
 2:  c1b8625de15 !  2:  b428f468d68 describe tests: refactor away from glob matching
    @@ t/t6120-describe.sh: check_describe () {
     -	esac
     +		git describe $describe_opts 2>err.actual >raw &&
     +		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
    -+		echo $expect >expect &&
    ++		echo "$expect" >expect &&
     +		test_cmp expect actual
      	'
      }
      
     @@ t/t6120-describe.sh: test_expect_success setup '
    - 
    + 	test_commit --no-tag x file
      '
      
     -check_describe A-* HEAD
 3:  ac1a658d07f !  3:  50b5a41f88d describe tests: always assert empty stderr from "describe"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    describe tests: always assert empty stderr from "describe"
    +    describe tests: don't rely on err.actual from "check_describe"
     
    -    Invert a test added in 3291fe4072e (Add git-describe test for "verify
    -    annotated tag names on output", 2008-03-03) to make checking that we
    -    don't have warnings the rule rather than the exception.
    +    Convert the one test that relied on the "err.actual" file produced by
    +    check_describe() to instead do its own check of "git describe"
    +    output.
     
    -    There was only one case where we expected and got a warning. Let's
    -    test for that case explicitly, and assert no warnings or other stderr
    -    output for all the rest.
    +    This means that the two tests won't have an inter-dependency (e.g. if
    +    the earlier test is skipped).
    +
    +    An earlier version of this patch instead asserted that no other test
    +    had any output on stderr. We're not doing that here out of fear that
    +    "gc --auto" or another future change to "git describe" will cause it
    +    to legitimately emit output on stderr unexpectedly[1].
    +
    +    I'd think that inverting the test added in 3291fe4072e (Add
    +    git-describe test for "verify annotated tag names on output",
    +    2008-03-03) to make checking that we don't have warnings the rule
    +    rather than the exception would be the sort of thing the describe
    +    tests should be catching, but for now let's leave it as it is.
    +
    +    1. http://lore.kernel.org/git/xmqqwnuqo8ze.fsf@gitster.c.googlers.com
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t6120-describe.sh: check_describe () {
      	describe_opts="$@"
      	test_expect_success "describe $describe_opts" '
     -		git describe $describe_opts 2>err.actual >raw &&
    -+		git describe $describe_opts 2>err >raw &&
    -+		test_must_be_empty err &&
    ++		git describe $describe_opts >raw &&
      		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
    - 		echo $expect >expect &&
    + 		echo "$expect" >expect &&
      		test_cmp expect actual
     @@ t/t6120-describe.sh: test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
      '
    @@ t/t6120-describe.sh: test_expect_success 'describe --contains defaults to HEAD w
     -'
     +test_expect_success 'renaming tag A to Q locally produces a warning' "
     +	mv .git/refs/tags/A .git/refs/tags/Q &&
    -+	git describe HEAD 2>actual >out &&
    ++	git describe HEAD 2>err >out &&
     +	cat >expected <<-\EOF &&
     +	warning: tag 'Q' is externally known as 'A'
     +	EOF
    -+	test_cmp expected actual &&
    ++	test_cmp expected err &&
     +	grep -E '^A-8-g[0-9a-f]+$' out
     +"
     +
 4:  15efc2c6242 <  -:  ----------- test-lib functions: add an --annotated-tag option to "test_commit"
 5:  06a8904d693 <  -:  ----------- describe tests: convert setup to use test_commit
 6:  91424c8392b =  4:  5c81358d6bb describe tests: fix nested "test_expect_success" call
 7:  ecb8f6fb02f !  5:  798f6cd63c8 describe tests: support -C in "check_describe"
    @@ t/t6120-describe.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      	shift
      	describe_opts="$@"
      	test_expect_success "describe $describe_opts" '
    --		git describe $describe_opts 2>err >raw &&
    -+		git ${indir:+ -C "$indir"} describe $describe_opts 2>err >raw &&
    - 		test_must_be_empty err &&
    +-		git describe $describe_opts >raw &&
    ++		git ${indir:+ -C "$indir"} describe $describe_opts >raw &&
      		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
    - 		echo $expect >expect &&
    + 		echo "$expect" >expect &&
    + 		test_cmp expect actual
     @@ t/t6120-describe.sh: test_expect_success 'setup: describe commits with disjoint bases' '
      	)
      '
 8:  be5ed59dc61 <  -:  ----------- svn tests: remove legacy re-setup from init-clone test
 9:  0b4238d012a <  -:  ----------- svn tests: refactor away a "set -e" in test body
10:  4f2c4f1fdd5 <  -:  ----------- test-lib: return 1 from test_expect_{success,failure}
-- 
2.31.1.634.gb41287a30b0

