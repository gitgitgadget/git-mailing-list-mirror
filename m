From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git merge bug: creating new files in one branch in a directory that is renamed in another
Date: Sun, 21 Jan 2007 03:44:06 -0500
Message-ID: <20070121084405.GB10632@spearce.org>
References: <45B3224B.3020800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 09:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8YJD-0006FV-ME
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 09:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAUIoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 03:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXAUIoL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 03:44:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32917 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbXAUIoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 03:44:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H8YIT-0004Db-Cz; Sun, 21 Jan 2007 03:43:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD3A020FBAE; Sun, 21 Jan 2007 03:44:06 -0500 (EST)
To: Liraz Siri <liraz.siri@gmail.com>
Content-Disposition: inline
In-Reply-To: <45B3224B.3020800@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37311>

Liraz Siri <liraz.siri@gmail.com> wrote:
> I'm running a few tests to figure out when git does the right thing on
> merges, and I've discovered that git does not do the right thing if you
> are creating new files in one branch in a directory that is renamed in
> another.

Well, it depends on your definition of "the right thing" as to
whether or not Git does it.  :-)
 
> Merging edits of files in dir/ in one branch and renaming dir/ to
> newdir/ in another branch works, but if you create files in the renamed
> dir/ then after the merge they will still remain in dir/, rather than
> newdir/.

Yes.  We don't actually track directories, we track contents of
files.  Renaming a directory in one branch and adding a file to that
directory in the other branch does not imply that after the merge
the new file belongs in the renamed location.  Nor does it imply it
should be in the old location, but that is where we currently put it.

We probably could modify merge-recursive to rename new files added
by the second branch if:

 - the file from the second branch does not exist in the merge base
 (hence it was added by the second branch);

 - the file from the second branch is located under a path where
 a prefix of directories exists within the merge base;

 - all files in the merge base under that path prefix were either
 deleted or renamed to the another path prefix by the first branch.

but I'm not sure how often that occurs in practice that its
worth implmenting, as the implementation is slightly non-trivial.
Especially since it needs to be done for both sides.

-- 
Shawn.
