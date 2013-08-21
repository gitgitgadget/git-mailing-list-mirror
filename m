From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH 3/3] Revert "bash prompt: avoid command substitution when finalizing gitstring"
Date: Wed, 21 Aug 2013 13:49:33 -0700
Message-ID: <1377118173-23405-3-git-send-email-bcasey@nvidia.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	<szeder@ira.uka.de>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFLc-0005m8-8H
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab3HUUtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:49:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18742 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab3HUUtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:49:40 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B521527e10000>; Wed, 21 Aug 2013 13:49:37 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2013 13:49:39 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 21 Aug 2013 13:49:39 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.298.1; Wed, 21 Aug 2013
 13:49:09 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
In-Reply-To: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232728>

From: Brandon Casey <drafnel@gmail.com>

This reverts commit 69a8141a5d81925b7e08cb228535e9ea4a7a02e3.

Old Bash (3.0) which is distributed with RHEL 4.X and other ancient
platforms that are still in wide use, does not have a printf that
supports -v.  Let's revert this patch and go back to using printf
in the traditional way.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/completion/git-prompt.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index a81ef5a..7698ec4 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -433,11 +433,7 @@ __git_ps1 ()
 	local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
 
 	if [ $pcmode = yes ]; then
-		if [[ -n ${ZSH_VERSION-} ]]; then
-			gitstring=$(printf -- "$printf_format" "$gitstring")
-		else
-			printf -v gitstring -- "$printf_format" "$gitstring"
-		fi
+		gitstring=$(printf -- "$printf_format" "$gitstring")
 		PS1="$ps1pc_start$gitstring$ps1pc_end"
 	else
 		printf -- "$printf_format" "$gitstring"
-- 
1.8.4.rc0.2.g6cf5c31


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
