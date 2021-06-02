Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B4C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BB9613EB
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFBUNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBUNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:13:00 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B4C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 13:11:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 5so2056800qvk.0
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OzJCp1ThNDLUweBArweTEGFBtZ/Vx1zw9NthxiR7k54=;
        b=Zoot9Mw7X2JT61dd1G0/1b79q83Q1ptOxSrh4eWP+Q9MaxbPj2ZGYs1SzQ5WlZCBt6
         DhTX1Jq85WCoEG19IxVEeT9pWyLFcEeRJT7p+BVo3ASnHwEeXE4bTizq8NcHwA2V4max
         BWvlizp9YtXdVOdeIkfMF33vSFB4aY6sdT4UVOYxKimMl49clqMhqTkL5nvR+hY49ugW
         Y/7CiXPQZWC7LjkeK5BIIs2aHpKtuDJB1MjQdvav95lGS8Y+kFjlGQv9n3OvhbJliPCe
         xXrwaMmt9RvyJJD0qlW2CBr/yQ5j2ICeHWhtGN3kE5Fc8XUZULI+oo0tj8y24qTmKh6B
         g9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OzJCp1ThNDLUweBArweTEGFBtZ/Vx1zw9NthxiR7k54=;
        b=Y6NDi1CQdz2to8t1YxmRrVQhO0276IWSCJgNf7h3aWn3oiFXrAqqjR2qrmqka+BHPx
         0WXy5Uh2YwTFXjnuTlglnUOBfkmmpxB+3ir74WLoif2VbqyjcaKbuz0vqszruxKwkts/
         +UkKLI6+BPsMTPUoI3W60faQmEDO1fcuq54Lkb4ltal0UJr369xkbY4LhZkQaFzIXIeX
         payX4YmeWO3s4tiP5szVgoNUtYfFRNhFZVclkI+KIG5rljuc/ivqerlQy9tvsIjtxPJw
         yZAsH4SoWwG/qVAUJssz95yG/JXTlChyRQ9PaGoiZaYpT8itzXkuECdqiRbcXlG3O7wr
         p3WA==
X-Gm-Message-State: AOAM5314hk+6UIOlvroMGYY1Z2GjvtEOZCy6ISkQV79zOEuwW82pwp6X
        SuqVRpH8QkgIIUPIHPxzYO+BR59I1eu7piGv
X-Google-Smtp-Source: ABdhPJwBCn7n+omB4GuI9IwanxAlix4TQwsApwgs9zo/U3wpOrHgq9vx3B33qT3GdUy04b2X8MKPlQ==
X-Received: by 2002:ad4:5bc7:: with SMTP id t7mr3696604qvt.30.1622664676307;
        Wed, 02 Jun 2021 13:11:16 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id d18sm421960qty.67.2021.06.02.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:11:15 -0700 (PDT)
Date:   Wed, 2 Jun 2021 16:11:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLfl4jkuwSCiNrrS@nand.local>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLfgy94sbmStC0mR@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 03:49:31PM -0400, Jeff King wrote:
> And so when he gets this error:
>
>   fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN': Interrupted system call
>
> presumably we were in fsync() when the signal arrived, and unlike most
> other platforms, the call needs to be restarted manually (even though we
> set up the signal with SA_RESTART).

Aha, thanks for explaining. That makes sense to me.

> I'm not sure if this violates POSIX or not (I couldn't find a
> definitive answer to the set of interruptible functions in the
> standard).

I couldn't find anything either, but I believe you that what you
outlined is the right solution.

> But either way, the workaround is probably something like:

Seems very reasonable. Here's a patch:

--- >8 ---

Subject: [PATCH] compat: introduce git_fsync_with_restart()

Some platforms, like NonStop do not automatically restart fsync() when
interrupted by a signal, even when that signal is setup with SA_RESTART.

This can lead to test breakage, e.g., where "--progress" is used, thus
SIGALRM is sent often, and can interrupt an fsync() syscall.

Add a Makefile knob FSYNC_NEEDS_RESTART to replace fsync() with one that
gracefully handles getting EINTR.

Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile          |  8 ++++++++
 compat/fsync.c    | 10 ++++++++++
 git-compat-util.h |  6 ++++++
 3 files changed, 24 insertions(+)
 create mode 100644 compat/fsync.c

diff --git a/Makefile b/Makefile
index c3565fc0f8..ebea693a2c 100644
--- a/Makefile
+++ b/Makefile
@@ -423,6 +423,9 @@ all::
 # Define NEED_ACCESS_ROOT_HANDLER if access() under root may success for X_OK
 # even if execution permission isn't granted for any user.
 #
+# Define FSYNC_NEEDS_RESTART if your platform's fsync() needs to be restarted
+# manually when interrupted by a signal.
+#
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
 # default environment variables to be passed when a pager is spawned, e.g.
 #
@@ -1926,6 +1929,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_OBJS += compat/access.o
 endif

+ifdef FSYNC_NEEDS_RESTART
+	COMPAT_CFLAGS += -DFSYNC_NEEDS_RESTART
+	COMPAT_OBJS += compat/fsync.o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/compat/fsync.c b/compat/fsync.c
new file mode 100644
index 0000000000..f340fc628b
--- /dev/null
+++ b/compat/fsync.c
@@ -0,0 +1,10 @@
+#include "git-compat-util.h"
+
+#undef fsync
+int git_fsync_with_restart(int fd)
+{
+	int ret;
+	while ((ret = fsync(fd)) < 0 && errno == EINTR)
+		; /* try again */
+	return ret;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..972fdb609f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -833,6 +833,12 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 int git_atexit(void (*handler)(void));
 #endif

+#ifdef FSYNC_NEEDS_RESTART
+#undef fsync
+#define fsync git_fsync_with_restart
+int git_fsync_with_restart(int fd);
+#endif
+
 static inline size_t st_add(size_t a, size_t b)
 {
 	if (unsigned_add_overflows(a, b))
--
2.31.1.163.ga65ce7f831

