From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 12:10:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org> <20081103071420.GD10772@coredump.intra.peff.net> <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
 <20081112083353.GB3817@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 12:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0DWT-0000in-OP
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 12:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbYKLLDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 06:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYKLLDS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 06:03:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:37549 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751470AbYKLLDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 06:03:17 -0500
Received: (qmail invoked by alias); 12 Nov 2008 11:03:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 12 Nov 2008 12:03:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+l/+BVrqqlRxHQwcWI7HCJ918gu7fShRdQ01qGhU
	sQkiI7eyJpuL5h
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081112083353.GB3817@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100741>

Hi,

On Wed, 12 Nov 2008, Jeff King wrote:

> On Mon, Nov 10, 2008 at 11:04:42PM -0500, Avery Pennarun wrote:
> 
> > Speaking just for myself, I would find this all a lot less confusing 
> > if "staged" were a refspec of some sort, not an option at all.
> > 
> >    git diff HEAD..STAGED
> >    git diff STAGED..WORKTREE
> >    git grep pattern STAGED HEAD sillybranch WORKTREE ^ignorebranch --
> > path/to/files
> 
> I agree that such a thing is reasonably intuitive. I have thought about 
> "magic" refspecs before; my local git has an "EMPTY" refspec which 
> points to the empty tree for diffing. However, that was trivial to 
> implement (since it turns into a sha1), and yours is very hard (since 
> you will have to pass these "pretend" objects around).
> 
> So I think it is a neat idea, but I am not volunteering to work on it.
> :)

Just in case anybody thought about creating tree objects on the fly and 
use their SHA-1s: that won't fly, as you can have unmerged entries in the 
index.  So STAGED.. is a _fundamentally_ different thing from HEAD^..

Maybe we could play tricks with a special staged_commit (pretending to be 
a commit with SHA-1 000000... so that git log STAGED.. would do the same 
as plain git log, the rationale being that STAGED is no commit, so ^STAGED 
should be a nop).

"git diff" would then have some special handling for the case that there 
are exactly two revs, exactly one of them negative, and exactly one of 
them being the staged_commit, passing off to the respective diff backends.

Ciao,
Dscho
