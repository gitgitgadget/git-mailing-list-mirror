Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D70C2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 02:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B42420732
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 02:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXDIrUH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392863AbgDOCMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392860AbgDOCMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 22:12:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C501FC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 19:12:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ng8so6132826pjb.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 19:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XIjWU+wSnHHNKwlLFHF1ryberL79wJSQkoCtzUM9M7Y=;
        b=dXDIrUH+T8e71TlioAychj0Xxg3K0XSO0/cap+2BkLpzsdsAV/eUdSyYmeX8qz3GpH
         EvOWPbz4uuWzCtu1Wy1ulcjqiZbGuOiv/KDEycXa1m2FqwJSCmj5cMZasD767dA6FqqB
         pKPEiamYpDLp5rvJ0Zil7zmIXuHcyn6FPywdjdEJbQfbHr3XdUalnfSkRqmaLrPhssXG
         zKoWXo1VucRkQ2wOqY5ROgI/DB/9iThPG56BeGDBvYeCpQK/vfoN9yMVGKMoQ/e9qgZG
         6ilJVd1drohsEXKWsrGrWm3VwpVgAbWjBcNQnNkZ7jLRPApeKk7M7QSIwODPNk+5z9Zs
         kFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XIjWU+wSnHHNKwlLFHF1ryberL79wJSQkoCtzUM9M7Y=;
        b=UsCPJg55G/e9nn1clHx/k2lB2V+gdtIAOQVP2O1/2fTugRBbLtSQrqRYUhgIL3nCrP
         gCzTei2mqnDuGX3PkHs8Q+3/bX4hD/lZXcVbCjVx23maKTlQOohw+Rz8EP/99frWTF0i
         ifhrk1grNVbikaDavYwIyxe4whp6dtwfRszQ5dDYGO0ecNDHXJweDUHaDZVFV1usCKnt
         OmFgw6WBcbYBauCamw2IlXpcrYIT5F9dPy5LruSO0kF8GOI9M1ryDbWY0ZRJKuujh20K
         b8oUYtdQhaXu+qCDfgW8IFkozX1Mm1SuaGWAi/SaNgnlG7HhJNirhsMZhs839hXCdE1c
         2/1w==
X-Gm-Message-State: AGi0PuYSdJcw7F3h7mzTX1oNOOOfpI9pbNOUfV9sFk5P+9+ZmvzM2j44
        K03ZXOnZFqnDA53SOWBTe/KUBkbb
X-Google-Smtp-Source: APiQypI/OObr0xHHn9yTR67WRBMYAx4MqL0509WrmCPQnF8RzmE5Pyy6H47eKFW2mVTNH7ziy2F1EA==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr2864376plk.80.1586916725129;
        Tue, 14 Apr 2020 19:12:05 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id ie17sm5441439pjb.19.2020.04.14.19.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 19:12:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:12:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
Message-ID: <20200415021202.GA19025@danh.dev>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
 <20200414202401.GC1879688@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414202401.GC1879688@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-14 16:24:01-0400, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 14, 2020 at 04:31:55PM +0700, Đoàn Trần Công Danh wrote:
> 
> > @@ -666,6 +666,24 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
> >  		n++;
> >  	} while (isdigit(date[n]));
> >  
> > +	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
> > +	if (n == 8) {
> > +		tm->tm_year = num / 10000 - 1900;
> > +		tm->tm_mon = (num % 10000) / 100 - 1;
> > +		tm->tm_mday = num % 100;
> > +		return n;
> > +	}
> 
> I worry a little this may conflict with other approxidate heuristics.
> The only one I can think of is an actual unix timestamp, though, and we
> already require that to have at least 9 digits (plus anybody wanting to
> use one robustly really should be using @12345678).
> 
> And it looks like we'd exit early from the function for anything longer
> than 4 digits anyway, ignoring the value.
> 
> We could probably tighten the heuristics a bit by insisting that the
> month and day be sensible. Or even year (see the 1900 to 2100 magic for
> the 4-digit year guess).

Yeah, It's make sense to tighten the heuristics.
While 1900 is lower bound for year makes sense to me,
but I don't think we should limit upper bound for tm_year.

> > +	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
> > +	if (n == 6) {
> > +		tm->tm_hour = num / 10000;
> > +		tm->tm_min = (num % 10000) / 100;
> > +		tm->tm_sec = num % 100;
> > +		if (*end == '.' && isdigit(end[1]))
> > +			strtoul(end + 1, &end, 10);
> > +		return end - date;
> > +	}
> 
> And likewise here that the hour, minute, and second be reasonable.
> 
> -Peff

-- 
Danh
