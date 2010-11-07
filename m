From: Thomas Rinderknecht <thomasr@sailguy.org>
Subject: Re: Minor bug with git sparse checkout code
Date: Sun, 7 Nov 2010 17:19:27 +0000 (UTC)
Message-ID: <loom.20101107T181452-152@post.gmane.org>
References: <loom.20101107T172926-284@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 18:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF8uB-0005j6-II
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 18:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab0KGRTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 12:19:41 -0500
Received: from lo.gmane.org ([80.91.229.12]:38940 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab0KGRTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 12:19:40 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PF8u3-0005g5-0S
	for git@vger.kernel.org; Sun, 07 Nov 2010 18:19:39 +0100
Received: from pool-96-225-233-249.ptldor.fios.verizon.net ([96.225.233.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 18:19:38 +0100
Received: from thomasr by pool-96-225-233-249.ptldor.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 18:19:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 96.225.233.249 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.10 (maverick) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160889>

Hello,

The description of the bug in my previous e-mail was correct, but the 2nd part
of steps for replicating the bug were incorrect.  Please use the following
sequences to reproduce the bug (this time I actually verified it completely...)

(1) create the reference repository (same as previous e-mail)
mkdir /tmp/git_bug
cd /tmp/git_bug
git init
mkdir a1
touch a1/base
mkdir a1-extra
touch a1-extra/more
git add .
git commit -m "test"

(2) replicate the bug
cd /tmp/git_bug2
git clone -n /tmp/git_bug .
git config core.sparsecheckout true
echo "a1/" > .git/info/sparse-checkout
git read-tree -u -m HEAD
ls

The previous example was using "git checkout" instead of "git read-tree", and
the "echo" command was missing an output redirect operator. It actually was
checking out both directories, but for the wrong reason. With this example, if
the two directories are named as shown, they both get checked out, but if you
modify step (1), and name the other repository as "b1-extra", then only the "a1"
directory gets checked out in step (2).

Sorry about the confusion..
