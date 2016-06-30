Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ADD11FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 00:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbcF3X75 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 19:59:57 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:49492 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbcF3X74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 19:59:56 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bIlrJ-0006Rn-Ho; Fri, 01 Jul 2016 08:59:01 +0900
Date:	Fri, 1 Jul 2016 08:59:01 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160630235901.GA24593@glandium.org>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <5774F4C7.805@gmail.com>
 <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 11:12:52AM -0700, Linus Torvalds wrote:
> On Thu, Jun 30, 2016 at 3:30 AM, Jakub Narębski <jnareb@gmail.com> wrote:
> >
> > P.S. Having Git ensure that committerdate (as an epoch) is greater
> > than committerdates of its parents at the commit creation time (with
> > providing warning about time skew, perhaps not doing it if skew is
> > too large) would be not costly. No need to add anything, and it would
> > help future queries to be faster, I think.
> 
> So I think git should check the committer date (ie verify that the
> commitetr date of a new commit is always equal to or more recent than
> all the parents).
> 
> But we should probably allow some slop for when machines are out of
> sync (think build farms etc automation that may do automated commits,
> but the clocks on different machines may be off by a few seconds). We
> already do things like that in some of the use of committer dates -
> see for example CUTOFF_DATE_SLOP)
> 
> And we should probably allow the user to override the refusal to
> create new commits with bogus dates - think importing repositories etc
> where you may have reasons to just say "that's just how it was".
> 
> And it will take years for that to percolate out to all users, so it's
> not like it will fix things immediately, but then some time from now,
> we can consider commit dates to be more reliably generation numbers.

This is an assumption that might work for git repositories, but not for
foreign repositories imported in git (think e.g. mercurial repositories
accessed with a remote helper)

Mike
