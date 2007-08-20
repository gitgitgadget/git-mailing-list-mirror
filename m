From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to do a reverse rebase?
Date: Mon, 20 Aug 2007 01:58:09 -0400
Message-ID: <20070820055809.GZ27913@spearce.org>
References: <20070820053237.9349.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Aug 20 07:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0Hk-0003wK-67
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 07:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXHTF6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 01:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXHTF6P
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 01:58:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39707 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXHTF6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 01:58:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IN0HD-0007KG-C0; Mon, 20 Aug 2007 01:58:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D94D220FBAE; Mon, 20 Aug 2007 01:58:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070820053237.9349.qmail@science.horizon.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56172>

linux@horizon.com wrote:
> I don't want to rebase HEAD on *that*, but rather rebase *that*
> on top of the current HEAD.
...
> Currently, when I remember, I'll use git-cherry-pick and manually
> rename branches.
> 
> Is there an easier way?

I don't think so.  To do the merge of those files we need a working
directory to operate in; that working directory is the one you have.
It sounds like what you want is this:

	old=`git symbolic-ref HEAD` &&
	git checkout HEAD^0 &&
	git cherry-pick debug_hack &&
	git branch -f debug_hack HEAD &&
	git checkout $old

What's really needed is to avoid switching to the branch, as
you mentioned.  Instead switch to the --onto (implied or given
by user).  That way you can avoid updating a lot of files in the
working directory for no (compelling) reason.  Looking at the part of
git-rebase.sh that is affected by this (l.284-322) this is probably
not that difficult to improve.  Just a little bit of work to keep
track of everything.

Of course `git-rebase -i` is a completely different implementation,
so now you are also talking about l.409-480 of that.  Ick.

> Or should I just learn StGit?

Probably.  It handles patch stacks easier than core Git.  Or so I'm
told.  I find `git rebase -i` good enough for my needs, but it going
first to the debug_hack branch, then to the onto does sort of suck.

-- 
Shawn.
