Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D048420954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdKVXVb (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:21:31 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36726 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbdKVXV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:21:28 -0500
Received: by mail-lf0-f47.google.com with SMTP id k66so20070148lfg.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RwYJC9GrNIt9bBhn/rfQNVlmZkJbMANFf+IBHAi/GTg=;
        b=s/8aTSqHd18FRq/9MHaihYHRODBFJBYRQE2VzMMs8QXpR7cvV4vwCmJYkKA0lj4hs0
         QBOhqd+8Pq+1IKpEXIfwuDn3nNxQxt5aCAe49OionfJEOdqajmPloa0whmHujRl5vTv0
         Ra37CMTLuCb8wZKnTjZ30l3+TOMJXfVHJVY2NZAIgpj2llQ4iu9Y/skoEtjoYJIqSeFX
         vr2rg5LxNm3BX4z4zpWvqt9/1dywZgF/ueEn1RDI8PLaXBXRM2I+4coatp1sO6IXreWd
         QnxwSZ3DrwTD8U414aC67fNS8q2VurazS0eZmaVtypRkNv/blLWdTIyx7yQGqZgdwtWe
         sL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RwYJC9GrNIt9bBhn/rfQNVlmZkJbMANFf+IBHAi/GTg=;
        b=afN7k6MWr/5K9kbOSDGdKLro/miHYJTNqV+mrnCoVSATjfiW8Q3nObJlaOWd9X2OZP
         0HQ7fYmy939K5vmrF8TrBgPv9v6Xr4lYzKBOhJGojdiQRxeTi68m+z/WAZ9bK+FRskj4
         hrL4oVfPJX7gWyQ9UQ29g6oSs2qGSCxHx6XIKEpkrBZmiCvJpzs/Wi517NCTnye3Hi/A
         g0YNKwp2uv1tRxXgpD9mUEtY2Mh8C7Flp7QpeiMpivOYHUkSreMTtE3PLVgXB7Em4Lvv
         0yytP9SgT0tK3WIQi0sKNJlNE5fBGq5EypiZBseI5OW82KixOBUc6UIfCW8XBZ6xkQYs
         W9tQ==
X-Gm-Message-State: AJaThX5y+8bbH8gC/NBCGo9baX5gbUzsCAJPEYUr/zy5+39fohpTny9A
        /VHwKxhjFLpI8mLYDlyoB1LLJxiRy3QlmgcnUZ9SUA47
X-Google-Smtp-Source: AGs4zMZN3o+HQvsiQrgS6ici2n+oZxJLwVYxRu0/ZIIggyxCxNtcWVEzANP+6SwoCReca4dfJQsQkThQOVFMMOyTw10=
X-Received: by 10.25.165.200 with SMTP id o191mr6643430lfe.92.1511392886818;
 Wed, 22 Nov 2017 15:21:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.179.22.16 with HTTP; Wed, 22 Nov 2017 15:21:06 -0800 (PST)
In-Reply-To: <20171122212710.GB2854@sigill>
References: <20171121234336.10209-1-phil.hord@gmail.com> <20171122212710.GB2854@sigill>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Wed, 22 Nov 2017 15:21:06 -0800
Message-ID: <CABURp0rq9pwFWuBbrSB-FNUQ6B-7V8uL=Drw6O1-151u_cRKww@mail.gmail.com>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 1:27 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 21, 2017 at 03:43:36PM -0800, Phil Hord wrote:
>
>> With many thousands of references, a simple `git rev-parse HEAD` may take
>> more than a second to return because it first loads all the refs into
>> memory even though it will never use them.
>
> The overall goal of lazy-loading seems reasonable, but I'm slightly
> confused: how and why does "git rev-parse HEAD" load ref decorations?
>
> Grepping around I find that we mostly load them only when appropriate
> (when the "log" family sees a decorate option, when we see %d/%D in a
> pretty format, or with --simplify-by-decoration in a traversal). And
> poking at "rev-parse HEAD" in gdb seems to confirm that it does not hit
> that function.

Hm. I think I was confused.

I wrote v1 of this patch a few months ago. Clearly I was wrong about
rev-parse being afflicted.  We have a script that was suffering and it
uses both "git log --format=%h" and "git rev-parse" to get hashes; I
remember testing both, but I can't find it in my $zsh_history; my
memory and my commit-message must be faulty.

However, "git log" does not need any --decorate option to trigger this lag.

    $ git for-each-ref| wc -l
    24172
    $ time git log --format=%h -1
    git log --format=%h -1   0.47s user 0.04s system 99% cpu 0.509 total

I grepped the code just now, too, and I see the same as you, though;
it seems to hold off unless !!decoration_style.  Nevertheless, gdb
shows me decoration_style=1 with this command:

    GIT_CONFIG=/dev/null cgdb --args git log -1 --format="%h"

Here are timing tests on this repo without this change:

    git log --format=%h -1             0.54s user 0.05s system 99% cpu
0.597 total
    git log --format=%h -1 --decorate  0.54s user 0.04s system 98% cpu
0.590 total
    git log --format=%h%d -1           0.53s user 0.05s system 99% cpu
0.578 total

And the same commands with this change:

    git log --format=%h -1              0.01s user 0.01s system 71%
cpu 0.017 total
    git log --format=%h -1 --decorate   0.00s user 0.01s system 92%
cpu 0.009 total
    git log --format=%h%d -1            0.53s user 0.09s system 88%
cpu 0.699 total

> I have definitely seen "rev-parse HEAD" be O(# of refs), but that is
> mostly attributable to having all the refs packed (and until v2.15.0,
> the packed-refs code would read the whole file into memory).

Hm.  Could this be why rev-parse was slow for me?  My original problem
showed up on v1.9 (build machine) and I patched it on v2.14.0-rc1.
But, no; testing on 1.9, 2.11 and 2.14 still doesn't show me the lag
in rev-parse.  I remain befuddled.

> I've also
> seen unnecessary ref lookups due to replace refs (we load al of the
> packed refs to find out that no, there's nothing in refs/replace).

I haven't seen this in the code, but I have had refs/replace hacks in
the past. Is that enough to wake this up?

Phil
