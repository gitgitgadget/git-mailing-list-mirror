From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: PUSH_HEAD, was Re: disallowing push to currently checked-out
 branch
Date: Tue, 17 Feb 2009 12:28:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171200250.6185@intel-tinevez-2-302>
References: <7veixybw7u.fsf@gitster.siamese.dyndns.org>  <20090216135812.GA20377@coredump.intra.peff.net>  <49999ED6.7010608@gmail.com>  <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>  <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com> 
 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>  <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>  <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>  <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com> 
 <20090216225226.GB23764@sigill.intra.peff.net> <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 12:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZO9d-0001Vj-C1
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 12:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbZBQL2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 06:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZBQL2u
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 06:28:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:37278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751332AbZBQL2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 06:28:49 -0500
Received: (qmail invoked by alias); 17 Feb 2009 11:28:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 17 Feb 2009 12:28:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fuzkkWmWflyv7synioUiVcGQRMDZ3Euv3iXfM3B
	CkthJaWoHLspL8
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110359>

Hi,

On Tue, 17 Feb 2009, Jay Soffian wrote:

> My head is playing around with two ideas now that Dscho has mentioned:
> 
> receive.localBranches = (refuse | allow)
> 
> http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78065

In the meantime, we have receive.denyCurrentBranch, which is much superior 
to the localBranches design: it tackles the _real_ issue -- the only 
reason why a current branch cannot be updated lightly is that it might 
have a working directory which would be forced out-of-sync.

> And PUSH_HEAD.
> 
> The idea would be for side-pushes never to update a local branch, but to 
> be recorded in PUSH_HEAD. You'd be able to rebase/merge local branch 
> on-top of changes in PUSH_HEAD. I'm trying to figure out what can make 
> sense when pulling from such a repo.

Sorry, I should clarify what I mean by PUSH_HEAD:

The idea is to have the _same_ as FETCH_HEAD, i.e. a simple file 
(.git/FETCH_HEAD) listing all the branch tips that have been pushed, _no 
matter_ if they were successfully stored as refs.

Just do this in a repository which is lagging behind origin a little:

	$ git fetch origin

and then see that a file .git/FETCH_HEAD exists.  As long as you are only 
interested in the first rev, you can even use "FETCH_HEAD" as a rev name:

	$ git show FETCH_HEAD

The important feature of this method is that FETCH_HEAD is not fetchable.  
Neither 'ls-remote' nor 'branch' will show it.

BTW a PUSH_HEAD could also help the issue that when updating of a ref was 
refused, all the objects will have to be transferred via the wire again 
when pushing somewhere else.

Having said all that, I can easily live without PUSH_HEAD.

Ciao,
Dscho
