Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E180C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB8B2067D
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDRJj6ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKVSw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:52:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40089 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKVSw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:52:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so3876960pfl.7
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wNP36OxhnXTF4oo6T0522h8gpAFV+jmpLJAtahirNmA=;
        b=aDRJj6ME2zL03HDbP0Gf6WIeHC1eEVTYDJcRXFoOPw8UHKMceB/AOi+7rziUBbnhP7
         dTPRvKOAutqY/sQ6fGB6TQBpXD/+6x9lMUDgJtxzrROPtxn7/Ky/jy1gAsegYJ8fp6L7
         GGmU15vqFDFapKtSN6sDBcGgKO5Dsiud/vi0ylOKRUHgqTVjarGMjcAuGr5CqbA70Epn
         WRjALQ6UOT4hO7ouBb+KDz5yWlv3XzzgQb9CRcrh+00+OXvpLgfrU+pZ82TKf1cWtXNy
         FVnb0vsszuBD8SQI6KU8Du2BCvqo4I6URwxYeJ3T09QJVzbu5vNm+cdh+gr2MFT0xA77
         xvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNP36OxhnXTF4oo6T0522h8gpAFV+jmpLJAtahirNmA=;
        b=IcO9IAyfyf521NMrUvaYFOWzb/D6VplGDurGoi1WTAvyOT6UvMCrnrfbWjzMr4/BgC
         golDxXLpwGjqnvrv9EdSbmG8bjTyROk/ED72Dn/G5W2Ob04akJYlQefhbWC2+tmwt9h+
         PcubaFE7BEsgP3JRSfXQRGBnoesd3pD4YrnKqu9dyiZQxfOPen0haPwn2v2qTJE86QWp
         eQdXQa/tcGDs2Xp7CUuKCt1vWPUvlRDHytemp8ObMJez66N4Cc7Q0HiwDtVct1a8z20d
         ELzM0W+s6gy6sl0bDvP0hU6pN85Z6g4GZoF25oMoAq6JEfaLU1ZDvXUrgcyqvaTDlsWD
         Carw==
X-Gm-Message-State: APjAAAUXhsZn4JojVxsWQx6soavIMR1bVwJOY7hXZvU4qkKZrkIWZ+sd
        XBaumzBUCnkrGsQ0mHWIo9A=
X-Google-Smtp-Source: APXvYqzmBq+jwMWzjPvlinwqJkKa/K9mqg5iMfR61WfcOgl71tqvRmdL0LNMW2NQC4WPDYqbqJgpww==
X-Received: by 2002:a63:450:: with SMTP id 77mr11211444pge.384.1574448773753;
        Fri, 22 Nov 2019 10:52:53 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id q199sm8434238pfq.147.2019.11.22.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:52:53 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:52:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
Message-ID: <20191122185251.GA58965@generichostname>
References: <20191122011646.218346-1-emilyshaffer@google.com>
 <20191122021419.GA52557@generichostname>
 <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Nov 22, 2019 at 11:34:17AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > The reason I ask is because (correct me if I'm wrong) a lot of other git
> > commands (like add, reset and checkout) don't seem to accept pathspecs
> > via stdin and could suffer the same problem. xargs seems like a more
> > general way of solving the problem of long command lines.
> 
> You contributors who are potentially throwing your own topics into
> the cauldron, please be paying a bit more attention to other topics
> already cooking in the pot.  I think am/pathspec-from-file wants to
> go in the general direction.

Interesting, I never caught this topic when it went over the list. I
guess I should read your What's Cooking emails more thoroughly instead
of just scanning for my own contributions.

> 
> There are things "xargs" is sufficient, and there are things that
> absolutely requires a single invocation of "git".  "grep" is a bit
> of both.
> 
>     $ git grep -e "$pattern" -- A B C
> 
> (where A, B and C are hundreds) can be split into three independent
> invocations of "git grep" via "xargs", essentially running
> 
>     $ git grep -e "$pattern" -- A
>     $ git grep -e "$pattern" -- B
>     $ git grep -e "$pattern" -- C
> 
> independently.

In the above, I was talking about the new --pathspecs-file option in
particular. So it looks like you agree with me that the new option
doesn't supercede xargs?

> 
> But
> 
>     $ git grep -e P1 -e P2 -e P3 -- A
> 
> (where each of "-e Pn" in reality may be "-e Pn1 -e Pn2 -e Pn3..."
> that has hundreds of patterns) cannot be split into separate
> invocations and keep the same meaning.
> 
>     $ git grep -e P1 -- A
>     $ git grep -e P2 -- A
>     $ git grep -e P3 -- A
> 
> may show the same lines, but (1) lines with both P1 and P2 would be
> shown duplicated, and (2) the order of the output would be different
> from a single invocation looking for all patterns at once.

We already have `-f` to handle this particular case, no?

> 
> Needless to say, the ability to combine patterns with --all-match,
> --and, etc., and negate them would mean the list of patterns must be
> split (even when it makes sense to do so) at the right places.
> 
>     $ git grep -e P1 --and -e P2
> 
> cannot be split into two or more invocations, for example.

Anyway, thanks for going into detail about this. It makes things a lot
more clear.

-Denton
