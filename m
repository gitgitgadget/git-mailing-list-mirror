From: Chris Ball <ceball@users.sourceforge.net>
Subject: Interrupted git-svn dcommit, now I get segmentation faults
Date: Thu, 21 Feb 2008 06:49:33 +0000 (UTC)
Message-ID: <loom.20080221T062522-821@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 07:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS5LT-0004fs-Ax
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 07:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbYBUGzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 01:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbYBUGzK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 01:55:10 -0500
Received: from main.gmane.org ([80.91.229.2]:52092 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437AbYBUGzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 01:55:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JS5Kg-0007Pk-RH
	for git@vger.kernel.org; Thu, 21 Feb 2008 06:55:02 +0000
Received: from 221.201.160.146 ([221.201.160.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 06:55:02 +0000
Received: from ceball by 221.201.160.146 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 06:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 221.201.160.146 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8.0.13pre) Gecko/20071126 Ubuntu/dapper-security Firefox/1.5.0.13pre)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74604>

Hi,

I mistakenly interrupted a git-svn dcommit, and now whenever I run
git-svn dcommit I get a segmentation fault, but the commit is
successful. I have just switched from Subversion to Git, so I'm not
sure what to do (and probably using Git in a clumsy way).

How I caused the problem:

$ git commit -m "msg" path/to/file
Created commit bee0414: msg
 1 files changed, 6 insertions(+), 0 deletions(-)
$ git-svn dcommit
Committing to https://svn/repository ...
	M	path/to/file
Committed r8041
# ** Interruption with ctrl-c happened right at this point **


git diff still showed the change on my machine, so I ran git-svn dcommit
again:

$ git-svn dcommit
Committing to https://svn/repository ...
Merge conflict during commit: Your file or directory 'path/to/file' is
probably out-of-date: The version resource does not correspond to the
resource within the transaction.  Either the requested version
resource is out of date (needs to be updated), or the requested
version resource is newer than the transaction root (restart the
commit). at /usr/bin/git-svn line 420


Checking the SVN repository itself, I found the commit was actually
successful (in that it appears as normal in the SVN respository). I
deleted my copy of the file, ran 'git-svn rebase', and then used 'git
checkout path/to/file. This gave me seemingly the correct version
(i.e. with the updates).

This would all be ok, except that now, whenever I git-svn dcommit
anything, this happens:

$ git-svn dcommit
Committing to https://svn/repository ...
	M	path/to/different/file
Committed r8044
Segmentation fault

The commit is successful (i.e. appears in the SVN repository).

Can anyone suggest what I should do? I still have a full transcript
of the session in case that will help. 

I'm using Ubuntu 6.06 LTS. My versions of git, git-svn, and svn (all
from Ubuntu packages):

$ git --version
git version 1.5.3.6
$ git-svn --version
git-svn version 1.5.3.6 (svn 1.3.2)


Thanks very much for any help,

Chris
