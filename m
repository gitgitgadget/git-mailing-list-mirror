From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: git filter-branch --subdirectory-filter, still a mistery
Date: Wed, 6 Aug 2008 15:39:50 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200808061539.50268.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 15:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQjN0-0004Le-VE
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 15:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbYHFNqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 09:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbYHFNqv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 09:46:51 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:40484 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753628AbYHFNqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 09:46:50 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Aug 2008 09:46:50 EDT
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Aug 2008 15:40:36 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 06 Aug 2008 13:40:36.0834 (UTC) FILETIME=[01F4E420:01C8F7CA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91510>

Hi,

I've been puzzling most of today to do something that must be simple.
I've got a big repo which contains a project with several nicely related
subprojects in directories. Only now, we want to share some of these
subprojects with another project. I.e. they must start to live there own
life. Of course, I would like to keep the history. So, I did (git --version:
1.5.6.GIT):

	% git clone /home/git/pl.git
	% cd pl
	% git filter-branch --subdirectory-filter packages/chr HEAD

This indeed creates a nice directory holding only the contents of
packages/chr.  But, starting qgit I see that all commits, also those
that had absolutely nothing to do with this dir are still there.  Also,
all tags are still there with exactly the same SHA1 as the original.
I'd expect the tags to be rewritten such that their SHA1 refers to the
state of this single directory and its contents!?  Of course, these
tags give me access to everything, so the repository doesn't shrink
much too.

I must be missing something important ...  I found similar complaints,
but few decent answers and the few answer I did find appeared outdated.
The one at http://use.perl.org/~rjbs/journal/34411 comes closest, although
the reset --hard is no longer needed and the copying and gc-ing doesn't
help much anymore.

Should I write a tree-filter that removes all but the directory I want 
to keep?  I.e. something like this?  Feels like and overkill and I fear
I'll have a lot of empty commits left.

	'mv packages/chr .. && rm -r * && mv ../chr/* . && rmdir ../chr'

I'll be grateful for a clue!

	Cheers --- Jan
