From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/5] Simplify setup of $GIT_DIR in git-sh-setup.sh
Date: Mon, 18 Feb 2008 11:44:19 +0100
Message-ID: <1203331463-13857-2-git-send-email-hjemli@gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 11:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR3XT-0004QX-1X
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 11:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759136AbYBRKqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 05:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759137AbYBRKqt
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 05:46:49 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:52828 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759126AbYBRKqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 05:46:48 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m1IAjYWJ026988;
	Mon, 18 Feb 2008 11:45:37 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
In-Reply-To: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74262>

Using 'git rev-parse --git-dir' makes the code shorter and more future-
proof.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-sh-setup.sh |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f388275..a44b1c7 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -127,20 +127,14 @@ get_author_ident_from_commit () {
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
 then
+	GIT_DIR=$(git rev-parse --git-dir) || exit
 	if [ -z "$SUBDIRECTORY_OK" ]
 	then
-		: ${GIT_DIR=.git}
 		test -z "$(git rev-parse --show-cdup)" || {
 			exit=$?
 			echo >&2 "You need to run this command from the toplevel of the working tree."
 			exit $exit
 		}
-	else
-		GIT_DIR=$(git rev-parse --git-dir) || {
-		    exit=$?
-		    echo >&2 "Failed to find a valid git directory."
-		    exit $exit
-		}
 	fi
 	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
 		echo >&2 "Unable to determine absolute path of git directory"
-- 
1.5.4.1.188.g3ea1f5
