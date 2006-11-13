X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: [PATCH] test-lib.sh: A command dying due to a signal is an unexpected failure.
Date: Mon, 13 Nov 2006 13:50:04 +0000 (UTC)
Message-ID: <11634257784001-git-send-email-j.sixt@eudaptics.com>
Reply-To: Johannes Sixt <j.sixt@eudaptics.com>
NNTP-Posting-Date: Mon, 13 Nov 2006 13:50:04 +0000 (UTC)
Cc: Johannes Sixt <johannes.sixt@telecom.at>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Date: Mo, 13 Nov 2006 14:49:37 +0100
X-Mailer: git-send-email 1.4.1.rc1.g47e5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31298>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjcC4-0004T8-0j for gcvg-git@gmane.org; Mon, 13 Nov
 2006 14:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754649AbWKMNtn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 08:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbWKMNtn
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 08:49:43 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:38180 "EHLO
 linz.eudaptics.com") by vger.kernel.org with ESMTP id S1754649AbWKMNtm (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 08:49:42 -0500
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4]) by
 linz.eudaptics.com (Postfix) with ESMTP id 92D1D10038; Mon, 13 Nov 2006
 14:49:39 +0100 (CET)
Received: by srv.linz.eudaptics (Postfix, from userid 503) id B5EA3104; Mon,
 13 Nov 2006 14:49:38 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Johannes Sixt <johannes.sixt@telecom.at>

When test_expect_failure detects that a command failed, it still has to
treat a program that crashed from a signal as unexpected failure.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 07cb706..3895f16 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -129,7 +129,7 @@ test_expect_failure () {
 	error "bug in the test script: not 2 parameters to test-expect-failure"
 	say >&3 "expecting failure: $2"
 	test_run_ "$2"
-	if [ "$?" = 0 -a "$eval_ret" != 0 ]
+	if [ "$?" = 0 -a "$eval_ret" != 0 -a "$eval_ret" -lt 129 ]
 	then
 		test_ok_ "$1"
 	else
-- 
1.4.1.rc1.g47e5
