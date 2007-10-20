From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Sat, 20 Oct 2007 02:58:22 -0400
Message-ID: <20071020065822.GW14735@spearce.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com> <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net> <alpine.LFD.0.9999.0710191009330.19446@xanadu.home> <20071020050019.GA27282@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Theodore Tso <tytso@thunk.org>,
	Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij8IO-0002xa-E3
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760494AbXJTG6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759792AbXJTG6j
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:58:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47836 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbXJTG6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:58:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij8Hv-0007uE-G9; Sat, 20 Oct 2007 02:58:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02D7620FBAE; Sat, 20 Oct 2007 02:58:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071020050019.GA27282@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61802>

Jeff King <peff@peff.net> wrote:
> On Fri, Oct 19, 2007 at 10:14:59AM -0400, Nicolas Pitre wrote:
> 
> > > ==> git://repo.or.cz/git/spearce.git
> > >  * (new)              gitk -> spearce/gitk
> > >  * 1aa3d01..e7187e4   maint -> spearce/maint
> > >  * de61e42..7840ce6   master -> spearce/master
> > >  * 895be02..2fe5433   next -> spearce/next
> > >  + 89fa332...1e4c517  pu -> spearce/pu
> > >  * (new)              todo -> spearce/todo
> > 
> > Actually I think this is the best format so far: one line per branch, no 
> > terminal width issue (long branch names are simply wrapped), the 
> > old..new info is there also with the single character marker to quickly 
> > notice the type of update.

Yea, I think this is almost the right format.

Nicolas Pitre <nico@cam.org> wrote:
> Agreed.  ' ' = fast forward, '+' = forced update, and '!' = refused.
 
We're probably looking at something like this:

>From git://repo.or.cz/git/spearce.git
   1aa3d01..e7187e4   maint -> spearce/maint
   de61e42..7840ce6   master -> spearce/master
   895be02..2fe5433   next -> spearce/next
   (new)              todo -> spearce/todo
   (new)              tag v1.6.0
 + 89fa332...1e4c517  pu -> spearce/pu  (forced update)
 ! 2b5afb...289840    gitk -> spearce/gitk (non-fast forward)

Notice the sorting order by *type* of update.  I think it makes
the code slightly more complicated in builtin-fetch as we need to
classify each ref into a type of update, then sort them by that
type, but it allows the end-user to see the most "important" (not
simple fast-forward updates) at the end of their terminal window,
especially if there were many fast-forward branches.  Within a
class of update we still sort by ref name.

> Technically speaking, the hash IDs can be up to 80 characters long,
> since they are meant to be unique abbreviations. But in practice, I
> think leaving enough space for 10 + '...' + 10 should accomodate just
> about any project (IIRC, the kernel's longest non-unique is around 9).

Which nicely solves the issue with the window size as we aren't
really worring about it here in this display.

-- 
Shawn.
