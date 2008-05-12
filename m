From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/3] Modified test-lib.sh to output stats to /tmp/git-test-results
Date: Mon, 12 May 2008 11:33:50 +0200
Message-ID: <1210584832-16402-2-git-send-email-srabbelier@gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Cc: dsymonds@gmail.com, Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 12:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUq7-0004Gn-1S
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803AbYELKAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbYELKAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:00:09 -0400
Received: from olive.qinip.net ([62.100.30.40]:51895 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757567AbYELKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:00:07 -0400
X-Greylist: delayed 1572 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 May 2008 06:00:07 EDT
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id A825EFB64;
	Mon, 12 May 2008 11:33:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81845>

This change is needed order to aggregate data on the test run later on.
Because writing to the current directory is not possible, we write to /tmp/.
Suggestions for a better location are welcome.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/test-lib.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7c2a8ba..68b6555 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -152,6 +152,7 @@ test_failure=0
 test_count=0
 test_fixed=0
 test_broken=0
+test_success=0
 
 die () {
 	echo >&5 "FATAL: Unexpected exit with code $?"
@@ -177,6 +178,7 @@ test_tick () {
 
 test_ok_ () {
 	test_count=$(expr "$test_count" + 1)
+	test_success=$(expr "$test_success" + 1)
 	say_color "" "  ok $test_count: $@"
 }
 
@@ -337,6 +339,14 @@ test_create_repo () {
 
 test_done () {
 	trap - exit
+	test_results_path="/tmp/git-test-results"
+
+	echo "total $test_count" >> $test_results_path
+	echo "success $test_success" >> $test_results_path
+	echo "fixed $test_fixed" >> $test_results_path
+	echo "broken $test_broken" >> $test_results_path
+	echo "failed $test_failure" >> $test_results_path
+	echo "" >> $test_results_path
 
 	if test "$test_fixed" != 0
 	then
-- 
1.5.5.1.178.g1f811
