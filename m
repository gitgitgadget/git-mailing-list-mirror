From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: Git sideband hook output
Date: Thu, 10 Jun 2010 14:05:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006101344150.30664@xanadu.home>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
 <20100608214632.GN14847@spearce.org>
 <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
 <alpine.LFD.2.00.1006090934320.30664@xanadu.home>
 <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:05:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMm8Q-0006ix-RB
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759589Ab0FJSF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:05:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15773 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759437Ab0FJSFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:05:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L3T00MR98WZM7A0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jun 2010 14:05:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148899>

On Thu, 10 Jun 2010, Peter Kjellerstedt wrote:

> Behalf Of Nicolas Pitre
> > On Wed, 9 Jun 2010, Peter Kjellerstedt wrote:
> > 
> > > And it is very annoying that the output format has suddenly changed
> > > so that the output from hooks that rely on the previous no-prefix
> > > format no longer fit on an 80 char wide terminal where they used to
> > > fit just fine.
> > 
> > Fix your hook output then.
> 
> I can do that for our hooks, but all may not have that option.

Why not?  If that's a real impossibility then people can enlarge their 
terminal window.  No one mandated that the git commands have to be run 
in a 80x25 terminal to work anyway.

> > > > > Is
> > > > > there a way to suppress this to get the old output format?
> > > >
> > > > No.  Other than to have the hook not output anything at all.
> > > >
> > > > --
> > > > Shawn.
> > >
> > > Here is +1 for giving us back the no-prefix output. I would like
> > > to suggest adding a configuration option to allow users to enable
> > > the "remote: " prefix if they want it.
> > 
> > Would be much more logical to fix the hook output, and keep hook
> > developers honnest by not confusing the user with output that isn't
> > local stuff.
> 
> Why should the user care whether the output is generated locally 
> or remotely?

Think about things like "out of disk space", or "access permission 
denied", or "repository corrupted", etc.  You really want to know if 
those are local or remote.

> Shouldn't you prefix local hook output then as well
> to separate it from the output of the git commands themselves 
> (and no, I am not suggesting this is added)?

I don't see this being as relevant.  It is way far more confusing if a 
remote message can be confused with a local one.

> As I see it this change has taken away a little bit of freedom.
> Previously I (as a hook writer) could choose to add a prefix like 
> "remote:" to my hook if I wanted to, to make it more obvious that the
> output came from the remote server, _or_ I could choose not to and 
> have a standardized output that looked the same regardless of whether
> it was a local hook or a remote one that complained about the 
> formatting of a commit message. Now I no longer have that option.

Previously you even didn't have the option of generating messages to be 
displayed on the client's console at all.  If that happened to work with 
SSH that was by pure accident, and causing lots of confusion as remote 
errors were displayed like local ones.  If you tried to push using the 
native Git transport, or the smart HTTP transport, then you would have 
got nothing at all as the hook output was simply dropped on the floor.  
Now this has been fixed, and remote messages are formalized with a 
"remote:" prefix.

> And what if my hook output is localized? Now there is an English
> "remote:" in front of every line... Or even worse, what if the
> "remote:" string is localized in a future version of git, then I 
> have no way of knowing how wide it is and cannot take measures to 
> format my hook output so that it will look right.

Just don't assume anything about the remote terminal size, because you 
actually don't know what the remote terminal size is.  If you *really* 
need to know that information, then the best solution is to create a 
protocol capability for that with the screen width encoded in it, minus 
the "remote" prefix of course.


Nicolas
