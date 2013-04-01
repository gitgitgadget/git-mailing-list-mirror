From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] submodule summary: support --summary-limit=<n>
Date: Mon, 01 Apr 2013 15:06:27 +0200
Message-ID: <51598653.5030001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Ping Yin <pkufranky@gmail.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 01 15:07:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMeS1-0001uP-86
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 15:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683Ab3DANGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 09:06:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:50780 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab3DANGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 09:06:36 -0400
Received: from [192.168.2.105] (p4FFD8EC0.dip.t-dialin.net [79.253.142.192])
	by india601.server4you.de (Postfix) with ESMTPSA id 53EED1DF;
	Mon,  1 Apr 2013 15:06:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219685>

In addition to "--summary-limit <n>" support the form "--summary-limit=<n>",
for consistency with other parameters and commands.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 git-submodule.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 204bc78..275c664 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -267,6 +267,11 @@ module_clone()
 	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
 
+isnumber()
+{
+	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
+}
+
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -889,14 +894,14 @@ cmd_summary() {
 			for_status="$1"
 			;;
 		-n|--summary-limit)
-			if summary_limit=$(($2 + 0)) 2>/dev/null && test "$summary_limit" = "$2"
-			then
-				:
-			else
-				usage
-			fi
+			summary_limit="$2"
+			isnumber "$summary_limit" || usage
 			shift
 			;;
+		--summary-limit=*)
+			summary_limit="${1#--summary-limit=}"
+			isnumber "$summary_limit" || usage
+			;;
 		--)
 			shift
 			break
-- 
1.8.2
