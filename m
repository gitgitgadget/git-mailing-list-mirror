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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC700C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F5160F92
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhHaNgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhHaNgn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C26C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so2588486wms.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxfEYWGZY1WR1muEdDUETRVEgFnetHfyjGBUWbvLoNA=;
        b=Skk+x+qUcAaK8bCuAC1Evn+9mba2H4CmiEX7XZYvd8kAuuAqr/dA2ErP3JHVasOs94
         fA6lQh+bkM3/XbeG3+GsZGMeSD5q/LWVq2Y6dSRcYXRMkhlIMXp8KvXA6sXCV/HRWY7r
         27USDWiOD81UhFv/rSzdsbvqZ1FENZ/kE6PL1CCDXgWBL4zZ/x15xN4NTkcioSH0dGDb
         LaUOSVhSd4qt6Bxy4H24zbMWjFjnVT4i4+wmZ8bgKBicfIL5g9ur4ZLhSC2J4P9bbJNV
         8zsCH+BAkQOpMOyLmLErGL2EDUKSiabdmnPFmiv872PctuuVHu0ObXjFFWRA5mjQOsGW
         7bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxfEYWGZY1WR1muEdDUETRVEgFnetHfyjGBUWbvLoNA=;
        b=uN0GmVoG7VkccH6grt5tCCKTrNi8ZGuiLlv9OZIxMQwGpKXOfBfItTxCcgBz0vfpIV
         xH+f6vR0RykIWqCmi14CeNc7PUg2E2+Ii5q98PcxY8UsVkiR3n5Cml5HWWhAqcY9wfSj
         yjjTY8tCL/CvRsWwg5xryyX9eRR9+ExXqM052vK6lRINjBl7OmA0E4O9C8mfYG5hDuV6
         R7+enieyFDSmvlCOIjgqeKenFDORwkNpx2pRwQJIzU4rxzMDkaV1ehGcMb4S6xXIRTyA
         aUFOsMuRu/knHYO9n2f98ETRFGP1M7M5Jc/EajbkjcsvRnnxl9MfGpAHHtqucpgBIoH/
         AAfg==
X-Gm-Message-State: AOAM531NQSW6RTiUzZsxTxQDhk8kyvlsEzwnJtFxmJ2+/C7mfu90/Cvz
        eBI189CozxjCxCmba/K0W3vbMj0kLrhtvA==
X-Google-Smtp-Source: ABdhPJwKFbk6BXR/u/Q5d2Y4EOwtJDqsROVv45W3Jrjg3Gn+LtvSaueCL1tPYXMMVa8x6kuRDtbHKA==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr4293664wmq.44.1630416945902;
        Tue, 31 Aug 2021 06:35:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:45 -0700 (PDT)
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
Subject: [PATCH v3 0/8] add a test mode for SANITIZE=leak, run it in CI
Date:   Tue, 31 Aug 2021 15:35:34 +0200
Message-Id: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can compile git with SANITIZE=leak, and have had various efforts in
the past such as 31f9acf9ce2 (Merge branch 'ah/plugleaks', 2021-08-04)
to plug memory leaks, but have had no CI testing of it to ensure that
we don't get regressions. This series adds a GIT_TEST_* mode for
checking those regressions, and runs it in CI.

Since I submitted v2 the delta between origin/master..origin/seen
broke even t0001-init.sh when run under SANITIZE=leak, so this series
will cause test smoke on "seen". It's a prblom with another topic[1]
though, which I and Emily will fix.

Changes since v2:

 * In v2 compiling with SANITIZE=leak would change things so only
   known-good passing tests were run by default, everything else would
   pass as a dummy. Now the default running of tests is unchanged, but
   if we run with GIT_TEST_PASSING_SANITIZE_LEAK=true only those tests
   are run which set and export TEST_PASSES_SANITIZE_LEAK=true.

 * The facility for declaring known-good tests in test-lib.sh based on
   wildcards is gone, instead individual tests need to declare if
   they're OK under SANITIZE=leak. This is done via "export
   TEST_PASSES_SANITIZE_LEAK=true", there's a handy import of
   "./test-pragma-SANITIZE=leak-ok.sh" before sourcing "./test-lib.sh"
   itself to set this.

 * The various leak fixes are gone entirely. I'll submit some of those
   independently or as follow-ups.

 * We now mark 57 tests in the test suite as OK under
   SANITIZE=leak. This is far from all of them, but gives us a decent
   set to start out with. The largest chunk of these is in t0*.sh.

 * The CI job is not run under both GCC and Clang, but just whatever
   with one default compiler (which happens to be GCC). I'd missed
   that running under both was pointless.

   It would be meaningful to run this under e.g. OSX & Windows too, as
   we take different codepaths there, but that can be left to a
   follow-up series.

1. https://lore.kernel.org/git/8735qvyw0p.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (8):
  Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
  CI: refactor "if" to "case" statement
  tests: add a test mode for SANITIZE=leak, run it in CI
  tests: annotate t000*.sh with TEST_PASSES_SANITIZE_LEAK=true
  tests: annotate t001*.sh with TEST_PASSES_SANITIZE_LEAK=true
  tests: annotate t002*.sh with TEST_PASSES_SANITIZE_LEAK=true
  tests: annotate select t0*.sh with TEST_PASSES_SANITIZE_LEAK=true
  tests: annotate select t*.sh with TEST_PASSES_SANITIZE_LEAK=true

 .github/workflows/main.yml              |  2 ++
 Makefile                                |  5 +++++
 ci/install-dependencies.sh              |  4 ++--
 ci/lib.sh                               | 29 +++++++++++++++++--------
 ci/run-build-and-tests.sh               |  4 ++--
 t/README                                |  7 ++++++
 t/t0000-basic.sh                        |  1 +
 t/t0001-init.sh                         |  1 +
 t/t0002-gitfile.sh                      |  1 +
 t/t0003-attributes.sh                   |  1 +
 t/t0004-unwritable.sh                   |  3 ++-
 t/t0005-signals.sh                      |  2 ++
 t/t0007-git-var.sh                      |  2 ++
 t/t0008-ignores.sh                      |  1 +
 t/t0010-racy-git.sh                     |  1 +
 t/t0011-hashmap.sh                      |  1 +
 t/t0013-sha1dc.sh                       |  1 +
 t/t0016-oidmap.sh                       |  1 +
 t/t0017-env-helper.sh                   |  1 +
 t/t0018-advice.sh                       |  1 +
 t/t0022-crlf-rename.sh                  |  1 +
 t/t0024-crlf-archive.sh                 |  1 +
 t/t0025-crlf-renormalize.sh             |  1 +
 t/t0026-eol-config.sh                   |  1 +
 t/t0029-core-unsetenvvars.sh            |  1 +
 t/t0030-stripspace.sh                   |  1 +
 t/t0052-simple-ipc.sh                   |  1 +
 t/t0061-run-command.sh                  |  1 +
 t/t0063-string-list.sh                  |  1 +
 t/t0066-dir-iterator.sh                 |  1 +
 t/t0067-parse_pathspec_file.sh          |  1 +
 t/t0091-bugreport.sh                    |  1 +
 t/t1010-mktree.sh                       |  1 +
 t/t1100-commit-tree-options.sh          |  1 +
 t/t1308-config-set.sh                   |  1 +
 t/t1309-early-config.sh                 |  1 +
 t/t1420-lost-found.sh                   |  1 +
 t/t1430-bad-ref-name.sh                 |  1 +
 t/t1509-root-work-tree.sh               |  1 +
 t/t2002-checkout-cache-u.sh             |  1 +
 t/t2050-git-dir-relative.sh             |  1 +
 t/t2081-parallel-checkout-collisions.sh |  1 +
 t/t2100-update-cache-badpath.sh         |  1 +
 t/t2200-add-update.sh                   |  1 +
 t/t2201-add-update-typechange.sh        |  1 +
 t/t2202-add-addremove.sh                |  1 +
 t/t2204-add-ignored.sh                  |  1 +
 t/t2300-cd-to-toplevel.sh               |  1 +
 t/t3000-ls-files-others.sh              |  1 +
 t/t3004-ls-files-basic.sh               |  1 +
 t/t3006-ls-files-long.sh                |  1 +
 t/t3008-ls-files-lazy-init-name-hash.sh |  1 +
 t/t3100-ls-tree-restrict.sh             |  1 +
 t/t3101-ls-tree-dirname.sh              |  1 +
 t/t3102-ls-tree-wildcards.sh            |  1 +
 t/t3103-ls-tree-misc.sh                 |  1 +
 t/t3205-branch-color.sh                 |  1 +
 t/t3211-peel-ref.sh                     |  1 +
 t/t3300-funny-names.sh                  |  1 +
 t/t3902-quoted.sh                       |  1 +
 t/t4002-diff-basic.sh                   |  1 +
 t/t4026-color.sh                        |  1 +
 t/t4300-merge-tree.sh                   |  1 +
 t/test-lib.sh                           | 22 +++++++++++++++++++
 t/test-pragma-SANITIZE=leak-ok.sh       |  8 +++++++
 65 files changed, 128 insertions(+), 14 deletions(-)
 create mode 100644 t/test-pragma-SANITIZE=leak-ok.sh

Range-diff against v2:
-:  ----------- > 1:  85619728d41 Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
-:  ----------- > 2:  91c36b94eaa CI: refactor "if" to "case" statement
1:  df5a44e70b5 ! 3:  7e3577e4e3c tests: add a test mode for SANITIZE=leak, run it in CI
    @@ Commit message
         corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
         fixed as one-offs without structured regression testing.
     
    -    This change add such a mode, we now have new
    -    linux-{clang,gcc}-sanitize-leak CI targets, these targets run the same
    -    tests as linux-{clang,gcc}, except that almost all of them are
    -    skipped.
    +    This change add such a mode, and a new linux-SANITIZE=leak CI
    +    target. The test mode and CI target only runs a whitelist of
    +    known-good tests using a mechanism discussed below, to ensure that we
    +    won't add regressions to code that's had its memory leaks fixed.
     
    -    There is a whitelist of some tests that are OK in test-lib.sh, and
    -    individual tests can be opted-in by setting
    -    GIT_TEST_SANITIZE_LEAK=true before sourcing test-lib.sh. Within those
    -    individual test can be skipped with the "!SANITIZE_LEAK"
    -    prerequisite. See the updated t/README for more details.
    +    The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
    +    mode. When running in that mode all tests except those that have opted
    +    themselves in to running by setting and exporting
    +    TEST_PASSES_SANITIZE_LEAK=true before sourcing test-lib.sh.
     
    -    I'm using the GIT_TEST_SANITIZE_LEAK=true and !SANITIZE_LEAK pattern
    -    in a couple of tests whose memory leaks I'll fix in subsequent
    -    commits.
    +    I'm adding a "test-pragma-SANITIZE=leak-ok.sh" wrapper for setting and
    +    exporting that variable, as the assignment/export boilerplate would
    +    otherwise get quite verbose and repetitive in subsequent commits.
     
    -    I'm not being aggressive about opting in tests, it's not all tests
    -    that currently pass under SANITIZE=leak, just a small number of
    -    known-good tests. We can add more later as we fix leaks and grow more
    -    confident in this test mode.
    +    The tests using the "test-pragma-SANITIZE=leak-ok.sh" pragma can in
    +    turn make use of the "SANITIZE_LEAK" prerequisite added in a preceding
    +    commit, should they wish to selectively skip tests even under
    +    "GIT_TEST_PASSING_SANITIZE_LEAK=true".
     
    -    See the recent discussion at [1] about the lack of this sort of test
    -    mode, and 0e5bba53af (add UNLEAK annotation for reducing leak false
    -    positives, 2017-09-08) for the initial addition of SANITIZE=leak.
    +    Now tests that don't set the "test-pragma-SANITIZE=leak-ok.sh" pragma
    +    will be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:
    +
    +        $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0001-init.sh
    +        1..0 # SKIP skip all tests in t0001 under SANITIZE=leak, TEST_PASSES_SANITIZE_LEAK not set
    +
    +    In subsequents commit we'll conservatively add more
    +    TEST_PASSES_SANITIZE_LEAK=true annotations. The idea is that as memory
    +    leaks are fixed we can add more known-good tests to this CI target, to
    +    ensure that we won't have regressions.
    +
    +    As of writing this we've got major regressions between master..seen,
    +    i.e. the t000*.sh tests and more fixed since 31f9acf9ce2 (Merge branch
    +    'ah/plugleaks', 2021-08-04) have regressed recently.
    +
    +    See the discussion at <87czsv2idy.fsf@evledraar.gmail.com> about the
    +    lack of this sort of test mode, and 0e5bba53af (add UNLEAK annotation
    +    for reducing leak false positives, 2017-09-08) for the initial
    +    addition of SANITIZE=leak.
     
         See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
         7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
         936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
         past history of "one-off" SANITIZE=leak (and more) fixes.
     
    -    When calling maybe_skip_all_sanitize_leak matching against
    -    "$TEST_NAME" instead of "$this_test" as other "match_pattern_list()"
    -    users do is intentional. I'd like to match things like "t13*config*"
    -    in subsequent commits. This part of the API isn't public, so we can
    -    freely change it in the future.
    -
    -    1. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
                - jobname: linux-gcc-default
                  cc: gcc
                  pool: ubuntu-latest
    -+          - jobname: linux-clang-sanitize-leak
    -+            cc: clang
    -+            pool: ubuntu-latest
    -+          - jobname: linux-gcc-sanitize-leak
    -+            cc: gcc
    ++          - jobname: linux-SANITIZE=leak
     +            pool: ubuntu-latest
          env:
            CC: ${{matrix.vector.cc}}
            jobname: ${{matrix.vector.jobname}}
     
    - ## Makefile ##
    -@@ Makefile: PTHREAD_CFLAGS =
    - SPARSE_FLAGS ?=
    - SP_EXTRA_FLAGS = -Wno-universal-initializer
    - 
    -+# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
    -+SANITIZE_LEAK =
    -+
    - # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
    - # usually result in less CPU usage at the cost of higher peak memory.
    - # Setting it to 0 will feed all files in a single spatch invocation.
    -@@ Makefile: BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
    - endif
    - ifneq ($(filter leak,$(SANITIZERS)),)
    - BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
    -+SANITIZE_LEAK = YesCompiledWithIt
    - endif
    - ifneq ($(filter address,$(SANITIZERS)),)
    - NO_REGEX = NeededForASAN
    -@@ Makefile: GIT-BUILD-OPTIONS: FORCE
    - 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
    - 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
    - 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
    -+	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
    - 	@echo X=\'$(X)\' >>$@+
    - ifdef TEST_OUTPUT_DIRECTORY
    - 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
    -
      ## ci/install-dependencies.sh ##
     @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
       libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
      
      case "$jobname" in
     -linux-clang|linux-gcc)
    -+linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
    ++linux-clang|linux-gcc|linux-SANITIZE=leak)
      	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
      	sudo apt-get -q update
      	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
      		$UBUNTU_COMMON_PKGS
      	case "$jobname" in
     -	linux-gcc)
    -+	linux-gcc|linux-gcc-sanitize-leak)
    ++	linux-gcc|linux-SANITIZE=leak)
      		sudo apt-get -q -y install gcc-8
      		;;
      	esac
    @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
      
      case "$jobname" in
     -linux-clang|linux-gcc)
    --	if [ "$jobname" = linux-gcc ]
    --	then
    -+linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
    -+	case "$jobname" in
    -+	linux-gcc|linux-gcc-sanitize-leak)
    ++linux-clang|linux-gcc|linux-SANITIZE=leak)
    + 	case "$jobname" in
    +-	linux-gcc)
    ++	linux-gcc|linux-SANITIZE=leak)
      		export CC=gcc-8
      		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
    --	else
    -+		;;
    -+	*)
    - 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
    --	fi
    -+		;;
    -+	esac
    - 
    - 	export GIT_TEST_HTTPD=true
    - 
    + 		;;
     @@ ci/lib.sh: linux-musl)
      	;;
      esac
      
     +case "$jobname" in
    -+linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
    ++linux-SANITIZE=leak)
     +	export SANITIZE=leak
    ++	export GIT_TEST_PASSING_SANITIZE_LEAK=true
     +	;;
     +esac
     +
    @@ ci/run-build-and-tests.sh: esac
      make
      case "$jobname" in
     -linux-gcc)
    -+linux-gcc|linux-gcc-sanitize-leak)
    ++linux-gcc|linux-SANITIZE=leak)
      	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      	make test
      	export GIT_TEST_SPLIT_INDEX=yes
    @@ ci/run-build-and-tests.sh: linux-gcc)
      	make test
      	;;
     -linux-clang)
    -+linux-clang|linux-clang-sanitize-leak)
    ++linux-clang|linux-SANITIZE=leak)
      	export GIT_TEST_DEFAULT_HASH=sha1
      	make test
      	export GIT_TEST_DEFAULT_HASH=sha256
    @@ t/README: GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
      to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
      execution of the parallel-checkout code.
      
    -+GIT_TEST_SANITIZE_LEAK=<boolean> will force the tests to run when git
    -+is compiled with SANITIZE=leak (we pick it up via
    -+../GIT-BUILD-OPTIONS).
    -+
    -+By default all tests are skipped when compiled with SANITIZE=leak, and
    -+individual test scripts opt themselves in to leak testing by setting
    -+GIT_TEST_SANITIZE_LEAK=true before sourcing test-lib.sh. Within those
    -+tests use the SANITIZE_LEAK prerequisite to skip individiual tests
    -+(i.e. test_expect_success !SANITIZE_LEAK [...]).
    -+
    -+So the GIT_TEST_SANITIZE_LEAK setting is different in behavior from
    -+both other GIT_TEST_*=[true|false] settings, but more useful given how
    -+SANITIZE=leak works & the state of the test suite. Manually setting
    -+GIT_TEST_SANITIZE_LEAK=true is only useful during development when
    -+finding and fixing memory leaks.
    ++GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
    ++SANITIZE=leak will run only those tests that have whitelisted
    ++themselves as passing with no memory leaks. Do this by sourcing
    ++"test-pragma-SANITIZE=leak-ok.sh" before sourcing "test-lib.sh" itself
    ++at the top of the test script. This test mode is used by the
    ++"linux-SANITIZE=leak" CI target.
     +
      Naming Tests
      ------------
      
     
    - ## t/t5701-git-serve.sh ##
    -@@ t/t5701-git-serve.sh: test_expect_success 'unexpected lines are not allowed in fetch request' '
    + ## t/t0000-basic.sh ##
    +@@ t/t0000-basic.sh: swapping compression and hashing order, the person who is making the
    + modification *should* take notice and update the test vectors here.
    + '
    + 
    ++. ./test-pragma-SANITIZE=leak-ok.sh
    + . ./test-lib.sh
      
    - # Test the basics of object-info
    - #
    --test_expect_success 'basics of object-info' '
    -+test_expect_success !SANITIZE_LEAK 'basics of object-info' '
    - 	test-tool pkt-line pack >in <<-EOF &&
    - 	command=object-info
    - 	object-format=$(test_oid algo)
    + try_local_xy () {
     
      ## t/test-lib.sh ##
    -@@ t/test-lib.sh: then
    - 	exit 1
    - fi
    - 
    -+# SANITIZE=leak test mode
    -+sanitize_leak_true=
    -+add_sanitize_leak_true () {
    -+	sanitize_leak_true="$sanitize_leak_true$1 "
    -+}
    -+
    -+sanitize_leak_false=
    -+add_sanitize_leak_false () {
    -+	sanitize_leak_false="$sanitize_leak_false$1 "
    -+}
    -+
    -+sanitize_leak_opt_in_msg="opt-in with GIT_TEST_SANITIZE_LEAK=true"
    -+maybe_skip_all_sanitize_leak () {
    -+	# Whitelist patterns
    -+	add_sanitize_leak_true 't000*'
    -+	add_sanitize_leak_true 't001*'
    -+	add_sanitize_leak_true 't006*'
    -+
    -+	# Blacklist patterns (overrides whitelist)
    -+	add_sanitize_leak_false 't000[469]*'
    -+	add_sanitize_leak_false 't001[2459]*'
    -+	add_sanitize_leak_false 't006[0248]*'
    -+
    -+	if match_pattern_list "$1" "$sanitize_leak_false"
    -+	then
    -+		skip_all="test $this_test on SANITIZE=leak blacklist, $sanitize_leak_opt_in_msg"
    -+		test_done
    -+	elif match_pattern_list "$1" "$sanitize_leak_true"
    -+	then
    -+		return 0
    -+	fi
    -+	return 1
    -+}
    -+
    - # Are we running this test at all?
    - remove_trash=
    - this_test=${0##*/}
     @@ t/test-lib.sh: then
      	test_done
      fi
    @@ t/test-lib.sh: then
     +# SANITIZE=leak
     +if test -n "$SANITIZE_LEAK"
     +then
    -+	if test -z "$GIT_TEST_SANITIZE_LEAK" &&
    -+		maybe_skip_all_sanitize_leak "$TEST_NAME"
    ++	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
     +	then
    -+		say_color info >&3 "test $this_test on SANITIZE=leak whitelist"
    -+		GIT_TEST_SANITIZE_LEAK=true
    -+	fi
    ++		# We need to see it in "git env--helper" (via
    ++		# test_bool_env)
    ++		export TEST_PASSES_SANITIZE_LEAK
     +
    -+	# We need to see it in "git env--helper" (via
    -+	# test_bool_env)
    -+	export GIT_TEST_SANITIZE_LEAK
    -+
    -+	if ! test_bool_env GIT_TEST_SANITIZE_LEAK false
    -+	then
    -+		skip_all="skip all tests in $this_test under SANITIZE=leak, $sanitize_leak_opt_in_msg"
    -+		test_done
    ++		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
    ++		then
    ++			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
    ++			test_done
    ++		fi
     +	fi
    -+elif test_bool_env GIT_TEST_SANITIZE_LEAK false
    ++elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
     +then
    -+	error "GIT_TEST_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
    ++	error "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
     +fi
     +
      # Last-minute variable setup
      HOME="$TRASH_DIRECTORY"
      GNUPGHOME="$HOME/gnupg-home-not-used"
    -@@ t/test-lib.sh: test -z "$NO_PYTHON" && test_set_prereq PYTHON
    - test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
    - test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
    - test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
    -+test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
    - 
    - if test -z "$GIT_TEST_CHECK_CACHE_TREE"
    - then
    +
    + ## t/test-pragma-SANITIZE=leak-ok.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++## This "pragma" (as in "perldoc perlpragma") declares that the test
    ++## will pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. Source this
    ++## before sourcing test-lib.sh
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    ++export TEST_PASSES_SANITIZE_LEAK
2:  51fd1c400da < -:  ----------- SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
3:  720852eee0b < -:  ----------- SANITIZE tests: fix memory leaks in t5701*, add to whitelist
4:  80edda308c9 < -:  ----------- SANITIZE tests: fix leak in mailmap.c
-:  ----------- > 4:  0cd14d64165 tests: annotate t000*.sh with TEST_PASSES_SANITIZE_LEAK=true
-:  ----------- > 5:  ed5f5705755 tests: annotate t001*.sh with TEST_PASSES_SANITIZE_LEAK=true
-:  ----------- > 6:  2599016c4e7 tests: annotate t002*.sh with TEST_PASSES_SANITIZE_LEAK=true
-:  ----------- > 7:  ddc4d6d2cf1 tests: annotate select t0*.sh with TEST_PASSES_SANITIZE_LEAK=true
-:  ----------- > 8:  e611d2c23d9 tests: annotate select t*.sh with TEST_PASSES_SANITIZE_LEAK=true
-- 
2.33.0.805.g739b16c2189

