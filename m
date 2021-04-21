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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D5C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D22B61442
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhDUKP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhDUKP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:15:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7177C06138A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n4-20020a05600c4f84b029013151278decso922211wmq.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iOvv1gZ1EcIHLUyMNyh8BxMqJBajEt04ECiibQ+g3Y=;
        b=i4YwihXp7yt1jyTSJk4PAz5docABbVzWSllOj5MVQ9sGFXYFsipOK76Bwn+UT+zzFJ
         zinYI7eT1W4aHLrXYPK6z2jT/f+mxMd1XxQlynJ1cw/zawH6PlDy3eK3Wm7RxlyIqnYP
         SEb23gWFAPVaBKhlBLnYhhLB2yWOBmXYUxUFDKYfM4blsFUpmGt6x0Gc17BrC954y1mk
         1wosQi3ZIgP3qXkRiRl4NxekTpNNOHhBhRSn07WnTOjCCps//3iQ5Cq8dsoD1v9X/xeb
         ts8+h9vadeLwbpuvTCfJzSinaiJ8iq607Y/UwjCiBpOJ0vsNLrP1VQlXKI4y+1GD7Zb2
         9u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iOvv1gZ1EcIHLUyMNyh8BxMqJBajEt04ECiibQ+g3Y=;
        b=ZDxYmzKzAx+Ki9TgN8cBltgJAj1RMbT9Nnd6FzGSjHuN4QQqxgck9WNJbhgSUVNu0e
         ax1rWYFsNqrsraA+pHMmHpSvCEEX3XrKTersahiF4v5p5nDztVv0jbP017a+buLlQgGn
         E/L7NeBERcPmZ/iJHBG+piBz0od6wH1DwV/6Mi1Kbnlwd2T/PQtbRo8ABZvBXPQOrnpG
         0pznuG5kZy92SrhDzL9a0GQrpZA03N1LTk8cdjvuoAg6CISkibXKweORG4uSzQOXHMON
         r4eQaq29+bL64fKVsPUMFaVHPkVc9Vp8W3C9Okpr8pY3THHSmTEKcE/7Da9TIncZeAYw
         ZmYA==
X-Gm-Message-State: AOAM532kh9dmPTAM7OfrNGktrwQXttcmmBVkY/B11OmLXnvWxCTdADBd
        sUZy7onkIRJpd3vwqy6H8aP2gYCb01ubLg==
X-Google-Smtp-Source: ABdhPJxBTOcSnVnVJpK6k9g1OxklZHOlDGm/jNLee5SJCdBb83tNcmwkFyWo7Orp4zYL6fQcDgb0UQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr9098327wmc.59.1619000120140;
        Wed, 21 Apr 2021 03:15:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:19 -0700 (PDT)
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
Subject: [PATCH v4 01/11] test-lib: bring $remove_trash out of retirement
Date:   Wed, 21 Apr 2021 12:15:06 +0200
Message-Id: <patch-01.11-a76ea749bb-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
index 3dec266221..105c424bf5 100644
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
2.31.1.721.gbeb6a21927

