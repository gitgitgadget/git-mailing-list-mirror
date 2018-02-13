Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D0D1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935010AbeBMM2M (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 07:28:12 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:37534 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMM2L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 07:28:11 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:37330 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1elZgw-0006Tk-9l; Tue, 13 Feb 2018 07:28:10 -0500
Date:   Tue, 13 Feb 2018 07:28:08 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: totally confused as to what "git bisect skip" is supposed to
 do
In-Reply-To: <CAP8UFD03TDGBU3t3+m2OmhyJt6sNcPhMZ2ejzufX3x-_1EEDHA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1802130712260.15482@localhost.localdomain>
References: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain> <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1802120522580.17810@localhost.localdomain> <CAP8UFD03TDGBU3t3+m2OmhyJt6sNcPhMZ2ejzufX3x-_1EEDHA@mail.gmail.com>
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

On Mon, 12 Feb 2018, Christian Couder wrote:

> On Mon, Feb 12, 2018 at 11:44 AM, Robert P. J. Day
> <rpjday@crashcourse.ca> wrote:
> > On Fri, 9 Feb 2018, Junio C Hamano wrote:
> >
> >> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> >>
> >> >   i'm confused ... why, after skipping a good chunk in the interval
> >> > [v4.13,v4.14], do i still have exactly 7300 revisions to bisect? what
> >> > am i so hopelessly misunderstanding here?
> >>
> >> Are you really "skipping" a chunk in the interval?
> >>
> >> I thought that "git bisect skip" is a way for you to respond, when
> >> "git bisect" gave you a commit to test, saying "sorry, I cannot test
> >> that exact version, please offer me something else to test".  And
> >> each time you say that, you are not narrowing the search space in
> >> any way, so it is understandable that the numver of candidate bad
> >> commits will not decrease.
> >
> >   this might be an issue of terminology, then, as "man git-bisect"
> > clearly suggests you can skip a range:
> >
> >     You can also skip a range of commits, instead of just one
> >     commit, using range notation. For example:
> >
> >            $ git bisect skip v2.5..v2.6
> >
> >     This tells the bisect process that no commit after v2.5, up to
> >     and including v2.6, should be tested.
>
> Yeah, I think this is kind of a terminology related.
>
> First when git bisect says "Bisecting: XXX revisions left to test
> after this" it doesn't mean that all those revisions left will
> actually be tested, as git bisect's purpose is to avoid testing as
> many revisions as possible.
>
> So the XXX revisions are actually the revisions that possibly
> contain the first bad commit.
>
> And, as Junio wrote, when you tell git bisect that you cannot test
> some revisions, it doesn't mean that those revisions cannot contain
> the first bad commit.
>
> > my issue (if this is indeed an issue) is that if i select to skip
> > a sizable range of commits to test, should that not result in git
> > bisect telling me it now has far fewer revisions to test? if i, in
> > fact, manage to "disqualify" a number of commits from testing, is
> > there no visual confirmation that i now have fewer commits to
> > test?
>
> I hope that the above clarification I gave is enough, but maybe the
> following will help you.
>
> If you cannot test let's say 20 commits because there is build
> problem in those commits, and in the end Git tells you that the
> first bad commit could be any of 3 commits, 2 of them that were
> previously marked with skip, then you could still, if you wanted,
> fix those commits, so that they can be built and test them.
>
> So yeah if we only talk about the current bisection, the skipped
> commits will not be tested, but if we talk about completely
> finishing the bisection and finding the first bad commit, then those
> commits could still be tested.

  ok, i'll give this more thought later in the week when i have the
time, but is there a simple expression (using "gitrevisions") that
defines the set of revisions to be tested by bisection if i define the
search space between <GOOD> and <BAD>?

  consider the following history:

               ... 50000 commits ... (feature branch)
             /                      ^
            /                        \
           v                          \
  A  <--  B <-- <GOOD> <-- D <-- E <-- F <-- <BAD>

so imagine branching at B, creating a massively lengthy feature
branch, and merging it back to master at F. now imagine i know "GOOD"
is a good revision, and "BAD" is broken. according to the above, the
offending commit could be any of D, E, or any of the 50,000 commits on
the feature branch, correct? so if i had the above commit history,
would:

  $ git bisect start <BAD> <GOOD>

tell me i have 50,002 revisions to test? am i making sense here?

rday

p.s. i suspect i should RTFS to see exactly how git bisect does its
work.
