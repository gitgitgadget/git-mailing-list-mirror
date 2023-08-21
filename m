Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51897EE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHUV0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHUVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:25:59 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D830C7
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:25:58 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58c4f61ca12so42335337b3.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692653157; x=1693257957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSB/pC/rAN6RMaUnCzNNCGr5Uo49jP8CTpnwVaxCEK4=;
        b=4Fxie40tmhqcAlc+y4Ilt2jQTDKywI0JkmziNJdUh28csFnqgMWaYOlQk4iXrl7iD4
         smVkwfAH8Hz6gCNEv/izc340qLWLo6HwiFL+8suZa1pppx/0MoW6kTRe3JToynGERi1r
         MvsFMiv9J+PxMyb/sPkvGXJxUXb1c9WVntAipc4jRAADWZ4GAMDt9r/lFO2XpYuvpr+g
         givSBGlmm6DVYnPS8akd0uKkGnXmmcEgHaAB/sDnY3AVftoSzSsoKxJeyu0VvlJOqF9r
         1xlIJA1ItsKl9yBXuuQrPhiFOZfG/gyIzZm2ubFG6uMXY/q/k7xkwfbftZJoMJq5Y8yN
         FmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653157; x=1693257957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSB/pC/rAN6RMaUnCzNNCGr5Uo49jP8CTpnwVaxCEK4=;
        b=WQeaTBwtNGceBuu331zAhDrFYsmYF4E/aHdwJvha+tlkDkTOkkkeXebfn6oK7UbeoY
         77Y5lH5CS+OwFQmpfLb2yR1uVJmHYG6FyY93vhU82HahNNye0YQFt+WKgcfnxrctNzNL
         xNOmfvUQSdsG43cFwaxWAATk6d/HeYVHqlq+MBQTFDMMDtgMDaolaJP/jfZLxmxg+/n3
         wHRJYKwfrSbv+1lYJm3O8bCLkMkt9biW/vL86UfESWbQ4gP8cUocCf9xughixnNgas7z
         Fj3QKHnxHnUXGB2ZKxS0RGDPSoEmUPWY3kkdihSCikOdAP+sxbUg14fD6rCfCn6p3EwO
         Uq0w==
X-Gm-Message-State: AOJu0YyTKggZvlIU653RAej68gh0pU21ZoUV+W2DMXoctNElBDJHN1gy
        jatl7IFf73Wkzs+uzz6Dj5NZO6jmMtV4CS4awn1O+Q==
X-Google-Smtp-Source: AGHT+IHMX59WT0HNRqdX0LeYTCs7xk0zSXvanW66W3Q2NSVinYa9KrxAShehBwA/wIuriTIhqS40Qg==
X-Received: by 2002:a0d:cd45:0:b0:561:206a:ee52 with SMTP id p66-20020a0dcd45000000b00561206aee52mr9246367ywd.24.1692653157106;
        Mon, 21 Aug 2023 14:25:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w124-20020a0ded82000000b0057a57a9a932sm2402675ywe.107.2023.08.21.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:25:56 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:25:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] commit-graph: fsck zero/non-zero generation
 number fixes
Message-ID: <ZOPWY3ydDS1leV5A@nand.local>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
 <20230811175854.GA2816191@coredump.intra.peff.net>
 <xmqqr0o9s7im.fsf@gitster.g>
 <20230817195108.GC3032779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817195108.GC3032779@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 03:51:08PM -0400, Jeff King wrote:
> > One very minor thing is that how much value are we getting by
> > reporting the object names of one example from each camp, instead of
> > just reporting a single bit "we have commits not counted and also
> > counted their generations, which is an anomaly".
> >
> > Obviously it does not matter.  Even if we stopped doing so, the code
> > would not become much simpler.  We'd just use a word with two bits
> > instead of two pointers to existing in-core objects, which does not
> > have meaningful performance implications either way.
>
> Yeah, I wasn't sure if the commit names were valuable or not. Two bits
> would definitely work (though I have a slight preference for two
> boolean variables, just because I find the syntax easier to read).

I think having a single example of both a commit with zero and non-zero
generation is marginally useful. I think keeping track of two commit
pointers is more straightforward than the bit-field, and it does not
complicate things too much, so I think it is worth keeping.

> I don't think we've heard from Taylor, but I saw his original patches
> were in 'next'. I'm happy to clean up what I posted, but I'm also happy
> if we just merge what's in next and move on.

Sorry that this fell to the bottom of my queue, which I am just digging
out of now that 2.42.0 has been tagged.

I think that the clean-up you suggested is worthwhile. Let's replace
what we have in 'next' with the reroll that I'm about to submit...

Thanks,
Taylor
