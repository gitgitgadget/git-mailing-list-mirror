From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 03:29:24 -0400
Message-ID: <20060614072923.GB13886@spearce.org>
References: <1150269478.20536.150.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 09:29:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqPou-0005OS-AU
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 09:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFNH3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 03:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFNH3k
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 03:29:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33221 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750799AbWFNH3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 03:29:40 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FqPod-0007KB-Lo; Wed, 14 Jun 2006 03:29:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7225D20FB20; Wed, 14 Jun 2006 03:29:24 -0400 (EDT)
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1150269478.20536.150.camel@neko.keithp.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21831>

Keith Packard <keithp@keithp.com> wrote:
> parsecvs scans every ,v file and creates a blob for every revision of
> every file right up front. Once these are created, it discards the
> actual file contents and deals solely with the hash values.
> 
> The problem is that while this is going on, the repository consists
> solely of disconnected objects, and I can't make git-repack put those
> into pack objects. This leaves the directories bloated, and operations
> within the tree quite sluggish. I'm importing a project with 30000 files
> and 30000 revisions (the CVS repository is about 700MB), and after
> scanning the files, and constructing (in memory) a complete revision
> history, the actual construction of the commits is happening at about 2
> per second, and about 70% of that time is in the kernel, presumably
> playing around in the repository.
> 
> I'm assuming that if I could get these disconnected blobs all neatly
> tucked into a pack object, things might go a bit faster.

What about running git-update-index using .git/objects as the
current working directory and adding all files in ??/* into the
index, then git-write-tree that index and git-commit-tree the tree.

When you are done you have a bunch of orphan trees and a commit
but these shouldn't be very big and I'd guess would prune out with
a repack if you don't hold a ref to the orphan commit.

-- 
Shawn.
