Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E663C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110D361164
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJNAtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJNAth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:49:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91EEC061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:47:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o20so14093103wro.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73yukyy56fpF3h2Sl8c7BQCsdUm91DqixS5hPdhvuIk=;
        b=hOG1pjVCLyi8MUcxckyDGebBLMr5GHq9iRRrAVJ0Te3qb54P0MnZbZghT0l//Cx8IW
         vWG/HdOxwXTdRPHDpKpQ9NnD8WPMj6QQrFRC+jF6cm66h2+9b2Dj5DIXhMmj4ppMFgcR
         wyS39HK5I7Gvc/RSsGEXD2qvie2UO0oTWDZr2dvESPJ1yk7ghr/qBjw5MAcurhUDuP9M
         w6V6GjPQJye2267Q8HJCyfdCS525cI0c+ukBFrSxErSblEYk4U7evXEA/fZBbi7ELvAO
         i1tbp/TWid8rTH7m9rVZHUlWwcsBNvk4XGAJXkbRMKQqI4GPKuT9MNRyglTIrlqhnODf
         NQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73yukyy56fpF3h2Sl8c7BQCsdUm91DqixS5hPdhvuIk=;
        b=tCYARG+/jUKqjKCYoxlcrs/Rkyea0+uovCPQ2J4kepZxkNr3lCwg9OeB0Qk0iB4hVj
         kTJSOqnbNKMmXxNz/6cNf1UnwiKwtS28QAmVcwnto3z0TMwp6GLUEpi2ckg4WM9iuAZx
         vQuLj+CuzlLj7L2H4KQ24abSYy5n+b8ZcZ2xQnYmq5KqpXHv+s2C1HvZzrN1PkEHi6Cf
         FRD68aELZ4BTmcTtogYBcL6Iy+Rc9lx4cHjiXsVqxOA5oY7iFLWrPnhIuq/ZwDGsPWab
         Hb/vgR099E6Ro9iw6T78a0UD15lFT8X8Yg9JssMdbtNm6wRos8dIy146Bzbpf9kDUt/i
         vaZA==
X-Gm-Message-State: AOAM532UbdFpbLAihUK+HRyQVnVCLs3g4ELpvm1PBXwkBK45wribA+F8
        giZ/VvA3hp97wT4VdVx78ECsxgRZ0/TRbg==
X-Google-Smtp-Source: ABdhPJwtvVLEZYO4M23KUDZpFaXz+5uCUp9jdh1KunLAcuXK6RrfUl+zDGrXdJ1PMIBG6jD384j9Qw==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr2868679wri.193.1634172452220;
        Wed, 13 Oct 2021 17:47:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w11sm736126wmc.44.2021.10.13.17.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:47:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] test-lib.sh: use "Bail out!" syntax on bad SANITIZE=leak use
Date:   Thu, 14 Oct 2021 02:47:29 +0200
Message-Id: <patch-2.2-6fd2a64bcfa-20211014T004542Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode added in
956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in CI,
2021-09-23) to use a TAP "Bail out!" message when exiting. This will
cause the test run to exit immediately under a TAP consumer like
"prove(1)".

See 614fe015212 (test-lib: bail out when "-v" used under "prove",
2016-10-22) for the initial introduction of "Bail out!" to the
--verbose being amended here.

Before this compiling with "SANITIZE=" and running the tests with
"prove(1)" would cause all the tests to be run to the end (output
trimmed for fewer columns):

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true make
    rm -f -r 'test-results'
    *** prove ***
    t0000-basic.sh ......... Dubious, test returned 1 (wstat 256, 0x100)
    No subtests run
    t0001-init.sh .......... Dubious, test returned 1 (wstat 256, 0x100)
    No subtests run
    [...output where we list every single t[0-9]*.sh file as failing snipped]

Whereas now we'll fail early, like this ("->" line wrapping added):

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true make
    [...]

    t0000-basic.sh ..................................... Bailout called.  Further testing stopped:
    -> GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak
    FAILED--Further testing stopped: GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except
    -> when compiled with SANITIZE=leak
    make: *** [Makefile:53: prove] Error 1

This change also adds a red color to the "Bailout called" line, as
we're now using "say_color error". That improves existing output in
the case of e.g.:

    $ prove -j8 t[0-9]*.sh :: -v
    Bailout called.  Further testing stopped:  verbose mode forbidden under TAP harness; try --verbose-log
    FAILED--Further testing stopped: verbose mode forbidden under TAP harness; try --verbose-log

We don't need to have a "Bail out! " prefix when we're not running
under a TAP consumer (i.e. if test -n "$HARNESS_ACTIVE"), but let's
not make the output conditional on that. Showing it under e.g.:

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0095-bloom.sh
    Bail out! GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak

Doesn't harm anything, and I don't think the (small) complexity of
only adding this if we're under "$HARNESS_ACTIVE" is worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c610f09ddb1..617cda36f3a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -604,6 +604,18 @@ BUG () {
 	error >&7 "bug in the test script: $*"
 }
 
+BAIL_OUT () {
+	test $# -ne 1 && BUG "1 param"
+
+	# Do not change "Bail out! " string. It's part of TAP syntax:
+	# https://testanything.org/tap-specification.html
+	local bail_out="Bail out! "
+	local message="$1"
+
+	say_color error $bail_out "$message"
+	_error_exit
+}
+
 say () {
 	say_color info "$*"
 }
@@ -612,9 +624,7 @@ if test -n "$HARNESS_ACTIVE"
 then
 	if test "$verbose" = t || test -n "$verbose_only"
 	then
-		printf 'Bail out! %s\n' \
-		 'verbose mode forbidden under TAP harness; try --verbose-log'
-		exit 1
+		BAIL_OUT 'verbose mode forbidden under TAP harness; try --verbose-log'
 	fi
 fi
 
@@ -1402,7 +1412,7 @@ then
 	fi
 elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
-	error "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
+	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
 fi
 
 # Last-minute variable setup
-- 
2.33.1.1346.g48288c3c089

