From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v5 1/2] git-prompt.sh: if pc mode, immediately set PS1 to a plain prompt
Date: Tue,  6 Jan 2015 20:22:26 -0500
Message-ID: <1420593747-24110-2-git-send-email-rhansen@bbn.com>
References: <xmqqwq4zmqpt.fsf@gitster.dls.corp.google.com>
 <1420593747-24110-1-git-send-email-rhansen@bbn.com>
Cc: j6t@kdbg.org, jess.austin@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 07 02:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8fKp-0000wW-JV
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 02:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbbAGBWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 20:22:51 -0500
Received: from smtp.bbn.com ([128.33.0.80]:56137 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325AbbAGBWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 20:22:49 -0500
Received: from socket.bbn.com ([192.1.120.102]:53257)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y8fKg-000Pre-VX; Tue, 06 Jan 2015 20:22:47 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BD56A3FFD2
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420593747-24110-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262124>

At the beginning of __git_ps1, right after determining that the
function is running in pc mode, set PS1 to a plain (undecorated)
prompt.  This makes it possible to simply return early without having
to set PS1 if the prompt should not be decorated.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/completion/git-prompt.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 729f769..b0de082 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -299,6 +299,10 @@ __git_ps1 ()
 			ps1pc_start="$1"
 			ps1pc_end="$2"
 			printf_format="${3:-$printf_format}"
+			# set PS1 to a plain prompt so that we can
+			# simply return early if the prompt should not
+			# be decorated
+			PS1="$ps1pc_start$ps1pc_end"
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
@@ -350,10 +354,6 @@ __git_ps1 ()
 	rev_parse_exit_code="$?"
 
 	if [ -z "$repo_info" ]; then
-		if [ $pcmode = yes ]; then
-			#In PC mode PS1 always needs to be set
-			PS1="$ps1pc_start$ps1pc_end"
-		fi
 		return
 	fi
 
@@ -412,9 +412,6 @@ __git_ps1 ()
 		else
 			local head=""
 			if ! __git_eread "$g/HEAD" head; then
-				if [ $pcmode = yes ]; then
-					PS1="$ps1pc_start$ps1pc_end"
-				fi
 				return
 			fi
 			# is it a symbolic ref?
-- 
2.2.1
