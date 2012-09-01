From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/6] test-lib.sh: Suppress the "passed all ..." message if no tests run
Date: Sat, 01 Sep 2012 19:26:21 +0100
Message-ID: <5042534D.3030600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQr-0004YZ-Ax
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab2IAS2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:25 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44551 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755588Ab2IAS2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:28:24 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9FDE4128075;
	Sat,  1 Sep 2012 19:28:23 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id AD02E128071;	Sat,  1 Sep 2012 19:28:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:28:17 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204647>


If a test script issues a test_done without executing any tests, for
example when using the 'skip_all' facility, the output looks something
like this:

    $ ./t9159-git-svn-no-parent-mergeinfo.sh
    # passed all 0 test(s)
    1..0 # SKIP skipping git svn tests, svn not found
    $

The "passed all 0 test(s)" comment line, while correct, looks a little
strange. Add a check to suppress this message if no tests have actually
been run.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I suspect some people would disagree with this one. Indeed, this only
irritates me when I'm feeling grumpy (so most days then). :-D
It's clearly not important (I just happened to be making changes in
this area), so drop this one if you feel it's not justified.

ATB,
Ramsay Jones

 t/test-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 283d27a..f8e3733 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -391,7 +391,10 @@ test_done () {
 
 		if test $test_external_has_tap -eq 0
 		then
-			say_color pass "# passed all $msg"
+			if test $test_count -gt 0
+			then
+				say_color pass "# passed all $msg"
+			fi
 			say "1..$test_count$skip_all"
 		fi
 
-- 
1.7.12
