Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80082C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjC0VdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjC0VdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 17:33:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EEB2D46
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 14:33:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c18so9747531ple.11
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679952787;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rOPBOU3LfVaqHMA3dYkSFuy0bOnhL6jyi9s0UZvQ3k=;
        b=TQTUQrawDJNQ9z9fpH01ykGW3dDyefmJy/I7tic8nRxqQI+cZv6xDCVFLILcvZg7iR
         cG69i88vlJTdJo07pBqKidZW+4rDzKNBL456AYSJ6Fcbr4t3JJ4D4A2wkmbHT0MAuaqY
         E/NtSea7zt9ld7nbeXzFBR0FeKz3jx8Tm7HqqNNo6Ed7Q/n6hnI1zPKyT7P8udwbslJ3
         uJuZV6XwQU6O+TtRAG5oDrVZsshvaH3oV3RlvYM72bhUKQKAn6VGNGE56jRvpsU9EMzS
         +iXIet9ighy5Y4xklIldGlZBnPD3/kpD/DtZnS4Ux3sneCIzgheEYeJUquHlZgZZLaqV
         SwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952787;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rOPBOU3LfVaqHMA3dYkSFuy0bOnhL6jyi9s0UZvQ3k=;
        b=Cm4L79L0tEfRlal6JN/O6TEOch77+hDwvG/SLGGekaFzlSMFGHxbXWQUnfYfnJoY2C
         dEMZM04W4mrI8gxUuBu+WxUM8YhjpQw3cUqUVe9+0SqTybDqlwRgUkstlMRC+jRSwSCF
         qcZfUyiiXpB0agyy80ojZJScklurWf7XSOOHZikMaAkc2EXZozfkuBxqWtfGzV4woYGd
         AprNwJAGqgizE7kUt748NmbfCbEO/vOHxYo4u4U8t2nQqatEyDBtWf9vMlxzGKvcGtZS
         yKuM05dA1Q99XJ5lL+ncTypWo3138GnOatDDmZbqrarI0+JuTxbQc204cFacQXQyA/Jn
         4LVQ==
X-Gm-Message-State: AO0yUKXk9vCulV9ZA+PbjMbZBFlW2suitcnWic0aDJCrSW6aRGKuw8eH
        oQ37MArne5oSJqRP/Sy80i4=
X-Google-Smtp-Source: AK7set/7kAqIvZGZNNdAX8zNUftMBFY9KFIZJsRFgfwCEvwcpZ5l2WvmkOFewJHDy5OijYcMKEKUtg==
X-Received: by 2002:a05:6a20:4e1a:b0:cc:a5d4:c334 with SMTP id gk26-20020a056a204e1a00b000cca5d4c334mr11033119pzb.10.1679952787071;
        Mon, 27 Mar 2023 14:33:07 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g19-20020a62e313000000b006247123adf1sm4019406pfh.143.2023.03.27.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:33:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Mario Grgic <mario_grgic@hotmail.com>,
        demerphq <demerphq@gmail.com>, git@vger.kernel.org
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
        <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de>
        <xmqqh6u6cg4l.fsf@gitster.g>
        <03fd7ddb-8241-1a0a-3e82-d8083e4ce0f7@web.de>
Date:   Mon, 27 Mar 2023 14:33:06 -0700
In-Reply-To: <03fd7ddb-8241-1a0a-3e82-d8083e4ce0f7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 27 Mar 2023 19:23:35 +0200")
Message-ID: <xmqqjzz1nalp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> 54463d32ef only affects basic regular expressions (BRE), but -G and -S
> use extended ones (ERE).  macOS allows both to be "enhanced".
>
> I have a hard time finding a readable reference to the documentation to
> brings us all onto the same page regarding what REG_ENHANCED actually
> does.  [1] is in raw troff format, [2] isn't very pretty and shows ads.

Wow, [2] is also misleading in that it loses the distinction between
'+' and '\+'; in [1] at least you can see the differences between \&+
and \e+ ;-)

> Anyway, the rather lengthy section "ENHANCED FEATURES" explains it.

I suspect that 54463d32ef was done in a conservative way to avoid
unintended side effects to make ERE "enhanced".  I am not 100%
certain, but after reading the documentation you pointed at, I do
not see a valid expression without ENHANCED flag starting to mean
totally different thing with it (well, an extra '?' turning a
pattern from greedy to minimal may count as such a change in
semantics, but I do not see anybody sensible adding an extra '?'
in a pattern in the first place).

Perhaps it is safe to go ahead and loosen what 54463d32ef did, with
something like this (this is not even compile tested, of course)?

 Makefile                  | 9 +++++++++
 compat/regcomp_enhanced.c | 2 ++
 git-compat-util.h         | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git c/Makefile w/Makefile
index 50ee51fde3..1fe0eb399e 100644
--- c/Makefile
+++ w/Makefile
@@ -293,6 +293,10 @@ include shared.mak
 # the flag REG_ENHANCED and you'd like to use it to enable enhanced basic
 # regular expressions.
 #
+# Define USE_ENHANCED_REGULAR_EXPRESSIONS if your C library provides
+# the flag REG_ENHANCED and you'd like to use it to enable enhanced
+# regular expressions for both BRE and ERE.
+#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
@@ -2041,11 +2045,16 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 else
+ifdef USE_ENHANCED_REGULAR_EXPRESSIONS
+	COMPAT_CFLAGS += -DUSE_ENHANCED_REGULAR_EXPRESSIONS
+	COMPAT_OBJS += compat/regcomp_enhanced.o
+else
 ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_OBJS += compat/regcomp_enhanced.o
 endif
 endif
+endif
 ifdef NATIVE_CRLF
 	BASIC_CFLAGS += -DNATIVE_CRLF
 endif
diff --git c/compat/regcomp_enhanced.c w/compat/regcomp_enhanced.c
index 84193ce53b..aadbbac6d3 100644
--- c/compat/regcomp_enhanced.c
+++ w/compat/regcomp_enhanced.c
@@ -3,7 +3,9 @@
 
 int git_regcomp(regex_t *preg, const char *pattern, int cflags)
 {
+#ifndef USE_ENHANCED_REGULAR_EXPRESSIONS
 	if (!(cflags & REG_EXTENDED))
+#endif
 		cflags |= REG_ENHANCED;
 	return regcomp(preg, pattern, cflags);
 }
diff --git c/git-compat-util.h w/git-compat-util.h
index 1e6592624d..95d9b75a15 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -1377,7 +1377,7 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
 }
 
-#ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
+#if defined(USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS) || defined(USE_ENHANCED_REGULAR_EXPRESSIONS)
 int git_regcomp(regex_t *preg, const char *pattern, int cflags);
 #define regcomp git_regcomp
 #endif

