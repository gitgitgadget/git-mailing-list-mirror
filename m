From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] rebase -i: do not leave a =?UTF-8?Q?CHERRY=5FPICK?=
 =?UTF-8?Q?=5FHEAD=20file=20behind?=
Date: Thu, 18 Jun 2015 18:38:53 +0200
Organization: gmx
Message-ID: <bf1954a4447bcf99c27a566a10cb0b311221135f.1434645436.git.johannes.schindelin@gmx.de>
References: <cover.1434627492.git.johannes.schindelin@gmx.de>
 <cover.1434645436.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 18:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cqd-0002h0-DR
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbbFRQjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 12:39:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:60016 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756151AbbFRQi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:38:59 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M7YF5-1Yt1lS2Khj-00xJW6; Thu, 18 Jun 2015 18:38:53
 +0200
In-Reply-To: <cover.1434645436.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:i3V3yBMM2C97Uy9RUFKOeSqFXQLwaNVaviLoxjHAKvbQcJ69xrI
 VTfEy7Ki0CLA9ZYd7xWoy8FNGqp0VX1DbNIwu9KuBETF/i16G0iYwzh+A7lDTcWe2Y1tAMo
 M0HI8kbGNV6xGiQv4xk8wXDkAVQZHARxxZ8YPf70uOMzCp0Ovr3ICBsNL5O1nc7qAJD7NWO
 g3ZzKOrDWczH5FIIB56xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cLlrsaBaZbM=:F4FM48ALleWtB3UWVFWVkQ
 bh/YhtPWC1phOheBjrEJGQBTbR0/1TSvQeQmAkDHUtFFW93HXi5EoaveKPEAaP21y65Dflzwx
 raHxOXNVZssi10XoOOuh+kgDKdJmpo4RavEWpKs220OZZu4QCGWxvQydYIHchHd5JqNY+Z5AH
 04tUaZ5MhkDRJtmHjEQrmmhZB6BMMkpmr4UtOUjaEU4VWOFAjrALbk3Nq4bG7SnuZr+DhUZqk
 oIt26xaFVTd6TtS/YqipRqQOJdL9OxXSrPWc0XddR/9CVpHuWUXoEikmm5k66n6kjMPw5M50m
 x047CQZn9/cGGVg6rzZhiPyxDfZF/aYQHq+7K4BwbFSUX6TdGCU9BZxTsnt7D+YGvBssh/8MD
 bMwvfXJMA9Dx1Lr/6OlObMLKEByeLRLNCS4oKh2SBFuAsqO3FeNqWeWtxmMUVq6qVyaebEsAu
 1JNb12sz30aCwIvNa2LKUeimNVVj+Adbrx+9ERiOy6BIwUIow+qC7eFI/Txq+Cjyfy4VQKfWS
 8ph9EefyepD70v8Y4Rp6muSlXEtgHPPTei/h0WnORFN4HoJtxuF5sbGcdzH/XOxxcQO551Pr9
 5XLkN/ev3hbeb0/VW/joKaUC86opI1nA1tTTTOe+MbhW1J9oELaARvElSSuvUesGGFOGfoleB
 p3ISo7zK4p5xyiv8Q22+vxvnGt3V3rNjgwToedvGQpnL0FIl1iZDg4MkpvXHFQW3e/Qw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272026>

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
index 6fe6c47..6bcf18b 100755
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
