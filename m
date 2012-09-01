From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/6] test-lib.sh: Add check for invalid use of 'skip_all' facility
Date: Sat, 01 Sep 2012 19:13:19 +0100
Message-ID: <5042503F.7040101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQj-0004P4-Df
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab2IAS2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:17 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44543 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755573Ab2IAS2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:28:14 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id EE9D2128076;
	Sat,  1 Sep 2012 19:28:13 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 5BBE6128075;	Sat,  1 Sep 2012 19:28:13 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:28:12 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204646>


The 'skip_all' facility cannot be used after one or more tests
have been executed using (for example) 'test_expect_success'.
To do so results in invalid TAP output, which leads to 'prove'
complaining of "Parse errors: No plan found in TAP output".

Add a check for such invalid usage and abort the test with an
error message to alert the test author.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 56b028c..283d27a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -383,6 +383,10 @@ test_done () {
 	case "$test_failure" in
 	0)
 		# Maybe print SKIP message
+		if test -n "$skip_all" && test $test_count -gt 0
+		then
+			error "Can't use skip_all after running some tests"
+		fi
 		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
 
 		if test $test_external_has_tap -eq 0
-- 
1.7.12
