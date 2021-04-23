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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDE0C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B249613DB
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbhDWHWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbhDWHWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0AC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so63799244ejb.12
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEXil81XGsIn7ez73csuPkHBu+5/DvCKlakTqsUpZTQ=;
        b=pm4NHmJzNq9bMcv4V1/0jyf55iqaoDvn+dadIy+5ToYCSRWhwjujIBN54lI0vs6GcU
         I8V02u3TaJjQzi7ow58wyqaikHiSbZJG+X5B4vbdWckx6DWqMCcF2hIDlhM0m5dfu0iz
         4nituUE+ZrTxVYnuU2luRq729LEJxjTooD5LbAC2KtSD5lpHNoS74xPjQh0eCmcEf6rk
         bsfWal+RfjA0LBeI+Ste/ellHHrHQDUaun1HYYNfJp4NPx1PwJak0cfoKN9vYm4zsKKm
         FD/9Q3P7uUr9TNq4yxgYkiCH6mdtckHzSDHN/lcTJuP5nfkOA6jCs5gp0gM5NhtoXYYv
         BHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEXil81XGsIn7ez73csuPkHBu+5/DvCKlakTqsUpZTQ=;
        b=JDchjIg63mg+wyYkKAmXqkFVJwyMKscs7aq1yXsXjM0fV0VyQpyjk8KIcjn4mRKjNV
         e2bfQtetAHRcUcYHDesdcXjhFT/BRdQXb0oKf0U2pBhdgTLN/2BvsPplVBdG6llsBiAd
         +zQ56Jo6fQLmDEuaT4MVC6V48rAe+7r1j7XXQwdIAwY1D1BSP4dIhGp62YIiF0Yn6BZM
         xSLmescjHBE0ByYhvd2yzC+B2O7AklFvty3XHAEluwUhVrT871JHeTZ4nhZcGXbX928I
         aiFSgBVAmJ974IztXdC72WFeaALtJj3hcIOrjgKaEH5Lo16dpBY2ogUyQKgab3lWyDEr
         54lw==
X-Gm-Message-State: AOAM532teBnrtOPEw0JWs+64frNbDRUZI4TLpCyUYu+YqOVpB7YzCh3z
        WG4cymdmiEaf600+RS78N9tk67kgzKE=
X-Google-Smtp-Source: ABdhPJyx3KBepqVfSPOrMvO90bAqSLoYoyJh4Bfsk3VLb7yuF09wEbxJfQS1QpDBcP4IMvYMtF4HKw==
X-Received: by 2002:a17:906:1c17:: with SMTP id k23mr2783677ejg.266.1619162483179;
        Fri, 23 Apr 2021 00:21:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:22 -0700 (PDT)
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
Subject: [PATCH v5 01/11] test-lib: bring $remove_trash out of retirement
Date:   Fri, 23 Apr 2021 09:21:05 +0200
Message-Id: <patch-01.11-75667f98f3a-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
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
is unexpectedly gone at test_done time we'll hit the error about it
being unexpectedly gone added in df4c0d1a792 (test-lib: abort when
can't remove trash directory, 2017-04-20).

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

While I'm at it let's move the HOME assignment to just before
test_create_repo, it could be lower, but it seems better to set it
before calling anything in test-lib-functions.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3dec266221c..105c424bf56 100644
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
2.31.1.737.g98b508eba36

