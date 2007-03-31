From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Keep rename/rename conflicts of intermediate merges while doing recursive merge
Date: Sat, 31 Mar 2007 19:34:45 +0200
Message-ID: <20070331173445.GA7696@steel.home>
References: <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org> <20070331104947.GA4377@steel.home> <20070331114938.GB4377@steel.home> <Pine.LNX.4.64.0703310856070.6730@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 19:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXhTr-0007CM-1q
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 19:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbXCaRet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbXCaRet
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 13:34:49 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54950 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbXCaRes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 13:34:48 -0400
Received: from tigra.home (Fc8c6.f.strato-dslnet.de [195.4.200.198])
	by post.webmailer.de (mrclete mo14) (RZmta 5.5)
	with ESMTP id B01841j2VECNsp ; Sat, 31 Mar 2007 19:34:46 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5AB0A277B6;
	Sat, 31 Mar 2007 19:34:46 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AEE74D150; Sat, 31 Mar 2007 19:34:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703310856070.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WNdA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43563>

Linus Torvalds, Sat, Mar 31, 2007 18:07:56 +0200:
> > 
> > The result seem to be at least predictable. Still, doesn't it mean
> > that once a rename/rename conflict is in it has to be resolved
> > manually forever?
> 
> The only way to resolve some conflicts in the long run is to either 
>  - converge on some common case (ie normally by merging both ways 
>    eventually, or just try to converge otherwise)
>  - remember the conflict resolution and re-doing it automatically (ie 
>    "git rerere" for rename conflicts)
> 
> That's very fundamental, btw. I don't think there *is* any other way to do 
> automatic merges in the long run, it has nothing to do with this 
> particular issue, it's a generic property of automatic merging.
> 
> Junio - I think Alex' patch is better than what we have right now (which 
> is dying - whether with a SIGSEGV or a die() doesn't much matter), so it 
> should be applied. It probably isn't perfect, and I bet we can tweak the 
> resolution to something much better - Dscho seems to have ideas in that 
> areas. But:
> 
> 	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> in the meantime.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

> One thing we could/probably should do is to perhaps just add a flag about 
> "intermediate merges had complex issues", and refuse to commit the result 
> even if it looked "clean" in the end. It's better to make people perhaps 
> have to do an "unnecessary" extra git-commit, than to silently commit 
> something that might have been mis-merged. Just ask people to "please 
> verify the end result" kind of thing..

That'd be using the return value of inner merge which we historically
do not do. Corresponding comment is in place: "The cleanness flag is
ignored, it was never actually used, as result of merge_trees has
always overwritten it: the committed conflicts were already resolved".
Somehow it does not help to understand "why" the cleanliness of the
inner merge does not matter...
