From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-merge-recursive-{ours,theirs}
Date: Sat, 21 Jun 2008 17:29:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806211728090.6439@racer>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com> <20080616092554.GB29404@genesis.frugalware.org> <48563D6C.8060704@viscovery.net> <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com> <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806181618070.6439@racer> <alpine.DEB.1.00.0806181627260.6439@racer> <7viqw6zovi.fsf@gitster.siamese.dyndns.org> <7vfxr8o8sx.fsf_-_@gitster.siamese.dyndns.org> <7vbq1wo8ck.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806201351370.6439@racer> <7vy74z9l3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 18:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA60e-0001Ur-Mw
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 18:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbYFUQbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYFUQbA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 12:31:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:49856 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750880AbYFUQa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 12:30:59 -0400
Received: (qmail invoked by alias); 21 Jun 2008 16:30:57 -0000
Received: from 87.114.2.237.plusnet.thn-ag3.dyn.plus.net (EHLO racer.local) [87.114.2.237]
  by mail.gmx.net (mp017) with SMTP; 21 Jun 2008 18:30:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//h1wZVIj/l5H1CeRTY/HA3Vkv4yJ6lQo3POZBlZ
	eob3aP/vMuhTwU
X-X-Sender: gene099@racer
In-Reply-To: <7vy74z9l3l.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85713>

Hi,

On Sat, 21 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> @@ -1379,11 +1401,18 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
> >>  	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
> >>  	int index_fd;
> >>  
> >> +	merge_recursive_variants = 0;
> >>  	if (argv[0]) {
> >>  		int namelen = strlen(argv[0]);
> >>  		if (8 < namelen &&
> >>  		    !strcmp(argv[0] + namelen - 8, "-subtree"))
> >> -			subtree_merge = 1;
> >> +			merge_recursive_variants = MERGE_RECURSIVE_SUBTREE;
> >> +		else if (5 < namelen &&
> >> +			 !strcmp(argv[0] + namelen - 5, "-ours"))
> >> +			merge_recursive_variants = MERGE_RECURSIVE_OURS;
> >> +		else if (7 < namelen &&
> >> +			 !strcmp(argv[0] + namelen - 7, "-theirs"))
> >> +			merge_recursive_variants = MERGE_RECURSIVE_THEIRS;
> >
> > This just cries out loud for a new function suffixcmp().
> 
> Actually, I think "git-merge-recursive-theirs" is a mistake.  We should
> bite the bullet and give "git-merge" an ability to pass backend specific
> parameters to "git-merge-recursive".

Fair enough.

> The new convention could be that anything that begins with -X is passed 
> to the backend.
> 
> E.g.
> 
> 	git merge -Xfavor=theirs foo
>         git merge -Xsubtree=/=gitk-git paulus
> 
> As you noticed already, subtree is just a funny optional behaviour
> attached to recursive, so are theirs and ours.  The above two would invoke
> git-merge-recursive like so:
> 
> 	git merge-recursive -Xfavor=theirs <base> -- HEAD MERGE_HEAD
> 	git merge-recursive -Xsubtree=/=gitk-git <base> -- HEAD MERGE_HEAD
> 
> We could even mix these two if we are ambitious.

Looks fine to me.  And much cleaner than the hardlinking.

Ciao,
Dscho
