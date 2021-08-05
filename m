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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C68DC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFAE60F02
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbhHEKhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbhHEKhs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED70C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso5975062wms.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYGNNGTtV5PMxU0yXjHlzbDhVx2xLiXrohB6G7SKTcE=;
        b=q7gsTzQgKteP+Li6ai6QwV9co7WRnBbWFlPU4ieJWcKQ4Da4wIiV5AjdFPkS91sbxg
         a5WEVo3fGFsyff9CHzVytbr9v6r4axhQUN1PJAlnGLfEbMh9fiPDY/dTZOYmjqbeASfC
         wgIVyWBoUnU3UavkObQwA6mFNT5dg4DmL9whvdsgRgNgzUMJId7Q+EiT2xivENDvzesB
         0a+APE0FcAi8ru79eDG4LYHsVJTJ3RXxQn//R8o1uSsn5pW/2dOMt1xBlvwRuHUEmUou
         bVK1FprbCUb2JIUeGKgg2LOjXG1iSrTt1GOOGDmhUGc8DohMfBCUqYdw/gSl4ZmO4EJp
         xoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYGNNGTtV5PMxU0yXjHlzbDhVx2xLiXrohB6G7SKTcE=;
        b=Enlvp3UBg4e3K9GPIR/w72OdK3Csi5bV13izM7vohHLUdvLnwdZ349PBzI9R7SiT7H
         zoGZBM19Jh8cens+KP1n2FOoBmmLzymYshYs3/+WppYKa5dfBb2trGioY4yxR5xogm7I
         jPlFJ2hp74P+67CfoNon2WHgVHEERhRdF/bQ7GgvT7GmmjH7SC02IMrKsm3nZDCHTOQB
         0mPHLHe9y7J8LSwgpbx/NhwlHAOXkwLmJc2p+2cXBTx4Ain6JFRTRdTc4264xDwcXjtp
         nAL7d7L2/0QvwrINEkFJ7muYfNKS0hJOO8WAbvKoKeCqUtSAobe+blgedb93CORpfsTY
         Z9sg==
X-Gm-Message-State: AOAM531CkToCzrc06AYuVeOq4H6UlndAyy+EDvMeZsLPVeMNUcD61uiq
        sFiPHsEfvIAu/RL2hUP4YyeG8+gNZRU25Q==
X-Google-Smtp-Source: ABdhPJyABCLPLFpC+F+EY2jRR7s49XtS8LKX7vw/Ql+nxG65qUeWlRX6FAd84nh30uL4bE21epSO1A==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr4243579wms.35.1628159851832;
        Thu, 05 Aug 2021 03:37:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] test-lib tests: split off subtest code in t0000 into lib-subtest.sh
Date:   Thu,  5 Aug 2021 12:37:19 +0200
Message-Id: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series has been looking for reviewer attention for a while. It
splits up the testing of test-lib.sh itself from t0000-basic.sh into a
lib-subtest.sh library, a subsequent series of mine makes use of that
library.

The diffstat is nicely negative since a lot of the test code is
something we could delete as redundant, the tests are also made
stricter as a result (e.g. now checking 1 exit code, not any
non-zero).

For v2, see:
https://lore.kernel.org/git/cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com/

The ony tricky part of this series is the "clever" way of (ab)using
the object store and tags to detect copy/pasted tests. For this v3
I've split that up into its own commit, see [56]/9 for the removal of
the copy/pasting and the assertion, respectively.

This series also depended on ps/t0000-output-directory-fix and
jk/t0000-subtests-fix, since both made it mo "master" it's been
rebased on "master". The range-diff that's not the split-up around
[56]/9 is due to that rebasing.

Ævar Arnfjörð Bjarmason (9):
  test-lib tests: move "run_sub_test" to a new lib-subtest.sh
  test-lib tests: split up "write and run" into two functions
  test-lib tests: stop using a subshell in write_sub_test_lib_test()
  test-lib tests: don't provide a description for the sub-tests
  test-lib tests: get rid of copy/pasted mock test code
  test-lib tests: assert no copy/pasted mock test code
  test-lib tests: avoid subshell for "test_cmp" for readability
  test-lib tests: refactor common part of check_sub_test_lib_test*()
  test-lib tests: assert 1 exit code, not non-zero

 t/lib-subtest.sh | 127 ++++++++++++++
 t/t0000-basic.sh | 448 +++++++++++++----------------------------------
 2 files changed, 245 insertions(+), 330 deletions(-)
 create mode 100644 t/lib-subtest.sh

Range-diff against v2:
 1:  7a06ea3a7b =  1:  3f34420a3e test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 2:  28117b84ab !  2:  c9c16016da test-lib tests: split up "write and run" into two functions
    @@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
      run_sub_test_lib_test () {
      	_run_sub_test_lib_test_common '' "$@"
      }
    -@@ t/lib-subtest.sh: check_sub_test_lib_test_err () {
    - 		test_cmp expect.err err
    - 	)
    - }
    -+
     
      ## t/t0000-basic.sh ##
     @@ t/t0000-basic.sh: test_expect_success 'success is reported like this' '
 3:  7d5ed335a3 =  3:  76f57eadcd test-lib tests: stop using a subshell in write_sub_test_lib_test()
 4:  2a0dd64da9 =  4:  cde015c7dd test-lib tests: don't provide a description for the sub-tests
 5:  f60190dec6 !  5:  7d1e6b9a3e test-lib tests: get rid of copy/pasted mock test code
    @@ Commit message
         run_sub_test_lib_test*() functions let's fix those tests in
         t0000-basic.sh that were verbosely copy/pasting earlier tests.
     
    -    I'm (ab)using writing a tag object under a ref-name that's
    -    content-addressable from the content of the test script. If we can
    -    update-ref that it's unique, if not we've got a duplicate. The tag
    -    object stores the name of the earlier test for reporting the error.
    +    In a subsequent commit we'll add an assertion to check whether we
    +    caught all of the copy/pasting.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/lib-subtest.sh ##
    -@@
    -+_assert_unique_sub_test () {
    -+	name=$1 &&
    -+
    -+	# Alert about the copy/paste programming
    -+	hash=$(git hash-object -w "$name") &&
    -+	cat >tag.sig <<-EOF &&
    -+	object $hash
    -+	type blob
    -+	tag $hash
    -+	tagger . <> 0 +0000
    -+
    -+	duplicate script detected!
    -+
    -+	This test script was already written as:
    -+
    -+	$name
    -+
    -+	You can just re-use its test code with your own
    -+	run_sub_test_lib_test*()
    -+	EOF
    -+
    -+	tag=$(git mktag <tag.sig) &&
    -+	if ! git update-ref refs/tags/blob-$hash $tag $(test_oid zero) 2>/dev/null
    -+	then
    -+		msg=$(git for-each-ref refs/tags/blob-$hash \
    -+			--format='%(contents)' refs/tags/blob-$hash)
    -+		error "on write of $name: $msg"
    -+		return 1
    -+	fi
    -+}
    -+
    - write_sub_test_lib_test () {
    - 	name="$1" # stdin is the body of the test code
    - 	mkdir "$name" &&
    -@@ t/lib-subtest.sh: write_sub_test_lib_test () {
    - 	# Point to the t/test-lib.sh, which isn't in ../ as usual
    - 	. "\$TEST_DIRECTORY"/test-lib.sh
    - 	EOF
    --	cat >>"$name/$name.sh"
    -+	cat >>"$name/$name.sh" &&
    -+	_assert_unique_sub_test "$name/$name.sh"
    - }
    - 
    - _run_sub_test_lib_test_common () {
    -
      ## t/t0000-basic.sh ##
     @@ t/t0000-basic.sh: test_expect_success 'subtest: --verbose option' '
      '
 -:  ---------- >  6:  bc79b29f3c test-lib tests: assert no copy/pasted mock test code
 6:  022ddbabf6 !  7:  48176f3e60 test-lib tests: avoid subshell for "test_cmp" for readability
    @@ t/lib-subtest.sh: run_sub_test_lib_test_err () {
     +	sed -e 's/^> //' -e 's/Z$//' <&3 >"$name"/expect.err &&
     +	test_cmp "$name"/expect.err "$name"/err
      }
    - 
 7:  ae0226e164 =  8:  fda7c4fbe3 test-lib tests: refactor common part of check_sub_test_lib_test*()
 8:  676547e001 =  9:  dd0af5bd6c test-lib tests: assert 1 exit code, not non-zero
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

