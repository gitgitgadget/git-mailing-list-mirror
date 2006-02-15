From: Shawn Pearce <spearce@spearce.org>
Subject: Re: StGIT refreshes all added files - limitation of git-write-tree?
Date: Wed, 15 Feb 2006 01:28:14 -0500
Message-ID: <20060215062814.GA26632@spearce.org>
References: <1139978528.28292.41.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 07:28:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9G9F-0002FZ-4N
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 07:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbWBOG2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 01:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWBOG2S
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 01:28:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:19883 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423004AbWBOG2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 01:28:18 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F9G9A-0002fQ-IP; Wed, 15 Feb 2006 01:28:16 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 6F50B20FBA0; Wed, 15 Feb 2006 01:28:14 -0500 (EST)
To: Pavel Roskin <proski@gnu.org>
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1139978528.28292.41.camel@dv>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16215>

Pavel Roskin <proski@gnu.org> wrote:
> Or maybe git-write-tree and other utilities could be changed to work on
> a copy of the index file?  I would prefer not to move the
> actual .git/index away, but to make a copy for the current "stg refresh"
> operation.

git-write-tree pays attention to the GIT_INDEX_FILE environment
variable; if this, GIT_DIR and GIT_OBJECT_DIRECTORY are set you can
redirect git-write-tree to look at a different index.  One way to
create a tree from a mixture of your current index and the current
HEAD's tree is to set GIT_INDEX_FILE to a temporary file name
(which doesn't exist), use git-read-tree to load the current tree
unmodified into that index, copy the modified records of interest
from the current index to the temporary index, then git-write-tree
from the temporary index.  But now you need to update your current
index with the real SHA1s of the written files.

Somewhat convoluted.  I think that git-commit.sh and cg-commit.sh
play such games to do partial commits based on what the user has
passed on the command line or modified in their editor (which is
actually a rather cool feature of Cogito).  I'm using a similar
trick in pg to load binary objects from a patch directory (for a
specific use case that I have).  git-am.sh uses a similar trick
to perform a 3 way merge if git-apply fails.

-- 
Shawn.
