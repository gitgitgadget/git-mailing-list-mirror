From: Tony Finch <dot@dotat.at>
Subject: [PATCH] git-prompt: preserve value of $? in all cases
Date: Wed, 14 Jan 2015 10:06:28 +0000
Message-ID: <alpine.LSU.2.00.1501141005560.23307@hermes-1.csi.cam.ac.uk>
References: <20150114005726.Horde.idyLC0Or9SvaghEN_N_pRg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 11:06:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBKqS-0000sx-0r
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 11:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbbANKGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 05:06:31 -0500
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45901 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbbANKGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 05:06:30 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:47396)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YBKqK-0002LG-Xw (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 14 Jan 2015 10:06:28 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YBKqK-0006nX-F5 (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 14 Jan 2015 10:06:28 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <20150114005726.Horde.idyLC0Or9SvaghEN_N_pRg1@webmail.informatik.kit.edu>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262371>

Signed-off-by: Tony Finch <dot@dotat.at>
---
 contrib/completion/git-prompt.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 3c3fc6d..3e70e74 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -288,6 +288,7 @@ __git_eread ()
 # In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
 __git_ps1 ()
 {
+	# preserve exit status
 	local exit=$?
 	local pcmode=no
 	local detached=no
@@ -303,7 +304,7 @@ __git_ps1 ()
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
-		*)	return
+		*)	return $exit
 		;;
 	esac

@@ -355,7 +356,7 @@ __git_ps1 ()
 			#In PC mode PS1 always needs to be set
 			PS1="$ps1pc_start$ps1pc_end"
 		fi
-		return
+		return $exit
 	fi

 	local short_sha
@@ -416,7 +417,7 @@ __git_ps1 ()
 				if [ $pcmode = yes ]; then
 					PS1="$ps1pc_start$ps1pc_end"
 				fi
-				return
+				return $exit
 			fi
 			# is it a symbolic ref?
 			b="${head#ref: }"
@@ -513,6 +514,5 @@ __git_ps1 ()
 		printf -- "$printf_format" "$gitstring"
 	fi

-	# preserve exit status
 	return $exit
 }
-- 
2.2.1.68.g56d9796
