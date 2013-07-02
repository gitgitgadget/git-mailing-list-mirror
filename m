From: benoit.person@ensimag.fr
Subject: [PATCH v7 4/7] git-remote-mediawiki: Update tests to run with the new bin-wrapper
Date: Wed,  3 Jul 2013 00:39:46 +0200
Message-ID: <1372804789-12732-5-git-send-email-benoit.person@ensimag.fr>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 00:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9QT-0000tX-TW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 00:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab3GBWvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 18:51:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37427 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab3GBWlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 18:41:39 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r62MfPd6032596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 00:41:25 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r62MfSNC021158;
	Wed, 3 Jul 2013 00:41:28 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r62MfMNe024530;
	Wed, 3 Jul 2013 00:41:28 +0200
X-Mailer: git-send-email 1.8.3.1.590.gc07d91b
In-Reply-To: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jul 2013 00:41:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r62MfPd6032596
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1373409688.10443@I2ziNe0W3EHJXH2TuKCI6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229437>

From: Benoit Person <benoit.person@ensimag.fr>

Until now, if git-remote-mediawiki was not installed, the test suite
copied it to the toplevel directory. This solution pollutes the
directory with untracked files. Plus, we would need to copy the new
git-mw.perl file to test it too.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/t/test-gitmw-lib.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index bb76cee..ca6860f 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -62,12 +62,8 @@ test_check_precond () {
 		test_done
 	fi
 
-	if [ ! -f "$GIT_BUILD_DIR"/git-remote-mediawiki ];
-	then
-		echo "No remote mediawiki for git found. Copying it in git"
-		echo "cp $GIT_BUILD_DIR/contrib/mw-to-git/git-remote-mediawiki $GIT_BUILD_DIR/"
-		ln -s "$GIT_BUILD_DIR"/contrib/mw-to-git/git-remote-mediawiki "$GIT_BUILD_DIR"
-	fi
+	GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd "../.." && pwd)
+	PATH="$GIT_EXEC_PATH"'/bin-wrapper:'"$PATH"
 
 	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ];
 	then
-- 
1.8.3.1.590.gc07d91b
