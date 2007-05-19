From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 15:05:42 +0200
Message-ID: <20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
References: <11795163053812-git-send-email-skimo@liacs.nl>
 <11795163061588-git-send-email-skimo@liacs.nl>
 <20070518215312.GB10475@steel.home>
 <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
 <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 15:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpOd5-0006zr-C9
	for gcvg-git@gmane.org; Sat, 19 May 2007 15:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbXESNFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 09:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbXESNFp
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 09:05:45 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:56815 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbXESNFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 09:05:44 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIA00EZMHPJGU@psmtp13.wxs.nl> for git@vger.kernel.org; Sat,
 19 May 2007 15:05:43 +0200 (MEST)
Received: (qmail 7679 invoked by uid 500); Sat, 19 May 2007 13:05:42 +0000
In-reply-to: <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47747>

On Fri, May 18, 2007 at 08:59:48PM -0700, Junio C Hamano wrote:
> Now, suppose "git checkout" needs to recurse into one
> subdirectory that is to have a subproject.  There are three
> cases:
> 
>  (1) There is no git repository yet (the plumbing layer already
>      makes sure there is a directory, but does not do anything
>      else).
> 
>  (2) There already is a git repository there, which is the
>      correct repository (perhaps determined by .gitmodules and
>      .git/config in the superproject, or presense of the commit
>      that is recorded in the superproject's index).
> 
>  (3) There is a git repository but it is not the correct one.
> 
> We've discussed in the other thread about what to do in case
> (1) to some degree.
> 
> For case (2), I think what should happen there is an equivalent
> of this:
> 
> 	$ commit=$(git-rev-parse :subproject)
>         $ cd subproject
> 	$ git-rev-parse --verify $commit || git fetch || barf
>         $ git checkout $commit

Does everyone agree that we should fetch (possibly after asking
for confirmation from the use) _during_ the checkout ?
I now only fetch submodules during a fetch of the supermodule
(actually, in my current patch set, I only fetch a submodule
the first time I see it, but that's a bug), but if there is
a consensus on this, I can switch to fetching during checkout.

As to the key to use to lookup the URL in the config, right
now I simply use the directory name where it is attached
(which seems like a useful default to me).
I'm not all that convinced that we should store a default URL
in history, so AFAICS, the only thing we need to store is a
mapping between directory names and subproject names.
It has been suggested to do that in .gitattributes.
Is that OK for everyone, or do we really need a separate .gitmodules ?

skimo
