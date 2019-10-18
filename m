Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262A11F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 20:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJRUpy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 18 Oct 2019 16:45:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55330 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfJRUpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 16:45:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so7419995wma.5
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 13:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3YXp350UM24grkM/dcfcDAjVq164J/Q4Muq2gIYz6C4=;
        b=W2HV3ghvmkpLsdlESjpM+Y4sxoVQkWA5RvhuRRmKyLEZWEd80g9+ZYyKXlSBBza+D/
         mAxOPzyp9LWGnS5kwJEZqmbKh9mR84GcqeFexD8fHz/0sWQI5hANb0HVRUYsQpZL3Z72
         XKSE2D0GtDCIW4MeAKwspifKgZ+bBmkBgNlkn6qDWlQZtHIXHsJvaUUZdqFXHwxnTeE8
         wlrkuL94A6VfO/f+paQpDhg62veEdPysl6jXxZo6e8BwtK4b65V5e67OegPXXCjSY97Z
         IZYUPbaHSn/TJ1M64VBdqSaGtiJZqtf+Ef34hdU/BdLFzey940S16WEbje+1sVAoHq3A
         gkNA==
X-Gm-Message-State: APjAAAWMKBJrogb5+XW4eFw7U7f5j0nx2zFRb3GD8G5LbazKT1qwms7e
        IDbs1L20nf1TAIMm8kjeHU1jWXI53UJjvyKdKyZ0dw==
X-Google-Smtp-Source: APXvYqxzodlype4qHlAkw6HM8uq/3pH36aI+zCRpSGnygHqukn9Z6x+omwjdpqFI+bhLy3bfi/2UEft6aiblSk4evq0=
X-Received: by 2002:a1c:a651:: with SMTP id p78mr2640093wme.53.1571431550724;
 Fri, 18 Oct 2019 13:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173501.3198-1-szeder.dev@gmail.com> <20191017173501.3198-6-szeder.dev@gmail.com>
 <CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com> <20191018150006.GD29845@szeder.dev>
In-Reply-To: <20191018150006.GD29845@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Oct 2019 16:45:38 -0400
Message-ID: <CAPig+cTitWCs5vB=0iXuUyEY22c0gvjXvY1ZtTT90s74ydhE=A@mail.gmail.com>
Subject: Re: [PATCH 5/6] completion: list existing working trees for 'git
 worktree' subcommands
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 11:00 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Thu, Oct 17, 2019 at 02:08:12PM -0400, Eric Sunshine wrote:
> > It is a long-standing To-Do[1] for "git worktree list [--porcelain]"
> > to indicate whether a worktree is locked, prunable, etc. Looking at
> > the implementation of builtin/worktree.c:show_worktree_porcelain(), it
> > should be easy enough to add.
>
> I didn't look at the implementation, but only at the docs, which says:
>
>   --porcelain
>       With list, output in an easy-to-parse format for scripts. This
>       format will remain stable across Git versions and regardless of
>       user configuration. See below for details.
>
> I'm not sure whether introducing a new boolean attribute (i.e. a line
> containing only "locked") would still be considered acceptable, or
> would count as changing the format.  I can imagine that a too strict
> parser would barf upon encountering the unrecognized "locked"
> attribute; but yeah, no sensible parser should be that strict IMO.

The stanza-based format of the porcelain output was chosen with the
specific intention of being easy to parse _and_ to allow extension
such as the introduction of new attributes. It is unfortunate that the
documentation you quoted, as well as the description of the porcelain
format itself, does a poor job of (or utterly fails at) conveying that
intention. (Had I been around to review the later iteration(s) of the
series which introduced the porcelain format, I likely would have
pointed out these shortcomings, however, Real Life had other ideas,
and I didn't manage to review it until weeks after the series had made
it into an actual release.)

I'm not convinced, though, that we're locked into exactly the few
attributes shown only in an example in the porcelain section of the
documentation. That documentation is so woefully underspecified --
indeed, it doesn't even talk about what attributes are available, but
only gives a single example showing some of the (possible) attributes
-- that it effectively makes no promises about what will or will not
appear in a stanza. (The only thing is says strongly is that stanzas
will be separated by a blank line -- despite the intention all along
being that each new stanza would start with a "worktree" attributes,
and that blank lines, if output, were to be ignored.)

So, I am of the opinion that we are not prevented from adding new
attributes, such as "locked" and "prunable".

> Furthermore, I'm not sure what to do with the reason for locking.  In
> general I would think that it makes sense to display the reason in an
> easy-to-parse format as well.  However, doing so will inherently make
> the format less easy to parse, because the reason could span multiple
> lines, so without some sort of encoding/escaping it would violate the
> "a line per attribute" format.

Yep, I believe my thinking at the time was that the lock reason and
the prunable reason would be escaped if needed. So, for instance:

    worktree /blah
    branch refs/heads/blah
    locked Sneaker-net removable storage\nNot always mounted

> I would say that this is beyong the scope of this patch series :)

Oh, I wasn't suggesting that this series do anything of the sort.
Instead, I was merely responding to the point in the commit message
that the porcelain format was lacking information about the lock, and
to say that it could (eventually) be solved by extending the output.
