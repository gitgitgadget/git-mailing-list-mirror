From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 13:55:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121351470.23555@xanadu.home>
References: <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_VmUppro3C1W1mkMRpg2OkQ)"
Cc: Jeff King <peff@peff.net>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:55:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVJX-0008Uv-9g
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab2FLRz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:55:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab2FLRz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:55:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I00AZNN4ASA50@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 13:55:24 -0400 (EDT)
In-reply-to: <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199822>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_VmUppro3C1W1mkMRpg2OkQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 12 Jun 2012, Shawn Pearce wrote:

> On Tue, Jun 12, 2012 at 10:32 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, Jun 12, 2012 at 01:30:07PM -0400, Nicolas Pitre wrote:
> >
> >> > > To make it "safe", the cruft packs would have to be searchable for
> >> > > object retrieval, but not during object creation.  That nuance would
> >> > > affect the core code in subtle ways and I'm not sure if that would be
> >> > > worth it ... just for the safe handling of cruft.
> >> >
> >> > Why is that? If you do a "repack -Ad", then any referenced objects will
> >> > have been retrieved and put into the new all-in-one pack. At that point,
> >> > by deleting the cruft pack, you are guaranteed to be deleting only
> >> > objects that are either unreferenced, or are duplicated in another pack.
> >>
> >> Now what if you fetch and a bunch of objects are already found in your
> >> cruft pack?  Right now, we search for the existence of any object before
> >> creating them, and if the cruft packs are searchable then such objects
> >> won't get uncruftified.
> >
> > Then those objects will remain in the cruft pack. Which is why, as I
> > said, it is not generally safe to just delete a cruft pack. However,
> > when you do a full repack, those objects will be copied into the new
> > pack (because they are referenced). Which is why I am claiming that it
> > is safe to remove cruft packs at that point.
> 
> But there is a race condition with a concurrent fetch and a concurrent
> repack. If that fetch needs those cruft objects, and sees them in the
> cruft pack, and the repack sees the references before the fetch, the
> repacker might delete things the fetch is about to reference and that
> will leave you with a corrupt repository.
> 
> I think we already have this race condition with loose unreachable
> objects whose mtimes are older than 2 weeks; they are removed by prune
> but may have just become reachable by a concurrent fetch that doesn't
> overwrite them because they already exist, and doesn't update the
> mtime because they aren't writable.

Splat!


Nicolas

--Boundary_(ID_VmUppro3C1W1mkMRpg2OkQ)--
