Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435C120357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbdGNOy0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:54:26 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34178 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbdGNOyY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:54:24 -0400
Received: by mail-pg0-f44.google.com with SMTP id t186so47059071pgb.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CiwJoRJZaUYQn355UFDIF8JBc/5mZ0c/QUlDkPtWA8g=;
        b=JEId9CzgHGs/dxPwH82OuVm2T4QuEQmW/zef0LbE7s1d23fD9nU9j8ntk/Cyqht4vN
         zmZjk/I9DTSB0Go6Bz+d0Uzbus91ro08pVfKO3sVzHDKM9Q2U+w5biaBwgdODsAn+dc6
         abc8FQ5J73KVAbNmsp50ptEF6997pGNqbam9V1XKGo4y+sPBMpsw1qAR9proUW7pj3wE
         DLXwdjLeDZf8WUYb1NNRsz4buGQeX7ZeNsOafWtf1Wf32Ovih1P16Vlnh3XzyoKTdlhb
         ns2zKucx+0omaoOnTb2/sgrJC9o6tnByfY9b3CgC8tBVP777bPwiIvyRGKAv3s9FSHMg
         F0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CiwJoRJZaUYQn355UFDIF8JBc/5mZ0c/QUlDkPtWA8g=;
        b=fV56GPE+JSdy852vbuns6YGk2zd0KR/z36pj3zJRczXp1FEVmpobSlcriSYQFzJXGv
         P0OouprcKQW95Oe6wZBeAhCsFX5jRUombtD1zO4d4VDSl5ysfOw6iUAMWJ2/ILE8Gvak
         NDa2+dZQl44cAxhKwiUiLPmxpYCqlDnQ/ixqYWUtE4Ek/z3Ms0ByuYHEJcyxxJETdmpN
         GwrVSWGJ4xVor7+q3vhYWjlu3NqKWOQP+3IeH7mGlp0UFgNo1Jk5dW3fn6DidYcnikfI
         eGN4nF/3XLwD0EWqe5ofDPEoeBQmd3e3KiC0zlzoclAr88OhhtzbXksJld1nUDI3AzOk
         L5bg==
X-Gm-Message-State: AIVw110DgRBw62ZWegu3CGiOAzyYp+EJhdQ2osWpLOEy+gYOGUFSGFVc
        NEmJFBLwD5bXU8o4XEU=
X-Received: by 10.99.6.205 with SMTP id 196mr4501187pgg.227.1500044058092;
        Fri, 14 Jul 2017 07:54:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id y185sm16993357pgb.9.2017.07.14.07.54.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 07:54:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
        <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
        <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
        <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net>
Date:   Fri, 14 Jul 2017 07:54:16 -0700
In-Reply-To: <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Jul 2017 08:24:01 -0400")
Message-ID: <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, I think the right solution is some amount of peeling. Recognizing
> that the commit sha1 is the same, or better yet, not bothering to retest
> trees which have already been tested.

Yup, I also have a hack to avoid testing a version that is only
different in insignificant way (e.g. the only difference being
GIT-VERSION-GEN or Documentation/RelNotes/*) from an installed one
in the script I use after each integration attempt I do, which I use
a few times a day (that's "Meta/Dothem" if anybody is interested).

> If we had some kind of persistent storage, we could do a quick:
> ...
> The "git test" script[1] uses this strategy with git-notes as the
> storage, and I've found it quite useful. I don't think we can rely on
> git-notes, but I think Travis gives us some storage options. Even just a
> best-effort cache directory would probably be sufficient (this is an
> optimization, after all).

We do seem to use some persistence to order prove tests already, but
I do not think it helps the common case, where my end-of-day push
pushes out 'maint' and 'v2.13.3' at the same time, because the push
is made with "git push --follow-tags $there maint master next pu"
and the new tag happens to be at 'maint'.  It would be nice if
Travis runs were sequential, but I often observe that it creates
jobs for these multiple branches and tags pushed at the same time,
and start running a few of them.

