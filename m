Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355261FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 00:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751703AbdBIASc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:18:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35741 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdBIASb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:18:31 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so12466902pfa.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ejik1zMOlztO4F3RwZN40eylz1Acok+r6EiAfq5kelw=;
        b=r8zC4BczHO/RFdQZdUA0t+d4wIEXwQqH7yrymImJjIrFV/WjYoi0P+Qjj712Pzj65E
         oVzTKxRlcuOw35bmlCOZW/x61HY+AZDL7xDcWEM9mF46wiEtW2VdEw/sGo+CpGaiU3OB
         y13jk3EyNhXsb9Fy+wrOnh+K9LaykRpE53+sboQzYIzhSN3UunMIlL8QkXF5rbGenNz1
         6yozxKZB5PqKTSRFTwQF+cvfUqOPxBWP+vWiLebEOn+LKiN5VpX5whuzq0MCzzicsCh/
         8gMVW+C1VXw69di+c+Xka3tK0mfr54gz9UDycg9xd//Y/K57OOrifwnnHTFjVvhzrLuq
         oQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ejik1zMOlztO4F3RwZN40eylz1Acok+r6EiAfq5kelw=;
        b=KWTME+ZtXJYI2/s8kBceSZPP24HCX9dS0wn/G0+Kja4aw4PmMQJz27ovRXbQadGhB6
         fmMUu8R1h01fsrvjaMNwGEAtjOU48GNXkSKOwhWYspprpItjU5vY7diRYpUBpjh/OFko
         b3gGHBs3HdiPtTKXHgYfgtkOAK5EX+x26PW0fCKOOxQdNi/TQl8+EcWoMm0v0/v9Eys0
         ToWtzdxzqJnJhA4NHMce9rBfx6SXSbxa6hF+NiAT9NKs+/pk4wE1DzocwkopR1a6qNX/
         JwIgztm+Loud2hCMZinsv32hJxrvLOhBF94z1JpOePGTw5NGsxl8d0P0lcvmV/TLq0NE
         ja7g==
X-Gm-Message-State: AMke39nqpweyYK99jQZN/ZTHcFMYcqIa3bS6tVJGR2vVnFeVPr0Vtb8MMYfC5n9WQP4uhQ==
X-Received: by 10.84.232.198 with SMTP id x6mr358154plm.27.1486599507800;
        Wed, 08 Feb 2017 16:18:27 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id w123sm15185951pfb.44.2017.02.08.16.18.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 16:18:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <novalis@novalis.org>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
References: <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
        <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
        <1486515795.1938.45.camel@novalis.org>
        <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
        <1486542299.1938.47.camel@novalis.org>
        <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
        <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
        <1486580742.1938.52.camel@novalis.org>
        <20170208190858.rjoqehbhyizlwg5q@sigill.intra.peff.net>
        <1486592043.1938.82.camel@novalis.org>
        <20170208230057.hking37uuynf4cgd@sigill.intra.peff.net>
Date:   Wed, 08 Feb 2017 16:18:25 -0800
In-Reply-To: <20170208230057.hking37uuynf4cgd@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Feb 2017 18:00:57 -0500")
Message-ID: <xmqqbmuctdwu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In my experience, auto-gc has never been a low-maintenance operation on
> the server side (and I do think it was primarily designed with clients
> in mind).

I do not think auto-gc was ever tweaked to help server usage, in its
history since it was invented strictly to help end-users (mostly new
ones).

> At GitHub we disable it entirely, and do our own gc based on a throttled
> job queue ...
> I wish regular Git were more turn-key in that respect. Maybe it is for
> smaller sites, but we certainly didn't find it so. And I don't know that
> it's feasible to really share the solution. It's entangled with our
> database (to store last-pushed and last-maintenance values for repos)
> and our job scheduler.

Thanks for sharing the insights from the trenches ;-)

> Yeah, I'm certainly open to improving Git's defaults. If it's not clear
> from the above, I mostly just gave up for a site the size of GitHub. :)
>
>> Idea 1: when gc --auto would issue this message, instead it could create
>> a file named gc.too-much-garbage (instead of gc.log), with this message.
>> If that file exists, and it is less than one day (?) old, then we don't
>> attempt to do a full gc; instead we just run git repack -A -d.  (If it's
>> more than one day old, we just delete it and continue anyway).
>
> I kind of wonder if this should apply to _any_ error. I.e., just check
> the mtime of gc.log and forcibly remove it when it's older than a day.
> You never want to get into a state that will fail to resolve itself
> eventually. That might still happen (e.g., corrupt repo), but at the
> very least it won't be because Git is too dumb to try again.

;-)

>> Idea 2 : Like idea 1, but instead of repacking, just smash the existing
>> packs together into one big pack.  In other words, don't consider
>> dangling objects, or recompute deltas.  Twitter has a tool called "git
>> combine-pack" that does this:
>> https://github.com/dturner-tw/git/blob/dturner/journal/builtin/combine-pack.c
>
> We wrote something similar at GitHub, too, but we never ended up using
> it in production. We found that with a sane scheduler, it's not too big
> a deal to just do maintenance once in a while.

Thanks again for this.  I've also been wondering about how effective
a "concatenate packs without paying reachability penalty" would be.

> I'm still not sure if it's worth making the fatal/non-fatal distinction.
> Doing so is perhaps safer, but it does mean that somebody has to decide
> which errors are important enough to block a retry totally, and which
> are not. In theory, it would be safe to always _try_ and then the gc
> process can decide when something is broken and abort. And all you've
> wasted is some processing power each day.

Yup, and somebody or something need to monitor so that repeated
failures can be dealt with.
