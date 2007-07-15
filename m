From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 16:11:41 +0200
Message-ID: <469A2B1D.2040107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 16:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4pE-0007aL-Uv
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 16:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbXGOOLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756521AbXGOOLu
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 10:11:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37400 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbXGOOLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 10:11:49 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6FEBfs8031273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 Jul 2007 16:11:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52558>

I've been reading the documentation for git-fast-import (thanks for the
fine documentation!) as part of determining how much work it would be to
add a git back end to cvs2svn, and I have a few questions.

1. Is it a problem to create blobs that are never referenced?  The
easiest point to create blobs is when the RCS files are originally
parsed, but later we discard some CVS revisions, meaning that the
corresponding blobs would never be needed.  Would this be a problem?

2. It appears that author/committer require an email address.  How
important is a valid email address here?

   a. CVS commits include a username but not an email address.  If an
email address is really required, then I suppose the person doing the
conversion would have to supply a lookup table mapping username -> email
address.

   b. CVS tag/branch creation events do not even include a username.
Any suggestions for what to use here?

3. I expect we should set 'committer' to the value determined from CVS
and leave 'author' unused.  But I suppose another possibility would be
to set the 'committer' to 'cvs2svn' and the 'author' to the original CVS
author.  Which one makes sense?

4. It appears that a commit can only have a single 'from', which I
suppose means that files can only be added to one branch from a single
source branch/revision in a single commit.  But CVS branches and tags
can include files from multiple source branches and/or revisions.  What
would be the most git-like way to handle this situation?  Should the
branch be created in one commit, then have files from other sources
added to it in other commits?  Or should (is this even possible?) all
files be added to the branch in a single commit, using multiple "merge"
sources?

5. Is there any significance at all to the order that commits are output
to git-fast-import?  Obviously, blobs have to be defined before they are
used, and '<committish>'s have to be defined before they are referenced.
 But is there any other significance to the order of commits?

All in all, I don't think that a git back end for cvs2svn would be very
trick at all.  There will be a bit of refactoring work to allow the user
to switch between SVN/git output at runtime, but so far I don't see any
reason that the fundamental algorithms of cvs2svn will have to be changed.

Thanks,
Michael
