Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238BCC43461
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A9C613C1
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhDTMWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhDTMWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B596C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w186so15512262wmg.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HM6toKW+5a1mvdYKKirFl4WUMcf2kp/k5IIoYPnyjRA=;
        b=Dd/lMsTw5Fm0cWghzsyRZoQaRjr1guK6jIEjd7ijWqS+D+D9lW6XOqm/326nZBbiSi
         Vs1ch6xqxcmX9hp8XgYTnvgHyCNBs9skLob7OilNJD9CcE6zADgADi77sWDEVQ8hmEU3
         c1+wZ4z4u4Hg8HxlgcqkHsWonsptKlJX0IeYD2xPuDZWtZOG+6fqBOHHMDqcIGKVxK/S
         qG+TibF4aslGhL6s1aCKuXmsZLqHDfl7E2bL+/BjuS4sdfl0iDP4CjwQZ0t/lKGgF8Lf
         P7kuol0l2UnezShyX0WCD32z6HYZJmisdiJiv/iDu45pbweU+tG5U10M4FsW3z6M7euO
         WzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HM6toKW+5a1mvdYKKirFl4WUMcf2kp/k5IIoYPnyjRA=;
        b=fh7wd5mkBsktvjaMomuGnPbhcxrkWmnLUTT6tt4k3YdwX/GYl9fM8sj1trjJYgCAqg
         5oaHncrqU1h8+UjDqQdjSuRhPvQOcHpWVFF8NTKO8LzLfY2q5Hf7ZaLwh6SYuKxpyOTm
         bvMtus8i1J1NTpg6XgBFLkSzHPuQWRm5Ju5MJwWfThVz3yXQolHTfDzzBC1fr6MqqngF
         5jiQzOpPUMCM27ItbPBwXPFkXeDXRQ5rgpvbXnvq3/c+nwNM3A4+CAAHTXjstqLDRqGg
         pX/D/w1K7dwSH0QlUXb/zgnfy5GMEoUQIav6F/x+r/MAYA+Bd/6cs5f1Rs3xbtZsrTmK
         XKdQ==
X-Gm-Message-State: AOAM531byzbK1v9LWPO11DU0mAZ8ZRv/7eVNV2LM6LwR7CC1hDFzgtqV
        mdWpL9LSD99ZlH7yAIDpJL4TX81VG87k0Q==
X-Google-Smtp-Source: ABdhPJxtY0KXhLT9qGu2hJPsi579mziq/pGXkLYIUAf3jIZiYf/agvKIP3H2NzXCDrDef8yZ4/tr+w==
X-Received: by 2002:a1c:9a43:: with SMTP id c64mr4317255wme.16.1618921328865;
        Tue, 20 Apr 2021 05:22:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:08 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/12] test-lib: bring $remove_trash out of retirement
Date:   Tue, 20 Apr 2021 14:21:53 +0200
Message-Id: <patch-02.12-39759d00ad-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
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

I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
under --debug at the end of the test, 2017-04-24) for a bug we don't
want to re-introduce.

While I'm at it let's move the HOME assignment to just before
test_create_repo, it could be lower, but it seems better to set it
before calling anything in test-lib-functions.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3dec266221..7522faf39f 100644
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
@@ -1334,6 +1334,21 @@ then
 	exit 1
 fi
 
+# Are we running this test at all?
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
@@ -1341,10 +1356,7 @@ rm -fr "$TRASH_DIRECTORY" || {
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
@@ -1356,15 +1368,6 @@ fi
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
2.31.1.723.gf6bad1b9ba1

