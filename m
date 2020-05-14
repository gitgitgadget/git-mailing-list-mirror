Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C19C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B158620675
	for <git@archiver.kernel.org>; Thu, 14 May 2020 19:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEfl/uVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgENTTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728286AbgENTTI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 15:19:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55DAC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 12:19:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so12991422pjb.1
        for <git@vger.kernel.org>; Thu, 14 May 2020 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edHYoLrzozt7VWPr8lKcpkP2B8WxliLQhvA2ZfvGJ8A=;
        b=hEfl/uVbJ3VcGjp4n/uSd9pY6EmnCh7XxmtjxYl9p3TtQpvtIwmW16BddZNHHRi7xi
         TFjXBwLXYBoZDZK+Dn5e13RNgR6p0zbwXXOa2rlG/O3oNze4xiJzA6a3QOfqmeEcrPte
         /t1uchw7pDbDg94mTvylrCyUnKzdLdoSeRoiayNhVrEUZZaP2OeHvL6cpI1bRG9pTS97
         cul+K6f4cCFUgvWr2vHLPuJIQqA/ftoO3KTbjGSmkuFel+Mi/PKwvgojHnkVE1Kuns/E
         JccgzdqSIK8QQJxhcYxGJOmgaakeNKWf4tryNRm1c5k3CuzJ14dHl5q1mEe7+BqJ6jRd
         hTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edHYoLrzozt7VWPr8lKcpkP2B8WxliLQhvA2ZfvGJ8A=;
        b=pOu74WhWzCwxesfNA/qeOxsZ9JqXAmw5o48jtJjFxJkjaq85m7ldt1bkc5pPiwEJYT
         gG/cPSOZ20NOX+LkwYXc9HT7FpVyHqNz6WPsqEw3lHbHbOXxZ1i3o9pg5wnZ4DGmmp6w
         lAbACFqFlGYCicRsnLcPs7c5hENg4EeUNGJ2/X7kNQtVypd3hn2pYkrCrIsTb3Z4RvCx
         LAZk69ZZPJUIhsjqxu8Wr6CaVfnfJlCzFZ/Qw6nu850/ypgXCwU/j3npwmLiijjhdBqn
         aC3b6FAWM/JVcODG3yVnPB/DVyooIFsjXA+klEaQ+CPJb1O9VT/PR4T40Rr588HVnDm8
         7P8w==
X-Gm-Message-State: AOAM533L/uNTyjA7B917dQ/rRmegEcXWKDzaqCKktvgfEwjH3NODA4hf
        INHmsaqUP/cq3VPOcVhE9aoiHGlN
X-Google-Smtp-Source: ABdhPJzaAw+QncVb4rmLWsOkSMjsNdgyK5C+KdYLNpx2dcb0rDvOJ2WNla/TYfKR6w/SCLAVu7GmMA==
X-Received: by 2002:a17:90a:e147:: with SMTP id ez7mr4816183pjb.25.1589483947901;
        Thu, 14 May 2020 12:19:07 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d10sm15212pgo.10.2020.05.14.12.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 12:19:07 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     congdanhqx@gmail.com, peff@peff.net, cbailey32@bloomberg.net,
        l.s.r@web.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] compat: remove gmtime
Date:   Thu, 14 May 2020 12:18:54 -0700
Message-Id: <20200514191854.55231-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.812.g046d49d455
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ccd469450a (date.c: switch to reentrant {gm,local}time_r, 2019-11-28)
removes the only gmtime() call we had and moves to gmtime_r() which
doesn't have the same portability problems.

Remove the compat gmtime code since it is no longer needed, and confirm
by successfull running t4212 in FreeBSD 9.3 amd64 (the oldest I could
get a hold off).

Further work might be needed to ensure 32bit time_t systems (like FreeBSD
i386) will handle correctly the overflows tested in t4212, but that is
orthogonal to this change, and it doesn't change the current behaviour
as neither gmtime() or gmtime_r() will ever return NULL on those systems
because time_t is unsigned.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile          |  8 --------
 compat/gmtime.c   | 29 -----------------------------
 config.mak.uname  |  1 -
 git-compat-util.h |  7 -------
 4 files changed, 45 deletions(-)
 delete mode 100644 compat/gmtime.c

diff --git a/Makefile b/Makefile
index 9804a0758b..12c650f259 100644
--- a/Makefile
+++ b/Makefile
@@ -405,9 +405,6 @@ all::
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
-# Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
-# return NULL when it receives a bogus time_t.
-#
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
@@ -1803,11 +1800,6 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT += --check --statistics
 endif
 
-ifdef GMTIME_UNRELIABLE_ERRORS
-	COMPAT_OBJS += compat/gmtime.o
-	BASIC_CFLAGS += -DGMTIME_UNRELIABLE_ERRORS
-endif
-
 ifdef HAVE_CLOCK_GETTIME
 	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
 endif
diff --git a/compat/gmtime.c b/compat/gmtime.c
deleted file mode 100644
index e8362dd2b9..0000000000
--- a/compat/gmtime.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include "../git-compat-util.h"
-#undef gmtime
-#undef gmtime_r
-
-struct tm *git_gmtime(const time_t *timep)
-{
-	static struct tm result;
-	return git_gmtime_r(timep, &result);
-}
-
-struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
-{
-	struct tm *ret;
-
-	memset(result, 0, sizeof(*result));
-	ret = gmtime_r(timep, result);
-
-	/*
-	 * Rather than NULL, FreeBSD gmtime simply leaves the "struct tm"
-	 * untouched when it encounters overflow. Since "mday" cannot otherwise
-	 * be zero, we can test this very quickly.
-	 */
-	if (ret && !ret->tm_mday) {
-		ret = NULL;
-		errno = EOVERFLOW;
-	}
-
-	return ret;
-}
diff --git a/config.mak.uname b/config.mak.uname
index 2bff8b3466..c0852b37a5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -244,7 +244,6 @@ ifeq ($(uname_S),FreeBSD)
 	PYTHON_PATH = /usr/local/bin/python
 	PERL_PATH = /usr/local/bin/perl
 	HAVE_PATHS_H = YesPlease
-	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
diff --git a/git-compat-util.h b/git-compat-util.h
index aed0b5d4f9..f1b0a5aa0a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1208,13 +1208,6 @@ int access_or_die(const char *path, int mode, unsigned flag);
 /* Warn on an inaccessible file if errno indicates this is an error */
 int warn_on_fopen_errors(const char *path);
 
-#ifdef GMTIME_UNRELIABLE_ERRORS
-struct tm *git_gmtime(const time_t *);
-struct tm *git_gmtime_r(const time_t *, struct tm *);
-#define gmtime git_gmtime
-#define gmtime_r git_gmtime_r
-#endif
-
 #if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
 #define USE_PARENS_AROUND_GETTEXT_N 1
 #endif
-- 
2.26.2.812.g046d49d455

