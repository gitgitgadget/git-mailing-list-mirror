From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git pull failure, truncated object
Date: Tue, 8 May 2007 10:59:16 -0400
Message-ID: <20070508145916.GQ11311@spearce.org>
References: <17984.35097.568689.482933@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlR9w-0005He-Tm
	for gcvg-git@gmane.org; Tue, 08 May 2007 16:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934139AbXEHO7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 10:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934156AbXEHO7U
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 10:59:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39020 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934139AbXEHO7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 10:59:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlR9k-0007sH-Sv; Tue, 08 May 2007 10:59:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8B79E20FBAE; Tue,  8 May 2007 10:59:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <17984.35097.568689.482933@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46584>

Bill Lear <rael@zopyra.com> wrote:
...
> error: failed to read delta-pack base object
> 4b93eb81265ea4f2b436618a4b1c3bea2bedf06d
> fatal: unpack-objects died with error code 1

Danger Will Robinson!  Danger!  Your repository is not acting
normally...

> So, I looked in the man page of git-gc and thought to try --prune,
> as this was not an active repository.  This worked, and then
> the pull did as well.

Don't run git-gc on a repository that is acting strangely, unless
you have concluded that the correct course of action is to just
repack the repository.  (It rarely is, btw.)  You could make things
worse if a packfile contains a corrupt object and you have the
same valid loose object; a gc would delete the valid object and
keep the corrupt one.

> I'm wondering why git-gc did not at least warn us of this problem when
> we tried it.  It appeared to us that git-gc gave our repo a clean bill
> of health, and so we turned our attention to the remote and
> investigated there, instead of continuing in the local repo.
> 
> Should we have tried git fsck instead in this case?

Yes, git-fsck is meant for checking the "health" of a repository.
In this case it should have caught the 0 length object and told
you that loose object was corrupt.  A sure sign that you have a
problem.  If you have a loose object problem, `git prune` might
fix it, as it did here, but only if that object isn't actually
needed.  A `git fsck` immediately after would tell you if the
prune fixed the issue, or not.

-- 
Shawn.
