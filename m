From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Wed, 25 Jun 2008 11:16:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806251109380.9925@racer>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBS61-00019F-3t
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbYFYKS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYFYKS3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:18:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:36148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752295AbYFYKS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:18:28 -0400
Received: (qmail invoked by alias); 25 Jun 2008 10:18:21 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp024) with SMTP; 25 Jun 2008 12:18:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++SPYW8Je+xEdUA4TF40RDW0XjSt58s+39qJLLpP
	hba+mTSej6/uoZ
X-X-Sender: gene099@racer
In-Reply-To: <48620C1A.6000509@panasas.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86266>

Hi,

just to add to Junio's comments:

On Wed, 25 Jun 2008, Boaz Harrosh wrote:

> Junio C Hamano wrote:
> > Steven Walter <stevenrwalter@gmail.com> writes:
> > 
> >> @@ -225,6 +243,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
> >>  	if (reset_type == HARD && is_bare_repository())
> >>  		die("hard reset makes no sense in a bare repository");
> >>  
> >> +        if (reset_type == HARD && !force && index_is_dirty()) {
> >> +                die("Uncommitted changes; re-run with -f to trash them");
> >> +        }
> >> +
> > 
> > Please don't.  With your change, does the testsuite even pass?
> > 
> > "reset --hard" has *ALWAYS* meant to be destructive --- discarding
> > potential local cruft is the whole point of the operation.
> > 
> 
> I was under the impression that --hard means working-directory-also
> as opposed to tree-and-index-only. Nothing to do with 
> destructive-discarding.

But "reset" _means_ to discard something.

Frankly, we could introduce "git reset --hard --force --really 
--really-i-mean-it --do-reset-the-fscking-working-directory-NOW", but I do 
not think that it makes sense.

If you want to reset the working directory, you want to reset the working 
directory.  If you wanted to save the changes somewhere, you should have 
done that.  We have enough ways to do that.

> > Learn the lingo, and get over it.
> 
> I did lern the lingo and got bitten.

Apparently not.  So again, "reset --hard" means to reset HEAD, index and 
working directory to the revision you pass (defaulting to the HEAD).

The fact that you do not lose the information which used to be HEAD, is 
just a side-effect of Git storing all the revisions in one big graph.  It 
is _not_ implied by "reset", which, as I pointed out, means "re-set".

> there is:
> git-reset --clean - destructive-discarding any local changes

What would be a "nondestructive-discarding", /me wonders.

> git-reset --hard - move tree index and working directory to new head

That is not "git reset --hard".

"move" to a new head is called "switching branches" in Git lingo (and BTW 
in many other SCM lingos, too, so you might just as well get used to it), 
and it is another command: "git checkout <branch>".

Incidentally, a friend just told me that "checkout" is everything but 
intuitive, and he would have preferred "git branch switch <branch>", but 
then settled for my proposed "git branch --switch <branch>", which I did 
not have time to implement yet, unfortunately.

Ciao,
Dscho
