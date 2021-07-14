Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1560AC11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 03:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE39460720
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 03:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhGND0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 23:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhGND0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 23:26:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9FC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 20:23:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w15so893245pgk.13
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vlPlwzQlWZsQ4v+ofTJMq5VyEL2H1zLoQ1gtY1+CDy8=;
        b=C1PoGyd9dojlsCYEKCLlrAYdBAcoYzxfYmjYDeBJMp4J8zrrs93KsG9z/XfB4mDLyD
         0PuVTTpBx3W1loxBiLwcJzr8IMWHFO06b9xuaSsedVrZSEdnbnUi+gPmIiCWsrtHu7Dl
         Bsu+xJCwHob9z8F8l8gtuRQQUrIjQ6Nqhbsmirw+SgjlUxmkCsZiyg4yBZS8s1qkQMP1
         LBPQtHKk4zIwUVNhMz2oEUXZsRuYSK/BHcVrU0y/c4eP4IWhEMB+SkzoP5I/QIwM7AaX
         vIdgS2tHmUF0PWcX7xSFFoI3IE01eQyYCI2q1ubheBH2tC3q1XPFoKp3e/efDdChNWT9
         t3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vlPlwzQlWZsQ4v+ofTJMq5VyEL2H1zLoQ1gtY1+CDy8=;
        b=F++n+PIlxOA6dJ5VVn5WTBnola3AI3IaoV+/tcH4Ii00LjV6LYRQhQn3hE0/x0wspN
         lzrt8UjkKfp31e1TtF3odpIx9cR80/jICSScJRZ63P+5jY4Gh3SiEVt4pLkeic2Ijerz
         GYSjnmNoPIqMcN7K1/5Q2Uw+4rIQw5ZlJ58LuKsEy9LUQUaUIIrBJsqRwfs/Dul+/WZH
         ohbf7ceH2krHLinIe9pETr4yh0tj5uroCoVjx56pbN556eNY+uJ5GNBDuxrFhgdMlvjr
         r6KWKfUQH5xzcPm+/kbfam3z+2pGAwx+cZxVJmhYrAmQlzkf/pw5V5CtFWk0wLbS47B/
         07Dw==
X-Gm-Message-State: AOAM531HFdl7Ew+cqnssR6M1lvPiigXzqksWf1YlqABC+BG1W+clFFwk
        XtQbCX7j9nWPF6oAE3kZSYU=
X-Google-Smtp-Source: ABdhPJwvV3rXaTUYuCw/v1JV5EXUECslkn9ai2h8bvjxrmNi7YrQjqnOob7RjsJZU8FA+1OmVPFBkA==
X-Received: by 2002:a63:f654:: with SMTP id u20mr7404757pgj.89.1626233011705;
        Tue, 13 Jul 2021 20:23:31 -0700 (PDT)
Received: from localhost ([2402:800:63b8:f6f9:3a91:18b:7264:dbcb])
        by smtp.gmail.com with ESMTPSA id k6sm91504pju.8.2021.07.13.20.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 20:23:31 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:23:29 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/4] tests: add a test mode for SANITIZE=leak, run it in
 CI
Message-ID: <YO5YsWV5dIW3XbiV@danh.dev>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <patch-1.4-a61a294132-20210714T001007Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.4-a61a294132-20210714T001007Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-14 02:11:46+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> While git can be compiled with SANITIZE=leak there has been no
> corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
> fixed as one-offs without structured regression testing.
> 
> This change add such a mode, we now have new
> linux-{clang,gcc}-sanitize-leak CI targets, these targets run the same
> tests as linux-{clang,gcc}, except that almost all of them are
> skipped.
> 
> There is a whitelist of some tests that are OK in test-lib.sh, and
> individual tests can be opted-in by setting
> GIT_TEST_SANITIZE_LEAK=true before sourcing test-lib.sh. Within those
> individual test can be skipped with the "!SANITIZE_LEAK"
> prerequisite. See the updated t/README for more details.
> 
> I'm using the GIT_TEST_SANITIZE_LEAK=true and !SANITIZE_LEAK pattern
> in a couple of tests whose memory leaks I'll fix in subsequent
> commits.
> 
> I'm not being aggressive about opting in tests, it's not all tests
> that currently pass under SANITIZE=leak, just a small number of
> known-good tests. We can add more later as we fix leaks and grow more
> confident in this test mode.
> 
> See the recent discussion at [1] about the lack of this sort of test
> mode, and 0e5bba53af (add UNLEAK annotation for reducing leak false
> positives, 2017-09-08) for the initial addition of SANITIZE=leak.
> 
> See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
> 7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
> 936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
> past history of "one-off" SANITIZE=leak (and more) fixes.
> 
> When calling maybe_skip_all_sanitize_leak matching against
> "$TEST_NAME" instead of "$this_test" as other "match_pattern_list()"
> users do is intentional. I'd like to match things like "t13*config*"
> in subsequent commits. This part of the API isn't public, so we can
> freely change it in the future.
> 
> 1. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .github/workflows/main.yml  |  6 ++++
>  Makefile                    |  5 ++++
>  ci/install-dependencies.sh  |  4 +--
>  ci/lib.sh                   | 18 +++++++----
>  ci/run-build-and-tests.sh   |  4 +--
>  t/README                    | 16 ++++++++++
>  t/t0500-progress-display.sh |  3 +-
>  t/t5701-git-serve.sh        |  2 +-
>  t/test-lib.sh               | 60 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 107 insertions(+), 11 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 73856bafc9..b81ec34959 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -297,6 +297,12 @@ jobs:
>            - jobname: linux-gcc-default
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: linux-clang-sanitize-leak
> +            cc: clang
> +            pool: ubuntu-latest
> +          - jobname: linux-gcc-sanitize-leak
> +            cc: clang

I think you meant:

	cc: gcc

?
> +            pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        jobname: ${{matrix.vector.jobname}}
> diff --git a/Makefile b/Makefile
> index 502e0c9a81..d4cad5136f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1216,6 +1216,9 @@ PTHREAD_CFLAGS =
>  SPARSE_FLAGS ?=
>  SP_EXTRA_FLAGS = -Wno-universal-initializer
>  
> +# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
> +SANITIZE_LEAK =
> +
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
>  # Setting it to 0 will feed all files in a single spatch invocation.
> @@ -1260,6 +1263,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>  endif
>  ifneq ($(filter leak,$(SANITIZERS)),)
>  BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
> +SANITIZE_LEAK = YesCompiledWithIt
>  endif
>  ifneq ($(filter address,$(SANITIZERS)),)
>  NO_REGEX = NeededForASAN
> @@ -2793,6 +2797,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
>  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
> +	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
>  	@echo X=\'$(X)\' >>$@+
>  ifdef TEST_OUTPUT_DIRECTORY
>  	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 67852d0d37..31e519cde9 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -12,13 +12,13 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
>   libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
>  
>  case "$jobname" in
> -linux-clang|linux-gcc)
> +linux-clang*|linux-gcc*)

This also affects linux-gcc-default, is it intended?
I think no? So, a case for linux-gcc-default is needed here.

>  	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>  		$UBUNTU_COMMON_PKGS
>  	case "$jobname" in
> -	linux-gcc)
> +	linux-gcc*)
>  		sudo apt-get -q -y install gcc-8
>  		;;
>  	esac
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 476c3f369f..34fd914438 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -183,14 +183,16 @@ export GIT_TEST_CLONE_2GB=true
>  export SKIP_DASHED_BUILT_INS=YesPlease
>  
>  case "$jobname" in
> -linux-clang|linux-gcc)
> -	if [ "$jobname" = linux-gcc ]
> -	then
> +linux-clang*|linux-gcc*)

Ditto.

> +	case "$jobname" in
> +	linux-gcc*)
>  		export CC=gcc-8
>  		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
> -	else
> +		;;
> +	*)
>  		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
> -	fi
> +		;;
> +	esac
>  
>  	export GIT_TEST_HTTPD=true
>  
> @@ -233,4 +235,10 @@ linux-musl)
>  	;;
>  esac
>  
> +case "$jobname" in
> +linux-*-sanitize-leak)
> +	export SANITIZE=leak
> +	;;
> +esac
> +
>  MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 3ce81ffee9..07b9c09f45 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -12,7 +12,7 @@ esac
>  
>  make
>  case "$jobname" in
> -linux-gcc)
> +linux-gcc*)

But, I'm not sure about this one, though.
linux-gcc-default falls into '*' leg, as of it's now.
Do we want to run it in this leg or the original one?

>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  	make test
>  	export GIT_TEST_SPLIT_INDEX=yes
> @@ -29,7 +29,7 @@ linux-gcc)
>  	export GIT_TEST_CHECKOUT_WORKERS=2
>  	make test
>  	;;
> -linux-clang)
> +linux-clang*)
>  	export GIT_TEST_DEFAULT_HASH=sha1
>  	make test
>  	export GIT_TEST_DEFAULT_HASH=sha256
> diff --git a/t/README b/t/README
> index 1a2072b2c8..303d0be817 100644
> --- a/t/README
> +++ b/t/README
> @@ -448,6 +448,22 @@ GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
>  to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
>  execution of the parallel-checkout code.
>  
> +GIT_TEST_SANITIZE_LEAK=<boolean> will force the tests to run when git
> +is compiled with SANITIZE=leak (we pick it up via
> +../GIT-BUILD-OPTIONS).
> +
> +By default all tests are skipped when compiled with SANITIZE=leak, and
> +individual test scripts opt themselves in to leak testing by setting
> +GIT_TEST_SANITIZE_LEAK=true before sourcing test-lib.sh. Within those
> +tests use the SANITIZE_LEAK prerequisite to skip individiual tests
> +(i.e. test_expect_success !SANITIZE_LEAK [...]).
> +
> +So the GIT_TEST_SANITIZE_LEAK setting is different in behavior from
> +both other GIT_TEST_*=[true|false] settings, but more useful given how
> +SANITIZE=leak works & the state of the test suite. Manually setting
> +GIT_TEST_SANITIZE_LEAK=true is only useful during development when
> +finding and fixing memory leaks.
> +
>  Naming Tests
>  ------------
>  
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index 22058b503a..7afb9abb1f 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -2,6 +2,7 @@
>  
>  test_description='progress display'
>  
> +GIT_TEST_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  show_cr () {
> @@ -283,7 +284,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
>  	test_cmp expect out
>  '
>  
> -test_expect_success 'progress generates traces' '
> +test_expect_success !SANITIZE_LEAK 'progress generates traces' '
>  	cat >in <<-\EOF &&
>  	throughput 102400 1000
>  	update
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 930721f053..d58efb0aa9 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -243,7 +243,7 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
>  
>  # Test the basics of object-info
>  #
> -test_expect_success 'basics of object-info' '
> +test_expect_success !SANITIZE_LEAK 'basics of object-info' '
>  	test-tool pkt-line pack >in <<-EOF &&
>  	command=object-info
>  	object-format=$(test_oid algo)
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7036f83b33..9201510e16 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1353,6 +1353,40 @@ then
>  	exit 1
>  fi
>  
> +# SANITIZE=leak test mode
> +sanitize_leak_true=
> +add_sanitize_leak_true () {
> +	sanitize_leak_true="$sanitize_leak_true$1 "
> +}
> +
> +sanitize_leak_false=
> +add_sanitize_leak_false () {
> +	sanitize_leak_false="$sanitize_leak_false$1 "
> +}
> +
> +sanitize_leak_opt_in_msg="opt-in with GIT_TEST_SANITIZE_LEAK=true"
> +maybe_skip_all_sanitize_leak () {
> +	# Whitelist patterns
> +	add_sanitize_leak_true 't000*'
> +	add_sanitize_leak_true 't001*'
> +	add_sanitize_leak_true 't006*'
> +
> +	# Blacklist patterns (overrides whitelist)
> +	add_sanitize_leak_false 't000[469]*'
> +	add_sanitize_leak_false 't001[2459]*'
> +	add_sanitize_leak_false 't006[0248]*'
> +
> +	if match_pattern_list "$1" "$sanitize_leak_false"
> +	then
> +		skip_all="test $this_test on SANITIZE=leak blacklist, $sanitize_leak_opt_in_msg"
> +		test_done
> +	elif match_pattern_list "$1" "$sanitize_leak_true"
> +	then
> +		return 0
> +	fi
> +	return 1
> +}
> +
>  # Are we running this test at all?
>  remove_trash=
>  this_test=${0##*/}
> @@ -1364,6 +1398,31 @@ then
>  	test_done
>  fi
>  
> +# Aggressively skip non-whitelisted tests when compiled with
> +# SANITIZE=leak
> +if test -n "$SANITIZE_LEAK"
> +then
> +	if test -z "$GIT_TEST_SANITIZE_LEAK" &&
> +		maybe_skip_all_sanitize_leak "$TEST_NAME"
> +	then
> +		say_color info >&3 "test $this_test on SANITIZE=leak whitelist"
> +		GIT_TEST_SANITIZE_LEAK=true
> +	fi
> +
> +	# We need to see it in "git env--helper" (via
> +	# test_bool_env)
> +	export GIT_TEST_SANITIZE_LEAK
> +
> +	if ! test_bool_env GIT_TEST_SANITIZE_LEAK false
> +	then
> +		skip_all="skip all tests in $this_test under SANITIZE=leak, $sanitize_leak_opt_in_msg"
> +		test_done
> +	fi
> +elif test_bool_env GIT_TEST_SANITIZE_LEAK false
> +then
> +	error "GIT_TEST_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
> +fi
> +
>  # Last-minute variable setup
>  HOME="$TRASH_DIRECTORY"
>  GNUPGHOME="$HOME/gnupg-home-not-used"
> @@ -1516,6 +1575,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
>  test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
>  test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
>  test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
> +test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
>  
>  if test -z "$GIT_TEST_CHECK_CACHE_TREE"
>  then
> -- 
> 2.32.0-dev
> 

-- 
Danh
