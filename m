Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83082C433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3D9207E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="msNMgahK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgGWBuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:50:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD329C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:50:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 6so3396320qtt.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kqPnZW8eJGeCvHymGrkv5bECTObq07apvZUsjZG2Hmk=;
        b=msNMgahKm9Z6oijEUbi4KWPbbNpQdF4AyHlaSkLbpOog6eSDIAl+Lv7kjDhqS6BT/k
         uUotxCoOXFvhzKCsTF9fgHzABOl2Umxd18CaZz/rXYb+d0igppoSQQs/UKvKwBxZxYwo
         F/+Rdh8Rzp3ZvN6x5j8iKf7XLmiyswLGdIkPLYCI/j9ecDzWBkeyhwD59WrrhSZdMwK2
         Bn0pI0/FreWFZJ6Zs5N/oM+DwwX5IaLI/l6neM2RBDXXTDnLzMIA/Gpp99R83DKcsVkN
         4Y8MpB+mEUN1+FPDAyG3JNLyfn6LUcstV8mG+w2xLnt04oYYQ3guy8lXw/5eT2sNwotI
         0uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kqPnZW8eJGeCvHymGrkv5bECTObq07apvZUsjZG2Hmk=;
        b=oBmBHISqiomtodZJFNnS5YPIFuFEOQDg6XvbURbIL0JrcrGsH4/TM7ay6N5J1jTxbc
         zoaj4d0VW3SK1leB39XiJnEK5tpixDIiafk+U8F7eG3JdmDz7z+MYezDA3P5zn07oWW7
         DXDqL45ArrEYtOg+jaRYBunhJ+LEQ1JX+Riib58JgRipW+G+r6C00+HRhJPs/gAx0vSF
         wjhvZet59ADp5W7nvl/S5gZUVnq9njAUXm0weT1Nbyeoh/sce/f9erUv/52E+0QzfzHL
         BolaXO2jBlvUxPndlAS+aWJbUxM/KJ8IEfC0k6JndcQ0rVuC7YcrNWEKhzDDhWltOUk3
         3NQA==
X-Gm-Message-State: AOAM532/gPrLSVZLLksCxg5bRmbeHyec2Gu4GCVvDb1uQOfNTm6Axnu/
        DeF5usZHKQihgeo0NEwzJTS7wg==
X-Google-Smtp-Source: ABdhPJzG0qjKNgXMY3j0cXlW0qEx0QOgTvFWZcSfSsdg2qp0fUWyAMOlCalLnjaESTr0Z9loU08Dhg==
X-Received: by 2002:ac8:44d6:: with SMTP id b22mr2132610qto.391.1595469050045;
        Wed, 22 Jul 2020 18:50:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id o187sm1318237qkd.112.2020.07.22.18.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 18:50:49 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:50:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200723015048.GA83982@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200715100043.GG11341@szeder.dev>
 <20200715105521.GB3262157@coredump.intra.peff.net>
 <20200720200739.GB91942@syl.lan>
 <20200722091758.GJ11341@szeder.dev>
 <20200722201531.GA59352@syl.lan>
 <xmqqft9j3t4i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft9j3t4i.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 06:41:33PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> If this die() were to show the same fancy error message as in the ERR
> >> packet, then it would always make it to 'git clone's stderr in the
> >> tests, so the tests could reliably check that 'git upload-pack' died
> >> for the expected reason.
> >
> > Beautiful idea. I changed this in my fork, and I'll send it to this
> > thread after 2.28 is out, since I don't want to create a distraction in
> > the meantime.
>
> Thanks.
>
> As long as everybody understands that "distraction" will immediately
> gets backburnered when a regression relevant to the upcoming release
> is found, however, I think performing work as usual is a good thing.
> After all, we often find glitches in the current code by trying to
> build on it, in addition to using it.

Fair enough ;-). I sent v2 a few minutes ago, but forgot to attach it to
this thread as a reply. So, I suppose we can pick up the review there,
instead.

Thanks,
Taylor
