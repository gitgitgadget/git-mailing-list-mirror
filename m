From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/6] t3902-*.sh: Skip all tests rather than each test
Date: Sat, 01 Sep 2012 19:10:01 +0100
Message-ID: <50424F79.2020707@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQb-0004DP-8g
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab2IAS2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:10 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44515 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755451Ab2IAS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:28:06 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id CFBE3128076;
	Sat,  1 Sep 2012 19:28:05 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id D6673128075;	Sat,  1 Sep 2012 19:28:04 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:28:04 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204642>


Each test in this file is skipped if the TABS_IN_FILENAMES test
prerequisite is set. Use the 'skip_all' facility at the head of
the file to skip all of the tests instead.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t3902-quoted.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 534ee08..892f567 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -16,9 +16,8 @@ echo foo 2>/dev/null > "Name and an${HT}HT"
 if ! test -f "Name and an${HT}HT"
 then
 	# FAT/NTFS does not allow tabs in filenames
-	say 'Your filesystem does not allow tabs in filenames'
-else
-	test_set_prereq TABS_IN_FILENAMES
+	skip_all='Your filesystem does not allow tabs in filenames'
+	test_done
 fi
 
 for_each_name () {
@@ -31,7 +30,7 @@ for_each_name () {
 	done
 }
 
-test_expect_success TABS_IN_FILENAMES 'setup' '
+test_expect_success 'setup' '
 
 	mkdir "$FN" &&
 	for_each_name "echo initial >\"\$name\"" &&
@@ -45,7 +44,7 @@ test_expect_success TABS_IN_FILENAMES 'setup' '
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'setup expected files' '
+test_expect_success 'setup expected files' '
 cat >expect.quoted <<\EOF &&
 Name
 "Name and a\nLF"
@@ -75,74 +74,74 @@ With SP in it
 EOF
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from ls-files' '
+test_expect_success 'check fully quoted output from ls-files' '
 
 	git ls-files >current && test_cmp expect.quoted current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from diff-files' '
+test_expect_success 'check fully quoted output from diff-files' '
 
 	git diff --name-only >current &&
 	test_cmp expect.quoted current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from diff-index' '
+test_expect_success 'check fully quoted output from diff-index' '
 
 	git diff --name-only HEAD >current &&
 	test_cmp expect.quoted current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from diff-tree' '
+test_expect_success 'check fully quoted output from diff-tree' '
 
 	git diff --name-only HEAD^ HEAD >current &&
 	test_cmp expect.quoted current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from ls-tree' '
+test_expect_success 'check fully quoted output from ls-tree' '
 
 	git ls-tree --name-only -r HEAD >current &&
 	test_cmp expect.quoted current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'setting core.quotepath' '
+test_expect_success 'setting core.quotepath' '
 
 	git config --bool core.quotepath false
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from ls-files' '
+test_expect_success 'check fully quoted output from ls-files' '
 
 	git ls-files >current && test_cmp expect.raw current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from diff-files' '
+test_expect_success 'check fully quoted output from diff-files' '
 
 	git diff --name-only >current &&
 	test_cmp expect.raw current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from diff-index' '
+test_expect_success 'check fully quoted output from diff-index' '
 
 	git diff --name-only HEAD >current &&
 	test_cmp expect.raw current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from diff-tree' '
+test_expect_success 'check fully quoted output from diff-tree' '
 
 	git diff --name-only HEAD^ HEAD >current &&
 	test_cmp expect.raw current
 
 '
 
-test_expect_success TABS_IN_FILENAMES 'check fully quoted output from ls-tree' '
+test_expect_success 'check fully quoted output from ls-tree' '
 
 	git ls-tree --name-only -r HEAD >current &&
 	test_cmp expect.raw current
-- 
1.7.12
