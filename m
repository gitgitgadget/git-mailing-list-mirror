From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
 [VOTE]  git versus mercurial)
Date: Tue, 28 Oct 2008 15:59:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810281551040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 28 15:53:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KupwQ-0006zd-Td
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 15:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYJ1Ovx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 10:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYJ1Ovw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 10:51:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:34958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751663AbYJ1Ovw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 10:51:52 -0400
Received: (qmail invoked by alias); 28 Oct 2008 14:51:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 28 Oct 2008 15:51:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pQzwpHSepl7pcOf/juJVKHKQ2TZxmclgvb1XEV9
	XJlbueqVgzgnRL
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99293>

Hi,

On Tue, 28 Oct 2008, Peter Krefting wrote:

> How difficult are the storage formats? Would it be possible, in a
> reasonable amount of work, to add support for the Mercurial protocol
> and format in "git clone", so that I could clone a Mercurial repository
> and work on it with Git, and then possibly use "git push" to possibly
> push the result back to Mercurial?

There was talk about imitating Mercurial's wire protocol in order to have 
an efficient HTTP server.  Shawn is working on that front;

We discussed it briefly, and there might be some cute ways to copy it: 
since we are not append-only, we have to download the pack index first 
(which is not downloaded ATM, as we generate it from the downloaded pack 
while verifying it).  With that index, we can determine which parts we 
need in order to regenerate the pack; it would still be pretty stupid when 
there are a lot of branches and we are really only interested in one of 
them.

But I doubt that it will be possible to use the wire protocol to pull/push 
between different DVCSes.  I _strongly_ doubt that the SHA-1s in the 
Mercurial repositories could _ever_ be reused in Git mirrors of them, as 
our data format (on which the hash depends) is different.

> It would be nice to have easy interoperability between the systems, at 
> least as far as can be covered by the lowest common denominator of what 
> they support. I would love to be able to use Git to clone a Bzr 
> repository that I need to be able to access, since bzr is just different 
> enough from Git to be annoying. Same goes for Mercurial. And I am sure 
> that users of the other tools feel the same.

Wasn't bzr touting it as one of their major features that they could have 
foreign-scm remotes?  If I remembered that correctly, that might be the 
route you want to take.

Ciao,
Dscho
