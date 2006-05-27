From: Yann Dirson <ydirson@altern.org>
Subject: remaining git-cvsimport problems: relying on timestamps looses patchsets
Date: Sat, 27 May 2006 14:24:55 +0200
Message-ID: <20060527122455.GM6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 27 14:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjxeq-0002I4-2e
	for gcvg-git@gmane.org; Sat, 27 May 2006 14:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWE0MMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 08:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWE0MMh
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 08:12:37 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:16298 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751486AbWE0MMg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 08:12:36 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2B96027467
	for <git@vger.kernel.org>; Sat, 27 May 2006 14:12:35 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fjxqi-0006ly-Bl
	for git@vger.kernel.org; Sat, 27 May 2006 14:24:56 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20851>

I use git-cvsimport daily to sync from an inernal CVS repository at
work.  Occasionally (in fact, much too often ;), I notice that not all
patchsets were really imported into git (and thus I have to reimport
from scratch, update my graft file, migrate my stgit branches, which
is quite a tedious and time-consuming task).

The problem seems to stem from the fact that git-cvsimport decides
which patch to import based on commit dates, and that we cannot rely
on all machines being correctly time-synchronized.

It would seem much more reliable to keep track of the latest patchset
imported on each branch.  Now, maybe this option was considered
already, and rejected for various reasons.  I'd welcome any info on
this.

One such reason I can think about is that cvsps patchset numbers seem
to be currently the only way to identify a patchset, and those are not
guaranted to be stable from one cvsps release to the other - eg. I
hope the bug mentionned in previous mail there can be fixed some day,
and thus the fixed patchsets will have different numbers; or maybe
some day cvsps will deal better with the pseudo-revisions introduced
by RCS when adding a file on a branch.

So we have to be able to detect when the cvsps output has changed and
the git history is now possibly out of sync, or it would also be
possible to have a corrupted mirror of the cvs history.

For this, we would need to record some patchset information in the
imported commits - currently only the patchset number seems to make
sense, but if new cvsps releases can show the commitid's introduced in
cvs 1.12.x that would be of great help here.  Then we could validate
for each patchset whether we can find a commit with its patchset
number in the git history, and do some checks to assert this commit
corresponds to the expected patchset - until we have access to the cvs
commitid's, we can check that the files changed by the commit are the
same than those in the patchset.

Does that make sense to anyone, or am I completely off-track ?
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
