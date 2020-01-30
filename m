Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3100C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932E020708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OslB3g2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgA3U1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:27:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35649 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3U1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:27:12 -0500
Received: by mail-io1-f66.google.com with SMTP id h8so5585241iob.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p02Flm59Uk6d7zCXh24SFGpP/1q2j3ewIbAdkfluklg=;
        b=OslB3g2y0OPQKMR0XNmj2iBP1YpDitaj77mubyErJ+ztzQ2XOmiGYKldRED/SMO2Vl
         1Zviq7qc8vudTTZMAYtNRdAojZcNXKEjEJ8rXg4Et3jJxwhEd4H96/GWMbi3eQLc0tbA
         j/LunwregIIXREtbvOzTDztR4Pj0oFdW3/hDUN8HIAL46D/0t5h431NwAtaPQkoH4kDZ
         aFdPA10R8/Mmku4TmOeQ/vHiQ968R0KGXAgziEq9yuDySzwhuyj6wpbCk5q/lH/2uAmV
         Vba90ZOer9Vrs6dh1E1lIFXi+IVdEEU66OA47FmGwKwYQIHu9jxvIO4ctQGnnkv0zN5v
         EG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p02Flm59Uk6d7zCXh24SFGpP/1q2j3ewIbAdkfluklg=;
        b=j9Ri10uYIzCDucaIrPF0XhC/erJzYGSZFAFU8V30acPR8qIoUX1MKU5jGaOxI7FkI1
         DR0xloXJasHfy1H53gDtQxJ+KFMe3wqVqQRzrglwuW7YxQxVzixf17tp8nEnHaPR9w2o
         d1lwHiuShPa/gi4VC9i3NfiOVRrBt3CCBtScv2DuFYosi1Ccp+xDa9oYuOeRbAPdap/0
         D0s1D90v01HLEY5rgFy78mmyaVBXo3UgYKb8ZIBJiYPxGQKOBrVbhPffWXDP96EFdemA
         xpOK7gAXRoQWj6clc+hKEH8WVrtQuXG0qZ3LjnbWzCugnSjvN1wRJv+dBLzvRf0PZT2B
         k1EA==
X-Gm-Message-State: APjAAAVmL34arem1b1L/eZhQPPlsipIQ0HS2y3ltR9hrnVU3Nvv3rDD/
        D26YhouMajozX2RvfTwcj8xFQJQ96GjpBpV4FuE=
X-Google-Smtp-Source: APXvYqz2qRpGj3oUKpJqcxxOAK5c2DTcqpjj6YlWhPA8PHVT+li5swHOlJxTN0IQomuFGwTMkUofLvC70aLj70myrdA=
X-Received: by 2002:a5e:840f:: with SMTP id h15mr5925166ioj.286.1580416031490;
 Thu, 30 Jan 2020 12:27:11 -0800 (PST)
MIME-Version: 1.0
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
 <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet> <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet> <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet> <xmqqmuaf70xx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuaf70xx.fsf@gitster-ct.c.googlers.com>
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Fri, 31 Jan 2020 01:56:35 +0530
Message-ID: <CAFFaXsxeyxkPwAYSs=TEzd8fsa5r9KpJ7q8PX0ehNJ1Wpai4fA@mail.gmail.com>
Subject: Re: Facing error in git-imap-send while compiling Git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,
I'll admit I'm quite perplexed with this OpenSSL problem that I'm
facing. Here's what I've done along with their results:
1. eroen and Jack Bates' suggestions
(https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com/)
2. I've also implemented Johannes' suggestions, and I'm still facing
the same problem.Here's the final diff:
---
diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..3248bc2123 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -41,7 +41,9 @@ typedef void *SSL;
 /* We don't have curl, so continue to use the historical implementation */
 #define USE_CURL_DEFAULT 0
 #endif
-
+#ifndef SSL_library_init
+       #define SSL_library_init();
+#endif
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;

@@ -59,6 +61,13 @@ static struct option imap_send_options[] = {
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3

+
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
+       #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
+       #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
+       #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y))
+#endif
+
 __attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
 __attribute__((format (printf, 1, 2)))
@@ -275,21 +284,30 @@ static int verify_hostname(X509 *cert, const
char *hostname)

 static int ssl_socket_connect(struct imap_socket *sock, int
use_tls_only, int verify)
 {
-#if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
-       const SSL_METHOD *meth;
-#else
-       SSL_METHOD *meth;
-#endif
-       SSL_CTX *ctx;
-       int ret;
-       X509 *cert;
-
-       SSL_library_init();
-       SSL_load_error_strings();
+       #if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
+               const SSL_METHOD *meth;
+       #else
+               SSL_METHOD *meth;
+       #endif
+               SSL_CTX *ctx;
+               int ret;
+               X509 *cert;
+
+       #if OPENSSL_VERSION_NUMBER >= 0x10100000L ||
defined(LIBRESSL_VERSION_NUMBER)
+               OPENSSL_init_ssl(0, NULL);
+               meth = TLS_method();
+       #else
+               SSL_library_init();
+               SSL_load_error_strings();
+               meth = SSLv23_method();
+       #endif

-       meth = SSLv23_method();
        if (!meth) {
-               ssl_socket_perror("SSLv23_method");
+       #if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+                       ssl_socket_perror("TLS_method");
+       #else
+                       ssl_socket_perror("SSLv23_method");
+       #endif
                return -1;
        }


---

Also, on a different note: I'm actually really interested in applying
to Git for GSoC, and I should be doing Git microprojects right now to
properly cement my chance of doing GSoC with Git. Many aspiring GSoC
applicants already been asking, enquiring and maybe even working about
Git microprojects, as evident from the mailing list.

So while I'm not saying that I'm in deep trouble and all this OpenSSL
v1.1.1 issue fixing is completely useless (I'm learning quite a lot
along the way and able to understand the project structure), but
saying that I'm not worried about my GSoC prospects of working in this
organization would honestly be false :) . I love git, I would love
contributing to Git, but I'd love to do a GSoC Summer with Git much
more than the rest.

Please let me know where am I going wrong. If there's any other system
packages that I can download so that I can focus on other Git issues
and this one simultaneously, please let me know. Here are my system
specifications (let me know if you need anything more specific):
---
OS: Ubuntu 18.04
Linux Kernel: 5.3
OpenSSL Version: 1.1.1d
---

Apologies for the long email,
Thank You,
Nirmal Khedkar
(https://nirmalhk7.github.io)


On Thu, Jan 23, 2020 at 12:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> From my limited knowledge of OpenSSL libraries, I think the error has
> >> more to do with 'SSL_library_init()' , which appears like a
> >> constructor to the OpenSSL library. I found these emails regarding
> >> "if" cases around this function. Please check out these patches:
> >> 1. Rosen Penev:
> >> https://lore.kernel.org/git/20181227023548.396-1-rosenp@gmail.com/
> >
> > I remember that one. And I agreed with Junio that the documentation
> > suggests that the call is _optional_, while the patch suggests that it
> > would be _incorrect_ instead.
> >
> > And looking at
> > https://www.openssl.org/docs/man1.1.1/man3/SSL_library_init.html suggests
> > to me that it is still supported.
> >
> > Having said that, if I look at the headers installed for `libssl-dev`
> > version `1.1.1-1ubuntu2.1~18.04.5` in my Ubuntu installation, I see that
> > `/usr/include/openssl/ssl.h` defines that symbol as:
> >
> >       #  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
> >
> > but _only_:
> >
> >       # if OPENSSL_API_COMPAT < 0x10100000L
> >
> > So maybe that disagrees with the documentation that says that
> > SSL_library_init() is optional?
> >
> > The curious thing is that `OPENSSL_API_COMPAT` is not even defined
> > anywhere. So maybe it _is_ the right thing to also `#define
> > SSL_library_init() (void)` in the diff you listed above?
> >
> > _Maybe_ guarded within `#ifndef SSL_library_init ... #endif` guards?
> >
> >> 2. eroen: https://lore.kernel.org/git/20170112104219.563497-1-git-scm@occam.eroen.eu/
> >
> > That sounds like a good suggestion, too.
> >
> >> Are the fixes made in these patches relevant here. Please let me know
> >> if I'm going wrong.
> >
> > Yes, both threads are relevant, and if you can reconcile them into a patch
> > that makes Git compile with OpenSSL v1.1.1, I will try my best to review
> > them (Cc: me, just in case).
>
> I agree with the above reasoning and the suggestion given by Bates in
> https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com/
> sounds like a reasonable one.
>
> Thanks for digging and double-checking these two previous efforts,
> and giving another round of thoughts on them.
>
>
>
>
