From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] perf-lib: fix start/stop of perf tests
Date: Sat, 29 Jun 2013 15:38:39 +0200
Message-ID: <1372513119-27384-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 29 15:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsvNY-0007Zi-8f
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 15:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3F2Njs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 09:39:48 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:49194 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab3F2Njr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 09:39:47 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so1131132bkc.15
        for <git@vger.kernel.org>; Sat, 29 Jun 2013 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=G2Kz4vs29fRGzsmx16V5Jbk5VNwx6djjZPaJ6TwnmmE=;
        b=KOgUYZ1c6wdMReR4UniWS02WCKgvEAPl19GJFMkIEmAe6U2gU65D6Q2eCeVbrMHWL2
         dXRtkAOnY0gd5MxU8fwXLoK3O23QPZldpJDUp05hCYMsAW53GEm/67ywaf0MNvsSVcPj
         hN6uVHcKfa5Qw1c1IHiuN9eolOe3k6REPGrzgWK+5O2aEEUiK9IqwNnlLTQQFhOtdrbf
         GxmOG1qw2l50VqiLnCtCxvlDJqYNoSujMStYgsLicbhj3kkVhhB0Zg+FePXYE7uPoKLy
         7fgt4/tYcxCfBZCyIhVQ4TPAQhq2jITt3a0PcheKVUjAlSoSRWIvL50AKR4DkgMpxnbM
         hqfw==
X-Received: by 10.204.224.142 with SMTP id io14mr2290562bkb.27.1372513185714;
        Sat, 29 Jun 2013 06:39:45 -0700 (PDT)
Received: from localhost (host252-192-dynamic.14-87-r.retail.telecomitalia.it. [87.14.192.252])
        by mx.google.com with ESMTPSA id ps10sm5090248bkb.14.2013.06.29.06.39.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 29 Jun 2013 06:39:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229252>

ae75342 test-lib: rearrange start/end of test_expect_* and test_skip
changed the way tests are started/stopped, but did not update the perf
tests.  They were therefore giving the wrong output, because of the
wrong test count.  Fix this by starting and stopping the tests
correctly.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/perf-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index a816fbc..c61d535 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -150,6 +150,7 @@ exit $ret' >&3 2>&4
 
 
 test_perf () {
+	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
@@ -187,7 +188,7 @@ test_perf () {
 		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
 		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
 	fi
-	echo >&3 ""
+	test_finish_
 }
 
 # We extend test_done to print timings at the end (./run disables this
-- 
1.8.3.453.g1dfc63d
