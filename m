From: Junio C Hamano <junkio@cox.net>
Subject: Re: something broken just now on git-pull from openbsd to OSX
Date: Fri, 18 Aug 2006 14:26:06 -0700
Message-ID: <7vwt9568i9.fsf@assigned-by-dhcp.cox.net>
References: <86pseykogj.fsf@blue.stonehenge.com>
	<86lkpmkod3.fsf@blue.stonehenge.com>
	<86hd0ako8h.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 23:26:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEBrG-0000zC-Co
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 23:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWHRV0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 17:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWHRV0J
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 17:26:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30133 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751483AbWHRV0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 17:26:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818212607.UHSD8129.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 17:26:07 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86hd0ako8h.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "18 Aug 2006 09:22:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25697>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> And even more info:
>
>     $ git-repack -a -d
>     Generating pack...
>     Done counting 2610 objects.
>     Deltifying 2610 objects.
>      100% (2610/2610) done
>     Writing 2610 objects.
>      100% (2610/2610) done
>     Total 2610, written 2610 (delta 1244), reused 2610 (delta 1244)
>     Pack pack-3cd61a256bd8736b13b0356aafff016260c22b80 created.
>     $ git-repack -a -d -f
>     Generating pack...
>     Done counting 2610 objects.
>     Deltifying 2610 objects.
>     Segmentation fault 
>
> Oops!  That's not good.

Indeed it is not good.

First we would need to see who is dying.

git-repack -a -d -f does:

 - list all the objects that need to be packed by running

	git rev-list --objects --all

 - piping that to pack-objects

 - after that remove old ones (because -d is given)

I am suspecting it is either rev-list or pack-objects, but let's
isolate which first.

	git-rev-list --objects --all >/var/tmp/revlist.out

Does this die?  If not

	git-pack-objects pack </var/tmp/revlist.out

does this die?

Once you isolate which, can you bisect to see where it broke in
recent history (assuming it worked ever on OSX)?
