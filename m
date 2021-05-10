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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21558C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BBD6120D
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhEJPNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhEJPNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612CBC0515E3
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i128so9305554wma.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIjjk+KT18hF3oRtoq+/rV63Y9dY1IW0WiAISpQeGtY=;
        b=IIB6Exkmyj0D5Kk0kmZ36vYKV9pVanV45dMOWQ3/3dl+E9Iuet0ZSF6TlxlIudbPEI
         0n57cJVQhEB1KpsHzX3ICSNd5F7AUcHA1ZgVje5azBuSFex96K6M/Jvk4sSLNgBGhFEh
         EwXAco4T+pldnzq2IHm8YCSBmAJZsiOgB3FJpv+JVhhegYCFx7NJg/51jez81PtoN7sj
         DvkYq+nxgYXulth3szhOozt4TfGRmYAn7maI6Ch8u9mPyGJBJOvP8CUI7wuUOwf1eqYK
         OKy4hYmTD0EhAQ3FIFUeU3LshSJwhaPUe0D1046VU6Uz7QC6fPrOqzjoQaGCKHkZCruO
         Swog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIjjk+KT18hF3oRtoq+/rV63Y9dY1IW0WiAISpQeGtY=;
        b=j6R5+Cel4Ek0Bs30lES+0aYHgXKx/U/Ke0Y8J+A0HOtsZXeE+Xrfzhr57Zoqwb3Zv7
         0GsyXktLdlF05iFSAmtJPDdpPfPzvzbUL9JaObDmFqasgEXHNS1bHG+djuuJshuUIT9z
         OHOf66sS3GWbnghpuFduYW5s61MbIBZRzvix1lDCEYFZ9Hu2TddV3X3UGps9nlgQaAYp
         TPCmTOjGRGU9wA256a4S9H/NRS++a9uMcvsXC0LuUOl69Jk56ixKvYJKKbl2c9iXLHgI
         eX4YMtdoQ3VaPPD7+6yy9i03ksLqYU7XRa7MobcS3yKJDBwxl6KvXXcieVV5sHYRNfIm
         ea9Q==
X-Gm-Message-State: AOAM533R7zJ1Gzqz63fUTzYgTDeon1YSFmE7swo2PB7rdQZ2VnMXhuoB
        gV8bf3FtYzLkVayRmIA4CU/6eGXFVtk4ZA==
X-Google-Smtp-Source: ABdhPJwi8xVplBwksGqZ0rokbMjjAaqD5AKhanP0ugkElK2hCBTMNf5N616lK9sWqsr3jkBCTtsvLg==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr26582481wmc.92.1620657134784;
        Mon, 10 May 2021 07:32:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/11] test-lib: bring $remove_trash out of retirement
Date:   Mon, 10 May 2021 16:19:00 +0200
Message-Id: <patch-01.11-febf98e87a1-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in creating a repository or directory only to decide
right afterwards that we're skipping all the tests. We can save
ourselves the redundant "git init" or "mkdir" and "rm -rf" in this
case.

We carry around the "$remove_trash" variable because if the directory
is unexpectedly gone at test_done time we'll still want to hit the
"trash directory already removed" error, but not if we never created
the trash directory. See df4c0d1a792 (test-lib: abort when can't
remove trash directory, 2017-04-20) for the addition of that error.

So let's partially revert 06478dab4c (test-lib: retire $remove_trash
variable, 2017-04-23) and move the decision about whether to skip all
tests earlier.

Let's also fix a bug that was with us since abc5d372ec (Enable
parallel tests, 2008-08-08): we would leak $remove_trash from the
environment. We don't want this to error out, so let's reset it to the
empty string first:

     remove_trash=t GIT_SKIP_TESTS=t0001 ./t0001-init.sh

I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
under --debug at the end of the test, 2017-04-24) for a bug we don't
want to re-introduce.

While I'm at it, let's move the HOME assignment to just before
test_create_repo, it could be lower, but it seems better to set it
before calling anything in test-lib-functions.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaa2db6014..7647afcfd0a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1169,7 +1169,7 @@ test_done () {
 			esac
 		fi
 
-		if test -z "$debug"
+		if test -z "$debug" && test -n "$remove_trash"
 		then
 			test -d "$TRASH_DIRECTORY" ||
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
@@ -1334,6 +1334,22 @@ then
 	exit 1
 fi
 
+# Are we running this test at all?
+remove_trash=
+this_test=${0##*/}
+this_test=${this_test%%-*}
+if match_pattern_list "$this_test" $GIT_SKIP_TESTS
+then
+	say_color info >&3 "skipping test $this_test altogether"
+	skip_all="skip all tests in $this_test"
+	test_done
+fi
+
+# Last-minute variable setup
+HOME="$TRASH_DIRECTORY"
+GNUPGHOME="$HOME/gnupg-home-not-used"
+export HOME GNUPGHOME
+
 # Test repository
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
@@ -1341,10 +1357,7 @@ rm -fr "$TRASH_DIRECTORY" || {
 	exit 1
 }
 
-HOME="$TRASH_DIRECTORY"
-GNUPGHOME="$HOME/gnupg-home-not-used"
-export HOME GNUPGHOME
-
+remove_trash=t
 if test -z "$TEST_NO_CREATE_REPO"
 then
 	test_create_repo "$TRASH_DIRECTORY"
@@ -1356,15 +1369,6 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
 
-this_test=${0##*/}
-this_test=${this_test%%-*}
-if match_pattern_list "$this_test" $GIT_SKIP_TESTS
-then
-	say_color info >&3 "skipping test $this_test altogether"
-	skip_all="skip all tests in $this_test"
-	test_done
-fi
-
 if test -n "$write_junit_xml"
 then
 	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
-- 
2.31.1.838.g924d365b763

