From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v5 2/2] format-patch: ignore diff.submodule setting
Date: Wed,  7 Jan 2015 14:32:12 -0600
Message-ID: <1420662732-11972-2-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
 <1420662732-11972-1-git-send-email-dougk.ff7@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:33:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8xHO-0003HF-EA
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbbAGUca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:32:30 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38325 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbAGUc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:32:29 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so5037093obc.4
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmMmnhJLZyMb8nad2XOeE3W0mh4ZKuFCtoMDNMzMyN4=;
        b=Oq/OWZh6JFz4JnvEc5GVmB5Y9ngBBu6XHLhXs0yUaasou5ZlNSi247LAXixJPXASF+
         zqDSR0HT58gphYmv77qPPDpu+GDR0yY/CtXCUIBKleVRJyNhnjxCJrMo4xsVQJij/pFl
         dptYJBUpIoNkS0oC5bsiBsZdQvthcHtlPLb5gsuE74/2TM5WIfwsPnlQOyxHq9ky9QID
         cPQBIhjv62+IZMQoBylsSEMqxcI4uVsY3Az7GOovBXEAWfDly2TBg+/rVi/9wQwDKT/t
         JOETOZctqhGj6O9tpxh/I4mPcQC7jQEUdBF4KPntDRt6+jhiLkMJ0D8znXGoYqUTEIMv
         QglQ==
X-Received: by 10.182.76.2 with SMTP id g2mr3291283obw.76.1420662749461;
        Wed, 07 Jan 2015 12:32:29 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id ox19sm1470496oeb.17.2015.01.07.12.32.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 12:32:28 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1420662732-11972-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262157>

diff.submodule when set to log produces output which git-am cannot
handle. Ignore this setting when generating patch output.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/log.c           | 2 +-
 t/t4255-am-submodule.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 734aab3..cb14db4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -705,7 +705,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff") ||
-	    !strcmp(var, "color.ui")) {
+	    !strcmp(var, "color.ui") || !strcmp(var, "diff.submodule")) {
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 450d261..0ba8194 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -80,12 +80,12 @@ test_expect_success 'diff.submodule unset with extra file' '
 	run_test $THIRD second-submodule
 '
 
-test_expect_failure 'diff.submodule=log' '
+test_expect_success 'diff.submodule=log' '
 	test_config diff.submodule log &&
 	run_test $SECOND first-submodule
 '
 
-test_expect_failure 'diff.submodule=log with extra file' '
+test_expect_success 'diff.submodule=log with extra file' '
 	test_config diff.submodule log &&
 	run_test $THIRD second-submodule
 '
-- 
2.0.5
