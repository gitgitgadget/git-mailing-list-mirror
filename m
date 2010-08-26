From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH] Test the interaction of --bool and --get-regexp on a key with no explicit value
Date: Thu, 26 Aug 2010 13:45:16 -0400
Message-ID: <1282844716-30591-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 20:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oogqe-0001Kz-L2
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 20:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0HZSGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 14:06:44 -0400
Received: from chmrr.net ([209.67.253.66]:43240 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab0HZSGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 14:06:42 -0400
X-Greylist: delayed 1274 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2010 14:06:42 EDT
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.71)
	(envelope-from <alex@chmrr.net>)
	id 1OogVw-0003sU-T6
	for git@vger.kernel.org; Thu, 26 Aug 2010 13:45:28 -0400
X-Mailer: git-send-email 1.7.2.2.458.g8d9c8
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.71 (build at 26-Feb-2010 17:03:13)
X-Date: 2010-08-26 13:45:28
X-Connected-IP: 75.147.59.54:38266
X-Message-Linecount: 43
X-Body-Linecount: 36
X-Message-Size: 1379
X-Body-Size: 1075
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154551>

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---

This test currently fails -- I don't have time to track down the fix,
but I figured that at least I could provide a failing test.  Note that
--null isn't necessary for the failure; without it, one gets
"section.sub=section.val5true", with no spacing between the key and
value.

 t/t1300-repo-config.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 074f2f2..147e0e6 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -816,6 +816,16 @@ echo >>result
 
 test_expect_success '--null --get-regexp' 'cmp result expect'
 
+cat > expect <<\EOF
+section.sub=section.val5
+trueQ
+EOF
+
+git config --null --bool --get-regexp 'val5' | perl -pe 'y/\000/Q/' > result
+echo >>result
+
+test_expect_success '--null --get-regexp --bool' 'cmp result expect'
+
 test_expect_success 'inner whitespace kept verbatim' '
 	git config section.val "foo 	  bar" &&
 	test "z$(git config section.val)" = "zfoo 	  bar"
-- 
1.7.2.2.458.g8d9c8
