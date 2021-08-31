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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DECBC43216
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7660E60462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhHaNgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhHaNgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BCEC061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n5so27676253wro.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOlWBdgIKEQxY/5QvMOqnYoNQ8ncU74Zf5cam8TkHCw=;
        b=n2MXbPwg31eXlQrRKJCYMs9S6b7KE92pBkSdR7r6xBw236vPfLzcnzeZWfruGTkk1K
         WzU90uCDVLRQuXjdiNjnhRYx3RRvVvp1lCQ2UFTVdpwOHbzVoqoL2drhDQgEEqe+ZP37
         yxkxkI3zd42sYGa6bTSITGIDqa/5HsqWelSWt3ytBERsx+fw/6lvondQHYApAHw5Xunw
         iDBcjrzrwiyMw9eA7wcQcqZzezdQawMyftkYZSVqeySzO540OrBTJ9NRxvJ3pPQIgrKt
         AMqtWBJWqPrI3cCqWhImE9Lcyp6fcV3/UZQ54McQ+lld2rYiTolwmlKvBZCrch4gGnwM
         LiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOlWBdgIKEQxY/5QvMOqnYoNQ8ncU74Zf5cam8TkHCw=;
        b=nPnHmGEpkF9Q6TH2Q8dBs4RYz5m+Uhimk3JqpHlwb82gyuVrcDnfUTgeHjRx0Sq5Vn
         bhgx+Sf1cLkZ1h4s5BEhNp++D1TLv5REnWhFVKC6FKHpoQAjzhrwpmup7vSM5xLzU9NI
         6BcstdacPH6QRrfih6KAIRo6WQRVCh7fs4CR449qMhE1Z9PBgbGDvutqIku2tGmAtgFw
         F3npYhWzEK1VAa8XEvmu9GWZUWG8fgxyXKfMfQs0DM67/+fM4oosxkn6DpTJwkn/FyAU
         Gxy9sG/mA5LLk1pQT5bIOA55lI3TCm5lYokp9IWvrSN0BSN75tByTzkcDctxy2Fp58Ix
         bdOg==
X-Gm-Message-State: AOAM533RriBnEsuh+XCY7zfpYkWuwJeQFpyS96BIioql2QzN43vrCLI+
        VEJQffeTr6K9uDljMPA9NGi08UNNv/jyUg==
X-Google-Smtp-Source: ABdhPJwmI5etsKLDAGCvYItQo5brVj0At83oweUhokSNKMQ/aKff29+67y5AXFotbTptW5mpl2sUnQ==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr14973209wre.141.1630416949767;
        Tue, 31 Aug 2021 06:35:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:49 -0700 (PDT)
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
Subject: [PATCH v3 3/8] tests: add a test mode for SANITIZE=leak, run it in CI
Date:   Tue, 31 Aug 2021 15:35:37 +0200
Message-Id: <patch-v3-3.8-7e3577e4e3c-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While git can be compiled with SANITIZE=leak there has been no
corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
fixed as one-offs without structured regression testing.

This change add such a mode, and a new linux-SANITIZE=leak CI
target. The test mode and CI target only runs a whitelist of
known-good tests using a mechanism discussed below, to ensure that we
won't add regressions to code that's had its memory leaks fixed.

The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
mode. When running in that mode all tests except those that have opted
themselves in to running by setting and exporting
TEST_PASSES_SANITIZE_LEAK=true before sourcing test-lib.sh.

I'm adding a "test-pragma-SANITIZE=leak-ok.sh" wrapper for setting and
exporting that variable, as the assignment/export boilerplate would
otherwise get quite verbose and repetitive in subsequent commits.

The tests using the "test-pragma-SANITIZE=leak-ok.sh" pragma can in
turn make use of the "SANITIZE_LEAK" prerequisite added in a preceding
commit, should they wish to selectively skip tests even under
"GIT_TEST_PASSING_SANITIZE_LEAK=true".

Now tests that don't set the "test-pragma-SANITIZE=leak-ok.sh" pragma
will be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0001-init.sh
    1..0 # SKIP skip all tests in t0001 under SANITIZE=leak, TEST_PASSES_SANITIZE_LEAK not set

In subsequents commit we'll conservatively add more
TEST_PASSES_SANITIZE_LEAK=true annotations. The idea is that as memory
leaks are fixed we can add more known-good tests to this CI target, to
ensure that we won't have regressions.

As of writing this we've got major regressions between master..seen,
i.e. the t000*.sh tests and more fixed since 31f9acf9ce2 (Merge branch
'ah/plugleaks', 2021-08-04) have regressed recently.

See the discussion at <87czsv2idy.fsf@evledraar.gmail.com> about the
lack of this sort of test mode, and 0e5bba53af (add UNLEAK annotation
for reducing leak false positives, 2017-09-08) for the initial
addition of SANITIZE=leak.

See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
past history of "one-off" SANITIZE=leak (and more) fixes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml        |  2 ++
 ci/install-dependencies.sh        |  4 ++--
 ci/lib.sh                         | 11 +++++++++--
 ci/run-build-and-tests.sh         |  4 ++--
 t/README                          |  7 +++++++
 t/t0000-basic.sh                  |  1 +
 t/test-lib.sh                     | 21 +++++++++++++++++++++
 t/test-pragma-SANITIZE=leak-ok.sh |  8 ++++++++
 8 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100644 t/test-pragma-SANITIZE=leak-ok.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 47876a4f02e..d11b971f970 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -232,6 +232,8 @@ jobs:
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-SANITIZE=leak
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5772081b6e5..30276ae1e00 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -12,13 +12,13 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-SANITIZE=leak)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS
 	case "$jobname" in
-	linux-gcc)
+	linux-gcc|linux-SANITIZE=leak)
 		sudo apt-get -q -y install gcc-8
 		;;
 	esac
diff --git a/ci/lib.sh b/ci/lib.sh
index 33b9777ab7e..d86b83ed203 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -183,9 +183,9 @@ export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-SANITIZE=leak)
 	case "$jobname" in
-	linux-gcc)
+	linux-gcc|linux-SANITIZE=leak)
 		export CC=gcc-8
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 		;;
@@ -237,4 +237,11 @@ linux-musl)
 	;;
 esac
 
+case "$jobname" in
+linux-SANITIZE=leak)
+	export SANITIZE=leak
+	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	;;
+esac
+
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3ce81ffee94..f0b9775b6c7 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -12,7 +12,7 @@ esac
 
 make
 case "$jobname" in
-linux-gcc)
+linux-gcc|linux-SANITIZE=leak)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	make test
 	export GIT_TEST_SPLIT_INDEX=yes
@@ -29,7 +29,7 @@ linux-gcc)
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	make test
 	;;
-linux-clang)
+linux-clang|linux-SANITIZE=leak)
 	export GIT_TEST_DEFAULT_HASH=sha1
 	make test
 	export GIT_TEST_DEFAULT_HASH=sha256
diff --git a/t/README b/t/README
index 9e701223020..f5dfac568d1 100644
--- a/t/README
+++ b/t/README
@@ -448,6 +448,13 @@ GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
 to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
 execution of the parallel-checkout code.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
+SANITIZE=leak will run only those tests that have whitelisted
+themselves as passing with no memory leaks. Do this by sourcing
+"test-pragma-SANITIZE=leak-ok.sh" before sourcing "test-lib.sh" itself
+at the top of the test script. This test mode is used by the
+"linux-SANITIZE=leak" CI target.
+
 Naming Tests
 ------------
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cb87768513c..14836c97cc6 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -18,6 +18,7 @@ swapping compression and hashing order, the person who is making the
 modification *should* take notice and update the test vectors here.
 '
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 try_local_xy () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4ab18914a3d..332dd59257d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1379,6 +1379,27 @@ then
 	test_done
 fi
 
+# Aggressively skip non-whitelisted tests when compiled with
+# SANITIZE=leak
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
 HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
diff --git a/t/test-pragma-SANITIZE=leak-ok.sh b/t/test-pragma-SANITIZE=leak-ok.sh
new file mode 100644
index 00000000000..5f03397075d
--- /dev/null
+++ b/t/test-pragma-SANITIZE=leak-ok.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+## This "pragma" (as in "perldoc perlpragma") declares that the test
+## will pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. Source this
+## before sourcing test-lib.sh
+
+TEST_PASSES_SANITIZE_LEAK=true
+export TEST_PASSES_SANITIZE_LEAK
-- 
2.33.0.805.g739b16c2189

