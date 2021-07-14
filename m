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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C261C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665D5613B5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhGNR0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGNR0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:26:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB7C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f17so4181652wrt.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frNbl+lol+kd0WP5DuSvg723K/GMgzxcg9QZs/q7kfE=;
        b=rokVhSQkYDvX3dRpZiOINTvDNVyp/TS08lQOR8Gm6fHR+tW3im95ZK2f6kfxYhbkqD
         bBxoxs9ucPIpn6yGuU12Ziu7thdboPaxji2r2FNf3fN7F2NvT4qSmisKreLFAb5pK+0F
         jVY4s/JCTME0MraWeqr5j3J+cSQEF4Pie5i+zdPtKXt3X+DTvydd0AhHEdtdPBWxzv3y
         5ZOm+nX9hfGMtobxV/G3iSTQ/SaVItZHgg89gpIN7kx/lT68lsDa+NNTb051wBRpSFYd
         VMQ0vRkvtyxazA2vHd5oSDoX+hHvddm58LEnWKM02qHMo/f+aykblVuJVaWorHdugI0R
         54Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frNbl+lol+kd0WP5DuSvg723K/GMgzxcg9QZs/q7kfE=;
        b=jb1KO84tij/UrVEULjayZMt6u4RF+1ud76DWsclBXLfCd94fWptqE6ePOC9UM2uXdZ
         RqpLdj9OhdseYwXKgEriz2Fnkawx5zOJm8Drl/CsZFe54kktBtQrl3aRqawQa2/HhOsQ
         S+x/suA3OQIkouW589vmt6HCFgiE7zK2j4kgSZMVxUNKeXDlLp+TF34A/hdfHduUw0ot
         BcIt3h7R3DnLLhdKXfvCrfX6Te/bTMt2+tVRDaeHf6JTyrGK0RRICt8fJjMhgPMYWWgw
         NMfYiWo1hQ88ZzrOCjL9P2DsasKP70lryxNpdiL1jhJdIR4kmqvrLVcpoufmr8PC/VsK
         4Q1A==
X-Gm-Message-State: AOAM531FRtqWuKQI2/b2B4VYiD+ZqLSVoBV0OmlH7HQyMQ2Ix7vQXmYZ
        MQ/P7zeZovherKeaXmVnyF+AHUkSXCDSsgMg
X-Google-Smtp-Source: ABdhPJxoNC9QS4wQqZ9UXmpTW1qtwy33flN+9/alMONfKwB9nGjpxol20vjwfHBPVRvetLB2QaMTRw==
X-Received: by 2002:adf:f885:: with SMTP id u5mr14371967wrp.84.1626283440572;
        Wed, 14 Jul 2021 10:24:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm3823795wrg.67.2021.07.14.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:24:00 -0700 (PDT)
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
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] add a test mode for SANITIZE=leak, run it in CI
Date:   Wed, 14 Jul 2021 19:23:50 +0200
Message-Id: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.853.g5a570c9bf9
In-Reply-To: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to my recent thread asking if we had some test mode or
CI to test for memory leak regression (we don't), add such a test
mode, and run it in CI.

Currently the two new CI targets take ~2-3 minutes to run in GitHub
CI, whereas the normal test targets take 20-30 minutes. The tests run
slower, but we have a small whitelist of test scripts that are OK.

v2:

 * Fixes issues spotted by Đoàn Trần Công Danh and Eric Sunshine,
   thanks both!

 * I got rid of the change to t0500, I saw it being flaky in GitHub
   CI, and looks like there'll be other concurrent edits to that file,
   so leaving it be.

v1: http://lore.kernel.org/git/cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (4):
  tests: add a test mode for SANITIZE=leak, run it in CI
  SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
  SANITIZE tests: fix memory leaks in t5701*, add to whitelist
  SANITIZE tests: fix leak in mailmap.c

 .github/workflows/main.yml |  6 ++++
 Makefile                   |  5 ++++
 ci/install-dependencies.sh |  4 +--
 ci/lib.sh                  | 18 +++++++----
 ci/run-build-and-tests.sh  |  4 +--
 config.c                   | 17 +++++++----
 mailmap.c                  |  2 ++
 protocol-caps.c            |  5 ++--
 t/README                   | 16 ++++++++++
 t/t1300-config.sh          | 16 ++++++----
 t/t4203-mailmap.sh         |  6 ++++
 t/t5701-git-serve.sh       |  3 +-
 t/test-lib.sh              | 61 ++++++++++++++++++++++++++++++++++++++
 13 files changed, 140 insertions(+), 23 deletions(-)

Range-diff against v1:
1:  b7948c408d ! 1:  0795436a24 tests: add a test mode for SANITIZE=leak, run it in CI
    @@ .github/workflows/main.yml: jobs:
     +            cc: clang
     +            pool: ubuntu-latest
     +          - jobname: linux-gcc-sanitize-leak
    -+            cc: clang
    ++            cc: gcc
     +            pool: ubuntu-latest
          env:
            CC: ${{matrix.vector.cc}}
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
      
      case "$jobname" in
     -linux-clang|linux-gcc)
    -+linux-clang*|linux-gcc*)
    ++linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
      	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
      	sudo apt-get -q update
      	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
      		$UBUNTU_COMMON_PKGS
      	case "$jobname" in
     -	linux-gcc)
    -+	linux-gcc*)
    ++	linux-gcc|linux-gcc-sanitize-leak)
      		sudo apt-get -q -y install gcc-8
      		;;
      	esac
    @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
     -linux-clang|linux-gcc)
     -	if [ "$jobname" = linux-gcc ]
     -	then
    -+linux-clang*|linux-gcc*)
    ++linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
     +	case "$jobname" in
    -+	linux-gcc*)
    ++	linux-gcc|linux-gcc-sanitize-leak)
      		export CC=gcc-8
      		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
     -	else
    @@ ci/lib.sh: linux-musl)
      esac
      
     +case "$jobname" in
    -+linux-*-sanitize-leak)
    ++linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
     +	export SANITIZE=leak
     +	;;
     +esac
    @@ ci/run-build-and-tests.sh: esac
      make
      case "$jobname" in
     -linux-gcc)
    -+linux-gcc*)
    ++linux-gcc|linux-gcc-sanitize-leak)
      	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      	make test
      	export GIT_TEST_SPLIT_INDEX=yes
    @@ ci/run-build-and-tests.sh: linux-gcc)
      	make test
      	;;
     -linux-clang)
    -+linux-clang*)
    ++linux-clang|linux-clang-sanitize-leak)
      	export GIT_TEST_DEFAULT_HASH=sha1
      	make test
      	export GIT_TEST_DEFAULT_HASH=sha256
    @@ t/README: GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
      ------------
      
     
    - ## t/t0500-progress-display.sh ##
    -@@
    - 
    - test_description='progress display'
    - 
    -+GIT_TEST_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - show_cr () {
    -@@ t/t0500-progress-display.sh: test_expect_success 'cover up after throughput shortens a lot' '
    - 	test_cmp expect out
    - '
    - 
    --test_expect_success 'progress generates traces' '
    -+test_expect_success !SANITIZE_LEAK 'progress generates traces' '
    - 	cat >in <<-\EOF &&
    - 	throughput 102400 1000
    - 	update
    -
      ## t/t5701-git-serve.sh ##
     @@ t/t5701-git-serve.sh: test_expect_success 'unexpected lines are not allowed in fetch request' '
      
2:  babcb1c289 = 2:  867e8e9a6c SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
3:  11aa2f3bb5 = 3:  b7fb5d5a56 SANITIZE tests: fix memory leaks in t5701*, add to whitelist
4:  7f4e433559 ! 4:  ad8680f529 SANITIZE tests: fix leak in mailmap.c
    @@ Commit message
         mailmap_entry structure, we didn't free the structure itself. The same
         goes for the "mailmap_info" structure.
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## mailmap.c ##
     @@ mailmap.c: static void free_mailmap_info(void *p, const char *s)
      		 s, debug_str(mi->name), debug_str(mi->email));
-- 
2.32.0.853.g5a570c9bf9

