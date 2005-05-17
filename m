From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list  in local commit order
Date: Tue, 17 May 2005 08:43:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505170833330.18337@ppc970.osdl.org>
References: <4127.10.10.10.24.1116107046.squirrel@linux1> 
 <1116186533.11872.152.camel@tglx>  <4971.10.10.10.24.1116187076.squirrel@linux1>
  <1116189873.11872.171.camel@tglx>  <1102.10.10.10.24.1116189916.squirrel@linux1>
  <1116191636.11872.195.camel@tglx>  <1273.10.10.10.24.1116192097.squirrel@linux1>
  <1116192629.11872.201.camel@tglx>  <1392.10.10.10.24.1116193437.squirrel@linux1>
  <1116195235.11872.213.camel@tglx>  <1629.10.10.10.24.1116278725.squirrel@linux1>
  <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org>
 <1116323520.17296.12.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 17:46:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY4Dn-0000ay-U4
	for gcvg-git@gmane.org; Tue, 17 May 2005 17:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVEQPnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 11:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVEQPnF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 11:43:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:5283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbVEQPlh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 11:41:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HFf8U3003683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 08:41:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HFf7Kg005798;
	Tue, 17 May 2005 08:41:08 -0700
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1116323520.17296.12.camel@tglx.tec.linutronix.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Thomas Gleixner wrote:
> 
> What you blow away is a work space. But at the end you push the result
> of whatever work space you kept into a public available repository. Also
> BK stores a somewhat hidden repository (not workspace) id.

No.

The public repo is secondary. Really. It has no meaning. The only thing 
that matters is what you call "workspace".

> My idea of repository id was not the notion of workspace seperation. I
> dont care in which directory and on which machine you or who ever
> commits a line of code. I care where the change appears in a public
> repository, which is unique.

You seem to think that the repository on master.kernel.org is more 
important than the one on my private machine, and you're _wrong_.

It's the _private_ repositories that are the important ones. The public 
ones are a communication channel, nothing more. They have no importance on 
their own.

I've blown the public one away several times. With BK, we've had disk
corruption on kernel.org, we've had break-ins on bkbits.net, and we've had
repository corruption due to people editing the SCCS files by hand. Any
number of silly problems, in other words. The result? Blow the public tree
away, restore it from one of the private ones from a machine that you
trust.

I _never_ look at my public tree. I literally have a small script called 
"push-all" in my git repositories, and it does:

	#!/bin/sh
	echo master.kernel.org:
	rsync -av --delete --exclude-from=.exclude .git/ master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	...

ie it just pushes my stuff to a few other places.

In other words, the public stuff is the _slave_. It has no meaning. The 
only important one is the one that the _developer_ works on.

Of course, this is not to say that everybody needs to take my approach.
The nice thing about distributed systems is that a centralized system is
just a trivial special case of them, so somebody else, who uses git as if
it were CVS, could say "repo xxxx at git-master:/pub/git-root/project is
the 'main' repository, and all the workspaces are just temporary
workspaces".

But from a git _design_ point (and from a kernel usage point), the belief
that a "workspace" is somehow less important than a "central repository"
is just very very very wrong. Each workspace is it's own repository, and 
it's the _local_ ones that matter, not some "central repository".

		Linus
