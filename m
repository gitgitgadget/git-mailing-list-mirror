From: "Sverre Rabbelier" <sverre@rabbelier.nl>
Subject: [PATCH 1/3] Modified test-lib.sh to output stats to /tmp/git-test-results
Date: Sun,  8 Jun 2008 16:04:33 +0200
Message-ID: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5LwB-0004Rw-IB
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163AbYFHOas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbYFHOar
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:30:47 -0400
Received: from olive.qinip.net ([62.100.30.40]:58495 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbYFHOap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:30:45 -0400
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id 2A105FBD8;
	Sun,  8 Jun 2008 16:04:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.214.g82ce2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84270>

From: Sverre Rabbelier <srabbelier@gmail.com>

This change is needed order to aggregate data on the test run later on.
Because writing to the current directory is not possible, we write to /tmp/.
Suggestions for a better location are welcome.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/test-lib.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a8bd27..4585fde 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -152,6 +152,7 @@ test_failure=0
 test_count=0
 test_fixed=0
 test_broken=0
+test_success=0
 
 die () {
 	echo >&5 "FATAL: Unexpected exit with code $?"
@@ -193,6 +194,7 @@ test_tick () {
 
 test_ok_ () {
 	test_count=$(expr "$test_count" + 1)
+	test_success=$(expr "$test_success" + 1)
 	say_color "" "  ok $test_count: $@"
 }
 
@@ -353,6 +355,14 @@ test_create_repo () {
 
 test_done () {
 	trap - exit
+	test_results_path="../test-results"
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
1.5.5.1.214.g82ce2.dirty
