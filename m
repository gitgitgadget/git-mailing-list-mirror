From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Skip t5540-http-push test when USE_CURL_MULTI is undefined
Date: Mon,  7 Jul 2008 21:02:50 +0200
Message-ID: <1215457370-24325-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 07 21:04:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFw0D-0007Ux-PN
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 21:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbYGGTC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbYGGTC4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 15:02:56 -0400
Received: from vuizook.err.no ([194.24.252.247]:48309 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755519AbYGGTC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 15:02:56 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFvz6-0004w2-Ey; Mon, 07 Jul 2008 21:02:55 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFvz8-0006Kl-Sc; Mon, 07 Jul 2008 21:02:50 +0200
X-Mailer: git-send-email 1.5.6.GIT
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87643>

When USE_CURL_MULTI is undefined, git http-push doesn't work, so it's
useless to test it.
---

 I wasted too much time wondering why the 3rd and 4th tests were failing
 before realizing I was building against an ancient libcurl, thus having
 a non working git http-push. This would avoid other people to do the same.

 t/t5540-http-push.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 6cd8b45..147ff98 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -12,6 +12,13 @@ This test runs various sanity checks on http-push.'
 ROOT_PATH="$PWD"
 LIB_HTTPD_DAV=t
 
+if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
+then
+	say "skipping test, USE_CURL_MULTI is not defined"
+	test_done
+	exit
+fi
+
 . ../lib-httpd.sh
 
 if ! start_httpd >&3 2>&4
-- 
1.5.6.2.220.g44701
