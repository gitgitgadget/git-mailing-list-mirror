From: David Greene <greened@obbligato.org>
Subject: [PATCH 3/7] contrib/subtree: Add tests for subtree add
Date: Thu,  5 Nov 2015 21:34:59 -0600
Message-ID: <1446780903-22156-4-git-send-email-greened@obbligato.org>
References: <1446780903-22156-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com,
	"David A . Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 05:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuYWD-0007Cp-OU
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 05:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031486AbbKFEUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 23:20:50 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48867 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030793AbbKFEUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 23:20:49 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1ZuXpB-0005Zp-CH; Thu, 05 Nov 2015 21:36:25 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446780903-22156-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280954>

From: Techlive Zheng <techlivezheng@gmail.com>

Add some tests to check various options to subtree add.  These test
various combinations of --message, --prefix and --squash.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 4471786..1fa5991 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -127,12 +127,24 @@ test_expect_success 'no merge from non-existent subtree' '
 	test_must_fail git subtree merge --prefix="sub dir" FETCH_HEAD
 '
 
+test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
+	git subtree add --prefix="sub dir" sub1 &&
+	check_equal "$(last_commit_message)" "Add '\''sub dir/'\'' from commit '\''$(git rev-parse sub1)'\''" &&
+	undo
+'
+
 test_expect_success 'check if --message works for add' '
 	git subtree add --prefix="sub dir" --message="Added subproject" sub1 &&
 	check_equal ''"$(last_commit_message)"'' "Added subproject" &&
 	undo
 '
 
+test_expect_success 'add subproj as subtree into sub dir/ with --prefix and --message' '
+	git subtree add --prefix="sub dir" --message="Added subproject" sub1 &&
+	check_equal "$(last_commit_message)" "Added subproject" &&
+	undo
+'
+
 test_expect_success 'check if --message works as -m and --prefix as -P' '
 	git subtree add -P "sub dir" -m "Added subproject using git subtree" sub1 &&
 	check_equal ''"$(last_commit_message)"'' "Added subproject using git subtree" &&
@@ -145,6 +157,13 @@ test_expect_success 'check if --message works with squash too' '
 	undo
 '
 
+test_expect_success 'add subproj as subtree into sub dir/ with --squash and --prefix and --message' '
+	git subtree add --prefix="sub dir" --message="Added subproject with squash" --squash sub1 &&
+	check_equal "$(last_commit_message)" "Added subproject with squash" &&
+	undo
+'
+
+# Maybe delete
 test_expect_success 'add subproj to mainline' '
 	git subtree add --prefix="sub dir"/ FETCH_HEAD &&
 	check_equal ''"$(last_commit_message)"'' "Add '"'sub dir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
-- 
2.6.1
