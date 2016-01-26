From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 17/19] mingw: avoid illegal filename in t9118
Date: Tue, 26 Jan 2016 15:35:34 +0100 (CET)
Message-ID: <53b4d33044a56b94837bba27441cb8467d1ef3ad.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:36:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4j4-000593-JL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966209AbcAZOf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:50324 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966119AbcAZOfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:43 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYtId-1aaZa02Ekd-00VkzI; Tue, 26 Jan 2016 15:35:35
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ArLayWzPE6czzC/hACyV+QpYqgqWUpVj15mj4NG3t6/qJpueVUa
 YJBzVPgCZaNjhVBtSfSTsA4lkCTMWGpXdl4vfZn630TPZbKSHMGlhBLMqNS97TdyvoNf3cX
 5UVQjij7W+ster05YObbQnGmGuY0mrZsxjyzOMOypqUG+PfQPgq0PUnmU/CT3YRjk8jkEZk
 KqHmqYQgyj/NpW3GXlkbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:veOidi69cPQ=:PicoGviwk58vjeWq/RcOKs
 zc3tF2zbfnKWpDdTDj805XB2qcdK/HXXRhJpw4rA1ON/IG5lXNq8re3FggaY7rh+5bqFZgDxL
 uJxqZb9LutZFuAoEteMhi0eEyPRLHQKwsu5z4iHcHqKH6L3qY737aBw/gU99P1+ZO8RVej0by
 vMxerQioPJKKg6jIh3P4UOg12rIXASRLhEWQU5EEvTAKZ7UWyimxWjlk+2E1lfkUV8bgQw6RT
 2/OEOV57aZRq5zbp42/d+eMb8+fwbVkixk/RXj0470J0TK6eVgTSM9xpVrpm5MKiU0D4bzWBk
 C/4xo2+hWFZ5+Pk2ZyrHu/BpMjKkHlFu7AN3jFkmiEbwDfHr0lO0Dk6BNnZ4u5J1nzwxrESfw
 /mjuaVQZ8drWzuFbRW0IQeNimz7eZJ7rPQcLYRBumlRHrzZ7/WY/CCHmx1AiR55L/OzlmmwGc
 W3whiujyjRl0DBfNQhNSYyAucGIuHO1iRsK23ITsy8UqV9lWMVE+JVoGOuQEQfJtTwzsD4DKw
 2vOZI0XiZ50kUzGqY6slsTQcn2dGP0uGtaZihpLoWhMhfW8ipA3txfeN8AQZ22JhwFJMaQqJ+
 HrFnL0w5JFTm10EWWPif0OVudg+TAbVyBXzNcyw97FuzQyumjyJJFV277a+O0LYcnJM9Jc53T
 XLt+0/aVV4QacRFcOzvoZsm8AoCYCd/O2UHKhVdYAbF/BlCLFYcjJdgkaPFfpeaLalzyRg6sr
 IY47CSFq63xjbCgw+nmsPISXWfLY/0QpAKwO8PolqlyXZd/twgha73W2wtVjIgzF/V7iY1xy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284830>

On Windows' file systems, file names with trailing dots are forbidden.
The POSIX emulation layer used by Git for Windows' Subversion emulates
those file names, therefore the test adding the file would actually
succeed, but when we would ask git.exe (which does not leverage the
POSIX emulation layer) to check out the tree, it would fail.

Let's just guard the test using a filename that is illegal on Windows
by the MINGW prereq.

This lets t9118-git-svn-funky-branch-names.sh pass in Git for Windows'
SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9118-git-svn-funky-branch-names.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index a221915..ecb1fed 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -23,8 +23,11 @@ test_expect_success 'setup svnrepo' '
 	              "$svnrepo/pr ject/branches/$scary_uri" &&
 	svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/.leading_dot" &&
-	svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
-			"$svnrepo/pr ject/branches/trailing_dot." &&
+	if test_have_prereq !MINGW
+	then
+		svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
+			"$svnrepo/pr ject/branches/trailing_dot."
+	fi &&
 	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
 	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
@@ -45,7 +48,10 @@ test_expect_success 'test clone with funky branch names' '
 		git rev-parse "refs/remotes/origin/more%20fun%20plugin!" &&
 		git rev-parse "refs/remotes/origin/$scary_ref" &&
 		git rev-parse "refs/remotes/origin/%2Eleading_dot" &&
-		git rev-parse "refs/remotes/origin/trailing_dot%2E" &&
+		if test_have_prereq !MINGW
+		then
+			git rev-parse "refs/remotes/origin/trailing_dot%2E"
+		fi &&
 		git rev-parse "refs/remotes/origin/trailing_dotlock%2Elock" &&
 		git rev-parse "refs/remotes/origin/$non_reflog"
 	)
-- 
2.7.0.windows.1.7.g55a05c8
