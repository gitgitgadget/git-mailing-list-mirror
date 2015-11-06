From: David Greene <greened@obbligato.org>
Subject: [PATCH 5/7] contrib/subtree: Add split tests
Date: Thu,  5 Nov 2015 21:35:01 -0600
Message-ID: <1446780903-22156-6-git-send-email-greened@obbligato.org>
References: <1446780903-22156-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com,
	"David A . Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 05:21:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuYWU-0007RK-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 05:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031818AbbKFEVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 23:21:05 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48886 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030793AbbKFEVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 23:21:03 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1ZuXpG-0005Zp-2d; Thu, 05 Nov 2015 21:36:30 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446780903-22156-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280957>

From: Techlive Zheng <techlivezheng@gmail.com>

Add tests to check various options to split.  Check combinations of
--prefix, --message, --annotate, --branch and --rejoin.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 7d59a1a..6250194 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -250,7 +250,6 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 
 test_expect_success 'check if --message works for split+rejoin' '
 	spl1=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
-	git branch spl1 "$spl1" &&
 	check_equal ''"$(last_commit_message)"'' "Split & rejoin" &&
 	undo
 '
@@ -282,7 +281,21 @@ test_expect_success 'check split with --branch for an incompatible branch' '
 	test_must_fail git subtree split --prefix "sub dir" --onto FETCH_HEAD --branch subdir
 '
 
-test_expect_success 'check split+rejoin' '
+test_expect_success 'split sub dir/ with --rejoin' '
+	spl1=$(git subtree split --prefix="sub dir" --annotate="*") &&
+	git branch spl1 "$spl1" &&
+	git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
+	check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$spl1'\''" &&
+	undo
+'
+
+test_expect_success 'split sub dir/ with --rejoin and --message' '
+	git subtree split --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin &&
+	check_equal "$(last_commit_message)" "Split & rejoin" &&
+	undo
+'
+
+test_expect_success 'check split+rejoin+onto' '
 	spl1=''"$(git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
 	undo &&
 	git subtree split --annotate='"'*'"' --prefix "sub dir" --onto FETCH_HEAD --rejoin &&
-- 
2.6.1
