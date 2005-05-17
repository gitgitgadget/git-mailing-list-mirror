From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list  in local commit order
Date: Tue, 17 May 2005 10:44:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505171035570.18337@ppc970.osdl.org>
References: <4127.10.10.10.24.1116107046.squirrel@linux1> 
 <1116186533.11872.152.camel@tglx>  <4971.10.10.10.24.1116187076.squirrel@linux1>
  <1116189873.11872.171.camel@tglx>  <1102.10.10.10.24.1116189916.squirrel@linux1>
  <1116191636.11872.195.camel@tglx>  <1273.10.10.10.24.1116192097.squirrel@linux1>
  <1116192629.11872.201.camel@tglx>  <1392.10.10.10.24.1116193437.squirrel@linux1>
  <1116195235.11872.213.camel@tglx>  <1629.10.10.10.24.1116278725.squirrel@linux1>
  <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org> 
 <1116323520.17296.12.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.58.0505170833330.18337@ppc970.osdl.org>
 <1116349507.17296.31.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 19:51:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY68n-0001Xo-3w
	for gcvg-git@gmane.org; Tue, 17 May 2005 19:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVEQRpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 13:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVEQRom
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 13:44:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:50380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261935AbVEQRmV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 13:42:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HHg9U3014156
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 10:42:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HHg7EF011703;
	Tue, 17 May 2005 10:42:08 -0700
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1116349507.17296.31.camel@tglx.tec.linutronix.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Thomas Gleixner wrote:
>
> On Tue, 2005-05-17 at 08:43 -0700, Linus Torvalds wrote:
> > > My idea of repository id was not the notion of workspace seperation. I
> > > dont care in which directory and on which machine you or who ever
> > > commits a line of code. I care where the change appears in a public
> > > repository, which is unique.
> > 
> > You seem to think that the repository on master.kernel.org is more 
> > important than the one on my private machine, and you're _wrong_.
> 
> For me yes, as I have no access to your private ones and I can only rely
> on the integrity of the public accessible ones.
> 
> For the individual developer the private workspaces are surely more
> important. I never doubted that, but I do not care whether you use one
> or ten workspaces and which one of them you blow away or use for
> updating of master.kernel.org. 

But how would you track "repositoryness", when the repository you care 
about has absolutely nothing to do with the repositories that any of the 
developers who created it in the first place care about?

See the problem? You can't. You seem to want to track information that
simply does not _exist_.

Put another way: the repository ID of the eventual public "target"  
repository only becomes available once the information has been pushed
there, not before. So a "commit" cannot contain that information, because
at commit time, you fundamentally cannot know what the eventual public
repository (if any) will be.

So the public repo really is nothing but a shadow of the real work, and 
the only reliable ordering you can do will have to depend on local 
information (ie things like the committer "email" value).

Now, what you _can_ do (and what the snapshot mechanism and the commit 
mailing list scripts do) is to create a "publicly visible timeline" thing, 
ie you can at regular intervals generate a snapshot of "what is the state 
of public repo X" and you'll get a "local commit ordering" from that.

But that local commit ordering will fundamentally depend on exactly when
and how often you do the snapshotting and when I (or somebody else)
happened to push to that public repo, so it will inevitably be something
you can never re-create later from just the final repository contents.  
IOW, it's not something that "git-rev-list" can re-create - the only way
to recreate it is literally to build up a separate list of "what was the
head commit at time X" outside of the repository.

		Linus
