Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCDB1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 12:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935075AbeBMMlz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 07:41:55 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:40516 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMMly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 07:41:54 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:37808 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1elZuD-0001lJ-VC; Tue, 13 Feb 2018 07:41:54 -0500
Date:   Tue, 13 Feb 2018 07:41:50 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git bisect run make" adequate to locate first unbuildable
 commit?
In-Reply-To: <7135CFE5288C49EEA02785C1F407B46D@PhilipOakley>
Message-ID: <alpine.LFD.2.21.1802130734550.16343@localhost.localdomain>
References: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41> <9803DEA99A6545F7A3F9A3CE08FE2263@PhilipOakley> <alpine.LFD.2.21.1802091553290.17104@localhost.localdomain> <7135CFE5288C49EEA02785C1F407B46D@PhilipOakley>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 9 Feb 2018, Philip Oakley wrote:

> From: "Robert P. J. Day" <rpjday@crashcourse.ca>
> > On Fri, 9 Feb 2018, Philip Oakley, CEng MIET wrote:
> (apologies for using the fancy letters after the name ID...)
> >
> >> From: "Robert P. J. Day" <rpjday@crashcourse.ca>
> >> >
> >> > writing a short tutorial on "git bisect" and, all the details
> >> > of special exit code 125 aside, if one wanted to locate the
> >> > first unbuildable commit, would it be sufficient to just run?
> >> >
> >> >  $ git bisect run make
> >> >
> >> > as i read it, make returns either 0, 1 or 2 so there doesn't
> >> > appear to be any possibility of weirdness with clashing with a
> >> > 125 exit code. am i overlooking some subtle detail here i
> >> > should be aware of? thanks.
> >> >
> >> > rday
> >>
> >> In the spirit of pedanticism, one should also clarify the word
> >> "first", in that it's not a linear search for _an_ unbuildable
> >> commit, but that one is looking for the transition between an
> >> unbroken sequence of unbuildable commits, which transitions to
> >> buildable commits, and its the transition that is sought. (there
> >> could be many random unbuildable commits within a sequence in
> >> some folks' processes!)
> >
> >  quite so, i should have been more precise.
> >
> > rday
>
> The other two things that may be happening (in the wider bisect
> discussion) that I've heard of are:

> 1. there may be feature branches that bypass the known good starting
>    commit, which can cause understanding issues as those side
>    branches that predate the start point are also considered
>    potential bu commits.

  ... snip ...

  sorry, i should have replied to this post since my last post
directly addresses this scenario -- i believe this is precisely what
you were suggesting:

               ... 50000 commits ... (feature branch)
             /                      ^
            /                        \
           v                          \
  A  <--  B <-- <GOOD> <-- D <-- E <-- F <-- <BAD>


i'm still curious ... if one doesn't get into skipping, what is the
"git rev-list" command to identify all of the possible revisions to be
tested here? isn't it just:

  $ git rev-list <BAD> ^<GOOD>

or was there somthing more subtle i was missing? sorry if someone
already explained this, i'll go back later and read the replies in
more excruciating detail.

rday

p.s. i'll take a closer look at the "--bisect*" options to "git
rev-list" shortly.
