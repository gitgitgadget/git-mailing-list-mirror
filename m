From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] rebase -i: do not leave a =?UTF-8?Q?CHERRY=5FPICK?=
 =?UTF-8?Q?=5FHEAD=20file=20behind?=
Date: Thu, 18 Jun 2015 13:44:48 +0200
Organization: gmx
Message-ID: <23bb1e151564cdc0249735b3c5f28ea441a5a907.1434627492.git.johannes.schindelin@gmx.de>
References: <cover.1434528725.git.johannes.schindelin@gmx.de>
 <cover.1434627492.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 13:45:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5YFe-0004Fa-Qq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbbFRLoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:44:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:63429 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbbFRLow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:44:52 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MhQxO-1ZR5Gs3Kjq-00MbnW; Thu, 18 Jun 2015 13:44:48
 +0200
In-Reply-To: <cover.1434627492.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:QgT/vjOZfK9xF28IPdKNJ+3H1DSCpXDjoec3NGUy3LxsCM06051
 4JC4jUee7ChdDaqoUlPW/YRO5w4yBGWfY2wqxfVMhRrVeJnOUNDGo0oo8C5qqLs9iwMX5HG
 A/z3a/cKynXxuOaX6r/QhFH6OA9yKjrfIjiQlc4WFDFod/HHePkwG/lt4h815d2RiRpn4l8
 AsIi096gTIxSu7FBSG6Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qh9i5JxQVT0=:ZGGDyQ6p8WN5qTLC1DMCKR
 Uryq2wfelzEMHtq6XRjY0roT5Y7th3Y90QfFP8PtjGK9liXBxKKPZBjyBaIipbaERarRB95wc
 omGHqvxaUPobjq9PoM2bedvLwntvujvydXIA5wcElmvr22bGGtlyikmoibbiItS9rLpNeoo+v
 QFAthrEHKO3ci+kY81bZSzn4i0lYycm19W/TIERqT3lQzVCM897Bx9okIZQnLbj90kbnlk5jn
 zijEIzG0TZMFvHLZiY1GpiwpPB4gWXWQh60YzpYNnl2vnmypJi3C9nYfYUlPsfQll0V9pSYS9
 Le37aX6Aul5GTmxvOZaPup6FePu4Zqv7+nk/WM9YmiL3i9Y3fY/idVc7j/3ovU3Hd7+zIchZB
 ucxMbt8acnEwQ1ERP47KuAPmC42H+73otzuFz0FCrMDENxCIc8eHC5Lv7TT+fLS2B1txSqVIg
 bxxLG6iNHTmw1K09pBE999lfwLpQ12RM1J2VTiyFZYZDGXG8aNtTKTNXUn24U6gBw/Qqlg89U
 SM12fhFjJRv+XRAGvnLXkIJBBajgI+2mo6OvQJLD1n2AcphS3uGYXgsvuqGGHQ+MWOojzx6hl
 wQFSAOmGjy8jsihhk86doo2nAmcn2FDRfGAVODgcygDlCkjcW/VsKMW5kGHWP0ycNDWqwXXyV
 dVCkDOUXwh0S2q0Wj6GzbgwN+OZlMQ0BMSOctbCTEvHSdKyCY2dOx3uPj6uRa3lEND9E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272000>

When skipping commits whose changes were already applied via `git rebase
--continue`, we need to clean up said file explicitly.

The same is not true for `git rebase --skip` because that will execute
`git reset --hard` as part of the "skip" handling in git-rebase.sh, even
before git-rebase--interactive.sh is called.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    | 6 +++++-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..5ff0f1c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -849,7 +849,11 @@ continue)
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
 	then
-		: Nothing to commit -- skip this
+		# Nothing to commit -- skip this commit
+
+		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+		die "Could not remove CHERRY_PICK_HEAD"
 	else
 		if ! test -f "$author_script"
 		then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e5e7744..f3337ad 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,7 +1102,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
 '
 
-test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
+test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 	git checkout -b commit-to-skip &&
 	for double in X 3 1
 	do
-- 
2.3.1.windows.1.9.g8c01ab4
