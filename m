From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Sun, 18 Jan 2009 14:42:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181440550.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151500.01876.trast@student.ethz.ch> <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de> <7vhc40s50t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de> <7v8wp917c3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 14:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOXwL-0002CO-Hq
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 14:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761036AbZARNmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 08:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760356AbZARNmY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 08:42:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:50542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758912AbZARNmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 08:42:23 -0500
Received: (qmail invoked by alias); 18 Jan 2009 13:42:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 18 Jan 2009 14:42:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I+rMpy2HIdl1kFxIllXWCg4rGyJJyF4nyknmjov
	0xyx8MJBg13OOE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v8wp917c3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106187>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When HEAD is detached, --all should list it, too, logically, as a
> > detached HEAD is by definition a temporary, unnamed branch.
> >
> > It is especially necessary to list it when garbage collecting, as
> > the detached HEAD would be trashed.
> >
> > Noticed by Thomas Rast.
> >
> > Note that this affects creating bundles with --all; I contend that it
> > is a good change to add the HEAD, so that cloning from such a bundle
> > will give you a current branch.  However, I had to fix t5701 as it
> > assumed that --all does not imply HEAD.
> 
> Sorry, but I do not understand.
> 
> > diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
> > index 8dfaaa4..14413f8 100755
> > --- a/t/t5701-clone-local.sh
> > +++ b/t/t5701-clone-local.sh
> > @@ -11,8 +11,8 @@ test_expect_success 'preparing origin repository' '
> >  	git clone --bare . x &&
> >  	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
> >  	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true
> > -	git bundle create b1.bundle --all HEAD &&
> > -	git bundle create b2.bundle --all &&
> > +	git bundle create b1.bundle master HEAD &&
> > +	git bundle create b2.bundle master &&
> 
> Because --all did not imply HEAD, "--all HEAD" used to be the way to say
> "everything and HEAD".  Now --all does imply HEAD, but it should still be
> a valid way to say "everything, by the way, do not forget HEAD".
> 
> Does the first one need to be changed to "master HEAD"?  If "--all HEAD"
> makes the rest of the test unhappy because HEAD is listed twice, perhaps
> that is an independent bug that needs to be fixed?

I changed it away from --all because I am a fan of being explicit.  We 
want a bundle here that has master and HEAD in it.  This being a test 
case, being lazy is so wrong here.  You should describe what you actually 
want, not use a set of parameters that just happens to work (by chance as 
we saw).

Ciao,
Dscho
