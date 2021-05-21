Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88528C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 02:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64253600CD
	for <git@archiver.kernel.org>; Fri, 21 May 2021 02:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhEUCII (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 22:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhEUCII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 22:08:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD6C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 19:06:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f22so5417792pfn.0
        for <git@vger.kernel.org>; Thu, 20 May 2021 19:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lOVl2UZwtWfftxHqDfV6CSVooGT/hpxdBKkUyzuuIk4=;
        b=Sz0gghepe4KevpsCy+UmRQaH+4SAyEmyea2UHu0li/mBV2tn9lx4RpxP5QFS80oC16
         YJ9ROYNCMraqInzeCOh8rpRAtIN/G9grmueuTNbr/jrZ2NmHkUM76po4RlsazGoUl8i1
         En+xc6OeTpFsYlyZxpgElQLHw3JF9B5NlpVy6xDzH3rfBkOyW2FvgknBb0pgM2QTEprr
         Y34ZjKMltm4qcdvNhEVOfsE84jBUCh6kISD2Lc2QYgCABXJj/GeKbvDAFwRmi6Y3W1fY
         LEmJAQ9KRje9kiwLoJe4AbChDTBSrkuMGFqoCPqcLR1XdjYpkwSyorVw0QDjiQp7nznn
         xpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lOVl2UZwtWfftxHqDfV6CSVooGT/hpxdBKkUyzuuIk4=;
        b=RZzT7DdzedpWvfaXhgpa/tC81L4pCURxbo35y1C+/kDKk2PIv+ay4/I6rohQ3JNa+j
         tgjKc+WffiOjXuIRZ75AOk43YLrrvd5+JCqWDfZndRbC1V+Lj1SsA7/ScTM+B4Npt/cD
         wNJiHO/l6QpY5gJy7jpYR5vW4XkCV1OpLjWGvOMWGS1k759BUuqzIqYCs0puQVWqbEOh
         etmtB3sCBnG0JVj71+KQogi5m7yPF83kFLKu+sLrPxc9O/MrACo8wC6HZg78AMJ/SW7x
         udYx8oGLsH0YVhjdcQ76DXDDq3Pd1TvfEunNbcrj5UCtDofDX7YHVH9S2nF9xqXa5HRZ
         0M6g==
X-Gm-Message-State: AOAM533nqN4gnMgZrxqZ/nhRBcfpbp8NGDC4WDfl+vCuq7K6B9CPk3vM
        8TL3BchrKbqtT82aHgHVjEU=
X-Google-Smtp-Source: ABdhPJxY71/MsGbZhslvs0Q98WhN1StM9RsORWMP63g7ooN4bx9bq8gAHBjPDBTV4DwXLtqLeOjEow==
X-Received: by 2002:a63:741e:: with SMTP id p30mr7573099pgc.68.1621562804303;
        Thu, 20 May 2021 19:06:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8774:366c:ae84:8f12])
        by smtp.gmail.com with ESMTPSA id x23sm7581249pje.52.2021.05.20.19.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 19:06:43 -0700 (PDT)
Date:   Thu, 20 May 2021 19:06:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific
 code
Message-ID: <YKcVsfsLZqrkMjXl@google.com>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Change a comment added in e208f9cc757 (make error()'s constant return
> value more visible, 2012-12-15) to note that the code doesn't only
> depend on variadic macros, which have been a hard dependency since
> 765dc168882 (git-compat-util: always enable variadic macros,
> 2021-01-28), but also on GCC's handling of __VA_ARGS__. The commit
> message for e208f9cc757 made this clear, but the comment it added did
> not.
>
> See also e05bed960d3 (trace: add 'file:line' to all trace output,
> 2014-07-12) for another comment about GNUC's handling of __VA_ARGS__.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  git-compat-util.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Oh, subtle.  In fact, I believe 9798f7e5f9 (Use __VA_ARGS__ for all of
error's arguments, 2013-02-08) got rid of the gcc-ism, so we could do
the following instead.

(See section 6.10.3.10 for a description of

	#define f(...) g(__VA_ARGS__)

in the C99 standard.)

Thanks,
Jonathan

-- >8 --
Subject: error: use macro-based static analysis aid on non-gcc, too

In the rest of Git, we check HAVE_VARIADIC_MACROS (which is
unconditionally defined to true as a way to discover platforms that do
not support it) to guard code that requires variadic macro support.
This variadic macro is a bit older, so it uses a __GNUC__ check
instead.  Switch to use of HAVE_VARIADIC_MACROS here as well, so more
compilers can get the benefit of knowing at compile time that error()
always returns -1.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..ca22b11760 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -483,14 +483,19 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 #include <openssl/x509v3.h>
 #endif /* NO_OPENSSL */
 
+/*
+ * This is always defined as a first step towards making the use of variadic
+ * macros unconditional. If it causes compilation problems on your platform,
+ * please report it to the Git mailing list at git@vger.kernel.org.
+ */
+#define HAVE_VARIADIC_MACROS 1
+
 /*
  * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because some compilers may not support variadic macros. Since we're only
- * trying to help gcc, anyway, it's OK; other compilers will fall back to
- * using the function as usual.
+ * gcc with -Wuninitialized analysis. Compilers without support for variadic
+ * macros will fall back to using the function as usual.
  */
-#if defined(__GNUC__)
+#ifdef HAVE_VARIADIC_MACROS
 static inline int const_error(void)
 {
 	return -1;
@@ -1192,13 +1197,6 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #endif
 #endif
 
-/*
- * This is always defined as a first step towards making the use of variadic
- * macros unconditional. If it causes compilation problems on your platform,
- * please report it to the Git mailing list at git@vger.kernel.org.
- */
-#define HAVE_VARIADIC_MACROS 1
-
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
-- 
2.31.1.818.g46aad6cb9e

