From: Paul Mackerras <paulus@samba.org>
Subject: git-rev-list problem with --max-age and --merge-order
Date: Thu, 16 Jun 2005 22:39:50 +1000
Message-ID: <17073.29462.564422.743677@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 16 14:35:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DitZy-0006p5-07
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 14:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVFPMjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 08:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVFPMjv
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 08:39:51 -0400
Received: from ozlabs.org ([203.10.76.45]:19644 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261662AbVFPMju (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2005 08:39:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9023867B91; Thu, 16 Jun 2005 22:39:48 +1000 (EST)
To: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have a version of gitk that draws stuff more-or-less as it receives
it from git-rev-list -- it reorders the commits somewhat but it
doesn't need to wait for the end of the output from git-rev-list
before it can draw anything.  To do that it passes --merge-order to
git-rev-list and relies on the property that parents will be listed
after all of their children.

I also want to make the default be to show the commits for the last 30
days.  However, using --max-age with --merge-order outputs many fewer
commits than I get if I use the same --max-age argument without
--merge-order.  For example, on the current linux-2.6 git tree,
git-rev-tree --max-age=1116330140 HEAD outputs 655 commits, whereas
git-rev-tree --merge-order --max-age=1116330140 HEAD only outputs 173
commits.  That date is 2005-05-17 21:42:20 in my timezone, about 30
days ago.  An example of a commit that isn't output with --merge-order
is 1e86d1c648508fd50e6c9960576b87906a7906ad:

Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>  2005-06-02 14:11:37
Committer: Linus Torvalds <torvalds@ppc970.osdl.org>  2005-06-03 01:19:27

[PATCH] ppc64: Fix result code handling in prom_init

Any ideas why using --merge-order means we don't see this one?  It's
certainly less than 30 days old.

Thanks,
Paul.
