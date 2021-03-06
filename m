Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A927AC433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 23:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F16C650CF
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCFXBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 18:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhCFXAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 18:00:55 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222DDC06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 15:00:55 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so12017185ejb.12
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 15:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYisTFaK8vcJ+mOYvSdY3Jva1Ai7JID1KJZ8OVvt6PI=;
        b=OnffcqOZHplTwWYldvkZyQy7NVwDSWuCCkH9BdiYJZGqQZ7BqpNzVmGwgURa1oJifT
         /DggDB5NQ7snGAioZJRAbTGWhmYdrGHLrzfcN9EOTU9rgDkOVvYzDG1yaLOFrDf5Gd4o
         mCzf3itRdpl+prqzJ2VqB5i32qFyArqNF3+dZD9XVx+IzsDFkLEP0FNSLphp8zKFrLM4
         AaNgEuANTvoaUHvxLrqkFlUAvrUEzKVVTSZFFdLvo3caGbMIstuJSfFRtFlGNRtis0Mb
         ml6ZYVEJEeJjONybX3NPbyAyAtkvh1pvI9amdGyvKR4Ltt28cE4I/XL/L5b0p41LZzfo
         7s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYisTFaK8vcJ+mOYvSdY3Jva1Ai7JID1KJZ8OVvt6PI=;
        b=ma/M17fQkO8J/i/0fdQoGzf11SMHQBJuepC07Sh6xcWBfFKGuFHLORSksKfanHk/cm
         QrrcEsG7M2G+K2YSXUoIov0H8VgJ6WGfo54zcvY/OvCBhafCDmVh2iK3kCSHZmJIMYYm
         xHwyaIqbsINqXv9WLVXCORPz6qkTjqtmDyL6ndYx5EP4QKKfR35/YgxpLV+S5DEamkzT
         EMu2aIKixhU5rwLb8nHZ9piticJkVqnTKQLVmy8YyLuvthu+vD/9Mdq3/r9ko6VhLud1
         ooQCbJW8zIMgcMkgRPYD3h3iwjoJPIeCcxve5uFZSzlfDUzDgaPZkmRNDE7m604da28E
         glYg==
X-Gm-Message-State: AOAM5336rrZRQ47S1y7DnIn8PgNgKgeCKbZHAbIB+pAfrRBI4WMmghFE
        p5qR78qQf7BB2pqkPs3iCQxcQTcSXVAPZ/0BSxZOSiKF2OlaXw==
X-Google-Smtp-Source: ABdhPJxVwUl9zJzYTFlNr1yduMtBFuy/FOQhgcDAg2evf1PK+Zz49gPYQunsH56urAoR9drpbkUP0nVSdYAhe7akeGI=
X-Received: by 2002:a17:906:79c7:: with SMTP id m7mr8147368ejo.337.1615071653595;
 Sat, 06 Mar 2021 15:00:53 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-EXQJ2rWFqvt++Gi2=ZSCBonNtS1JSBkW4k+ORrQiyizQ@mail.gmail.com>
 <YEHv/tlTWv72BDJ2@coredump.intra.peff.net>
In-Reply-To: <YEHv/tlTWv72BDJ2@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sat, 6 Mar 2021 15:00:43 -0800
Message-ID: <CAGyf7-Fp+xmC6KNr7pY+DFgv+oRGPHS+5sp8PE5c1RQQ4GNiOw@mail.gmail.com>
Subject: Re: rev-list --use-bitmap-index
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 12:47 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Mar 05, 2021 at 12:18:15AM -0800, Bryan Turner wrote:
>
> > The documentation for --use-bitmap-index notes that if used with
> > --objects trees and blobs they won't have their paths printed, but it
> > appears to change a whole lot more than that. In my testing, it
> > appears to mean --date-order, --format. --parents, and maybe more are
> > effectively ignored.
>
> Yes, quite a few options won't work with bitmaps. The order you get is
> not a traversal order at all, but mostly just the order of objects
> within the pack (and then with any extra traversal we had to do tacked
> onto the end!). Likewise something like "--boundary", as that implies
> that we actually walked the graph. We probably _could_ support --format
> and --parents, but don't.
>
> Probably the documentation should be strengthened to say that
> --use-bitmap-index implies thinking about the resulting objects as a set
> result, rather than a traversal. Or maybe that's getting too into the
> weeds.

I can't speak for anyone else, but to me that actually feels a lot
less "in the weeds" than the current documentation.
- The existing documentation talks about "speeding up the traversal",
but your comment here suggests what it actually does is _eliminate_
the traversal--producing output that's totally different (in terms of
ordering and content) to what a traversal would have produced
- The existing documentation talks about one specific flag, --objects,
where the output can change dramatically depending on whether
--use-bitmap-index is applied, but it doesn't hint at all that there
are other flags that are also affected, or may just be outright
ignored

Documenting that --use-bitmap-index produces a set, rather than a
traversal, might be more clear.

>
> > It appears this changed in 2.26.0. The release notes for that version
> > include this blurb, which seems like it might be relevant, but I'm not
> > sure:
>
> It has always been the case that those options wouldn't work with
> bitmaps. But v2.26 did let us use bitmaps in more cases.
>
> The blurb you mentioned is a bit of a red herring; it only applies when
> --filter is used. The interesting commit for your example below is
> 4eb707ebd6 (rev-list: allow commit-only bitmap traversals, 2020-02-14).
>
> The "--use-bitmap-index" option is really "if you can use bitmaps to
> speed things up, do so". So prior to v2.26 it was simply being ignored
> in your example (and you got no speedup benefit from specifying it).
>
> That "use it if you can" behavior should probably likewise be
> documented. Callers need to be prepared to receive either result (and
> hence asking for stuff like --boundary does not make any sense at all).
>
> > Is this expected? If so, perhaps the --use-bitmap-index documentation
> > should be updated to indicate that it has unexpected interactions with
> > a whole lot more than just --objects? Or perhaps I'm doing something
> > wrong/unexpected here? What sorts of traversals are --use-bitmap-index
> > expected to be used for?
>
> The interesting traversals IMHO are:
>
>   - with --objects, quickly getting the result set (but without paths,
>     and without any ordering)
>
>   - with --count (with or without --objects), because we avoid quite a
>     bit of work by counting bits rather than walking the graph
>
>   - with the new --disk-usage, which likewise avoids a bunch of work
>
> Asking about just commits via bitmaps isn't that big a speed improvement
> these days, because commit graphs make the cost to actually traverse
> each commit way cheaper (see the numbers in the commit I mentioned
> above).
>
> So the behavior you're seeing is expected, but probably not all that
> useful (and you should likely just drop --use-bitmap-index).

Thanks for all the details, Jeff, and for taking the time to provide
such a thorough answer. I had figured there must be some potential
downsides to --use-bitmap-index--otherwise, if it was just a simple
"go faster" knob I'd expect it would have long ago been enabled by
default--but trying to figure out what they are is tricky. And as they
start to materialize, the next challenge is to figure out, given those
downsides, where the upsides are useful.

Based on your list here, there are a couple places where I think I
could see some benefits, in other commands that I run, but it's clear
it's not a general-use option.

-b

>
> -Peff
