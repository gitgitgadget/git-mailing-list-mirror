Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24614C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40D761212
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhIPKug (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhIPKuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:50:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C5C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:49:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so8810798wrb.0
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbuUe3vnCAEh0AQ9BvproQuFEiPej2uReWH2cfO6idM=;
        b=IEucKtzlNHUd4rBuqGSGQyNfg9bxI7jipX2ZcN19DvZzhhUp8ilxKakmZ1OVgCCarx
         EYLrkTx6Zf/vcBPJfDQnln9Rq4lnUf8v2OeKGV6Ak5m+CJVw5oFo0phaKtHIfyE6EdiU
         HeRSbgQLCLDGSj9e5ZornEsnp2EccLBjj/W5S2vXa2KHjP5HzauqdEBVoWaWu8z/Wt3H
         deP/UAZs+nWK6vgsswwKCB11F4EmnApPY14tRycW668DxFdwMxiEmsiOI+cbks8sJ5sG
         C6ImuqWisQ3MNe7hrsLQQobezpMhUEDbZNa93oprn9URsc9ZpyawQtZG80pFrarJtvrb
         iEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbuUe3vnCAEh0AQ9BvproQuFEiPej2uReWH2cfO6idM=;
        b=1lHrLxZn4fa0ihCYU1jyfGwdqCI4saIsmBlj0ylZqZux80KS9KGLlG+/SpbGcf0BwN
         X9T42+oCfGuBz4dLfZVJ9ydJjxe03xauzqRNwQRFeqKnACVC/cMznMw143v1GdSMSiVd
         /G5enDH0qPPr8uy3O49REdIqttjwZkKJoqoqd3/hgw2I37aMk7PjqShXQEHIP0X9s9Wq
         sM/v/CHh5B4OwG+4YcFpYSbEfg5pbA5ceMiDpekYvSWAyvzNcJpXaPEXBTW/yhnyiNMF
         S8DGXo7dB25r5eH74aKqj2NM7uNqszUkQLqKi33zgOWCkRpOohSbRAlMGKHo99wjk6KS
         YmZg==
X-Gm-Message-State: AOAM5300rePas0zyW4MrrrN1nE7dACAN8cBCv7e3WLQTEePtXw6gm0Dp
        Kldp2koW4fnY+InucTNAWnkqiU1D92RUgQ==
X-Google-Smtp-Source: ABdhPJzZA4Bbur0TVnCcNUaxyUTil4TWXnZmhyAYwTWWkXkI6YbEbtVnolQN7U69S19qrVYUxdTJEQ==
X-Received: by 2002:adf:e390:: with SMTP id e16mr5219542wrm.217.1631789353518;
        Thu, 16 Sep 2021 03:49:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e25sm3216908wrc.23.2021.09.16.03.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 03:49:13 -0700 (PDT)
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
Subject: [PATCH v6 0/2] add a test mode for SANITIZE=leak, run it in CI
Date:   Thu, 16 Sep 2021 12:48:51 +0200
Message-Id: <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1056.gb2c8c79e36d
In-Reply-To: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
References: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v6 incorporates a suggested fixup from Carlo Marcelo Arenas
Belón, we weren't running at all under OSX as it turns out :
https://lore.kernel.org/git/20210916035603.76369-1-carenas@gmail.com/

So the osx-leaks job has been dropped, and we're not using an older
compiler anymore (I'd just copy/pasted that setting). Since we don't
need it, we can drop the 2nd patch of v5. For v5 see:
https://lore.kernel.org/git/cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com/

This also incorporates a wording fix from Eric Sunshine.

The rest of this CL is just a message for Eric Sunshine, included here
for what should be in case he'll see this on-list:

Eric: If you're reading this I dropped you from CC because since
around September 2nd mailer-daemon@googlemail.com has been failing to
deliver all mail to you. It appears the dynadot.com MTA you use has
banned delivery from GMail's public IP's due to spam complaints:

 The recipient server did not accept our requests to connect. Learn
 more at https://support.google.com/mail/answer/7720
 [parkmail.dynadot.com. 68.68.98.83: 421 parkmail.dynadot.com your ip
 address has been banned due to spam complaints 209.85.167.53 ]
 [parkmail.dynadot.com. 68.68.98.74: 421 parkmail.dynadot.com your ip
 address has been banned due to spam complaints 209.85.167.48 ]
 [parkmail.dynadot.com. 68.68.98.84: 421 parkmail.dynadot.com your ip
 address has been banned due to spam complaints 209.85.167.48 ]

Ævar Arnfjörð Bjarmason (2):
  Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
  tests: add a test mode for SANITIZE=leak, run it in CI

 .github/workflows/main.yml |  3 +++
 Makefile                   |  5 +++++
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  |  9 ++++++++-
 ci/run-build-and-tests.sh  |  2 +-
 t/README                   |  7 +++++++
 t/t0000-basic.sh           |  1 +
 t/t0004-unwritable.sh      |  3 ++-
 t/test-lib.sh              | 21 +++++++++++++++++++++
 9 files changed, 49 insertions(+), 4 deletions(-)

Range-diff against v5:
1:  bdfe2279271 = 1:  fc7ba4cb1c3 Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
2:  6aaa60e3759 < -:  ----------- CI: refactor "if" to "case" statement
3:  f3cd04b16d1 ! 2:  8dcb1269881 tests: add a test mode for SANITIZE=leak, run it in CI
    @@ Commit message
         one-offs without structured regression testing.
     
         This change adds CI testing for it. We'll now build and test
    -    t000[04]*.sh under both Linux and OSX. The new jobs are called
    -    "linux-leaks" and "osx-leaks".
    +    t000[04]*.sh under Linux with a new job called "linux-leaks".
     
         The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
         mode. When running in that mode, we'll assert that we were compiled
         with SANITIZE=leak. We'll then skip all tests, except those that we've
         opted-in by setting "TEST_PASSES_SANITIZE_LEAK=true".
     
    -    A test tests setting "TEST_PASSES_SANITIZE_LEAK=true" setting can in
    -    turn make use of the "SANITIZE_LEAK" prerequisite, should they wish to
    +    A test setting "TEST_PASSES_SANITIZE_LEAK=true" setting can in turn
    +    make use of the "SANITIZE_LEAK" prerequisite, should they wish to
         selectively skip tests even under
    -    "GIT_TEST_PASSING_SANITIZE_LEAK=true". In a preceding commit we
    +    "GIT_TEST_PASSING_SANITIZE_LEAK=true". In the preceding commit we
         started doing this in "t0004-unwritable.sh" under SANITIZE=leak, now
         it'll combine nicely with "GIT_TEST_PASSING_SANITIZE_LEAK=true".
     
    @@ Commit message
         936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
         past history of "one-off" SANITIZE=leak (and more) fixes.
     
    -    The reason for using gcc on OSX over the clang default is because when
    -    used with clang on "macos-latest" it'll currently fail to build with:
    -
    -        clang: error: unsupported option '-fsanitize=leak' for target 'x86_64-apple-darwin19.6.0'
    -
    -    If that's sorted out in the future we might want to run that job with
    -    "clang" merely to make use of the default, and also to add some
    -    compiler variance into the mix. Both use the
    -    "AddressSanitizerLeakSanitizer" library[4], so in they shouldn't
    -    behave differently under GCC or clang.
    +    As noted in [5] we can't support this on OSX yet until Clang 14 is
    +    released, at that point we'll probably want to resurrect that
    +    "osx-leaks" job.
     
         1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
         2. https://lore.kernel.org/git/YS9OT%2Fpn5rRK9cGB@coredump.intra.peff.net/
         3. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
         4. https://lore.kernel.org/git/YS9ZIDpANfsh7N+S@coredump.intra.peff.net/
    +    5. https://lore.kernel.org/git/20210916035603.76369-1-carenas@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    @@ .github/workflows/main.yml: jobs:
     +          - jobname: linux-leaks
     +            cc: gcc
     +            pool: ubuntu-latest
    -+          - jobname: osx-leaks
    -+            cc: gcc
    -+            pool: macos-latest
          env:
            CC: ${{matrix.vector.cc}}
            jobname: ${{matrix.vector.jobname}}
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
      	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
      	sudo apt-get -q update
      	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
    - 		$UBUNTU_COMMON_PKGS
    - 	case "$jobname" in
    --	linux-gcc)
    -+	linux-gcc|linux-leaks)
    - 		sudo apt-get -q -y install gcc-8
    - 		;;
    - 	esac
    -@@ ci/install-dependencies.sh: linux-clang|linux-gcc)
    - 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
    - 	popd
    - 	;;
    --osx-clang|osx-gcc)
    -+osx-clang|osx-gcc|osx-leaks)
    - 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
    - 	# Uncomment this if you want to run perf tests:
    - 	# brew install gnu-time
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
    @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
      case "$jobname" in
     -linux-clang|linux-gcc)
     +linux-clang|linux-gcc|linux-leaks)
    - 	case "$jobname" in
    --	linux-gcc)
    -+	linux-gcc|linux-leaks)
    + 	if [ "$jobname" = linux-gcc ]
    + 	then
      		export CC=gcc-8
    - 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
    - 		;;
    -@@ ci/lib.sh: linux-clang|linux-gcc)
    - 	GIT_LFS_PATH="$HOME/custom/git-lfs"
    - 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
    - 	;;
    --osx-clang|osx-gcc)
    -+osx-clang|osx-gcc|osx-leaks)
    - 	case "$jobname" in
    --	osx-gcc)
    -+	osx-gcc|osx-leaks)
    - 		export CC=gcc-9
    - 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
    - 		;;
     @@ ci/lib.sh: linux-musl)
      	;;
      esac
      
     +case "$jobname" in
    -+linux-leaks|osx-leaks)
    ++linux-leaks)
     +	export SANITIZE=leak
     +	export GIT_TEST_PASSING_SANITIZE_LEAK=true
     +	;;
    @@ ci/lib.sh: linux-musl)
      MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
     
      ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: esac
    +@@ ci/run-build-and-tests.sh: fi
      
      make
      case "$jobname" in
    @@ t/test-lib.sh: then
     +fi
     +
      # Last-minute variable setup
    + USER_HOME="$HOME"
      HOME="$TRASH_DIRECTORY"
    - GNUPGHOME="$HOME/gnupg-home-not-used"
-- 
2.33.0.1056.gb2c8c79e36d

