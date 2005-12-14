From: Len Brown <len.brown@intel.com>
Subject: new file leaked onto release branch
Date: Wed, 14 Dec 2005 02:57:03 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200512140257.03975.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 14 08:55:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmRST-0004sD-1T
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 08:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLNHxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 02:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVLNHxt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 02:53:49 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:58277 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932083AbVLNHxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 02:53:48 -0500
Received: from intel.com (c-24-63-232-79.hsd1.ma.comcast.net[24.63.232.79])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005121407534701300c7dobe>; Wed, 14 Dec 2005 07:53:47 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13620>

I'm suspecting that this issue is technically a pilot error of me issuing
git-updated-index at the wrong time, but perhaps the list
should be aware of this type of issue.  And perhaps somebody
can suggest a better work flow that is immune to this?

Somehow a new file leaked from my "acpica" branch onto my "release" branch
without me pulling "acpica" into "release".

I use the latest git and I follow Tony's Documentation/howto/using-topic-branches.txt.

The new file, rsinfo.c,  was added in one of the patches in the acpi branch,
but then was sucked into the release branch in this commit:
9115a6c787596e687df03010d97fccc5e0762506
which is on the release.broken branch of this tree:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git

Even though the file didn't exist on either of the parents of the merge.

I think I probably did a git-update-index while working on the acpica
branch, and then git remembered that while I was on the release branch
doing a routine pull from linus to make sure I was up-to-date before
doing a push to kernel.org.

why did I do this?

I use quilt to manage a stack of patches in my repo.
I like to build them on several build machines (i386, x86_64, ia64)
before doing a git commit.

I package up a tar-file for the remote machines with
git-tar-tree $BRANCH $REPO | gzip -1 > $TARFILE
But I still need to generate a patch containing all the local
changes that I haven't checked into git yet.

git diff > my.patch
does this for me.  But when it failed to pick up a new file,
I manually did a git-update-index --add IIR, and that seems
to be how rsinfo.c got sucked into the subsequent git pull from linus.

perhaps somebody has a better idiom for packaging up a  current
working tree for a remote build machine to crunch on it?

thanks,
-Len
