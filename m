From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH 2/3] t9902-completion.sh: old Bash still does not support array+=('') notation
Date: Wed, 21 Aug 2013 13:49:32 -0700
Message-ID: <1377118173-23405-2-git-send-email-bcasey@nvidia.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFLl-00063v-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab3HUUtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:49:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19512 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab3HUUtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:49:39 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B521527df0000>; Wed, 21 Aug 2013 13:49:35 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2013 13:47:23 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Wed, 21 Aug 2013 13:47:23 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.298.1; Wed, 21 Aug 2013
 13:49:09 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
In-Reply-To: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232730>

From: Brandon Casey <drafnel@gmail.com>

Old Bash (3.0) which is distributed with RHEL 4.X and other ancient
platforms that are still in wide use, does not understand the
array+=() notation.  Let's use an explicit assignment to the new array
element which works everywhere, like:

   array[${#array[@]}+1]=''

The right-hand side '' is not strictly necessary, but in this case
I think it is more clear.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 272a071..2d4beb5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -69,7 +69,7 @@ run_completion ()
 	local -a COMPREPLY _words
 	local _cword
 	_words=( $1 )
-	test "${1: -1}" = ' ' && _words+=('')
+	test "${1: -1}" = ' ' && _words[${#_words[@]}+1]=''
 	(( _cword = ${#_words[@]} - 1 ))
 	__git_wrap__git_main && print_comp
 }
-- 
1.8.4.rc0.2.g6cf5c31


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
