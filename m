From: Nicolas Pitre <nico@cam.org>
Subject: Re: Optimizing cloning of a high object count repository
Date: Sat, 13 Dec 2008 13:56:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812131347130.30035@xanadu.home>
References: <200812131624.57618.Resul-Cetin@gmx.net>
 <fcaeb9bf0812130746l38a12f37wde26f31d5fa0d2a2@mail.gmail.com>
 <200812131714.05472.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	gentoo-scm@gentoo.org
To: Resul Cetin <Resul-Cetin@gmx.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 19:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBZgY-0004dO-45
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 19:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbYLMS40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYLMS40
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 13:56:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18459 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYLMS4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 13:56:25 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBT0079YWKL8OQ1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 13 Dec 2008 13:55:34 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200812131714.05472.Resul-Cetin@gmx.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103010>

On Sat, 13 Dec 2008, Resul Cetin wrote:

> On Saturday 13 December 2008 16:46:50 you wrote:
> [...]
> > >  The size of the linux repository seems to be smaller but in the same
> > > range object count and repository size but clones are much much faster.
> > > Is there any way to optimize the server operations like counting and
> > > compressing of objects to get the same speed as we get from
> > > git.kernel.org (which does it in nearly no time and the only limiting
> > > factor seems to be my bandwith)?
> > >  The only other information I have is that Robin H. Johnson made a single
> > >  ~910MiB pack for the whole repository.
> >
> > Make yearly packed repository snapshots and publish them via http.
> > People can wget the latest snapshot, then pull updates later.
> That would be a workaround but it doesn't explain why git.kernel.org deliveres 
> torvalds repository without any notable counting and compressing time. Maybe 
> it has something todo with the config I found inside the repository:
> http://git.overlays.gentoo.org/gitroot/exp/gentoo-x86.git/config
> It says that it isnt a bare repository.

That's not relevant.

The counting time is a bit unfortunate (although I have plans to speed 
that up, if only I can find the time).

You should be able to skip the compression time entirely though, if you 
do repack the repository first.  And you want it to be as tightly packed 
as possible for public access.  I'm currently cloning it and the 
counting phase is not _that_ bad compared to the compression phase.  Try 
something like 'git repack -a -f -d --window=200' and let it run 
overnight if necessary.  You need to do this only once, and preferably 
on a machine with lots of RAM, and preferably on a 64-bit machine.  Once 
this is done then things should go much more smoothly afterwards.


Nicolas
