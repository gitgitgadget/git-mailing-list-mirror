From: Thomas Rinderknecht <thomasr@sailguy.org>
Subject: Minor bug with git sparse checkout code
Date: Sun, 7 Nov 2010 16:47:13 +0000 (UTC)
Message-ID: <loom.20101107T172926-284@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 17:50:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF8Rc-0007nU-U0
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 17:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab0KGQuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 11:50:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:42638 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab0KGQuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 11:50:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PF8RR-0007jJ-QB
	for git@vger.kernel.org; Sun, 07 Nov 2010 17:50:06 +0100
Received: from pool-96-225-233-249.ptldor.fios.verizon.net ([96.225.233.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 17:50:05 +0100
Received: from thomasr by pool-96-225-233-249.ptldor.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 17:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 96.225.233.249 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.10 (maverick) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160887>

Hello,

First, let me begin by just saying thanks to all the git developers. We switched
from cvs to git a few months ago, and it really is working well for us now that
we have overcome the initial learning curve.

We make extensive use of the sparse checkout functionality because our
repository is large and most developers don't need to see the entire source
tree. Using sparse checkout helps reduce disk usage, and also helps maintain
reasonable performance for commands such as "git status" that tend to get bogged
down when talking to slow network storage appliances.

I found what appears to be a bug in the sparse-checkout code. I am more than
happy to file a bug report on a bug tracking website, but I couldn't find one
with a quick web search. I hope that it is acceptable to post the bug report
here. Please let me know if further information is required, or if there is a
better way to file the bug report.

Short description of the problem:
---------------------------------
We have two subdirectories with similar names, for example "libs/lib1", and
"libs/lib1a". We want to check out just "libs/lib1". The sparse-checkout file
contains only a single line "libs/lib1/", but git still checks out both
subdirectories (it appears to be doing a partial match)

Sequence for reproducing the bug:
---------------------------------
(1) create a repository with similar directory names
mkdir /tmp/git_bug
cd /tmp/git_bug
git init
mkdir a1
touch a1/base
mkdir a1-extra
touch a1-extra/more
git add .
git commit -m "test"

(2) clone the repository, but don't check out the files
mkdir /tmp/git_bug2
cd /tmp/git_bug2
git clone -n /tmp/git_bug .
git config core.sparsecheckout true
echo "a1/" .git/info/sparse-checkout
git checkout
ls
<you should see that both a1 and a1_extra are checked out>

Note: We are currently using git version 1.7.2.3 ... I have not verified the bug
using the latest developmental code. Please accept my apologies if the issue has
already been addressed.

Thanks again,

Thomas R.
