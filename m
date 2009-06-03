From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] Rename submodule.<name>.rebase to
 submodule.<name>.update
Date: Wed, 03 Jun 2009 08:20:21 +0200
Message-ID: <200906030820.21372.johan@herland.net>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
 <1243983552-24810-2-git-send-email-johan@herland.net>
 <200906030615.45791.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apenwarr@gmail.com, peter.hutterer@who-t.net
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Jun 03 08:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBjpw-0000C7-PD
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 08:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbZFCGUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 02:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbZFCGUX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 02:20:23 -0400
Received: from mx.getmail.no ([84.208.15.66]:54114 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753271AbZFCGUW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 02:20:22 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKN00JHUG9YBL90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 08:20:22 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKN006V7G9XJQ50@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 08:20:22 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.3.60730
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <200906030615.45791.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120581>

Hi,

Thanks for the feedback. Really appreciated!

On Wednesday 03 June 2009, Markus Heidelberg wrote:
> Johan Herland, 03.06.2009:
> > Therefore, while "submodule.<name>.rebase" are not yet in a stable git
> > release, future-proof it, by changing it from
> >
> >   submodule.<name>.rebase = true/false
> >
> > to
> >
> >   submodule.<name>.update = checkout/rebase
> >
> > where "checkout" specifies the default behaviour of "git submodule
> > update" (checking out the new commit to a detached HEAD), and "rebase"
> > specifies the --rebase behaviour (where the current local branch in the
> > submodule is rebase onto the new commit). Thus .update == checkout is
> > .rebase == false, and .update == rebase is equivalent to .rebase ==
> > false. Finally, leaving
>   ^^^^^
> .rebase == true

Indeed. Thanks.

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > @@ -400,9 +400,9 @@ cmd_update()
> >  			die "Unable to find current revision in submodule path '$path'"
> >  		fi
> >
> > -		if test true = "$rebase"
> > +		if ! test -z "$update"
>
> Isn't this simpler: if test -n "$update"
> OTOH I think I have heard something about portability, but I'm not sure.

Yes, "test -n" is simpler than "! test -z", but at an earlier occasion I was 
told that "test -n" is not as portable as "test -z"...

> > @@ -420,16 +420,18 @@ cmd_update()
> >  				die "Unable to fetch in submodule path '$path'"
> >  			fi
> >
> > -			if test true = "$rebase_module"
> > -			then
> > -				command="git-rebase"
> > +			case "$update_module" in
> > +			rebase)
> > +				command="git rebase"
>
> I think it is common practice to use the dashed form in scripts and this
> patch shouldn't change it anyway.

I thought we were moving away from the dashed form altogether, both in 
scripts and in examples. Junio, is there an "official" position?

> >  				action="rebase"
> >  				msg="rebased onto"
> > -			else
> > -				command="git-checkout $force -q"
> > +				;;
> > +			*)
> > +				command="git checkout $force -q"
>
> ditto

Thanks for your comments, I'll send an updated patch.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
