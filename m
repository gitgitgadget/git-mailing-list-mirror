From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: committing empty diffs
Date: Mon, 12 Feb 2007 15:10:57 -0500
Message-ID: <20070212201057.GC30440@spearce.org>
References: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com> <20070212200324.GB30440@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhWw-0000k4-3c
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbXBLULJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbXBLULI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:11:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37978 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965279AbXBLULH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:11:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGhVk-0001fl-6j; Mon, 12 Feb 2007 15:10:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D4C3D20FBAE; Mon, 12 Feb 2007 15:10:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070212200324.GB30440@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39431>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Don Zickus <dzickus@gmail.com> wrote:
> > Considering git-commit doesn't allow this (probably for good reason),
> > is it technically safe to do the following sequence of events?
> > 
> > tree=$(git-write-tree)  #basically the same tree HEAD points to
> > commit=$(echo $IDEAS | git-commit-tree $tree -p HEAD)
> > git-update-ref HEAD $commit HEAD

This can also be written shorter, and safer:

	head=$(git-rev-parse --verify HEAD^0)
	commit=$(echo $IDEAS | git-commit-tree $head^{tree} -p $head)
	git-update-ref HEAD $commit $head

The reason you do it like this is it prevents a HEAD which was
modified between the time you did git-commit-tree and git-update-ref
from being lost.

And the write-tree is completely unnecessary, and might actually
write out a dirty-index, which would make your ideas commit actually
modifying files - not what you wanted.

-- 
Shawn.
