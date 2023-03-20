Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B095C76195
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjCTRIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjCTRIA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:08:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01A2F046
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:02:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c18so13125801ple.11
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679331675;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ6yKtbMnmnY5hTyJSXG4S07L70uK/Ni4jXVwoSx+Tg=;
        b=a8WCQNk7nLJ59XDRiO8NK2+Jfns8RrqEOZlQZvwjkzLbtAJLk6YXUmcSWXvTZSrTN0
         BKb4Vqsf/LS10xj/Ovxyw0mlzPwM54Vc/6DczvkakpbrJZA0Fo7aXFzQeRl2C0mk+Uni
         LUl7hORjiTux/fongarixH2G82+qy7sjbCWSiZ0fQGubbgJlxUrToIfhmgjF3mB9ILPQ
         8ZOpULQ/Fn6bFtKAlsMTwEOgg4UFpQIX6TJ0HbVrtPOdtfxqJRy1e+Orm1Zqy/qMqjZA
         oiXfovfvNftdD1jiaEl80BiSQJbMmHZC09OkZKCQYzgeCOgknsdHl8waK9dGBgFTCsCs
         IQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331675;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ6yKtbMnmnY5hTyJSXG4S07L70uK/Ni4jXVwoSx+Tg=;
        b=SIugIpUUAR2qAiV3LvAU6BOYNsgC3Nb3o/wdOrKpyrrXChuJ2PkXz7r5/OjiToDKhM
         FxOIDkt35cPUst253HAkJ36dcGeuOVhsKx+XQaxdZTY7mxNFNABobzDIuo4Df1+OJHqa
         uNlfe0oYn6Gz3ulhi+ZgNeXIb811tt5krMfb2fXt0CBp0YCYrYKXnmlMloUmGp1Jp870
         JCSyk7pA8b/c1nHKPTivy1h9ldnaERT/fU4C5lvzj+e75FE2cTf7G2cn0JbJJYnnYqg7
         Lbpc3sEvF+fgwczdnSo9+ffx3gQFXnxyXDlHJPXxCtoIaW1+hUD4jGVqoSZvXfJzrIMU
         N4CA==
X-Gm-Message-State: AO0yUKWxpuU1gGA8QEPebnQvWb1Kfd9++L57m07z2HliDf3wPCNRLh+1
        qJKIFB46Zl8F8j3Wk46Ad5Jsda8/2e4=
X-Google-Smtp-Source: AK7set+XSysBRxLDLrMRCe7JDK66nHEMkTkQgmUa8ZPFje+EK0X3qGb+fZ5P5Y9g1eF5/dL9fvoALQ==
X-Received: by 2002:a17:90a:19d0:b0:23d:360:877a with SMTP id 16-20020a17090a19d000b0023d0360877amr18463025pjj.25.1679331674982;
        Mon, 20 Mar 2023 10:01:14 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090a128700b00233ebab3770sm6389394pja.23.2023.03.20.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:01:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>, Paul Eggert <eggert@cs.ucla.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
        <20230319064353.686226-3-eggert@cs.ucla.edu>
        <20230319193449.M629601@dcvr> <xmqqh6ufo01u.fsf@gitster.g>
Date:   Mon, 20 Mar 2023 10:01:14 -0700
Message-ID: <xmqqr0tjmk6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <e@80x24.org> writes:
> ...
>> I decided to check glibc archives to find more discussion on it.
>> So far, I've found:
>>
>>   https://inbox.sourceware.org/libc-alpha/20230306160321.2942372-1-adhemerval.zanella@linaro.org/T/
>>
>> and the original bug:
>>   https://sourceware.org/bugzilla/show_bug.cgi?id=30200
>>
>> And this is due to the time64 changes in glibc 2.31+?
>> (<= 2.30 isn't affected?)
>>
> ...
>
> Yeah, this is interesting.  I however wonder if we should follow our
> usual pattern of implementing git_time() with the identical function
> signature as what we replace (i.e. system's time()), and #undef/#define
> the symbol we replace with git_time, though.  Wouldn't it make [1/2]
> a lot smaller and future-proof?

And here is how such an approach may look like.  The second part is
more or less the same as Paul's version so I kept his authorship
there (these are mostly for discussion and not for application).

----- >8 ----- [PATCH 1/2] ----- >8 -----
Subject: [PATCH] time(): allow OVERRIDE_TIME to redefine time(2)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile          | 11 +++++++++++
 compat/time.c     | 11 +++++++++++
 config.mak.uname  |  1 +
 git-compat-util.h |  8 ++++++++
 4 files changed, 31 insertions(+)
 create mode 100644 compat/time.c

diff --git a/Makefile b/Makefile
index 50ee51fde3..aa6fcd6e04 100644
--- a/Makefile
+++ b/Makefile
@@ -286,6 +286,12 @@ include shared.mak
 # crashes due to allocation and free working on different 'heaps'.
 # It's defined automatically if USE_NED_ALLOCATOR is set.
 #
+# Define OVERRIDE_TIME to override time(2) and replace it with an
+# implementation based on gettimeofday(2).  THis is necessary when
+# glibc 2.31+ on Linux is used, where in the first 1 to 2.5 ms of
+# every second, time(NULL) returns a value that is one less than the
+# tv_sec part of higher-resolution timestamps used in the file system.
+#
 # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
 # feature.
 #
@@ -2061,6 +2067,11 @@ ifdef OVERRIDE_STRDUP
 	COMPAT_OBJS += compat/strdup.o
 endif
 
+ifdef OVERRIDE_TIME
+	COMPAT_CFLAGS += -DOVERRIDE_TIME
+	COMPAT_OBJS += compat/time.o
+endif
+
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	export GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
diff --git a/compat/time.c b/compat/time.c
new file mode 100644
index 0000000000..a3ef5c0e98
--- /dev/null
+++ b/compat/time.c
@@ -0,0 +1,11 @@
+#include "../git-compat-util.h"
+
+#undef time
+time_t git_time(time_t *tloc)
+{
+	time_t t = time(NULL);
+
+	if (tloc)
+		*tloc = t;
+	return t;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 64c44db805..29398919e8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -64,6 +64,7 @@ ifeq ($(uname_S),Linux)
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
+	OVERRIDE_TIME = YesPlease
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
diff --git a/git-compat-util.h b/git-compat-util.h
index 1e6592624d..2279f3c90c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -917,6 +917,14 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
 char *gitstrdup(const char *s);
 #endif
 
+#ifdef OVERRIDE_TIME
+#ifdef time
+#undef time
+#endif
+#define time git_time
+extern time_t git_time(time_t *);
+#endif
+
 #ifdef NO_GETPAGESIZE
 #define getpagesize() sysconf(_SC_PAGESIZE)
 #endif
-- 
2.40.0-115-ge25cabbf6b


----- >8 ----- [PATCH 2/2] ----- >8 -----
From: Paul Eggert <eggert@cs.ucla.edu>
From: Paul Eggert <eggert@cs.ucla.edu>
Subject: [PATCH] time(): use gettimeofday()

Use gettimeofday instead of time(NULL) to get current time.
This avoids clock skew on glibc 2.31+ on Linux, where in the
first 1 to 2.5 ms of every second, time(NULL) returns a
value that is one less than the tv_sec part of
higher-resolution timestamps such as those returned by
gettimeofday or timespec_get, or those in the file system.
There are similar clock skew problems on AIX and MS-Windows,
which have problems in the first 5 ms of every second.

Without this patch, users can observe Git issuing a
timestamp T+1 before it issues timestamp T, because Git
sometimes uses time(NULL) or time(&t) and sometimes uses
higher-res methods like gettimeofday.  Although strictly
speaking users should tolerate this behavuior because a
superuser can always change the clock back, this is a
quality of implementation issue and users naturally expect
Git to issue timestamps in increasing order unless the
superuser has fiddled with the system clock.

This patch always uses gettimeofday(...) instead of time(...),
and I have verified that the resulting .o files never refer
to the name 'time'.  A trickier patch would change only
those calls for which timestamp monotonicity is user-visible.
Such a patch would require more expertise about Git internals,
though, and would be harder to maintain later.

Another possibility would be to change Git's documentation
to warn users that Git does not always issue timestamps in
increasing order.  However, Git users would likely be either
dismayed by this possibility, or confused by the level of
detail that any such documentation would require.

Yet another possibility would be to fix the Linux kernel so
that the time syscall is consistent with the other timestamp
syscalls.  I suppose this has not been done due to
performance implications.  (Git's use of timestamps is rare
enough that performance is not a significant consideration
for git.)  However, this wouldn't fix Git's problem on older
Linux kernels, or on AIX or MS-Windows.

Signed-off-by: Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/time.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/compat/time.c b/compat/time.c
index a3ef5c0e98..758a160ee7 100644
--- a/compat/time.c
+++ b/compat/time.c
@@ -3,9 +3,15 @@
 #undef time
 time_t git_time(time_t *tloc)
 {
-	time_t t = time(NULL);
+	/*
+	 * Avoid time(NULL), which can disagree with gettimeofday()
+	 * and filesystem timestamps.
+	 */
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
 
 	if (tloc)
-		*tloc = t;
-	return t;
+		*tloc = tv.tv_sec;
+	return tv.tv_sec;
 }
-- 
2.40.0-115-ge25cabbf6b

