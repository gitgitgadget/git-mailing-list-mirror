From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 5/9] test-hg.sh: eliminate 'local' bashism
Date: Sun, 17 Nov 2013 23:12:46 -0500
Message-ID: <1384747970-25481-6-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDS-00040D-OH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab3KRENf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:35 -0500
Received: from smtp.bbn.com ([128.33.1.81]:15233 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab3KRENW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:22 -0500
Received: from socket.bbn.com ([192.1.120.102]:45050)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGDB-000PlQ-BJ; Sun, 17 Nov 2013 23:13:21 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 9170F3FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237968>

Unlike bash, POSIX shell does not specify a 'local' command for
declaring function-local variable scope.  Except for IFS, the variable
names are not used anywhere else in the script so simply remove the
'local'.  For IFS, move the assignment to the 'read' command to
prevent it from affecting code outside the function.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index fa7d17b..ceef6b1 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -54,14 +54,14 @@ check_bookmark () {
 }
 
 check_push () {
-	local expected_ret=$1 ret=0 ref_ret=0 IFS=':'
+	expected_ret=$1 ret=0 ref_ret=0
 
 	shift
 	git push origin "$@" 2>error
 	ret=$?
 	cat error
 
-	while read branch kind
+	while IFS=':' read branch kind
 	do
 		case "$kind" in
 		'new')
-- 
1.8.5.rc1.208.g8ff7964
