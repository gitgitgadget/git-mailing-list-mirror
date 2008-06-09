From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: [PATCH 4/4] Make test-lib warn if the directory changes.
Date: Mon,  9 Jun 2008 02:44:01 +0200
Message-ID: <1212972241-7348-1-git-send-email-srabbelier@gmail.com>
References: <7vej77iqxb.fsf@gitster.siamese.dyndns.org>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 02:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5VUw-0004I7-31
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 02:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614AbYFIAnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 20:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756481AbYFIAnk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 20:43:40 -0400
Received: from olive.qinip.net ([62.100.30.40]:42700 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756240AbYFIAnj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 20:43:39 -0400
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id C754DFAD8;
	Mon,  9 Jun 2008 02:43:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2
In-Reply-To: <7vej77iqxb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84352>

From: Sverre Rabbelier <srabbelier@gmail.com>

If a script moves out of it's directory, but thereafter
does not move back, the test results would not get written
to the proper file, as such, remember where we start at
and then later on, write to that place.
Also, if it is noticed that the directory was changed,
issue a warning.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/test-lib.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4585fde..d9f2f4e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -5,6 +5,7 @@
 
 # Keep the original TERM for say_color
 ORIGINAL_TERM=$TERM
+ORIGINAL_PATH=$PWD
 
 # For repeatability, reset the environment to known value.
 LANG=C
@@ -355,7 +356,12 @@ test_create_repo () {
 
 test_done () {
 	trap - exit
-	test_results_path="../test-results"
+	test_results_path="$ORIGINAL_PATH/test-results"
+
+  if test "$ORIGINAL_PATH" != "$PWD"
+  then
+    say_color error "Script changed directory from '$ORIGINAL_PATH' to '$PWD'!"
+  fi
 
 	echo "total $test_count" >> $test_results_path
 	echo "success $test_success" >> $test_results_path
-- 
1.5.6.rc2
