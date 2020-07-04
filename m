Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE5C433E0
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1188A20747
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrF+A0gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDPVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGDPVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 11:21:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68739C061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 08:21:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so1505557pfm.4
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j3LnCSaPMndm4LGkYKllWssvce983/bLeHofVKsVAP4=;
        b=rrF+A0gwlUZWQMNQD1cfFtBCfd10vAs42O9mlwQhPX9b3LBY/vw0zxFTy84VfWm53V
         v0W9vOrLHRSTC26v9pvkPztJkCd9uZcMScCLHrHYgAKN7IUDmj/YBQ8PO/Aq8hilMW+Y
         7OCBlL6gYwqOhEo/hDNV6IrVS+jtyGufiXAeEwipVyo+mRPuQgFC+b21wH5dI8X6CnN8
         Vb5TAzUy4xo+3bcdfbrFt7eFgp4B6iB8P0iFUtQtG6c2IXOGfucGXdIwY/IuHx6sUjI2
         GoICkY/5ZX8cibjqKm6tCvha+9lscOObYt1YzqXZ5FNkWuH1ig2LMv5P7LDR6yPQIaLg
         TUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j3LnCSaPMndm4LGkYKllWssvce983/bLeHofVKsVAP4=;
        b=pV061D1p16kzmyQ4uhLr9scDcatIsVAJgHM+rYXWJNWAz/3TlUdVorzROmM+lqps9V
         x5r+Ml9YEpEQtWOvt9YTKd+BhtsKL4P1twtJLXjxIBsQZMd7Y52H8/BZE4CRNBZO68cY
         N05t20m0uKooonRxPtf2gJkaMCzqiuKJVkwhZmoG8IJ4l4YC48PvujMAuE2S+5eP6f/d
         GPWxmlct9od1SqEg88DPetcbmHoaCqE01OGFrl3QIG/UYUTD6Z7m9ea+CKqVPACjthpi
         4JC9DXu1juLcLY13vbFlqt8/VAdL24pJF14mh43KHpCNZkps0LZkokSFb0lTAw3cYh+W
         aIZg==
X-Gm-Message-State: AOAM532wOrssPkInJdDMWaxoHox6fEtIVOyT4UjGiEiuAsz3GqWINpDe
        v7FAvs3w79gBrm0hPa73CEk=
X-Google-Smtp-Source: ABdhPJxYvXRYhL7VdSRUbDbEqaDBFPWUUuoYQUsCE8piTzJHx6415oKMWZn5ClQWRNEEON8VkVfJnw==
X-Received: by 2002:a63:f541:: with SMTP id e1mr32514430pgk.375.1593876070914;
        Sat, 04 Jul 2020 08:21:10 -0700 (PDT)
Received: from konoha ([45.127.46.159])
        by smtp.gmail.com with ESMTPSA id e18sm14433862pff.37.2020.07.04.08.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 08:21:10 -0700 (PDT)
Date:   Sat, 4 Jul 2020 20:51:04 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
Subject: Re: [PATCH 1/4] submodule: amend extra line feed between callback
 struct and macro
Message-ID: <20200704152104.GA45598@konoha>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-2-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031653570.50@tvgsbejvaqbjf.bet>
 <8a36a3cd-02a3-f4fa-7b86-0d4884c88449@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a36a3cd-02a3-f4fa-7b86-0d4884c88449@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07 04:37, Philip Oakley wrote:
> 
> Suggestion...
> 
> On 03/07/2020 15:57, Johannes Schindelin wrote:
> > Maybe a native reader can suggest something that flows a bit easier? I am
> > not a native English speaker, but I'd prefer something along those lines:
> >
> > 	Many `submodule--helper` subcommands follow the convention a
> s/convention a/convention that a/    feels nicer for me

I did not get this one. Are you asking to replace "convention" with "a"
only?

> > 	struct defines their callback data, and the declaration of said
> s/said/that/   maybe.  'said' is a bit too much like 'patent speak', but
> otherwise either word is OK.

Okay will do!

> > 	struct is followed immediately by a macro to use in static
> > 	initializers, without any separating empty line.
> >
> > 	Let's align the `init`, `status` and `sync` subcommands with that
> > 	convention.
> Nice summary.
> 
> Philip
> Native Yorkshire speaker, but not that 'literate' ;-)

This made me chuckle. Nice!
