From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t7502-commit.sh: rearrange test to make more portable
Date: Tue, 22 Jul 2008 16:21:10 -0500
Message-ID: <Koa4iojOlOQ_YENPwWXKt7G8Aa1x6UaBnFFtliKdZmpcrrqOBhY7NQ@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPJa-0001NL-BI
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYGVVVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbYGVVVd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:21:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42889 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYGVVVc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:21:32 -0400
Received: by mail.nrlssc.navy.mil id m6MLLAwb021962; Tue, 22 Jul 2008 16:21:10 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:21:10.0454 (UTC) FILETIME=[DCAE6D60:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89539>


Some shells have problems with one-shot variable assignment notation
and function calls. The sequence is rearranged to avoid the one-shot
and to allow the test script to be linked together with '&&'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7502-commit.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index c25eff9..ad84c3d 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -228,10 +228,12 @@ EOF
 
 test_expect_success 'a SIGTERM should break locks' '
 	echo >>negative &&
-	"$SHELL_PATH" -c '\''
+	! "$SHELL_PATH" -c '\''
 	  echo kill -TERM $$ >> .git/FAKE_EDITOR
-	  GIT_EDITOR=.git/FAKE_EDITOR exec git commit -a'\'' && exit 1  # should fail
-	! test -f .git/index.lock
+	  GIT_EDITOR=.git/FAKE_EDITOR 
+	  export GIT_EDITOR
+	  exec git commit -a'\'' &&
+	test ! -f .git/index.lock
 '
 
 rm -f .git/MERGE_MSG .git/COMMIT_EDITMSG
-- 
1.6.0.rc0.38.g8b8fb7
