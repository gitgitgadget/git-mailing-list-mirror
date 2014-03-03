From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon,  3 Mar 2014 02:24:57 -0800
Message-ID: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 11:25:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKQ3u-0003Rh-LP
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbaCCKZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:25:26 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54916 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaCCKZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:25:25 -0500
Received: by mail-pb0-f42.google.com with SMTP id rr13so3638596pbb.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 02:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=odh4YUGsZ4+O7GiL2dI7H2O28g3VPeWX6HUyGOMpVkA=;
        b=ZvcBzcPPwk/zygoOSFPVhXYiKmHMtAHhvgVz8tzpABWrlhVnmfE9x6hyhCW3DF2gAB
         keZx01GdeDrbQbkOxbSkrGvidGQI4Bf7fO3huBLFO3lgG9ivh6hjnfuSIw5eEYel8cnm
         v63e6bLcgN+mIXFgYa7dP0OIXnLSmtJ2K8v+t5RLpSzsR3GpFzaJ+DLJ2dUB7B0Oa3+L
         ybe6QiMoHtGNTAYh0Kfy6vsC/bPrliffvMd8710UIufxSBajbyeoqwWzCEJpSmnQUX+Y
         gpRHHD7SGezDU9sC8tmOIFxHDoG1i68jZdUzlmzt230JVcP1QW+JB5UlscmdND6qSHjA
         FAIw==
X-Received: by 10.69.25.69 with SMTP id io5mr10147031pbd.22.1393842325202;
        Mon, 03 Mar 2014 02:25:25 -0800 (PST)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id kc9sm34578578pbc.25.2014.03.03.02.25.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 02:25:24 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243214>

We used to show "(missing )" next to tests skipped because they are
specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.
---
 t/test-lib.sh |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..89a405b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -446,25 +446,28 @@ test_finish_ () {
 
 test_skip () {
 	to_skip=
+	skipped_reason=
 	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
 	then
 		to_skip=t
+		skipped_reason="matched GIT_SKIP_TESTS"
 	fi
 	if test -z "$to_skip" && test -n "$test_prereq" &&
 	   ! test_have_prereq "$test_prereq"
 	then
 		to_skip=t
-	fi
-	case "$to_skip" in
-	t)
+
 		of_prereq=
 		if test "$missing_prereq" != "$test_prereq"
 		then
 			of_prereq=" of $test_prereq"
 		fi
-
+		skipped_reason="missing $missing_prereq${of_prereq}"
+	fi
+	case "$to_skip" in
+	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
+		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
 	*)
-- 
1.7.9
