From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 18:01:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>  <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:02:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwl0-0000QR-62
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZA3RAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZA3RAw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:00:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:58469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751914AbZA3RAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 12:00:52 -0500
Received: (qmail invoked by alias); 30 Jan 2009 17:00:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 30 Jan 2009 18:00:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pr4JziSjpg+nEc3bHWP4KV7nIZRoFyBg1rNG0hP
	CIO+L2jozOte+X
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107851>

Hi,

On Fri, 30 Jan 2009, Jay Soffian wrote:

> On Thu, Jan 29, 2009 at 7:34 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Many, many users set up non-bare repositories on their server, and are 
> > confused that the working directory is not updated.
> 
> This comes up on the list from time-to-time and is even in the FAQ.

So much so that it is high time we admitted that we have a design bug 
there.

> It has even been suggested that HEAD be detached when pushing into a 
> non-bare repository, but I am not suggesting that again.

No, because that would be as wrong as trying to update the working 
directory in any other way.  (Not only is it possible that you are a 
git-shell user, in which case you have no business meddling with the 
working directory -- or the symbolic ref HEAD -- to begin with, but you 
also run into the problem that you might not know where the working 
directory is at all, let alone if there is one.)

So it is a good thing you are not suggesting it again.

> I wonder if it might be helpful to teach clone to setup a push line in
> the cloned repo. i.e.:
> 
> [remote "origin"]
> 	url = ...
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> 	push = refs/heads/*:refs/remotes/origin/*
> 
> This could be a configurable default behavior when cloning from a
> non-bare repo (can that be determined?) and/or as a switch
> (--satellite perhaps?).

As Peff commented, this would be horribly wrong if the remote has a 
different "origin" remote.  Not forcing the push does not help either, it 
is still wrong.

But I think there is an even more fundamental problem: You do not want 
that default push.  We have "push only those refs the remote and the local 
repository share" rule for a reason.  It is way too easy to publish 
something you did not mean to publish otherwise.

Ciao,
Dscho
