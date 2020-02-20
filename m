Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E3C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2C220801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmsqyTTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgBTXd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:33:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42693 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:33:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so187648pfz.9
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sf2ei2Dz4wEezH6lLJ9XG+5wY/dUvJXJ5ZNCA5Zs7Gs=;
        b=TmsqyTTIBFQyNKQD8NrK28/GvlldDDRJH7GLPjO2R40bMMSj3As4Q3+mNP38kP5kTK
         xQDMtkcZMH0pYLKv71fkRtwujsqv/2pZde5ESj0RyigPn2ln1IeW8jCMzlx3yT+WhPoi
         3hz+C0oGIYtqi2P/X8L9AlovNtlXz/hDdEiD6/PSzaatMbSJNApouyHPgRacCtUyteVc
         k69BjUWstw2g4Xusz2U7UtlCkY1VTV/TXVLc6UzOWkIPkXli3zt7+rlfd5RV40MLC/eq
         Hi74OhzzI0hG9Mgckh6LEgGwEsLXi/Mnwl7hCadVtABiOe2l/VMQsWFZVnTL9kkfizPt
         VAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sf2ei2Dz4wEezH6lLJ9XG+5wY/dUvJXJ5ZNCA5Zs7Gs=;
        b=OGcSGzSGJpLjIZWQPX5UlDmR1sTm8zzykSU3JaAr5NixA1/9rC28mMUUQoeWsPpfNY
         lMMs47irJ7IaR/K8xsZet9ZlvTyujvdgMAXvuZ3Lr46ojkS+mvC0D6B39CKoRCFxImhU
         EHVTb9T+Thn/2OdyUwUJOlacMGjd8XOwbaJk+mkx6XTiZn5GxzST4AIhHKvCrz/Fm+43
         BMrNE38TT1SeomxxxSRvloZKA6vVsCqoHCTmXUTDLrW+vWLmAgkfypER41Ii70v40YkQ
         FKws2KgRrLvm5Kx+8t7jWSpSZfXq96T6aF3N17/A7RWAdn7xYku/4A955ZhjO1GS7bAq
         KTUQ==
X-Gm-Message-State: APjAAAXxgniBd9uT+8iTIVqpFHliyXY+12SflUnYM7xqkSyfhQ4f88XL
        hxWMc0yK7i34WTnFCTLi8EtDO8Sm+74=
X-Google-Smtp-Source: APXvYqz6gd3VSss6NtgxL7ekOBbykPC1o5yv+sQZbPI57NBJs7UsKxL/6n7LsPXFo/AX83QNLQMsWQ==
X-Received: by 2002:a63:e30e:: with SMTP id f14mr33258362pgh.260.1582241608580;
        Thu, 20 Feb 2020 15:33:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w11sm676318pfn.4.2020.02.20.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:33:28 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:33:23 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
Message-ID: <20200220233323.GI2447@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-7-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet>
 <20200219224547.GC26221@google.com>
 <nycvar.QRO.7.76.6.2002202306390.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002202306390.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 11:33:05PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Wed, 19 Feb 2020, Emily Shaffer wrote:
> 
> >   #ifdef __GLIBC__
> >   #include <gnu/libc-version.h>
> >   #endif
> >
> >   static inline void get_compiler_info(struct strbuf *info)
> >   {
> >   	#ifdef __GLIBC__
> > 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> > 	#endif
> >
> > 	#ifdef __GNUC__
> > 	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> > 	#endif
> >
> > 	#ifdef _MSC_VER
> > 	strbuf_addf(info, "msc runtime: %s\n", some_msc_info());
> 
> You could do it this way right away:
> 
> 	strbuf_addf(info, "MSVC version: %d.%d\n",
> 		    _MSC_VER / 100, _MSC_VER % 100);
> 
> Note: this is _not_ the MSVC _runtime_ version, but really the compiler
> version.
> 
> You could also use _MSC_FULL_VER, which is a bit more complete.

Sorry, but I'm not comfortable sending code I can't check for myself
(and already muscle-memoried into my format-patch/send-email workflow).
If you send a scissors I can roll it into the series with your SOB.

 - Emily
