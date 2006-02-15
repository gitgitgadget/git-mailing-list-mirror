From: Shawn Pearce <spearce@spearce.org>
Subject: Re: "git reset --hard" leaves empty directories that shouldn't exist
Date: Wed, 15 Feb 2006 03:06:24 -0500
Message-ID: <20060215080624.GA27037@spearce.org>
References: <87y80dhxfd.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 09:06:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9HgH-00031e-4r
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 09:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWBOIG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 03:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423030AbWBOIG2
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 03:06:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56497 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423029AbWBOIG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 03:06:28 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F9Hg9-0003yO-Qb; Wed, 15 Feb 2006 03:06:25 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 778DF20FBA0; Wed, 15 Feb 2006 03:06:24 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Mail-Followup-To: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87y80dhxfd.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16220>

Carl Worth <cworth@cworth.org> wrote:
> I've been exploring the potential for git-sync, and I found some odd
> behavior with "git reset --hard". It appears that if the current tree
> has some directory structure (at least two levels deep) that does not
> exist in the tree being reset to, that empty directories are left
> around after the reset:
> 
> 	$ git --version
> 	git version 1.2.0.gf6e8
> 	$ git init-db
> 	defaulting to local storage area
> 	$ touch file; git add file; git commit -m "Add file"
> 	Committing initial tree df2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078
> 	$ git tag OLD
> 	$ mkdir -p a/b/c; touch a/b/c/foo; git add a/b/c/foo; git commit -m
> 	"Add foo"
> 	$ git checkout -b bogus
> 	$ git reset --hard OLD
> 	$ find a
> 	a
> 	a/b
> 	a/b/c
> 	$
> 
> Is this operator error? I don't see any extra options I might be
> missing in the documentation of git-reset.

Its not operator error.

I just dug though git-reset.sh in 1.2.0 and it won't cull
directories, only files.  Culling the directories is a little bit
on the ugly side obviously as you must cull bottom-up.  The perl
code which git-reset.sh is using to cull files definately won't
cull the directories.

No patch attached.  Maybe someone not on the east coast can write
one; I need to go catch some sleep.  :-)

-- 
Shawn.
