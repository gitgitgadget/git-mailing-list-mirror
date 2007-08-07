From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during
 check-out
Date: Tue, 07 Aug 2007 10:51:49 +0200
Message-ID: <20070807085149.GH999MdfPADPa@greensroom.kotnet.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org>
 <20070805144632.GB999MdfPADPa@greensroom.kotnet.org>
 <46B76B8C.9050905@tromer.org>
 <20070806190344.GF999MdfPADPa@greensroom.kotnet.org>
 <46B7E5FE.7050006@tromer.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eran Tromer <git2eran@tromer.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 10:51:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIKnE-0003yo-SS
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 10:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796AbXHGIvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 04:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757863AbXHGIvv
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 04:51:51 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:36713 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757796AbXHGIvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 04:51:50 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JME00C5GBADAN@psmtp09.wxs.nl> for git@vger.kernel.org; Tue,
 07 Aug 2007 10:51:49 +0200 (MEST)
Received: (qmail 3730 invoked by uid 500); Tue, 07 Aug 2007 08:51:49 +0000
In-reply-to: <46B7E5FE.7050006@tromer.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55234>

On Mon, Aug 06, 2007 at 11:24:46PM -0400, Eran Tromer wrote:
> On 2007-08-06 15:03, Sven Verdoolaege wrote:
> >>>> Another approach is for pull, checkout etc. to automatically update the
> >>>> submodule' head ref, but no more.
> >>> Then everything, including "git submodule update", would assume
> >>> that the submodule is up-to-date.
> >> With that approach, "git submodule update" would fetch the submodule's
> >> head commit (which could be missing), and then check it against the
> >> submodule's index (and maybe its work tree).
> > And how is anyone supposed to figure out what HEAD the submodule's
> > index and working tree correspond to?
> 
> What HEAD corresponds to any other dirty index or dirty working tree?
> It's irrelevant and may not exist. You just have some random dirty state.

The only way to know that it's dirty is if you know the HEAD.
How can that not be relevant.

> > I can only hope that "git submodule update" would never blindly assume
> > that the submodule is clean and so the user would have to manually
> > sync the HEAD and the working tree.
> 
> Why would it assume that? In this approach, and ignoring submodule
> merging for now, "git submodule update" should mean roughly "cd
> submodule && git fetch HEAD && git reset --hard HEAD".

If you're doing that, then that is exactly what you are assuming.

> After all, this
> is really the only way to end up with the prescribed commit sha1.

That's the best way of losing all you precious changes in the submodule.
And there is no way to get them back!
Surely this is a lot worse than occasionally committing something you
didn't plan to commit, and only if you are performing a known "dangerous"
operation.

> I agree that for safety it makes sense to warn or abort if the index
> doesn't match ORIG_HEAD (saved by the supermodule checkout) or if the
> index doesn't match the work tree.

You may have done several supermodule checkouts since you last changed
the submodule.

skimo
