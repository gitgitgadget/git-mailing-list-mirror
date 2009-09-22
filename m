From: David Holmer <dholmer@persistentsystems.com>
Subject: gitk management of git diff-tree processes
Date: Tue, 22 Sep 2009 11:10:04 -0400
Organization: Persistent Systems
Message-ID: <1253632204.8531.78.camel@blackbird>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 18:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq7r1-0004rk-4a
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522AbZIVQDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbZIVQDl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:03:41 -0400
Received: from server18.pronicsolutions.com ([66.103.131.81]:52287 "EHLO
	server18.pronicsolutions.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932287AbZIVQDi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2009 12:03:38 -0400
X-Greylist: delayed 3214 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2009 12:03:38 EDT
Received: from pool-71-167-226-15.nycmny.east.verizon.net ([71.167.226.15]:50854 helo=[192.168.1.154])
	by server18.pronicsolutions.com with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <dholmer@persistentsystems.com>)
	id 1Mq70I-0001ir-US
	for git@vger.kernel.org; Tue, 22 Sep 2009 11:10:07 -0400
X-Mailer: Evolution 2.26.1 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server18.pronicsolutions.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - persistentsystems.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128944>

I find that if I am in gitk browsing through commits, gitk seems to be
spawning a git diff-tree process in order to display the changes and
patch file list in the bottom panes.

I have a certain commit that adds a very large amount of data to my
repository (1.2 GB). Understandably, the git diff-tree process that
tries to display the changes in this commit takes a VERY long time to
run (e.g. churns indefinitely).

The issue is that I find that if I simply browse past this commit (e.g.
using up/down arrows), gitk starts up a git diff-tree process and leaves
it running. As many times as I pass the commit (e.g. while looking at
changes before and after this commit), I end up with multiple processes
all running and my CPUs quickly go to 100%. Furthermore, even if I exit
gitk, all the git diff-tree processes keep running unless I manually
kill them.

Perhaps gitk could kill the git diff-tree process it spawns if its
output is no longer needed (e.g. user browses to a different commit, or
gitk exits).

Thank you,
David

$ ps -aF
UID        PID  PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
david    23635     1 18 88365 102892  0 10:49 pts/1    00:01:11 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23640     1 18 88368 102908  1 10:49 pts/1    00:01:10 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23644     1 16 88368 102904  0 10:49 pts/1    00:01:04 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23646     1 16 88367 102916  0 10:49 pts/1    00:01:04 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23652     1 17 88365 102892  1 10:49 pts/1    00:01:07 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23656     1 17 88368 102920  1 10:49 pts/1    00:01:06 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23660     1 16 88369 102932  0 10:49 pts/1    00:01:03 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23664     1 16 88368 102908  0 10:49 pts/1    00:01:03 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23670     1 16 88368 102904  1 10:49 pts/1    00:01:03 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23680     1 17 88365 102896  1 10:49 pts/1    00:01:05 git diff-tree -r -p --textconv -C --cc --no-commit-id -U3 8df50645c4cadf26dc951540e0c713b0826247b8
david    23851 10444  0   692  1032   0 10:56 pts/1    00:00:00 ps -aF

$ git version
git version 1.6.4.4

-- 
David G. Holmer, Ph.D.
dholmer@persistentsystems.com
CTO and Co-Founder
Persistent Systems, LLC
www.persistentsystems.com
Office: 212-561-5895
Mobile: 650-533-4964
Fax: 212-202-3625
