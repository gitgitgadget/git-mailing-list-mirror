From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 4/7] test-hg.sh: eliminate 'local' bashism
Date: Sun, 10 Nov 2013 23:05:09 -0500
Message-ID: <1384142712-2936-5-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfinJ-0004GW-CR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab3KKEIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:08:05 -0500
Received: from smtp.bbn.com ([128.33.0.80]:17875 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab3KKEID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:08:03 -0500
Received: from socket.bbn.com ([192.1.120.102]:57644)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfinC-0004dk-Ej; Sun, 10 Nov 2013 23:08:02 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A98823FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237601>

Unlike bash, POSIX shell does not specify a 'local' command for
declaring function-local variable scope.  Except for IFS, the variable
names are not used anywhere else in the script so simply remove the
'local'.  For IFS, move the assignment to the 'read' command to
prevent it from affecting code outside the function.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 53f2bba..558a656 100755
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
1.8.5.rc1.207.gc17dd22
