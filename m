Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5099AC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3116D61212
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhISIF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhISIF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:05:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC923C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:04:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so6853645wmj.3
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pXo4fVMYP6D38S+jS0g/OEpvWkFKLtbJYqEUp0O6c0=;
        b=Mjfmx3CbcMXjA/9q/IAOolnVaykBJshhG2ZNThuHMYw+jgSwJO0C4vkFBDamTKVhZV
         h0tLf5PuKO72VwAV5agSDSF7iyYvdvVxzFwtu2fSIkUlSRkCJV863Z5H56jsGLaweoGF
         0Dgwb8pLmDG0xB96BNTfZNIIFw736eyZ83L7Qw+RXULVBTp92v/vjVVcWi7ETihbfWX2
         C7WvUe+077tb3E91Cr2R/lkKkpjkAc0ZEuZN0qFxaXMS7u/KW232TZLo3xyRx82Lgtce
         u3O29UtGNCpCHqmwtrMpqRx6ukgYqLPLlGEhT8ODUFF4rkrmjQlBN7zZ8yMyoJxevV/t
         xG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pXo4fVMYP6D38S+jS0g/OEpvWkFKLtbJYqEUp0O6c0=;
        b=ZKgq3BtXO/ErCEj23f9hY0p+lsvSK2UmxQQlO9W/Le1vh57+uL+USCQIfnnzA+uh5H
         M7oY+/rjjGRP2zCqqNBO2tpjTmJyyeiv5sKHgkKORDLGs1GzQLI0SmhqYgT5Jb7id5FM
         oBxaNWkc3/i7ypRp4B9pZhtqLXjVVUoMGd5yDZ5ZgO8rWTyfgH73h6W1Ml2hJTwRRks2
         7ubl8gasv35HJRSEUj7kBSPrUlVo7xhnKWNM8dEyYoQpB8b+eJUJ3ayxwos91ck/6bwF
         4Sep5E1/7YlHMBFzKHsCsVpy9fdd/v4NSKDhsLZg5qZxGTQEU/DLxalCsdD2cA4mc7Jb
         DuMQ==
X-Gm-Message-State: AOAM530okf+O4TX8/eFDtMcCs/8iqUfs/F0LH/3V6gb4RaI1jGQ9epQC
        JpcXDtEVZlt6ysjHeCRbrt4nnnmwD29Ntg==
X-Google-Smtp-Source: ABdhPJzsOfxCKz3ADcpara0sN6zHRA09sDYTtDBwiNKVnBy7n7YQRb2vjugoAEXLwlIKmmWU+sIvmA==
X-Received: by 2002:a05:600c:19d4:: with SMTP id u20mr23025106wmq.28.1632038639922;
        Sun, 19 Sep 2021 01:03:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm14887692wmc.24.2021.09.19.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:03:59 -0700 (PDT)
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
Subject: [PATCH v7 2/2] tests: add a test mode for SANITIZE=leak, run it in CI
Date:   Sun, 19 Sep 2021 10:03:54 +0200
Message-Id: <patch-v7-2.2-56592952db5-20210919T075619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
References: <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com> <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While git can be compiled with SANITIZE=leak, we have not run
regression tests under that mode. Memory leaks have only been fixed as
one-offs without structured regression testing.

This change adds CI testing for it. We'll now build and small set of
whitelisted t00*.sh tests under Linux with a new job called
"linux-leaks".

The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
mode. When running in that mode, we'll assert that we were compiled
with SANITIZE=leak. We'll then skip all tests, except those that we've
opted-in by setting "TEST_PASSES_SANITIZE_LEAK=true".

A test setting "TEST_PASSES_SANITIZE_LEAK=true" setting can in turn
make use of the "SANITIZE_LEAK" prerequisite, should they wish to
selectively skip tests even under
"GIT_TEST_PASSING_SANITIZE_LEAK=true". In the preceding commit we
started doing this in "t0004-unwritable.sh" under SANITIZE=leak, now
it'll combine nicely with "GIT_TEST_PASSING_SANITIZE_LEAK=true".

This is how tests that don't set "TEST_PASSES_SANITIZE_LEAK=true" will
be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0001-init.sh
    1..0 # SKIP skip all tests in t0001 under SANITIZE=leak, TEST_PASSES_SANITIZE_LEAK not set

The intent is to add more TEST_PASSES_SANITIZE_LEAK=true annotations
as follow-up change, but let's start small to begin with.

It would also be possible to implement a more lightweight version of
this by only relying on setting "LSAN_OPTIONS". See
<YS9OT/pn5rRK9cGB@coredump.intra.peff.net>[1] and
<YS9ZIDpANfsh7N+S@coredump.intra.peff.net>[2] for a discussion of
that. I've opted for this approach of adding a GIT_TEST_* mode instead
because it's consistent with how we handle other special test modes.

Being able to add a "!SANITIZE_LEAK" prerequisite and calling
"test_done" early if it isn't satisfied also means that we can more
incrementally add regression tests without being forced to fix
widespread and hard-to-fix leaks at the same time.

We have tests that do simple checking of some tool we're interested
in, but later on in the script might be stressing trace2, or common
sources of leaks like "git log" in combination with the tool (e.g. the
commit-graph tests). To be clear having a prerequisite could also be
accomplished by using "LSAN_OPTIONS" directly.

On the topic of "LSAN_OPTIONS": It would be nice to have a mode to
aggregate all failures in our various scripts, see [2] for a start at
doing that which sets "log_path" in "LSAN_OPTIONS". I've punted on
that for now, it can be added later.

As of writing this we've got major regressions between master..seen,
i.e. the t000*.sh tests and more fixed since 31f9acf9ce2 (Merge branch
'ah/plugleaks', 2021-08-04) have regressed recently.

See the discussion at <87czsv2idy.fsf@evledraar.gmail.com>[3] about
the lack of this sort of test mode, and 0e5bba53af (add UNLEAK
annotation for reducing leak false positives, 2017-09-08) for the
initial addition of SANITIZE=leak.

See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
past history of "one-off" SANITIZE=leak (and more) fixes.

As noted in [5] we can't support this on OSX yet until Clang 14 is
released, at that point we'll probably want to resurrect that
"osx-leaks" job.

1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
2. https://lore.kernel.org/git/YS9OT%2Fpn5rRK9cGB@coredump.intra.peff.net/
3. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/YS9ZIDpANfsh7N+S@coredump.intra.peff.net/
5. https://lore.kernel.org/git/20210916035603.76369-1-carenas@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .github/workflows/main.yml |  3 +++
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  |  9 ++++++++-
 ci/run-build-and-tests.sh  |  2 +-
 t/README                   |  7 +++++++
 t/t0004-unwritable.sh      |  1 +
 t/t0011-hashmap.sh         |  2 ++
 t/t0016-oidmap.sh          |  2 ++
 t/t0017-env-helper.sh      |  1 +
 t/t0018-advice.sh          |  1 +
 t/t0030-stripspace.sh      |  1 +
 t/t0063-string-list.sh     |  1 +
 t/t0091-bugreport.sh       |  1 +
 t/test-lib.sh              | 20 ++++++++++++++++++++
 14 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b053b01c66e..47281684782 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -232,6 +232,9 @@ jobs:
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-leaks
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5772081b6e5..1d0e48f4515 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -12,7 +12,7 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-leaks)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
diff --git a/ci/lib.sh b/ci/lib.sh
index 476c3f369f5..82cb17f8eea 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -183,7 +183,7 @@ export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-leaks)
 	if [ "$jobname" = linux-gcc ]
 	then
 		export CC=gcc-8
@@ -233,4 +233,11 @@ linux-musl)
 	;;
 esac
 
+case "$jobname" in
+linux-leaks)
+	export SANITIZE=leak
+	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	;;
+esac
+
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index f3aba5d6cbb..ba29a93d84b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -17,7 +17,7 @@ fi
 
 make
 case "$jobname" in
-linux-gcc)
+linux-gcc|linux-leaks)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	make test
 	export GIT_TEST_SPLIT_INDEX=yes
diff --git a/t/README b/t/README
index e924bd81e2d..ab84278b7eb 100644
--- a/t/README
+++ b/t/README
@@ -366,6 +366,13 @@ excluded as so much relies on it, but this might change in the future.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
+SANITIZE=leak will run only those tests that have whitelisted
+themselves as passing with no memory leaks. Tests can be whitelisted
+by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
+"test-lib.sh" itself at the top of the test script. This test mode is
+used by the "linux-leaks" CI target.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index fbdcb926b3a..37d68ef03be 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -2,6 +2,7 @@
 
 test_description='detect unwritable repository and fail correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 5343ffd3f92..e094975b13b 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test hashmap and string hash functions'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_hashmap() {
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index 31f8276ba82..0faef1f4f11 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test oidmap'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This purposefully is very similar to t0011-hashmap.sh
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index 4a159f99e44..2e42fba9567 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -2,6 +2,7 @@
 
 test_description='test env--helper'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 39e5e4b34f8..c13057a4ca3 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -2,6 +2,7 @@
 
 test_description='Test advise_if_enabled functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'advice should be printed when config variable is unset' '
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 0c24a0f9a37..ae1ca380c1a 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -5,6 +5,7 @@
 
 test_description='git stripspace'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 t40='A quick brown fox jumps over the lazy do'
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index c6ee9f66b11..46d4839194b 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -5,6 +5,7 @@
 
 test_description='Test string list functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_split () {
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 526304ff95b..eeedbfa9193 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -2,6 +2,7 @@
 
 test_description='git bugreport'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Headers "[System Info]" will be followed by a non-empty line if we put some
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 06831086060..9310d9d900a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1381,6 +1381,26 @@ then
 	test_done
 fi
 
+# skip non-whitelisted tests when compiled with SANITIZE=leak
+if test -n "$SANITIZE_LEAK"
+then
+	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	then
+		# We need to see it in "git env--helper" (via
+		# test_bool_env)
+		export TEST_PASSES_SANITIZE_LEAK
+
+		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
+		then
+			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+			test_done
+		fi
+	fi
+elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+then
+	error "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
+fi
+
 # Last-minute variable setup
 USER_HOME="$HOME"
 HOME="$TRASH_DIRECTORY"
-- 
2.33.0.1092.g44c994ea1be

