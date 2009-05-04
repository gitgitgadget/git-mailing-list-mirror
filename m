From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git 1.5.4.3 push incorrectly honors grafts file
Date: Tue, 5 May 2009 00:40:22 +0400
Message-ID: <20090504204022.GE4863@dpotapov.dyndns.org>
References: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net> <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: elupus <elupus@ecce.se>
X-From: git-owner@vger.kernel.org Mon May 04 22:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M14ya-0006D0-AD
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 22:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbZEDUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbZEDUlN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 16:41:13 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57671 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZEDUlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 16:41:12 -0400
Received: by fxm2 with SMTP id 2so4081821fxm.37
        for <git@vger.kernel.org>; Mon, 04 May 2009 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GODHJVbEHL2vdkHLqfSuZmG93HhPQQcRgAB4qzUUmOY=;
        b=DE9mDwMrBEOccpRs6aPT0nGTjH6yRjonclcAjZvOyPZhfmniDRejS0AO5naGO/KKUU
         OqHhwXUIfnkzRG9bSpY1iiT/S8dHz9+JMr5r3RWsuSggkeUvDYCyP06wLmJ9LQvHJFj5
         AzAuonhy8geEgZ/jh7yYIIx1g6zptS8O7mASI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RGsqpqbAC9E43nclGVsJ3dEFw34ssafcTvL66RQZ1aWXWMZ6WUXUkao0rXuoefE3Ly
         WfKNz0E0E8WJO/zX0GsbsmfVmAg2appf71UwC+EAfUx6Qnd2C2xuTspp3bSq8w6U3MiD
         /QTPPJOJ85sOaCLM4WA8J1HihdqePMIaEu5b0=
Received: by 10.86.29.8 with SMTP id c8mr6320102fgc.70.1241469671437;
        Mon, 04 May 2009 13:41:11 -0700 (PDT)
Received: from localhost (ppp91-77-224-204.pppoe.mtu-net.ru [91.77.224.204])
        by mx.google.com with ESMTPS id d6sm11639815fga.27.2009.05.04.13.41.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 May 2009 13:41:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118262>

On Sun, May 03, 2009 at 07:14:22PM +0200, elupus wrote:
> On Mon, 27 Apr 2009 17:51:05 +0200, elupus wrote:
> 
> > Hi, 
> > 
> > I recently had a problem with git push honoring the grafts file. It caused
> > it not to push all data required for a branch to the remote repository,
> > rendering it impossible to clone the remote repository (missing blobs)
> > 
> > This was with an not so fresh git version of 1.5.4.3 (ubuntu hardy).
> > 
> > Has this issue been fixed in later git version? I saw a thread talking
> > about it a long time ago (long before my release in question) on this
> > mailing list, but nothing was mentioned about if it was actually solved.
> > 
> > Regards
> > Joakim Plate
> 
> Bump, anybody know of a way to avoid this?

Don't use the grafts file. It is primary useful immediately after importing
some repository to Git when you need to clean up it a bit before fixing the
result by running git-filter-branch. Another usage of it is to add old history,
which is not part of the official repository. In the last case, you only add
a new parent, so it should not be a problem, except this addition is purely
local and any cloned repo will not have it.

> The problem even occurs on the
> local machine in that git gc will cleanup stuff that isn't required due to
> the grafts file, rendering the repo invalid if the graft file is removed.

It may happen only if your graft makes some part of history unreachable. And
as I said above, using the grafts file should be avoided wherever possible,
and graft that replaces or removes some parents should only be used if you
are going to run git-filter-branch after that.

> 
> I don't think running filter-branch on the git svn imported branches seems
> like a good idea. since that would also wreak havoc on any repo that pulls
> from mine (ie still private repo like usb stick or other dev machine).

If you migrate from SVN to Git and want to edit history after importing, you
should run filter-branch before making this repository public.  Re-writing
public history is always a bad idea, regardless how it is done. If you use
git-svn for bidirectional synchronization then you most like use grafts in
the way it was not intended to use...

> Imho, grafts shouldn't be honored on either push/pull/gc operations.

If git gc will not honor grafts then it may delete those that are referred
by grafts, which is clearly wrong. So, perhaps, what you really want is that
git-gc should consider grafts as an additional source of information rather
than replacement. (Actually, git-gc is high level wrapper over git-repack,
git-prune, etc, which should be changed.) Also, git-fsck needs to be changed
to consider grafts as an additional source of information...

Whether grafts should be completely ignored by push/pull is not completely
clear. Though it may be the best course of action, it is also confusing,
because git log and other commands show you one history, but something
different gets pulled or pushed. (So, anyone who inherited such a repo from
another co-worker is bound to a big surprise as to why pull/push do not
work correctly). Also, we have a single logic that creates packages, whether
it is packages for network transfer or local storage, but it should be
changed to work different based on whether it is local or non-local package.
So, it appears to me a lot of changes, but the end result will be still not
something what you really want to use for reliable storage...

IMHO, grafts should not be used at all except very rare cases like editing
an imported history before making it public.


Dmitry
