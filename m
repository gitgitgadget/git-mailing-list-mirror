Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E38C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358948AbiBDNmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBDNmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:42:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C6C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:42:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so11346734wrb.13
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rb8SHTldyJYk4iSyYDkXfPuLuaD0JrsPsbL6l7BaPXQ=;
        b=qnZB/WRgRy8YL7Ipp2X95k2tTgfgKWalWSFLUgemDoVWM7dwzU2NB3sZx4gTOYgvJA
         i68c+PGT/w0IPjQ3KtkFoz7bBZqIXNLFQ+G31d7R7oQSIGxwmYsnYpZFk8SRalGSZkAW
         MtYzSO5Ayur4QYRwsq9LmWU8d1QIOZULvRz8CI8a0TvRxUersNumKqEFufMsWTHMWwyP
         T1RM7Ag/ulthCWvDNniMMte5aASwfdKIQDBYEMY6oq9R3+pp3IUSNdfTXlKarB8PGyvP
         SxYT/3g1DtGpEF3suieIfqzG/dYmxWamd+UmVqIpidf254Gx5jyLQz79RgPmtZaaRqSf
         G0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rb8SHTldyJYk4iSyYDkXfPuLuaD0JrsPsbL6l7BaPXQ=;
        b=5rP7zDw9RLTiheiQa9yKgqyWFToXDK69vlQ8IcTGn+uWbkIpjOcTbBOD7TIuyZN6Yz
         RXO06MhcVOqb/7vmAVnJs6Br+/r+miZQegMuhsd805eFN7BDs/JUSwzkINpRGVyw3WmL
         egSN1zVc/0PwyfBCv24YSrwBdZLykVOP83vslQfCFGMPbSCeGUoCSDTOiMEjmCmZjH2d
         qxEbNCmR3Vg+WKkOWZP8AcBcpvB53uRpiuBROsl+yawjL3Mt/h0J7CcDVJqfVYDMf+0A
         lv1b7F2kRrp8a+cdU+4jp97xMTAi3EMOiVDjalvCa72fXhvnXhNOefaX0mZtLZpOPoPW
         1Gbg==
X-Gm-Message-State: AOAM532MRciHd6GvAH4lSEk8GjybTM/pPeRL14Xhd6ngmaR/CVR7aVdM
        crQiv1x1RpNDSzNsAggzfoyDf3nEGWJvUg==
X-Google-Smtp-Source: ABdhPJziYfvrNZvO/Y9zZKTNq0FzjQH5rc/kl9jxH2YB4ggfSvpYdcvUTdzgFhIer99afSVAhUeCDg==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr2537521wrp.25.1643982155681;
        Fri, 04 Feb 2022 05:42:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s22sm9538913wmj.38.2022.02.04.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:42:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] t0051: use "skip_all" under !MINGW in single-test file
Date:   Fri,  4 Feb 2022 14:42:14 +0100
Message-Id: <patch-v2-1.1-1bc93bcba4b-20220204T134208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
References: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have this file added in 06ba9d03e34 (t0051: test GIT_TRACE to a
windows named pipe, 2018-09-11) use the same "skip_all" pattern as an
existing Windows-only test added in 0e218f91c29 (mingw: unset PERL5LIB
by default, 2018-10-30) uses.

This way TAP consumers like "prove" will show a nice summary when the
test is skipped. Instead of:

    $ prove t0051-windows-named-pipe.sh
    [...]
    t0051-windows-named-pipe.sh .. ok
    [...]

We will prominently show a "skipped" notice:

    $ prove t0051-windows-named-pipe.sh
    [...]
    t0051-windows-named-pipe.sh ... skipped: skipping Windows-specific tests
    [...]

This is because we are now making use of the right TAP-y way to
communicate this to the consumer. I.e. skipping the whole test file,
v.s. skipping individual tests (in this case there's only one test).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  34ff968dcb8 ! 1:  1bc93bcba4b t0051: use "skip_all" under !MINGW in single-test file
    @@ Commit message
         by default, 2018-10-30) uses.
     
         This way TAP consumers like "prove" will show a nice summary when the
    -    test is skipped, e.g.:
    +    test is skipped. Instead of:
    +
    +        $ prove t0051-windows-named-pipe.sh
    +        [...]
    +        t0051-windows-named-pipe.sh .. ok
    +        [...]
    +
    +    We will prominently show a "skipped" notice:
     
             $ prove t0051-windows-named-pipe.sh
             [...]
             t0051-windows-named-pipe.sh ... skipped: skipping Windows-specific tests
             [...]
     
    +    This is because we are now making use of the right TAP-y way to
    +    communicate this to the consumer. I.e. skipping the whole test file,
    +    v.s. skipping individual tests (in this case there's only one test).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0051-windows-named-pipe.sh ##

 t/t0051-windows-named-pipe.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe.sh
index 10ac92d2250..412f413360d 100755
--- a/t/t0051-windows-named-pipe.sh
+++ b/t/t0051-windows-named-pipe.sh
@@ -3,8 +3,13 @@
 test_description='Windows named pipes'
 
 . ./test-lib.sh
+if ! test_have_prereq MINGW
+then
+	skip_all='skipping Windows-specific tests'
+	test_done
+fi
 
-test_expect_success MINGW 'o_append write to named pipe' '
+test_expect_success 'o_append write to named pipe' '
 	GIT_TRACE="$(pwd)/expect" git status >/dev/null 2>&1 &&
 	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
 	pid=$! &&
-- 
2.35.1.940.ge7a5b4b05f2

