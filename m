Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11376C2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC37B24655
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I60iVqOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKRCYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKRCYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:24:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947DC061A48
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:24:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so463212pfu.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lFHh7iHzk4DtnH3MMQx96mWwRQE1bzbmNw6MyND0R+o=;
        b=I60iVqOPGq7fTmCDX27BSAB6tcCMD7cOFqEQ5sc7XlwZj4/+zMkEe1kCJICJ3cxoiH
         x30yh7oO2+o2/xk20DQIw4cbCxuayd8VNU7EKMPNWJh8eibKWaYMD3id3hxzacRBFmh1
         pKI9QHeBgiYh9fOb6aMcVq+ryXAFPFo0bqMcX4eGEXcrKU4yuLrDdQb8e9Pbf6O3g20z
         v3FEeewowr6n/BLc2/TcwBxA50sUgFeHGZ57GPxCpS5kmZzlAu6NgqAJmSQ5GbZCZLGT
         6ldqKovWSWW/pb5rW1RL8lKjEJyPIir/2b3XfrP3fskTEJlBDMiwQ3tk8p8tVQBLnirH
         tf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lFHh7iHzk4DtnH3MMQx96mWwRQE1bzbmNw6MyND0R+o=;
        b=jtMgPDDPM+2RK24lkFcAdiUOpRdGUCMxJE7QubHnoo2ua5tc/UGK6gtvtb9suMqoHJ
         urxESh7DQgtbusJlkDUOpTUSPZkecFlmLI3FxEWAGs+pqI48WNK2Az6W3qs+gk6aVo+P
         kuSlQxI6rHrxHvX21n0et3kpNZaEuxmPYwRPizjDJBhTBfBwq+SK5uVemtecoJxnuzTn
         RDVfdaoQVhzpiQ2fKsIm+Jpop4XGBn++OFHQMBwaWXyad3htx6pGTQHO1Re4UGMEYFRw
         H8msnbeXfl/DcnUwu6rXkgqyh5R2TpSyjOmI54MEjkTeEnsA7HMBP4bqy8RLUO7A5Zw7
         8/CQ==
X-Gm-Message-State: AOAM5327eLiLJuhjf5lnvrDMiZuAy/VPJFAMeYtnnleUTk8WO7AvD2xI
        efjJ7VLHfmCzLarwbKFLkm4=
X-Google-Smtp-Source: ABdhPJwKXnO3qcsk9hWFCSddS8uT9CyCIaz+KOSBXBPYtDXF4MLlnfRTlsS3w4U0106Xy0P984CJxg==
X-Received: by 2002:a63:4d07:: with SMTP id a7mr6362836pgb.274.1605666245513;
        Tue, 17 Nov 2020 18:24:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id gx24sm436581pjb.38.2020.11.17.18.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 18:24:05 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:24:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
Message-ID: <20201118022402.GC360414@google.com>
References: <20201114084327.14891-1-martin.agren@gmail.com>
 <20201117021318.GA30463@coredump.intra.peff.net>
 <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
 <20201117225401.GA642410@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117225401.GA642410@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I actually wonder if it is time to drop HAVE_VARIADIC_MACROS completely.
> They are in C99, and we have been introducing many other C99-isms. It
> would be a minor cleanup to a few bits of code, which perhaps isn't
> worth the risk. But I also have a vague memory of not being able to
> implement some interfaces because we couldn't count on them.
>
> Poking around, 3689539127 (add helpers for allocating flex-array
> structs, 2016-02-22) points out one such case. I think discussion of
> BUG_ON() got blocked by that, too. Looks like we also discussed them in
> the big "C99 weather balloon" thread:
>
>   https://lore.kernel.org/git/20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net/
>
> Maybe it's time for something like this as a test:

Yes.  For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Want to re-send with a signoff?

Thanks,
Jonathan

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 2fd9d5b403..fe5de2239f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1194,14 +1194,9 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
>  extern int BUG_exit_code;
>  
> -#ifdef HAVE_VARIADIC_MACROS
>  __attribute__((format (printf, 3, 4))) NORETURN
>  void BUG_fl(const char *file, int line, const char *fmt, ...);
>  #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
> -#else
> -__attribute__((format (printf, 1, 2))) NORETURN
> -void BUG(const char *fmt, ...);
> -#endif
>  
>  /*
>   * Preserves errno, prints a message, but gives no warning for ENOENT.
> diff --git a/usage.c b/usage.c
> index 06665823a2..b72f48f70e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -273,23 +273,13 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
>  	abort();
>  }
>  
> -#ifdef HAVE_VARIADIC_MACROS
>  NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
>  {
>  	va_list ap;
>  	va_start(ap, fmt);
>  	BUG_vfl(file, line, fmt, ap);
>  	va_end(ap);
>  }
> -#else
> -NORETURN void BUG(const char *fmt, ...)
> -{
> -	va_list ap;
> -	va_start(ap, fmt);
> -	BUG_vfl(NULL, 0, fmt, ap);
> -	va_end(ap);
> -}
> -#endif
>  
>  #ifdef SUPPRESS_ANNOTATED_LEAKS
>  void unleak_memory(const void *ptr, size_t len)
