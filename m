From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/6] t4016-*.sh: Skip all tests rather than each test
Date: Sat, 01 Sep 2012 19:10:57 +0100
Message-ID: <50424FB1.2010100@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQj-0004P4-UQ
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab2IAS2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:13 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44528 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755468Ab2IAS2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:28:09 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 67EFD128076;
	Sat,  1 Sep 2012 19:28:08 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id AFF52128075;	Sat,  1 Sep 2012 19:28:07 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:28:07 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204644>


Each test in this file is skipped if the TABS_IN_FILENAMES test
prerequisite is set. Use the 'skip_all' facility at the head of
the file to skip all of the tests instead.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t4016-diff-quote.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 97b8177..cd543ec 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -13,14 +13,12 @@ P1='pathname	with HT'
 P2='pathname with SP'
 P3='pathname
 with LF'
-if : 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
-then
-	test_set_prereq TABS_IN_FILENAMES
-else
-	say 'Your filesystem does not allow tabs in filenames'
-fi
+echo 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
+	skip_all='Your filesystem does not allow tabs in filenames'
+	test_done
+}
 
-test_expect_success TABS_IN_FILENAMES setup '
+test_expect_success setup '
 	echo P0.0 >"$P0.0" &&
 	echo P0.1 >"$P0.1" &&
 	echo P0.2 >"$P0.2" &&
@@ -40,7 +38,7 @@ test_expect_success TABS_IN_FILENAMES setup '
 	:
 '
 
-test_expect_success TABS_IN_FILENAMES 'setup expected files' '
+test_expect_success 'setup expected files' '
 cat >expect <<\EOF
  rename pathname.1 => "Rpathname\twith HT.0" (100%)
  rename pathname.3 => "Rpathname\nwith LF.0" (100%)
@@ -52,12 +50,12 @@ cat >expect <<\EOF
 EOF
 '
 
-test_expect_success TABS_IN_FILENAMES 'git diff --summary -M HEAD' '
+test_expect_success 'git diff --summary -M HEAD' '
 	git diff --summary -M HEAD >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success TABS_IN_FILENAMES 'git diff --numstat -M HEAD' '
+test_expect_success 'git diff --numstat -M HEAD' '
 	cat >expect <<-\EOF &&
 	0	0	pathname.1 => "Rpathname\twith HT.0"
 	0	0	pathname.3 => "Rpathname\nwith LF.0"
@@ -71,7 +69,7 @@ test_expect_success TABS_IN_FILENAMES 'git diff --numstat -M HEAD' '
 	test_cmp expect actual
 '
 
-test_expect_success TABS_IN_FILENAMES 'git diff --stat -M HEAD' '
+test_expect_success 'git diff --stat -M HEAD' '
 	cat >expect <<-\EOF &&
 	 pathname.1 => "Rpathname\twith HT.0"            | 0
 	 pathname.3 => "Rpathname\nwith LF.0"            | 0
-- 
1.7.12
