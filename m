From: David Turner <dturner@twopensource.com>
Subject: [PATCH] refs: Fix valgrind suppression file
Date: Fri,  4 Jul 2014 13:24:01 -0700
Message-ID: <1404505441-1853-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 22:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3A20-0007dx-7b
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 22:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760084AbaGDUYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 16:24:24 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55606 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbaGDUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 16:24:23 -0400
Received: by mail-qa0-f49.google.com with SMTP id w8so1612299qac.8
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 13:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZkvB438yS8O6iFIMmQo3VtGSUrpCpdXHO6Z+inIJrl0=;
        b=kdCrrkkZmZAqtwwO/76Wyc7yR2d2HrwtsCjbJYAuEl/G8FhqGDZyPDTe+70BV1X7jZ
         LxFgrH66+qxYatkwaaqxAlVR17vv0AwJyjz0vGJGgUlHOmk53wgvPzHMSqLeYP0CwDeX
         l59rOgkupETIm13Vi0eC417PHMrcDrbNUes38O7CiXw8/jD7gPDrMIggAelX1XnsGr+/
         iuwtR/orS7WAiABTT0kx9r4/mz2TKhlqxeiUp9aasbSQ1mDL1vDkei2AnKLfhzUputdA
         yLTww5o0YH813jLsKcbh1KnscUs65PPs9FUO/ldBehS8c0OjGwsxLa4DsH7QhxvzcI8B
         kfJQ==
X-Gm-Message-State: ALoCoQn7QNsiEsjv4wmGntVMeLWx5bIvht7F5kSZIK9Cku+7cTv8bcFDQMZj9/PNraCq3Rnnwf6s
X-Received: by 10.140.39.38 with SMTP id u35mr21177874qgu.45.1404505463314;
        Fri, 04 Jul 2014 13:24:23 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id m92sm21018234qgd.29.2014.07.04.13.24.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jul 2014 13:24:22 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252902>

Add all of the ways in which check_refname_format violates valgrind's
expectations to the valgrind suppression file; remove an assumption about
the call chain of check_refname_format from same.

Signed-off-by: David Turner <dturner@twitter.com>
---
 t/valgrind/default.supp | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 332ab1a..9d51c92 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -50,10 +50,17 @@
 	fun:copy_ref
 }
 {
-	ignore-sse-check_refname_format
+	ignore-sse-check_refname_format-addr
 	Memcheck:Addr8
 	fun:check_refname_format
-	fun:cmd_check_ref_format
-	fun:handle_builtin
-	fun:main
+}
+{
+	ignore-sse-check_refname_format-cond
+	Memcheck:Cond
+	fun:check_refname_format
+}
+{
+	ignore-sse-check_refname_format-value
+	Memcheck:Value8
+	fun:check_refname_format
 }
-- 
2.0.0.390.gcb682f8
