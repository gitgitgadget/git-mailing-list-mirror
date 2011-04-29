From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH v2] t/test-lib.sh: minor readability improvements
Date: Fri, 29 Apr 2011 14:30:30 +0200
Message-ID: <1304080230-11670-1-git-send-email-misfire@debugon.org>
References: <4DBA8C43.4040804@debugon.org>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:32:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFmrc-0002MA-5r
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 14:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab1D2Mb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 08:31:58 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62072 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab1D2Mb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 08:31:58 -0400
Received: from localhost.localdomain (dslb-088-071-229-195.pools.arcor-ip.net [88.71.229.195])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LavRV-1PVgOb1g4H-00kfb1; Fri, 29 Apr 2011 14:31:57 +0200
X-Mailer: git-send-email 1.7.5
In-Reply-To: <4DBA8C43.4040804@debugon.org>
X-Provags-ID: V02:K0:Xl6h8PRxcCGxX4mekVlyYeHuDwo/ZAw5bgwF5wIiw+e
 l1DTl1A76o93GuIT3swh7asRqbOv3ZktaxrhFK5UJ7ICkAo538
 dq97LfMTViZ0ygeCeihGGqafV8DvAlbVEZ6Irb8GWFPZ9oEYJL
 Lrur3TSuOL1MvvEQ9V4aIWfI7c6LfKbyaIYxQIEHlcCKX6joKt
 5PJssXvwq1bfxOmQZhUw7xachQGvyqzWUxKI6ofUhI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172450>

Apply parameter expansion. Also use here document to save
test results instead of appending each line with ">>".

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 t/test-lib.sh |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abc47f3..aca03d2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -575,7 +575,7 @@ test_external () {
 test_external_without_stderr () {
 	# The temporary file has no (and must have no) security
 	# implications.
-	tmp="$TMPDIR"; if [ -z "$tmp" ]; then tmp=/tmp; fi
+	tmp=${TMPDIR:-/tmp}
 	stderr="$tmp/git-external-stderr.$$.tmp"
 	test_external "$@" 4> "$stderr"
 	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
@@ -801,12 +801,14 @@ test_done () {
 		mkdir -p "$test_results_dir"
 		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
 
-		echo "total $test_count" >> $test_results_path
-		echo "success $test_success" >> $test_results_path
-		echo "fixed $test_fixed" >> $test_results_path
-		echo "broken $test_broken" >> $test_results_path
-		echo "failed $test_failure" >> $test_results_path
-		echo "" >> $test_results_path
+		cat >>"$test_results_path" <<-EOF
+		total $test_count
+		success $test_success
+		fixed $test_fixed
+		broken $test_broken
+		failed $test_failure
+
+		EOF
 	fi
 
 	if test "$test_fixed" != 0
-- 
1.7.5
