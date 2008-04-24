From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Cleaning the .git directory with gc
Date: Wed, 23 Apr 2008 20:50:13 -0400
Message-ID: <20080424005013.GP29771@spearce.org>
References: <20080423231359.GA30913@fox> <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Haakon Riiser <haakon.riiser@fys.uio.no>, git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 02:51:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jopg4-0007gQ-Cp
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 02:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYDXAuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 20:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYDXAuS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 20:50:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56192 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYDXAuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 20:50:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jopf2-00024G-2B; Wed, 23 Apr 2008 20:50:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2EA6920FBAE; Wed, 23 Apr 2008 20:50:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80276>

Russ Dill <russ.dill@gmail.com> wrote:
> On Wed, Apr 23, 2008 at 4:13 PM, Haakon Riiser <haakon.riiser@fys.uio.no> wrote:
> > I've recently started using git, and while experimenting with
> >  git commit --amend, I noticed that git gc does not do what I
> >  expected.  Example:
> 
> Thats a lot of work without first reading the man page:
> 
>        --prune
>            Usually git-gc packs refs, expires old reflog entries, packs loose
>            objects, and removes old rerere records. Removal of unreferenced
>            loose objects is an unsafe operation while other git operations are
>            in progress, so it is not done by default. Pass this option if you
>            want it, and only when you know nobody else is creating new objects
>            in the repository at the same time (e.g. never use this option in a
>            cron script).

But even with `git gc --prune` the old commit object will still
be in your repository.

Why?  Both HEAD and your branch's reflog have a reference to the
old commit.  And those will remain in there for 90 days by default,
so that you could always go back and get that if you _really_
had to recover it.  Take a look with `git reflog show HEAD`
or `git log -g` and you'll see what I mean.

A commit is peanuts when it comes to disk space.  Don't worry
about it.  After a lot of amends and such you will be carrying
around only a few extra MBs.  In return for those few extra MBs
you are always able to recovery anything, up to 3 months back.

If you _really_ need to whack all of that away, make a clone
and then discard the old one, e.g.:

	git clone file://`pwd`/old_proj new_proj

Note you need to use the file:// URI syntax to prevent Git from
just hardlinking everything.  It takes a little longer, but the
resulting new_proj will be cruft free.

-- 
Shawn.
