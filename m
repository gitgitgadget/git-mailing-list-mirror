From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: darcs2git.py - convert darcs repository using gfi
Date: Sun, 11 Feb 2007 20:14:01 -0500
Message-ID: <20070212011401.GK31488@spearce.org>
References: <eqoaf7$loq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 12 02:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGPlr-0006lt-0Q
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 02:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbXBLBOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 20:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbXBLBOI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 20:14:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55383 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594AbXBLBOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 20:14:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGPlQ-0006G3-WD; Sun, 11 Feb 2007 20:13:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D641620FBAE; Sun, 11 Feb 2007 20:14:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eqoaf7$loq$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39347>

Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> The python script attached is a try at providing a sane
> conversion from Darcs to GIT.  It tries to map darcs conflict
> resolutions onto git branch merges.

Impressive.
 
> Regarding GFI, it's a breeze to work with; my compliments to its
> author.

Hey, thanks!  ;-)

> My only gripe is the need to specify a branch for each commit.
> Darcs uses changeset based storage. It doesn't really have branches,
> but it does record divergent changes and merges of resulting
> conflicts.  Hence, it's not clear which refs/head/BRANCH should be
> used when creating a commit object.

Just make something up.  Or don't use refs/heads, instead use your
own directory e.g. refs/patches/.  Then you can delete the entire
directory when you are done importing.

> So, my feature request: please make the "commit" command always accept
> a "from" command

This restriction was a safety valve.  fast-import itself would be
OK if I permitted a from all of the time.  A bug in cvs2svn caused
multiple froms to be emitted for the same branch, and that wasn't
correct, so fast-import crashed on it rather than silently accepting
the data corruption.

Its actually one of those things that is nice to remove, as its 3
lines of code that just need to be deleted.  ;-)

> and make the "refs" argument optional.

This is harder than it sounds.  fast-import internally is built
around the assumption of a branch, which has a name, and which lives
in the branch LRU.  With the "from" command restriction lifted
you can just import every single commit onto the same hardcoded
branch name (e.g. DARCS_HEAD) then delete it when you are done
(e.g. rm .git/DARCS_HEAD).  That's basically the same thing as an
optional ref argument.

-- 
Shawn.
