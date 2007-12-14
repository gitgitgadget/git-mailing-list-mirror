From: David Miller <davem@davemloft.net>
Subject: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 10:43:12 -0800 (PST)
Message-ID: <20071214.104312.103638776.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 19:43:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3FVb-0001Cf-5e
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 19:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbXLNSnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbXLNSnO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 13:43:14 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33751
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbXLNSnN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 13:43:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id DE24135C001
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 10:43:12 -0800 (PST)
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68324>


I've been seeing this for I think a week or two, and I can't figure
out if it's some local problem of mine.  I even reran the testsuite
with "PATH=$(pwd):$PATH" just in case it was picking up my existing
1.5.3.7 installation for some reason, but it still fails even in that
case.

Is the following a known issue?

*** t3200-branch.sh ***
*   ok 1: prepare a trivial repository
*   ok 2: git branch --help should not have created a bogus branch
*   ok 3: git branch abc should create a branch
*   ok 4: git branch a/b/c should create a branch
*   ok 5: git branch -l d/e/f should create a branch and a log
*   ok 6: git branch -d d/e/f should delete a branch and a log
*   ok 7: git branch j/k should work after branch j has been deleted
*   ok 8: git branch l should work after branch l/m has been deleted
*   ok 9: git branch -m m m/m should work
*   ok 10: git branch -m n/n n should work
*   ok 11: git branch -m o/o o should fail when o/p exists
*   ok 12: git branch -m q r/q should fail when r exists
*   ok 13: git branch -m q q2 without config should succeed
*   ok 14: git branch -m s/s s should work when s/t is deleted
*   ok 15: config information was renamed, too
*   ok 16: git branch -m u v should fail when the reflog for u is a symlink
*   ok 17: test tracking setup via --track
*   ok 18: test tracking setup (non-wildcard, matching)
*   ok 19: test tracking setup (non-wildcard, not matching)
* FAIL 20: test tracking setup via config
        git config branch.autosetupmerge true &&
             git config remote.local.url . &&
             git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
             (git show-ref -q refs/remotes/local/master || git-fetch local) &&
             git branch my3 local/master &&
             test $(git config branch.my3.remote) = local &&
             test $(git config branch.my3.merge) = refs/heads/master
* FAIL 21: avoid ambiguous track
        
                git config branch.autosetupmerge true &&
                git config remote.ambi1.url = lalala &&
                git config remote.ambi1.fetch = refs/heads/lalala:refs/heads/master &&
                git config remote.ambi2.url = lilili &&
                git config remote.ambi2.fetch = refs/heads/lilili:refs/heads/master &&
                git branch all1 master &&
                test -z "$(git config branch.all1.merge)"
        
*   ok 22: test overriding tracking setup via --no-track
* FAIL 23: no tracking without .fetch entries
        git branch --track my6 s &&
             test -z "$(git config branch.my6.remote)" &&
             test -z "$(git config branch.my6.merge)"
* FAIL 24: test tracking setup via --track but deeper
        git config remote.local.url . &&
             git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
             (git show-ref -q refs/remotes/local/o/o || git-fetch local) &&
             git branch --track my7 local/o/o &&
             test "$(git config branch.my7.remote)" = local &&
             test "$(git config branch.my7.merge)" = refs/heads/o/o
* FAIL 25: test deleting branch deletes branch config
        git branch -d my7 &&
             test -z "$(git config branch.my7.remote)" &&
             test -z "$(git config branch.my7.merge)"
*   ok 26: test deleting branch without config
*   ok 27: git checkout -b g/h/i -l should create a branch and a log
* failed 5 among 27 test(s)
