From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 2/3] entry.c: checkout available submodules
Date: Fri, 25 May 2007 23:42:05 +0200
Message-ID: <20070525214205.GJ942MdfPADPa@greensroom.kotnet.org>
References: <1180127233729-git-send-email-skimo@liacs.nl>
 <1180127233893-git-send-email-skimo@liacs.nl>
 <20070525213103.GA8361@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri May 25 23:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrhY8-0006OZ-NM
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbXEYVmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbXEYVmJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:42:09 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:57869 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758381AbXEYVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:42:07 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIM003Q79M6DL@psmtp13.wxs.nl> for git@vger.kernel.org; Fri,
 25 May 2007 23:42:06 +0200 (MEST)
Received: (qmail 24740 invoked by uid 500); Fri, 25 May 2007 21:42:05 +0000
In-reply-to: <20070525213103.GA8361@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48423>

On Fri, May 25, 2007 at 11:31:03PM +0200, Martin Waitz wrote:
> I think the list tends to prefer subproject over submodule.

Does it?  It seems that everyone writing code is use submodule
instead of subproject.  Either way, I don't really care.

> > @@ -193,9 +220,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
> >  		 */
> >  		unlink(path);
> >  		if (S_ISDIR(st.st_mode)) {
> > -			/* If it is a gitlink, leave it alone! */
> >  			if (S_ISGITLINK(ntohl(ce->ce_mode)))
> > -				return 0;
> > +				return checkout_submodule(ce, path, state);
> >  			if (!state->force)
> >  				return error("%s is a directory", path);
> >  			remove_subtree(path);
> 
> I think the call to checkout_submodule should be moved to write_entry,
> to keep it in line with the other mode types.

Well, like your patch, this only deals with cases where the submodule
is already available.  In write_entry you could potentially clone
submodules based on some criteria, but I'm not doing this just yet
since some people apparently prefer to get these things in pieces.

Also, it seems that some people would like this to be a step
that is separated from git-checkout (see Lars' patch).

skimo
