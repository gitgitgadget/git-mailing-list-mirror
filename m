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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF60C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183D5610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhIVLVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhIVLV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:21:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EACC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:19:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g16so5722677wrb.3
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0LZijl1dWd7aIRmTrMWqO8pLsURH+9LfLndpfOzWAY=;
        b=UsnHCtyVm8Va+nUHA3Bws8j7xmSZvH6gwWoe8TPvfrcJgzXoagRoru59Ha+dtrOhN0
         7hIHvR5qjtNW0ZPnqLLZ3J2UV57s+nyy+APSWBtff8fms+oSBGNprX+iyKjPNsRN6ptM
         SSUAaWrSyPjvHihzv9kPBX8SuBk7w7u27xYZAkZinomzg3tMcga0LWRq6Mfw7enph6zw
         LZ7ImlMGlbRgHtXaEzSD9memPpTntcWt3MoTHvbS7UFDF6l2g71q4/a3cXrjGgBIRbLA
         3g+xjoKN+aYm3lQTwqXnAFPotuKLzcEGxcue/6/0oAxFCtehcoyPpcnsEHlpk5ZzFluV
         2cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0LZijl1dWd7aIRmTrMWqO8pLsURH+9LfLndpfOzWAY=;
        b=ZV2ZOZPJgi412PZsnO6TbSNxeLzsx4JUz8mP5yjMnONMX0s9KFikqtfe9KZ7SxDlhN
         xPJj4EaBRXK8j0gq73xK961fsDjVzS63nKWR9sjiW5x9E6V140zsExJvySocuutdeQ7P
         wPXLqAdo152YI+AfO4CXuuo9rVY+OaBYsAQ1kOOHpL3Zww8Td1TzFB5SWZ0qyewun6ub
         tzrSUpugKVhVPWbsFm86dAyHlRSPJyZkDIb1NMdiZUnaAYs9rB1Hl6viXfx8bnAUlcOZ
         4OdOsm9ktWFTHM/LKI0qMjlcqee7TgdrbedInw6eMBOMZKUfrf4oTbMIvXrB9vey2cMH
         fLmQ==
X-Gm-Message-State: AOAM533kevQ3RedgonwzZaOup1RWQ/u0iDuutP17vj/IkyEGhwlfW+FW
        sq8a86+nB4LzwIGbB36qkuPgGNqvwi558Q==
X-Google-Smtp-Source: ABdhPJyz7fd7g9zjgeH6mUMX3QKD32nw10JKLcBxUWnQKUTbp0qECB9WYJVOg6oL+dT5PLtt8MrtLQ==
X-Received: by 2002:a5d:64a7:: with SMTP id m7mr41010415wrp.171.1632309597243;
        Wed, 22 Sep 2021 04:19:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d70sm1679165wmd.3.2021.09.22.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:19:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] test-lib tests: split off subtest code in t0000 into lib-subtest.sh
Date:   Wed, 22 Sep 2021 13:19:46 +0200
Message-Id: <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v3[1] of this cleanup/refactoring of t0000-basic.sh
series which addresses Carlo's comments on it, thanks for the review
Carlo!

I.e. the old 3/9 is squashed into a 2/7, and the assertion of
non-duplicate tests is now ejected. I left a note in 7/7 that we may
want it in the future, but for now let's punt on it.

1. https://lore.kernel.org/git/cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com/
2. https://lore.kernel.org/git/CAPUEspg3pT1F5YMwGuwvmiyMGoYLUB0neHeunXnLxwc_G9zN-A@mail.gmail.com/

Ævar Arnfjörð Bjarmason (7):
  test-lib tests: move "run_sub_test" to a new lib-subtest.sh
  test-lib tests: split up "write and run" into two functions
  test-lib tests: don't provide a description for the sub-tests
  test-lib tests: avoid subshell for "test_cmp" for readability
  test-lib tests: refactor common part of check_sub_test_lib_test*()
  test-lib tests: assert 1 exit code, not non-zero
  test-lib tests: get rid of copy/pasted mock test code

 t/lib-subtest.sh |  95 ++++++++++
 t/t0000-basic.sh | 448 +++++++++++++----------------------------------
 2 files changed, 213 insertions(+), 330 deletions(-)
 create mode 100644 t/lib-subtest.sh

Range-diff against v3:
 1:  3f34420a3e1 =  1:  f915bc2ee77 test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 2:  c9c16016da6 !  2:  5b5038867df test-lib tests: split up "write and run" into two functions
    @@ Commit message
         it possible to do so. All the changes in t0000-basic.sh are a simple
         search-replacement.
     
    +    Since the _run_sub_test_lib_test_common() function doesn't handle
    +    running the test anymore we can do away with the sub-shell, which was
    +    used to scope an "unset" and "export" shell variables.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/lib-subtest.sh ##
    @@ t/lib-subtest.sh
     +write_sub_test_lib_test () {
     +	name="$1" descr="$2" # stdin is the body of the test code
     +	mkdir "$name" &&
    -+	(
    -+		cd "$name" &&
    -+		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
    -+		test_description='$descr (run in sub test-lib)
    ++	write_script "$name/$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
    ++	test_description='$descr (run in sub test-lib)
     +
    -+		This is run in a sub test-lib so that we do not get incorrect
    -+		passing metrics
    -+		'
    ++	This is run in a sub test-lib so that we do not get incorrect
    ++	passing metrics
    ++	'
     +
    -+		# Point to the t/test-lib.sh, which isn't in ../ as usual
    -+		. "\$TEST_DIRECTORY"/test-lib.sh
    -+		EOF
    -+		cat >>"$name.sh"
    -+	)
    ++	# Point to the t/test-lib.sh, which isn't in ../ as usual
    ++	. "\$TEST_DIRECTORY"/test-lib.sh
    ++	EOF
    ++	cat >>"$name/$name.sh"
     +}
     +
      _run_sub_test_lib_test_common () {
    @@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
     -		cd "$name" &&
     -		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
     -		test_description='$descr (run in sub test-lib)
    - 
    +-
     -		This is run in a sub test-lib so that we do not get incorrect
     -		passing metrics
     -		'
    --
    + 
     -		# Point to the t/test-lib.sh, which isn't in ../ as usual
     -		. "\$TEST_DIRECTORY"/test-lib.sh
     -		EOF
 3:  76f57eadcdd <  -:  ----------- test-lib tests: stop using a subshell in write_sub_test_lib_test()
 4:  cde015c7dd0 =  3:  78177ce1729 test-lib tests: don't provide a description for the sub-tests
 7:  48176f3e60c =  4:  a581bff6e62 test-lib tests: avoid subshell for "test_cmp" for readability
 8:  fda7c4fbe34 =  5:  5e95484fb61 test-lib tests: refactor common part of check_sub_test_lib_test*()
 9:  dd0af5bd6ce =  6:  1e0a49c1a70 test-lib tests: assert 1 exit code, not non-zero
 5:  7d1e6b9a3e4 !  7:  68f8fabaa1e test-lib tests: get rid of copy/pasted mock test code
    @@ Commit message
         run_sub_test_lib_test*() functions let's fix those tests in
         t0000-basic.sh that were verbosely copy/pasting earlier tests.
     
    -    In a subsequent commit we'll add an assertion to check whether we
    -    caught all of the copy/pasting.
    +    That we caught all of them was asserted with a follow-up change that's
    +    not part of this series[1], we might add such a duplication check at
    +    some later time, but for now let's just one-off remove the duplicate
    +    boilerplate.
    +
    +    1. https://lore.kernel.org/git/patch-v3-6.9-bc79b29f3c-20210805T103237Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 6:  bc79b29f3cd <  -:  ----------- test-lib tests: assert no copy/pasted mock test code
-- 
2.33.0.1225.g9f062250122

