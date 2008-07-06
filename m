From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Sun, 6 Jul 2008 18:29:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFX7y-0004oC-ER
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 18:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbYGFQ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 12:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757227AbYGFQ3U
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 12:29:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:47056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756804AbYGFQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 12:29:19 -0400
Received: (qmail invoked by alias); 06 Jul 2008 16:29:17 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp052) with SMTP; 06 Jul 2008 18:29:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ji0hgICoj57ubvZpyUd8T8BzLPw82gkvgJRJef4
	fiwZxd63gAUnwZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080706160758.GA23385@jhaampe.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87539>

Hi,

On Sun, 6 Jul 2008, Sylvain Joyeux wrote:

> > > Which one is the commit message ;-)?
> > 
> > I think it is clear that Sylvain has not read 
> > Documentation/SubmittingPatches yet.
> 
> Sylvain *has* read SubmittingPatches but has not understood every detail 
> of this very long document.

Oh.  But you should have already seen on this list that almost everybody 
puts the oneline as subject, the commit message as first part of the mail 
body, then a "--", optionally some personal stuff that should not go into
the commit message, and then the diffstat and all the rest.

IOW the mail body should look like the output of format-patch, optionally 
some comments between "--" and the diffstat.

Write a patch for SubmittingPatches.
 
> > If you could enlighten me on what is wrong ...
> 
> > > People who rely on working submodule support, do you have any 
> > > feedback on this patch?
> > 
> > Not yet.  Will test/comment when the spurious "fetch" is fixed.
>
> I thought that the only thing that 'fetch' does is update FETCH_HEAD.

Uhoh.  'fetch' fetches.  Which means it does not only update something.

> My problem is that doing the fetch is the only way to know what is the 
> status of the submodule w.r.t. the registered commit. If you have a 
> better way to get that information, I'm all ears :P

Are you sure that you understand the submodule thing enough to patch 
git-submodule?

There are three states that are interesting:

- the committed submodule state:

  You get this in the superproject by "git ls-tree HEAD -- <dir>"

- the local HEAD of the submodule:

  (cd "<dir>" && git rev-parse --verify HEAD)

- the HEAD of the default branch of the upstream repository of the 
  submodule:

  (cd "<dir>" && git ls-remote origin HEAD)

  NOTE: this does not have to do _anything_ with the submodule: you can 
  easily have two independent branches (see "html" and "next" in git.git), 
  and the submodule is free to be pinned to whatever commit is available
  in the upstream repository.

  It is even possible that it is pinned to a commit that is only reachable 
  from a tag, not from a branch.

Hth,
Dscho
