Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A31201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbdBRWhQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 17:37:16 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:43590 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdBRWhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 17:37:15 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vQlBd1fzjz5tlC;
        Sat, 18 Feb 2017 23:37:13 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A8E031E70;
        Sat, 18 Feb 2017 23:37:12 +0100 (CET)
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
 <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
 <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <148a585a-33df-1adb-6410-5c4fe09202b0@kdbg.org>
Date:   Sat, 18 Feb 2017 23:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.02.2017 um 19:36 schrieb Alex Hoffman:
> Let's consider your example with distinct names for nodes:
>
> --o1--o2--o3--G--X1
>     \                \
>      x1--x2--x3--x4--X2--B--
>
> It makes sense that git bisect is expecting a single transition, as
> this is a precondition for a binary search to work. My definition of
> "the transition" is a commit with at least one of its parents as a
> good version, but the commit itself a bad version.

But that is not the definition of transition that lets you pin-point the 
breaking commit precisly. Assume x3 is the commit introducing the 
breakage in the graph above. Even though you only know initially that G 
is good and B is bad, would you not prefer to find x3 instead of X2? As 
Christian said, a transition is when a commit is bad and all its parents 
are good, and this definition lets you find x3.

> I hope we agree
> that git bisect's mission is to search for this transition (as I
> suppose that most of people need such a functionality from git, if not
> exactly from git bisect). How could be x1 or x3 be the transition, if
> chances are that o1 is not a good version?

By declaring G as good, it is implied that o1 is also good. If it is in 
fact bad, the assumptions of git bisect are violated (because there 
would be a transition from bad to good at o2, o3, or G), and anything 
can happen.

> If you consider that git bisect's mission is different from finding
> the transition, could you please explain what exact commit git bisect
> is supposed to return (ideally with terms from the graph theory) and
> when it makes sense to return that? Because I do not see any sense in
> looking in the path x1-x3 without knowing that those commits may be a
> transition.

And I do not see a reason why git bisect should not look at those 
commits. If x3 is the commit that broke my program, I do prefer to be 
pointed at x3 rather than X2.

-- Hannes

