From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] test-lib: add the test_bash convenience function
Date: Sun, 15 Jan 2012 21:00:41 +0100
Message-ID: <4F133069.10308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 15 21:01:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmWGP-0002BE-Bk
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 21:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab2AOUBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 15:01:04 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:44392 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab2AOUA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 15:00:58 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate05.web.de (Postfix) with ESMTP id 75E476910B43
	for <git@vger.kernel.org>; Sun, 15 Jan 2012 21:00:47 +0100 (CET)
Received: from [192.168.178.43] ([91.3.220.216]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MSs2H-1SDmXM36l3-00RcmW; Sun, 15 Jan 2012 21:00:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Provags-ID: V02:K0:a/mKjVJaZE9eYm78FazT1MUg2cjZ00opWlxoMMFztf9
 /aXFcBwBlUluPIc2G0dA0Cgnm3J8PenHxPihd69NdodExvdywv
 EJmKn0nOBIIpbkOvHEP0hJ6Lq9xJL4y3JK3L92wkm2H/ovjZuR
 nnD0X8NEHtlsTG9G2ReyJgF/XSskEqjEEXPY38QLrT6guK+dhZ
 CCZRTuajw24gs0pex3PyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188598>

Since 781f76b15 (test-lib: redirect stdin of tests) you can't simply put a
"bash &&" into a test for debugging purposes anymore. Instead you'll have
to use "bash <&6 >&3 2>&4".

As that invocation is not that easy to remember add the test_bash
convenience function. This function also checks if the -v flag is given
and will complain if that is not the case instead of letting the test
hang until ^D is pressed.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I was tempted to call that method "run_bash" but after looking around
in test-lib.sh "test_bash" seemed like a better name.

 t/test-lib.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a65dfc7..f9061e0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -329,6 +329,17 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }

+# Stop execution and start a bash shell. This is useful for debugging tests
+# and only makes sense together with "-v".
+
+test_bash () {
+	if test "$verbose" = t; then
+		bash <&6 >&3 2>&4
+	else
+		say >&5 "skipping test_bash as it makes no sense without -v"
+	fi
+}
+
 # Call test_commit with the arguments "<message> [<file> [<contents>]]"
 #
 # This will commit a file with the given contents and the given commit
-- 
1.7.9.rc1.1.g46aa0.dirty
