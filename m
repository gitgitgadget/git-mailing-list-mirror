Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5039EC352BE
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 02:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3FD206D5
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 02:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTkLubi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392900AbgDOCPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387800AbgDOCPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 22:15:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E45C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 19:15:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so6125486pje.5
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=an7BZy6/IaEgYXhcVDoIAjiZXEruuMOG0g3KjIQFlZ4=;
        b=gTkLubi/8j0+vCzVlMP1rz+UTpY5VViGABFA9wfeEnqWzWPSrKOngQ1IW3zoskGieB
         RyfYnXbk0Lioh5+FbAFWAJwcgaxtLRBktT9OqdQIn0AlI1LVTeuwdZ+j33zJs29HtBwD
         ViqdKupwxMLYrVjAPPIM+3UtJyTH4OygF10cqtsMSz3O0J1z+QfRm6dbucUQZ5kfCvyc
         JI/X5bpW2S9GA7EHmMzCrQRTEMTfXXOUHnF/xYsUXriSx4FRjzOAI11cQ4EuHi8F6Nrp
         knztMl1FvYi+jmLj0ZzMdttUa8sjjvrECZ98bdQAsmpjOGKWbPlzXn8bIahrux7EqfMD
         Dayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=an7BZy6/IaEgYXhcVDoIAjiZXEruuMOG0g3KjIQFlZ4=;
        b=R99WJkw9sRKNLl6fqTCHxWqYaNXTPclp5q9QRrFGAv9pM2297nErYb/9DIh17nU5M+
         JzV/DyNj86wgHDTu5V41Mj114m32h2CNgoXYt1YSNDFP2Rxk7zGv9b6AgOuwbevArA+4
         iMaGQc9STMYj7tnUUneabMZ+DJhCuJmkTO3lKqcffUpmlcSnZpyIZ9H0cTWoXXAzQTOe
         Ozf6LdTqQoz/HNNGSYy1Qd2Ev3Mizl2/cKyzow9ONj1oMnPrv21bYIcNltG3dRFOJu/e
         5KXSbLxJt9cTk/cNsWKfiiKa019pp+rO82jjOVDzqj7P+9gLLUUTEf8r3oW6/Wo1tnxE
         6kUw==
X-Gm-Message-State: AGi0Publx72G+Kryxu8KKGjSvEKT3Y9zPztaUVFHG44VblaJqmszIZF6
        LgqR5hVp8mOptn/catrstuQ/7EWQ
X-Google-Smtp-Source: APiQypIqOfSVFPojjNKEmxz71kO4HVQtT7Ee37h3Q7OR8xNtI6pl0bkXnR0H7nvIp+1UzcM1RxB+JQ==
X-Received: by 2002:a17:90a:b28e:: with SMTP id c14mr3518319pjr.168.1586916923683;
        Tue, 14 Apr 2020 19:15:23 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o21sm7630603pjr.37.2020.04.14.19.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 19:15:23 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:15:21 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] date.c: allow fractional second part of ISO-8601
Message-ID: <20200415021521.GB19025@danh.dev>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <45676f4a7d001dbd25bbae531cc2ae5fc53936bb.1586856398.git.congdanhqx@gmail.com>
 <20200414201606.GA1879688@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414201606.GA1879688@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-14 16:16:06-0400, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 14, 2020 at 04:31:54PM +0700, Đoàn Trần Công Danh wrote:
> 
> > git-commit(1) says ISO-8601 is one of our supported date format.
> > However, we only support RFC-3339 date format.
> > 
> > We can either:
> > - Update documentation from ISO-8601 to RFC-3339
> > - Add full support for ISO-8601
> > 
> > This series will try to add full support for ISO-8601.
> 
> That seems more like a cover letter for the full series. The important
> thing in this patch is more like:
> 
>   ISO-8601 allows timestamps to have a fractional number of seconds. We
>   represent time only in terms of whole seconds, so we never bothered
>   parsing fractional seconds. However, it's better for us to parse and
>   throw away the fractional part than to refuse to parse the timestamp
>   at all.

Yeah, this sounds better. I intended write only this patch.
I made the second patch when the comment about 8 digits for YYYYMMDD
come to my eyes, hence this clumsy.

> > diff --git a/date.c b/date.c
> > index b0d9a8421d..2f37397beb 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
> >  	case ':':
> >  		if (num3 < 0)
> >  			num3 = 0;
> > +		else if (*end == '.' && isdigit(end[1]))
> > +			strtol(end + 1, &end, 10);
> 
> I was a bit worried about this change hurting other cases where people
> might use dots to separate numbers (but not mean a fraction). But the
> two common ones I can think of should be OK:
> 
>   - 5.seconds.ago would never match because you look for a digit after
>     the dot

This is covered.

>   - a date like 2019.10.12 wouldn't match, because we're only looking
>     after a ":", which heavily implies a time.

Yeah, It's worth to add this test.


-- 
Danh
