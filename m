From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 13:59:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsDP-0002mn-2k
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbZBJM6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbZBJM6W
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:58:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:37584 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754816AbZBJM6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:58:21 -0500
Received: (qmail invoked by alias); 10 Feb 2009 12:58:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 10 Feb 2009 13:58:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+k3Pxpu6ukCPkyPvy6YnP1Rf9bEuD0dUmrdofj9P
	YWWOcvivIwClKZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210121833.GC15491@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109229>

Hi,

On Tue, 10 Feb 2009, Jeff King wrote:

> On Mon, Feb 09, 2009 at 10:12:06PM +0100, Johannes Schindelin wrote:
> 
> > Shawn triggered some well needed thinking on my part about the notes 
> > implementation.  At the moment, we have flat directory structure, and read 
> > all of them in one go (when needed).
> > 
> > I think we should support that, because it is relatively easy to generate 
> > that kind of trees for small-scale applications.
> 
> Hmm. Do we really care about how easy it is to generate? Are we
> expecting people to not use the command interface and instead check out
> a notes tree and start putting stuff into $commit/foo?

I wanted to be nice to existing users of the feature (it is in 'next', 
after all, and Thomas has produced some awesome examples, that will 
hopefully show the scalability of the thing).

But you're right, it almost, but not quite, too late to switch.

> And if we are encouraging the dual possibilities, how do we handle the 
> case of merging two trees with equivalent but differently-formatted 
> content?
> 
> Imagine I have three users, A, B, and C, all collaborating on a project
> with notes. A and B use the "git notes" interface which generates a
> fan-out directory structure. C uses his own script that directly writes
> to the notes tree without fan-out.
> 
> Now let's imagine A, B, and C all write a note for commit X, and A pulls
> from the other two. When he pulls from B, there is a file-level
> conflict, and he decides that his note is better and resolves in his
> favor. But when he pulls from C, there is _no_ conflict, and now there
> are two notes for the same commit in his notes tree. You can give the
> multiple notes some sane semantics (one trumps the other, or they are a
> list, or whatever), but there is still an inconsistency: B's notes and
> C's notes behave differently. So now A has to start caring about how
> other people generate their notes.
> 
> The only two solutions I can think of are:
> 
>   - when A pulls notes, he does a specialized merge that normalizes the
>     note trees
> 
>   - particular notes trees are specified as being in "fan out" or "not
>     fan out" mode. But there is no place to specify that to enforce it.

You're correct.  This buys all kinds of trouble.

Ciao,
Dscho
