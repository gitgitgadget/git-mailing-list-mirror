From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Catch failures from t5540-http-push
Date: Mon,  7 Jul 2008 23:06:46 +0200
Message-ID: <1215464806-5412-1-git-send-email-mh@glandium.org>
References: <7vej6531xa.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 07 23:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxw7-0006Ux-Bu
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 23:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507AbYGGVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 17:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYGGVGx
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 17:06:53 -0400
Received: from vuizook.err.no ([194.24.252.247]:57118 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198AbYGGVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 17:06:53 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFxv2-0000Y2-3b; Mon, 07 Jul 2008 23:06:50 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFxv4-0001Po-CC; Mon, 07 Jul 2008 23:06:46 +0200
X-Mailer: git-send-email 1.5.6.GIT
In-Reply-To: <7vej6531xa.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87656>

git http-push doesn't handle packed-refs, and now the new builtin-clone
created packed refs, the http-push test fails.

Mark the current failure as such, and also catch third test's failure
that went unreported because git push doesn't return an error code when
it says:
 No refs in common and none specified; doing nothing.
Which it does when http-push can't get a list of refs recursively from
$URL/refs/.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 Feel free to squash this in the previous one, if you feel it's better.

 t/t5540-http-push.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 147ff98..21dbb55 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -51,16 +51,17 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '
 
-test_expect_success 'push to remote repository' '
+test_expect_failure 'push to remote repository' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -m path2 &&
-	git push
+	git push &&
+	[ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
 '
 
-test_expect_success 'create and delete remote branch' '
+test_expect_failure 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
 	: >path3 &&
-- 
1.5.6.GIT
