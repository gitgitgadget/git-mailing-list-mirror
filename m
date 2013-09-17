From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/2] perf-lib: split starting the test from the execution
Date: Tue, 17 Sep 2013 14:10:41 +0200
Message-ID: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, gitster@pobox.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 14:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLu7Q-00060l-Gi
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 14:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab3IQMKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 08:10:49 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:47680 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3IQMKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 08:10:48 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so2100972bkb.17
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/7A4o75+yZ+6mDul6W9ZBWujJ5jLfi1ZhvUSala9Tes=;
        b=DUBQkRLsTvb18eE2zpzz5KqbP6iCo88YfOJkv7s2MsBEORSI102zyTy5Ocn2ijb9E9
         OBfxbGPJiP3jP8SL5/nvOPT4Z9TsaIZmMBe7U56WEzX18tuuWkf5FTosqBuewFiJcqFO
         QfxIdNJ4Il6XMU6WyDpIFpoy6YzgVTDGhgpM7uVNc2k+fub+tVYs/6PgREA6YuC4d0zR
         +FbaChSJHpzYWM+wwvcIpOtN7K5m6bP2bLigRXKlVQmvVYSRAi9QMxtOHabe9nPPX4DG
         B1+MrvWCfyMnmIkIJp9wqZCYIiBlDKu3iYxuAOPxBPU5TwthMvfhWws22B+s8IhD1983
         nvLg==
X-Received: by 10.204.167.74 with SMTP id p10mr7188043bky.26.1379419847824;
        Tue, 17 Sep 2013 05:10:47 -0700 (PDT)
Received: from localhost ([2001:5c0:1400:a::44f])
        by mx.google.com with ESMTPSA id rj5sm9966707bkb.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 05:10:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1238.ga800761
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234874>

Separate the execution part to make future changes to the tests simpler.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/perf-lib.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index c61d535..95e483c 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -148,13 +148,8 @@ exit $ret' >&3 2>&4
 	return "$eval_ret"
 }
 
-
-test_perf () {
+perf_test_ () {
 	test_start_
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
-	export test_prereq
 	if ! test_skip "$@"
 	then
 		base=$(basename "$0" .sh)
@@ -191,6 +186,14 @@ test_perf () {
 	test_finish_
 }
 
+test_perf () {
+	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
+	test "$#" = 2 ||
+	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	export test_prereq
+	perf_test_ "$1" "$2"
+}
+
 # We extend test_done to print timings at the end (./run disables this
 # and does it after running everything)
 test_at_end_hook_ () {
-- 
1.8.3.4.1238.ga800761
