Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F70C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0583A60E77
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350392AbhICUOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbhICUOH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 16:14:07 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE1C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 13:13:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id z2so327656qvl.10
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OOikacycT07/+jnqD5RNzzGDziDDDDuan8ZlKI9mjBw=;
        b=FtQqPBTj+nJ2TMzruQUz/hncO0tq42dSlUk1qi2aal2lkW5QkXLxYOHKyoJWwAv/j6
         /7n3qy3ZFmHM9XjhOR5+l21SMBXJaHugY+XoPw/SDtI9ybhZKssXKfSQaE5n9ngvCxK/
         /s0j0X8jUeOhl6Mlgpgtx4HnuFlLQZwjaPMaB1tFfp8FjRkYJ4RRHrtISFl0pWdOoVbe
         HBXbydmBFOBc9HZTYEffD1w+Yk2naAzXpZOXkXTs3S/vTjWfuDB31QUCXLj1BnZUmy99
         vLNyIP99r6qslYtxn86K1MUGbG38o8HFFiy79x8BWosIv68eG05INq36l9B2IkshUNgZ
         tnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OOikacycT07/+jnqD5RNzzGDziDDDDuan8ZlKI9mjBw=;
        b=PE6BjRuzwJmjtqbS9Pd1XOJsu3iREtWxEM4w7CZJ65VnkQR8obY3TV9ygmIvFC+tvf
         DAemiFLDP0If5tvqbFI/Gj4V2/Cex2C8yah0F51Odk1vUADf8S3xXJ74EbzNRI9NlazZ
         7USkQKI3CYGrgEAO6SVywiV2Em3aZUT6hF//zgwz8HawggUnaDTHDxVPBTsOgW8yRNIl
         tkYdzenu01/WVXYQWMJ4H/l7MnXzqr6+MrpP8l7+shzKV58eDyc2yWwQqpEnilrUonmn
         RQnQHM+j1toRSVzHSlHnjtyVv1ofZK1rDjGW0dzYcVQTl3K2UTV8z1yP4V4Gl1bRde2n
         SIhQ==
X-Gm-Message-State: AOAM531mRpneqAwXa7o2UCOhk8OF1iHMP9bgGh55+ZtoODGYfcqLF/6W
        AnXATyQI20C3CSlOCfwFaKU=
X-Google-Smtp-Source: ABdhPJxH+SKj2h6fb2L5JdaMBPi55SKNgTOMmE3atTBUh/pFks1ZrXjCuJ9zkGKJ8ZIU3KoFcHRTBQ==
X-Received: by 2002:a05:6214:92b:: with SMTP id dk11mr883617qvb.46.1630699985718;
        Fri, 03 Sep 2021 13:13:05 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l126sm168410qke.96.2021.09.03.13.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 13:13:05 -0700 (PDT)
Date:   Fri, 3 Sep 2021 13:13:02 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
Message-ID: <YTKBzi3z5AotirNO@carlos-mbp.lan>
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
 <20210903170232.57646-3-carenas@gmail.com>
 <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 03, 2021 at 08:47:02PM +0200, René Scharfe wrote:
> Am 03.09.21 um 19:02 schrieb Carlo Marcelo Arenas Belón:
> > diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> > index 1cc31c3502..edb438a777 100644
> > --- a/compat/nedmalloc/nedmalloc.c
> > +++ b/compat/nedmalloc/nedmalloc.c
> > @@ -510,7 +510,7 @@ static void threadcache_free(nedpool *p, threadcache *tc, int mymspace, void *me
> >  	assert(idx<=THREADCACHEMAXBINS);
> >  	if(tck==*binsptr)
> >  	{
> > -		fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", tck);
> > +		fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", (void *)tck);
> 
> This change is not mentioned in the commit message.

got me there, I was intentionally trying to ignore it since nedmalloc gives
me PTSD and is obsoleted AFAIK[1], so just adding a casting to void (while
ugly) was also less intrusive.

> compat/nedmalloc/nedmalloc.c:513:82: error: format specifies type 'void *' but the argument has type 'threadcacheblk *' (aka 'struct threadcacheblk_t *') [-Werror,-Wformat-pedantic]
>                 fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", tck);
>                                                                             ~~                 ^~~
> This makes no sense to me, though: Any pointer can be converted to a
> void pointer without a cast in C.  GCC doesn't require void pointers
> for %p even with -pedantic.

strange, gcc-11 prints the following in MacOS for me:

compat/nedmalloc/nedmalloc.c: In function 'threadcache_free':
compat/nedmalloc/nedmalloc.c:522:78: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'threadcacheblk *' {aka 'struct threadcacheblk_t *'} [-Wformat=]
  522 |                 fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", tck);
      |                                                                             ~^                 ~~~
      |                                                                              |                 |
      |                                                                              void *            threadcacheblk * {aka struct threadcacheblk_t *}

I think the rationale is that it is better to be safe than sorry, and since
the parameter is variadic there is no chance for the compiler to do any
implicit type casting (unless one is provided explicitly).

clang 14 does also trigger a warning, so IMHO this code will be needed
until nedmalloc is retired.

> A slightly shorter fix would be to replace "tck" with "mem".  Not as
> obvious without further context, though.

so something like this on top?

Carlo
---- > 8 ----
diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index edb438a777..14e8c4df4f 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -510,7 +510,15 @@ static void threadcache_free(nedpool *p, threadcache *tc, int mymspace, void *me
 	assert(idx<=THREADCACHEMAXBINS);
 	if(tck==*binsptr)
 	{
-		fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", (void *)tck);
+		/*
+		 * Original code used tck instead of mem, but that was changed
+		 * to workaround a pedantic warning from mingw64 gcc 10.3 that
+		 * requires %p to have a explicit (void *) as a parameter.
+		 *
+		 * This might seem to be a compiler bug or limitation that
+		 * should be changed back if fixed for maintanability.
+		 */
+		fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", mem);
 		abort();
 	}
 #ifdef FULLSANITYCHECKS
