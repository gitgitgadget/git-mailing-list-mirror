From: David Greene <greened@obbligato.org>
Subject: [PATCH 4/7] contrib/subtree: Add merge tests
Date: Thu, 12 Nov 2015 20:32:33 -0600
Message-ID: <1447381956-4771-5-git-send-email-greened@obbligato.org>
References: <1447381956-4771-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com, gitster@pobox.com,
	"David A . Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 03:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx4BI-0007SB-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 03:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbbKMCdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 21:33:35 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:60487 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932345AbbKMCdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 21:33:33 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1Zx4Bp-0004iE-Ek; Thu, 12 Nov 2015 20:34:13 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1447381956-4771-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281227>

From: Techlive Zheng <techlivezheng@gmail.com>

Add some tests for various merge operations.  Test combinations of merge
with --message, --prefix and --squash.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 1fa5991..7d59a1a 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -210,11 +210,22 @@ test_expect_success 'check if --message for merge works with squash too' '
 
 test_expect_success 'merge new subproj history into subdir' '
 	git subtree merge --prefix="sub dir" FETCH_HEAD &&
-	git branch pre-split &&
 	check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline" &&
 	undo
 '
 
+test_expect_success 'merge new subproj history into subdir/ with --prefix and --message' '
+	git subtree merge --prefix="sub dir" --message="Merged changes from subproject" FETCH_HEAD &&
+	check_equal "$(last_commit_message)" "Merged changes from subproject" &&
+	undo
+'
+
+test_expect_success 'merge new subproj history into subdir/ with --squash and --prefix and --message' '
+	git subtree merge --prefix="sub dir" --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
+	check_equal "$(last_commit_message)" "Merged changes from subproject using squash" &&
+	undo
+'
+
 test_expect_success 'split requires option --prefix' '
 	echo "You must provide the --prefix option." > expected &&
 	test_must_fail git subtree split > actual 2>&1 &&
-- 
2.6.1
