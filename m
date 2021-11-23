Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C919C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhKWQcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhKWQcv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:32:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1029C06175A
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so2854830wme.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MaEZJJv7BpQjQ70XBjjm0QEMe+H+kgnTctqvaXQc0A=;
        b=SRsOPz7QqiQsVTtr/LC2HQoaQFMeKr/x1xKPLi7lGkJff3DlD2UVQdvi7g79BxXfF6
         h3VwWms7JhlMjtyq5BI8hnbcHaewpng+ika8f6PSNVyWHy/PASd0VF+o/jNSks1Hc4sM
         JSvbKQw0zOcJDg+aSfJ2obusJJaA6ZZaJDmcYX7iK6fzvJwNaJnJIM9LQJjG7z8+B60t
         eztxQrAWcOecavKtOid7UhWowbFcEwNelAotJYcRX73a3zxeizDsuqwU2q5O3reunSpp
         BIi+ZPb65kvOyjdy1eYqQaAEg0ZNlyGIK5dyerHJPA0qP1SGHiaCyyZX8mdwy4rUy6Zr
         2saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MaEZJJv7BpQjQ70XBjjm0QEMe+H+kgnTctqvaXQc0A=;
        b=CEhV0gQKqHT/J1C/SFkoOfixWHg+0ly7hbLntF+j3wCcgS4kr9foCuW6Q+wzR3SCsy
         5FJ23Ud4D4DjgwbByZBoLL0+K6FxfJo0HSKB47de3XOSG8qJ/p5KlbGuNXUzQ/23Zrmi
         lD93AUf8Gmu6gTDnK8MZZu3OgsQHoJLeUant9M/6MRH+bOUq4kmE88pXAexqNZPa6pE8
         vCpkmbkQjIHm7Yqs98Sp7xfaEofYf2uCnGpogOwrKwbgFfN+yG4kD44O6S2SyPMgflTD
         4OZmq58ALhoogmZGNdTgAJR9dY/Dpf0Zpyx+ukpMBa1nwXAfgYEURJsOTaGWOo96GB5b
         uc+Q==
X-Gm-Message-State: AOAM532iAbIsN+MnLeXeDg1G2exhScEwvDnOfWt6Xp1O0Khy/abrndo7
        0zXTKhPubUdv8uUo1XximxFgK+qX+Seneg==
X-Google-Smtp-Source: ABdhPJxvpp5XNKtIwsciDF04gGzd0QLRUcWiYAC9Mfxt2i/nSisUaFXvTtCF1M4N4cpae3j0WgyZ6w==
X-Received: by 2002:a05:600c:4e8d:: with SMTP id f13mr4801322wmq.7.1637684980955;
        Tue, 23 Nov 2021 08:29:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm2059940wmq.14.2021.11.23.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:29:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/5] CI: don't run "make test" twice in one job
Date:   Tue, 23 Nov 2021 17:29:12 +0100
Message-Id: <patch-v4-5.5-ee2f9254fc7-20211123T134300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.830.g6387a5d107e
In-Reply-To: <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "linux-clang" and "linux-gcc" jobs both run "make test" twice, but
with different environment variables. Running these in sequence seems
to have been done to work around some constraint on Travis, see
ae59a4e44f3 (travis: run tests with GIT_TEST_SPLIT_INDEX, 2018-01-07).

By having these run in parallel we'll get jobs that finish much sooner
than they otherwise would have.

We can also simplify the control flow in "ci/run-build-and-tests.sh"
as a result, since we won't run "make test" twice we don't need to run
"make" twice at all, let's default to "make all test" after setting
the variables, and then override it to just "all" for the compile-only
tests.

Add a comment to clarify that new "test" targets should adjust
$MAKE_TARGETS rather than being added after the "case/esac". This
should avoid future confusion where e.g. the compilation-only
"pedantic" target will unexpectedly start running tests. See [1] and
[2].

1. https://lore.kernel.org/git/211122.86ee78yxts.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211123.86ilwjujmd.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  9 +++++++++
 ci/run-build-and-tests.sh  | 23 +++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d402402a18b..628bcbf495e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -225,10 +225,19 @@ jobs:
           - jobname: linux-clang
             cc: clang
             pool: ubuntu-latest
+          - jobname: linux-sha256
+            cc: clang
+            os: ubuntu
+            pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
             cc_package: gcc-8
             pool: ubuntu-latest
+          - jobname: linux-TEST-vars
+            cc: gcc
+            os: ubuntu
+            cc_package: gcc-8
+            pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
             pool: macos-latest
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 18056501ec2..280dda7d285 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,16 +10,13 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-if test "$jobname" = "pedantic"
-then
-	export DEVOPTS=pedantic
-fi
+export MAKE_TARGETS="all test"
 
-make
 case "$jobname" in
 linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-	make test
+	;;
+linux-TEST-vars)
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_MERGE_ALGORITHM=recursive
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
@@ -33,23 +30,25 @@ linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
-	make test
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
-	make test
+	;;
+linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
-	make test
 	;;
 pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
-	;;
-*)
-	make test
+	export DEVOPTS=pedantic
+	export MAKE_TARGETS=all
 	;;
 esac
 
+# Any new "test" targets should not go after this "make", but should
+# adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
+# start running tests.
+make $MAKE_TARGETS
 check_unignored_build_artifacts
 
 save_good_tree
-- 
2.34.0.830.gb9cdc59c8af

