From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Mon, 18 May 2009 23:55:21 +0200
Message-ID: <200905182355.21645.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
 <200905181536.39508.johan@herland.net>
 <200905182140.29953.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon May 18 23:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Ao0-00008O-9s
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 23:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbZERVzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 17:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbZERVzX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 17:55:23 -0400
Received: from mx.getmail.no ([84.208.15.66]:36757 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752393AbZERVzX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 17:55:23 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJV000QP0WBWF00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 18 May 2009 23:55:23 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJV00MA60WAQA40@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 18 May 2009 23:55:23 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.18.214343
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <200905182140.29953.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119467>

On Monday 18 May 2009, Markus Heidelberg wrote:
> Johan Herland, 18.05.2009:
> > On Sunday 17 May 2009, Junio C Hamano wrote:
> > > [Will merge to "master" soon]
> > >
> > > * ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit
> > >  + git-submodule: add support for --rebase.
> >
> > [..]
> >
> > Now, my question should not stop this feature from going into 'master',
> > except for the fact that if we also want to support merge, we should
> > rename the associated config variable:
> >
> > Instead of
> >
> >   submodule.<name>.rebase = true/false (false if unset)
> >
> > we should have something like
> >
> >   submodule.<name>.resolve = checkout/rebase/merge (checkout if unset)
>
> At least this would be inconsistent with options like
> branch.<name>.merge and branch.<name>.rebase

No. We cannot "reuse" the branch.<name>.merge/rebase semantics in this case: 
branch.<name>.merge takes a remote branch name to merge with, while 
submodule.<name>.merge needs no such name (the merge is well-specified 
without that extra name: the new submodule commit is merged into the 
submodule's current branch). Thus, submodule.<name>.merge is reduced to a 
simple bool indicating whether or not we should merge. At this point, 
however, it is not only inconsistent with branch.<name>.merge, it also 
directly conflicts with submodule.<name>.rebase (they cannot both be "true" 
simultaneously). They should therefore be collapsed into one tri-state 
config variable set to either 'rebase', 'merge' or 'false'/unset (which 
triggers the default 'checkout' behaviour). This is pretty much what I 
propose above.

After some thinking, I don't like my original name submodule.<name>.resolve, 
since ".resolve" sounds more like a merge strategy or conflict resolution 
method, than a "how to deal with submodule update" choice. I propose 
submodule.<name>.update instead.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
