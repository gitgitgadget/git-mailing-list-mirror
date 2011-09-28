From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: [GUILT 4/6] Run regression tests in a directory which contains spaces
Date: Wed, 28 Sep 2011 15:15:22 +0100
Message-ID: <1317219324-10319-4-git-send-email-alan.christopher.jenkins@googlemail.com>
References: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Cc: git@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@googlemail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Sep 28 16:17:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uwi-0007QS-3w
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab1I1OQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:16:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57348 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab1I1OQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:16:54 -0400
Received: by mail-wy0-f174.google.com with SMTP id 34so31170wyg.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+uBFIHG/4I6fe1P82iOTfyP7RZVnBfn+UcMIMkyBHSg=;
        b=jDnQhx5OH05DWZ6ow8slJb3bdTNNTBYSL+A/VD1PPW0G0RNfg2eXWvEriiaGP2jXOE
         eGpurGFuW0NKoQe3yWSHWZ9++hbJIcL448UHg02WwJxT+IE5X394GRIZN1tPaHENp5Wm
         OmjnlJ8pydC6AFizDwwyg9Xy01t7ooQm8WwII=
Received: by 10.216.80.88 with SMTP id j66mr1152945wee.26.1317219413222;
        Wed, 28 Sep 2011 07:16:53 -0700 (PDT)
Received: from localhost.localdomain ([86.53.68.233])
        by mx.google.com with ESMTPS id n21sm40795936wbp.2.2011.09.28.07.16.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:16:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182323>

This helped me in finding some of the issues in the previous patch.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
---
 regression/run-tests |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/regression/run-tests b/regression/run-tests
index 4cb3eb4..a10e796 100755
--- a/regression/run-tests
+++ b/regression/run-tests
@@ -9,9 +9,9 @@ source scaffold
 # usage: empty_repo
 function empty_repo
 {
-	rm -rf $REPODIR
-	mkdir $REPODIR
-	cd $REPODIR > /dev/null
+	rm -rf "$REPODIR"
+	mkdir "$REPODIR"
+	cd "$REPODIR" > /dev/null
 	git init 2> /dev/null > /dev/null
 	cd - > /dev/null
 }
@@ -22,8 +22,9 @@ function test_failed
 Test failed!
 
 Test:		$TESTNAME
-Repo dir:	$REPODIR
 Log file:	$LOGFILE
+Repo dir:	"$REPODIR"
+
 DONE
 	exit 1
 }
@@ -42,7 +43,9 @@ function check_test
 # usage: run_test <test number>
 function run_test
 {
-	export REPODIR="/tmp/guilt.reg.$RANDOM"
+	# We make sure we can handle space characters
+	# by including one in REPODIR.
+	export REPODIR="/tmp/guilt reg.$RANDOM"
 	export LOGFILE="/tmp/guilt.log.$RANDOM"
 	export TESTNAME="$1"
 
@@ -51,7 +54,7 @@ function run_test
 	empty_repo
 
 	# run the test
-	cd $REPODIR > /dev/null
+	cd "$REPODIR" > /dev/null
 	"$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
 	ERR=$?
 	cd - > /dev/null
@@ -61,7 +64,7 @@ function run_test
 
 	echo "done."
 
-	rm -rf $REPODIR $LOGFILE
+	rm -rf "$REPODIR" "$LOGFILE"
 }
 
 case "$1" in
-- 
1.7.4.1
