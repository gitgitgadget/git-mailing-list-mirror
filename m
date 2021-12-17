Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA1EC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhLQAKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLQAKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:10:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BABBC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:10:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so955552wrg.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tozRrTc5F7O1sKvxEwjZB3JN28WqOB/ojJgKvbb1tFA=;
        b=DWjZBbtgAaSyeBucNk+Lf8gF0IY5Vf3apH0sQfnphZaS3IO2214iaVwhN2/IpwJHU6
         XF86ujljAeQM/REX5KJnrdL6QZka675yHkk/gpJ4gNTSCpAsoGrdGoYMPfr6BwuE1wET
         AXGFAETAdwbMpF91AQu4EcgGOux6Q/HaeOLMvJOE5iaOGw0bZRlZMe52OKxkBanG8uvJ
         aIterVleFa7ERc/ILCsqUOL9tVReUADDIE2sPeOyF9Gm/quvmpJS7J2JRITf8sYFqW/j
         y+/kN5Uhjo21T1kXFHpRNzLB0g1u+PMXr85PzblnwuQ12Cne4iI8kaIiQOKAmLzGWvYu
         motw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tozRrTc5F7O1sKvxEwjZB3JN28WqOB/ojJgKvbb1tFA=;
        b=Ugh1SCVzNYwBiiVCjlpjY11n/E4Yo6RINqpA/Z5ZYxCSs5cId2MWdUghAL7it6Zh6x
         08jzvXN8Rz7P/b29OJPOvy930rxfCJjJMwXb7EasiYy+pQBGEi527Kwyg/IviDCobV+Y
         07n/bs39qbLv5rzS/tyRXD1mz9055kT+NQvAMLBcU4qrrHge55eUY4dv4Qh/4XhZc0xn
         fwzY6Dr40hdKdy3vMu4HYVUdZ86p9qJkIwYULKOYvBHpjJdGhEyA+8g1WDwfAvPNXeGL
         GeSX+QGlkfutGgEdDnDhxLRpK7V/bRrYyDPZAUO0OcKl2o0XriMpVjgswQax54JavEAy
         tDUw==
X-Gm-Message-State: AOAM531Ay+jrQ+e6sOsZczw1efibiS5xOWh5CVy3XcDvvnTNQIyG4FH1
        Oe+6OOVZKOJo/VMiSqVcsqjIaxqb535LOA==
X-Google-Smtp-Source: ABdhPJxR37A0jW/OztdVNvDmThWTr5ujOY/hL81crJQn0MwACFiVWsJoOKrOuly4py+rLnl6/yAS8w==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr319151wru.380.1639699804459;
        Thu, 16 Dec 2021 16:10:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h5sm6096382wrz.63.2021.12.16.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:10:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: don't invoke msgfmt with --statistics
Date:   Fri, 17 Dec 2021 01:10:00 +0100
Message-Id: <patch-1.1-58408f384e7-20211217T000729Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the --statistics flag that I added in 5e9637c6297 (i18n: add
infrastructure for translating Git with gettext, 2011-11-18). Our
Makefile output is good about reducing verbosity by default, except in
this case:

    $ rm -rf po/build/locale/e*; time make -j $(nproc) all
        SUBDIR templates
        MKDIR -p po/build/locale/el/LC_MESSAGES
        MSGFMT po/build/locale/el/LC_MESSAGES/git.mo
        MKDIR -p po/build/locale/es/LC_MESSAGES
        MSGFMT po/build/locale/es/LC_MESSAGES/git.mo
    1038 translated messages, 3325 untranslated messages.
    5230 translated messages.

I didn't have any good reason for using --statistics at the time other
than ad-hoc eyeballing of the output. We don't need to spew out
exactly how many messages we've got translated every time. Now we'll
instead emit:

    $ rm -rf po/build/locale/e*; time make -j $(nproc) all
        SUBDIR templates
        MKDIR -p po/build/locale/el/LC_MESSAGES
        MSGFMT po/build/locale/el/LC_MESSAGES/git.mo
        MKDIR -p po/build/locale/es/LC_MESSAGES
        MSGFMT po/build/locale/es/LC_MESSAGES/git.mo

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As noted in [1] this is the first of smaller topics that split-up and
replace the ab/make-dependency topic. Range-to the previous start of
the series below. The v4 of the old series is at [2].

For this commit there were no changes or outstanding comments.

1. https://lore.kernel.org/git/211217.86a6h09km9.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com/

Range-diff:
 1:  1621ca72c1d =  1:  58408f384e7 Makefile: don't invoke msgfmt with --statistics
 2:  b7c36c9fea0 <  -:  ----------- Makefile: don't set up "perl/build" rules under NO_PERL=Y
 3:  29b000eb0f1 <  -:  ----------- Makefile: use "=" not ":=" for po/* and perl/*
 4:  daead5ec293 <  -:  ----------- Makefile: clean perl/build/ even with NO_PERL=Y
 5:  3c987590740 <  -:  ----------- Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 6:  b57f582ccd3 <  -:  ----------- Makefile: guard Perl-only variable assignments
 7:  fcdee92f64c <  -:  ----------- Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 8:  1e25b532ca2 <  -:  ----------- Makefile: adjust Perl-related comments & whitespace
 9:  77d9855bfcf <  -:  ----------- Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
10:  6004cdcd8d9 <  -:  ----------- Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
11:  17b30e96057 <  -:  ----------- Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
12:  30ddf7da2c8 <  -:  ----------- Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
13:  f378a7dc35e <  -:  ----------- Makefile: move $(comma), $(empty) and $(space) to shared.mak
14:  13cbb851d32 <  -:  ----------- Makefile: re-add and use the "shellquote" macros
15:  337953e4994 <  -:  ----------- Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
16:  5bb597c1993 <  -:  ----------- Makefile: add "$(QUIET)" boilerplate to shared.mak
17:  3c4d0589667 <  -:  ----------- Makefile: use $(wspfx) for $(QUIET...) in shared.mak
18:  be5882b2c99 <  -:  ----------- Makefiles: add and use wildcard "mkdir -p" template
19:  2710f8af6cd <  -:  ----------- Makefile: correct the dependency graph of hook-list.h
20:  59f22a0269a <  -:  ----------- Makefile: use $(file) I/O instead of "FORCE" when possible
21:  dd569a59c74 <  -:  ----------- Makefile: disable GNU make built-in wildcard rules
22:  4168a7e3b30 <  -:  ----------- Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
23:  48a3927d972 <  -:  ----------- Makefile: move ".SUFFIXES" rule to shared.mak

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9c00a793e47..b9d0f063eff 100644
--- a/Makefile
+++ b/Makefile
@@ -1880,7 +1880,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
 
 ifndef NO_MSGFMT_EXTENDED_OPTIONS
-	MSGFMT += --check --statistics
+	MSGFMT += --check
 endif
 
 ifdef HAVE_CLOCK_GETTIME
-- 
2.34.1.1119.g7a3fc8778ee

