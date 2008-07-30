From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 03:14:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807300223010.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807291235350.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807290838360.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 03:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO0IE-0004xa-35
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 03:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYG3BOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 21:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbYG3BOw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 21:14:52 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4396 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYG3BOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 21:14:51 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6U1ECmn094021
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 03:14:14 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <alpine.LFD.1.10.0807290838360.3334@nehalem.linux-foundation.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90722>

Hi,

On Tue, 29 Jul 2008, Linus Torvalds wrote:

> On Tue, 29 Jul 2008, Roman Zippel wrote:
> > 
> > I'm not dismissing it, but your focus is on how to get this result.
> 
> No, you misunderstand.
> 
> My focus is really on one single thing:
> 
>  - performance
> 
> with a smaller focus on the fact that I simply don't see how it's 
> _possible_ to do better than our current all-or-nothing approach of 
> simplification (eg either extreme simplification or none at all: nothing 
> or --full-history).

That's exactly what I'm not dismissing as you claim, but I've hit the 
problem where this approach simply produces crap, so I'm foremost 
interested in getting a useful result, only after that I'm interested in 
the performance (which I think is possible).

> So here's my challenge again, which you seem to have TOTALLY MISSED.
> 
> Make this be fast:
> 
> 	time sh -c "git log <filename> | head"
> 
> nothing else matters. If you can make that one be fast, I'm happy. 

I already explained it, but you simply dismissed it. It's possible, but it 
requires a bit of cached information (e.g. as part of the pack file, which 
is needed for decent performance anyway).

> In fact, you can see what I'm talking about by trying --topo-order in the 
> above timing test.

Please give me full example.
gitk --topo-order kernel/printk.c shows no difference (e.g. it doesn't 
show 02630a12c7f72fa294981c8d86e38038781c25b7), several experiments with 
git-rev-list show no improvement either.

> > > And quite frankly, I've seen that behaviour from you before, when it comes 
> > > to other things.
> > 
> > What exact behaviour is that? That I dare to disagree with you?
> 
> No. The fact that you like arguing _pointlessly_, and just being abrasive, 
> without actually helping or understanding the big picture.

The problem is that your picture doesn't include my specific problem, I'm 
very interested in the big picture, but I'd like to be in it.

> I'm thinking 
> back on the whole scheduler thing. You weren't arguing with _me_, but you 
> had the same modus operandi.

Well, it seems I have talent for finding the special cases, e.g. last time 
I tested the scheduler it was performing twice as bad as the old scheduler 
on m68k. I've also seen cases where it sacrifices throughput for 
interactivity.
Anyway, this is the wrong place for it anyway, the problem I'm hitting is 
these "good enough" solutions, which work in most situations, but fail in 
a few special situations, but nobody is interested to get these right 
unless your name is Linus.

bye, Roman
