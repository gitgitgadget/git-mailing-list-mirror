Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1DCC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiEYL1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiEYL0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C49CF39
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so3833976wmg.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1VXoDkeYcgy7xk9T7vecJREADbgg8cGHRe4tKO7dSA=;
        b=d6sOlU6ZQl78zTt/emOCIsmvkVuewEgfazKlnOpqXUSDc46tmeNJrheDOMpJLeYKQl
         J53tQF1ZXdlWZj0LVL/Zti8iOeajAMu1tMKy8dobBeauyWt1Xb2H96xBfFeTOxuT7NKj
         J0CXYoyqvFn0Rit9ExJbN5aIsncFuNNaNOQ38NB/kdI0XQ8XViWKWMzHEnr5bKzH28DI
         exIbfIRyV+4leMJ8FC1Jr0wRVxPGrFUTwLpXvonsKI0fDfNnSLKWY/cFNq78kP286Wpu
         ho/D8Nf40f1RRQNyGH7K/mmfQqN5/xwXc519R2LSU9Li/QW6j7FBw/EqIgk/YSFwWK4A
         E8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1VXoDkeYcgy7xk9T7vecJREADbgg8cGHRe4tKO7dSA=;
        b=WzFWKHa8ytlztEY3uZLqbTVmYLdIaUU9hgFlssNjAFOBKZlL5JTidsAG84DF6LFy/9
         dvu4flZ3+3kM8T3Sd2ni/6+mPX1dEYZ22s0FVf9b4VS9p9ExFlUanLYREHcMDwJf1GAp
         xyhEkbsJK5ZqgGc6ex8KZenKnDX9Zwt9RGz+Fn5J/byi2mtv2TyCeJ1UnlBBzoo2N7EW
         4AvVTG9vEAUVxtcm+NTEK5ib6+qDcuXCha9IaYRTlcTLd2u7iG8Wvs2gV2VAjEekr6M4
         opmYRb3qeie2NJVa1jW5j4JjGIaKmJK71W1qFYVB9//OZkpaBRREmyr/Ij4Mb7c9fuPJ
         396A==
X-Gm-Message-State: AOAM532CTn7pEN5bg2hBdRdUvR5I7y5YCZqlij/ikCOPXIZ0muk0jpJO
        2Q0ftiyViKc5Axg6qGr9sloos8vdvDXjJw==
X-Google-Smtp-Source: ABdhPJyRnki8VpizieyoLAfJzwPwl9Hv2YmB9+o6CADJIUDVskqmmO8PRYzuWWt8ArI2UyaWl630Mw==
X-Received: by 2002:a05:600c:3ac7:b0:397:5cb4:a2b5 with SMTP id d7-20020a05600c3ac700b003975cb4a2b5mr6644806wms.5.1653477989821;
        Wed, 25 May 2022 04:26:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/14] ci(github): avoid printing test case preamble twice
Date:   Wed, 25 May 2022 13:25:59 +0200
Message-Id: <patch-v6-10.14-90a152d79f9-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

We want to mark up the test case preamble when presenting test output in
Git's GitHub workflow. Let's suppress the non-marked-up version in that
case. Any information it would contain is included in the marked-up
variant already.

This change has the side-effect of not making the full logs available
to us in the *.out files anymore. E.g. in the case of running a test
where all tests are successful, we ran run this sequence of commands
in t/:

	test=t0013-sha1dc.sh;
	rm -rf test-results*;
	./$test --verbose-log -x;
	mv test-results{,.old};
	./$test --verbose-log -x --github-workflow-markup;
	diff -ru test-results{.old,}; file test-results/*markup

Which will emit:

	ok 1 - test-sha1 detects shattered pdf
	# passed all 1 test(s)
	1..1
	ok 1 - test-sha1 detects shattered pdf
	# passed all 1 test(s)
	1..1
	Only in test-results: t0013-sha1dc.markup
	diff -ru test-results.old/t0013-sha1dc.out test-results/t0013-sha1dc.out
	--- test-results.old/t0013-sha1dc.out   2022-05-24 19:12:14.106339385 +0200
	+++ test-results/t0013-sha1dc.out       2022-05-24 19:12:14.154338965 +0200
	@@ -1,9 +1,4 @@
	 Initialized empty Git repository in /home/avar/g/git/t/trash directory.t0013-sha1dc/.git/
	-expecting success of 0013.1 'test-sha1 detects shattered pdf':
	-       test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
	-       test_i18ngrep collision err &&
	-       grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
	-
	 + test_must_fail test-tool sha1
	 + _test_ok=
	 + test_must_fail_acceptable test-tool sha1
	test-results/t0013-sha1dc.markup: empty

This is because the the "test_skip_test_preamble" variable being set
here has a global effect. Perhaps it's acceptable to munge the *.out
output for now, as this will only kick in under
--github-workflow-markup, but ideally we'd implement
--github-workflow-markup in such a way that it doesn't change the
normal --verbose-log output.

Because of this change it's now harder to make sense of the
--verbose-log output when viewing the full log output, as some of the
context for test boundaries will be missing. Note that we shill have
the "ok" or "not ok" TAP lines, so we can still infer the test
boundaries. The output that suffers the most from this is the
"--verbose-log -x" output, i.e. we won't have the test source to go
along with the "-x" output.

Signed-off-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Tested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh              | 2 ++
 t/test-lib-github-workflow-markup.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index af4831a54c6..89a5e146b7a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -803,6 +803,7 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		test -n "$test_skip_test_preamble" ||
 		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2" expecting_failure
 		then
@@ -823,6 +824,7 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		test -n "$test_skip_test_preamble" ||
 		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2"
 		then
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index bad3ebafdb7..2267fba947c 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -20,6 +20,8 @@
 # workflows; these functions will then override (empty) functions
 # that are are called at the appropriate times during the test runs.
 
+test_skip_test_preamble=t
+
 start_test_output () {
 	test -n "$GIT_TEST_TEE_OUTPUT_FILE" ||
 	die "--github-workflow-markup requires --verbose-log"
-- 
2.36.1.1045.gf356b5617dd

