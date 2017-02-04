Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0D01FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbdBDHYC (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 02:24:02 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35197 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbdBDHYB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 02:24:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so3939791pge.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 23:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0oO35JESN6rZp83K46i4yygXPz+EGDKJiBwI/6Niljs=;
        b=Mx1ULJQYRzeiSJEyKQQuMEJk7BWMdT2ol8Ttlvl38ujqnL5mFKe1zp9al9z3Dqv3L9
         JTZpptb+IbNAn4BVRMhsRMVv5ADytw5u5czoshYDaL8DHOITHzv9TmR/+CvkBphI8H6a
         lobGx46GlUYVxSs50hjhDH0zyfAd2CrJLC5+0JAVXvM6QVbuSIf5USZ1xFCOIAw6i76R
         eLpQ+yyybK9wPtsld5e/ohk8+4pcvhN7BzG0/oOHkB+OFmBtlNTf9hAf7W+r8J1f78Zm
         N1kkTcYpQbGmUhloXCq2WmtQErcsmhScqFJcxUBzPMIn9hw9c1z1Z4s2wkMkrw0TixYT
         7GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0oO35JESN6rZp83K46i4yygXPz+EGDKJiBwI/6Niljs=;
        b=C3hQWN4jCsNVotXcbqIhnNr7LLhjQErzzJerIU2w5GgQyk9/QZ38toA0KonG9/C4NL
         RgvXPgAttlYmX6/7HSrcn0IRYr1grZ7FY6DO3F1VdFIdCBOTka2LtXznH5RrUsfWR6sH
         2ZYscmHTHRhrqOcQtGrR7TZeuKRtEI3OILEe3nTPzu0K2thQbt4pEwbtCKn1hJGro1zT
         rFht+seSjnPngkg4Jy6VI07OcMZFwFWo/12V8B0Y/BanPknsMje7z9gJwaMUHXKHsKIi
         RJ5nqRbTPUOQbgAIOluWJnvYEm9pDQRT9ZEqPHidr3ioikqWHByRUw19mDJ7i1ypmQbb
         pDQw==
X-Gm-Message-State: AIkVDXJbSPoN3Q39HX/i572Hjlj4Bqni2UlJF0DFA3LL6UBC+NfT7BSX3r2ycE9O4NEgRQ==
X-Received: by 10.99.126.76 with SMTP id o12mr1202374pgn.84.1486193040938;
        Fri, 03 Feb 2017 23:24:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id e127sm72118118pfh.89.2017.02.03.23.23.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 23:24:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Gumbel\, Matthew K" <matthew.k.gumbel@intel.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] commit: Optimize number of lstat() calls
References: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com>
        <xmqqwpd678lx.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702040129430.3496@virtualbox>
Date:   Fri, 03 Feb 2017 23:23:59 -0800
In-Reply-To: <alpine.DEB.2.20.1702040129430.3496@virtualbox> (Johannes
        Schindelin's message of "Sat, 4 Feb 2017 01:35:56 +0100 (CET)")
Message-ID: <xmqqd1ey5shc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Besides, leaving the main index not refreshed would mean the user
>> has to pay the refreshing cost when s/he runs other commands "git
>> diff", "git status", etc. after "git commit" for the first time;
>> so...
>
> I am not sure... when you run `git diff` and `git status`, the index is
> refreshed *anyway*, so with the patch under discussion we would save one
> round of lstat() calls, for the same effect.

Yeah, you're right.  The only ones that could be affected are
plumbing commands, and scripts that use plumbing are expected to be
written without relying on the "refreshed"-ness of the index they
are given (iow, if they want to rely on, they are expected to refresh
first before using plumbing commands).  So there is no downside of
leaving the index in an unrefreshed state as long as everbody plays
by the rule.

> I could imagine that there is a third option we should consider, too: only
> lstat() and update the paths that match the pathspec(s) provided on the
> command line (this is the semantic meaning of the --only option, after
> all: "I am only interested in these paths as far as this commit is
> concerned"). What do you think?

I wondered that myself when I read the first message from Matthew
and noticed that we always refresh the entire index.  But if it is
OK to leave the entire index un-refreshed, that would even be
simpler ;-)
