Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F18C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614AE2083B
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmzNsvzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgJHJwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJHJwi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 05:52:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02746C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 02:52:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b193so2945673pga.6
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pk1jHk3g+uPPtOXgZAnefOrQzSHneu5nBfHopnWYDhg=;
        b=PmzNsvzr3M0DP3uyashKTio4DtzSwwhE9AxjuuAWlJyMRk2rpdac1YcOoTfKiy0gqW
         iQdqbzy/FwcGwoioVIkutBUQOobb/iLxAlBy4Pzo+LFJYqKkXLAS8yKu/p7sQcUilRtH
         Wc3fpTBLSfFTndvV2vTGMgTe5Wpj7L/KEVdnpaaczlNoXaToF4k98FYD+VDIXbU0Miyd
         fNPzACtSa0eymtqZu+HZ6FshX4vDiqZLVU8OHhn4RFPt5DXIXTxz/wo8GupeR28vB1LO
         iUv4X4RuVm9zM1yrh0TG5azz2qKEH8S9RYXqUUrovbmG9U5bntURmtgKB8hBwlK6HM++
         +8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pk1jHk3g+uPPtOXgZAnefOrQzSHneu5nBfHopnWYDhg=;
        b=YJDhA8z6ZQUclpB9O1OUiq5OAnMqEIGQf7U0v8JkclfQnXb5OTKUWSZZLsfMifI5qU
         zmge4i5dXT8F3DDWgTJbs8+FzjnhtsMwAMtjR02BFk9lmeNGlBX+mfEkDah1a0+1uYfl
         rpnu0h39uoy0y/gdSZcDss6JJEAqrd5jR0fnBlePAVJ/W9Zf1TpDAkjYjd651t1I/GVL
         sz3glSpAt9esOilmBWSXGiQb5GcfHU4t1iLi1WFi5FK4f3/COxSy2coYaq/dccQe044q
         cku+AiCa2jZln7Z1mn2YgIDGP3IofMKbDK0nvxsTTw5AnuoWWZCMgpjdcz9k0RdRj4ls
         2S0g==
X-Gm-Message-State: AOAM531SRNXKs+g0+wwMUaBgDq7k6wVoCfqOYGuFnG4a4P9Av9OG9ZYr
        1zAtDvNXewdpNfuJlUvGRYOSmRKRudg=
X-Google-Smtp-Source: ABdhPJyiXesBkzFrCkJv37AxEuH/myxPr2rHkpaC1z/f/v3uX4kXGRQ3kwFscO6nil6MWpx9jfpG/g==
X-Received: by 2002:a65:6091:: with SMTP id t17mr6891769pgu.429.1602150757524;
        Thu, 08 Oct 2020 02:52:37 -0700 (PDT)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id i17sm6277514pfa.2.2020.10.08.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 02:52:36 -0700 (PDT)
Date:   Thu, 8 Oct 2020 02:52:33 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Makefile: create externcheck target
Message-ID: <20201008095233.GA2611970@generichostname>
References: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
 <1c2ee1c40ccde18a008262aeaf23a17da2064eae.1602142232.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.2010081125390.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010081125390.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Oct 08, 2020 at 11:32:03AM +0200, Johannes Schindelin wrote:
> P.S.: I am not really certain that the `\s` is portable, I do not see any
> mention of it in
> https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html#tag_09_03
> and would therefore expect BSD sed not to handle this correctly.

I've run a varation of this on MacOS's sed before and it works.
Unfortunately, I don't have access to a MacOS machine anymore so I can't
100% confirm it.

> In any
> case, the `-i` is _not_ portable, as BSD sed takes a mandatory argument
> (see
> https://stackoverflow.com/questions/5694228/sed-in-place-flag-that-works-both-on-mac-bsd-and-linux
> for more details).

This was the main reason why I sent it out as an RFC (although I forgot
to mention it in the commit message, whoops). Perhaps we could write
this as

	externcheck: $(filter-out $(THIRD_PARTY_SOURCES),$(filter %.c %.h,$(shell $(FIND_SOURCE_FILES))))
		sed -i.bak 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/' $^
		$(RM) $(addsuffix .bak,$^)

instead? I think that since this is a developer target, we can probably
call this portable enough.

Thanks,
Denton
