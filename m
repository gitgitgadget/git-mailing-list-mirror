From: Max Horn <max@quendi.de>
Subject: [PATCH 3/3] remote-hg: add test cases for null bookmarks
Date: Wed, 19 Mar 2014 13:33:19 +0100
Message-ID: <1395232399-60112-3-git-send-email-max@quendi.de>
References: <1395232399-60112-1-git-send-email-max@quendi.de>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 13:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQFgV-0001Cb-WE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 13:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbaCSMdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 08:33:24 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48899 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964883AbaCSMdW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 08:33:22 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQFgP-0008N9-43; Wed, 19 Mar 2014 13:33:21 +0100
X-Mailer: git-send-email 1.9.0.7.ga299b13
In-Reply-To: <1395232399-60112-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395232402;676ca8d1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244439>

Signed-off-by: Max Horn <max@quendi.de>
---
 contrib/remote-helpers/test-hg.sh | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index a933b1e..8d01b32 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -772,4 +772,52 @@ test_expect_success 'remote double failed push' '
 	)
 '
 
+test_expect_success 'clone remote with master null bookmark' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo a >a &&
+	hg add a &&
+	hg commit -m a &&
+	hg bookmark -r null master
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD a
+'
+
+test_expect_success 'clone remote with default null bookmark' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo a >a &&
+	hg add a &&
+	hg commit -m a &&
+	hg bookmark -r null -f default
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD a
+'
+
+test_expect_success 'clone remote with generic null bookmark' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo a >a &&
+	hg add a &&
+	hg commit -m a &&
+	hg bookmark -r null bmark
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD a
+'
+
 test_done
-- 
1.9.0.7.ga299b13
