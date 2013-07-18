From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] test-lib.sh - define and use GREP_STRIPS_CR
Date: Thu, 18 Jul 2013 17:44:57 -0400
Message-ID: <1374183897-11408-1-git-send-email-mlevedahl@gmail.com>
References: <7vtxjt56dc.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com, ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 18 23:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzw2q-0002Jw-KS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759427Ab3GRVrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:47:24 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:36427 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759416Ab3GRVrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:47:24 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so2044642qeb.8
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=W2aB7dtfFWeAWoar4RYXh9AWdAzS7xFZBCfcsEZrjqs=;
        b=R5Fu+OitOHwMZ1PxA4lhC0niy0l/fUP6sk9P6Dh+3JhT7CWkblZT9QSuvF9LzPgQbM
         3hSvWj+Di8kpMBGbyp99yDZigRuYdfeW1bVW3HrnVW7xXaxx5TBAE8CziXkl+H+BciZl
         wtS6lh5oZCLi6ypSIzi7UHP+1aURoOvj7NtEhJGgEUx7yb+JMnlV1TBwxAwmegi0LIs1
         Ckl3+rw/4JB6Q+kH79GjOU+g0s5pr4wVuHRCuCETzvBsUfP3oCdlckqi8YGO64+2l2gJ
         SqVo2hoDRGnIM4mFwf3+mEMDWnDLUvmWMMIgIEA4yZ7U3qcGHzfob9K59QDEH0Tv3dVo
         eGwA==
X-Received: by 10.49.42.98 with SMTP id n2mr14373053qel.31.1374184043314;
        Thu, 18 Jul 2013 14:47:23 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s8sm19174676qat.4.2013.07.18.14.47.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 14:47:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <7vtxjt56dc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230754>

Define a common macro for grep needing -U to allow tests to not need
to inquire of specific platforms needing this option. Change
t3032 and t5560 to use this rather than testing explicitly for mingw.
This fixes these two tests on Cygwin.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
This replaces my earlier patch against t3032 (8896b287 on pu)

 t/t3032-merge-recursive-options.sh | 2 +-
 t/t5560-http-backend-noserver.sh   | 2 +-
 t/test-lib.sh                      | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2b17311..5fd7bbb 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -14,7 +14,7 @@ test_description='merge-recursive options
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
-test_have_prereq MINGW && export GREP_OPTIONS=-U
+test_have_prereq GREP_STRIPS_CR && export GREP_OPTIONS=-U
 
 test_expect_success 'setup' '
 	conflict_hunks () {
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index ef98d95..9be9ae3 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -5,7 +5,7 @@ test_description='test git-http-backend-noserver'
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
 
-test_have_prereq MINGW && export GREP_OPTIONS=-U
+test_have_prereq GREP_STRIPS_CR && export GREP_OPTIONS=-U
 
 run_backend() {
 	echo "$2" |
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2d63307..1abea40 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -824,6 +824,7 @@ case $(uname -s) in
 	test_set_prereq MINGW
 	test_set_prereq NOT_CYGWIN
 	test_set_prereq SED_STRIPS_CR
+	test_set_prereq GREP_STRIPS_CR
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
@@ -831,6 +832,7 @@ case $(uname -s) in
 	test_set_prereq NOT_MINGW
 	test_set_prereq CYGWIN
 	test_set_prereq SED_STRIPS_CR
+	test_set_prereq GREP_STRIPS_CR
 	;;
 *)
 	test_set_prereq POSIXPERM
-- 
1.8.3.2.0.13
