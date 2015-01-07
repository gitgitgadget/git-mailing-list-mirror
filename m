From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v3 2/2] format-patch: ignore diff.submodule setting
Date: Wed,  7 Jan 2015 13:31:45 -0600
Message-ID: <1420659105-26546-2-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
 <1420659105-26546-1-git-send-email-dougk.ff7@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 20:32:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8wKi-0000ig-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 20:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbbAGTbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 14:31:53 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36134 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbbAGTbw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 14:31:52 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so4613104obc.8
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 11:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oWyByYAvOo/liop8SEhz2vdJcF1XXZDJX86r2oPXcrk=;
        b=Y/AWUxaUywjsvAqjMlnqf2dRPmnCrA6uIT1o2AKaJlYFfBbxZliCDu1El67i9CVGjV
         Xj7HySjKO4PnCJ/P53L830gaI1vvZKGtvOz1GvqUGS4hWHBsK5t1UL5iSdPOhnBial2H
         /CGBA8QDsjny95vmhImLH+60whigrq5G9PYaRFUfetwx7QsrOtQ21xociuioea0olu2O
         UAyQanGY2OaeuBEj6Egy8Iqd4Po1+Xa5qEWTPc5CV/D7uTNVJmp5vyt4E3uAP8ltwV9f
         bHNmRSx9OEqHRkGj1I/hbz5oAedG3H37ySh2B/DKKRGGDwQ4Hr4+3SpFguGJGgHmQsTN
         3ZHQ==
X-Received: by 10.182.148.229 with SMTP id tv5mr3126601obb.41.1420659111632;
        Wed, 07 Jan 2015 11:31:51 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id uv10sm1424290obc.27.2015.01.07.11.31.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 11:31:50 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1420659105-26546-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262146>

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
index 523accf..31cbdba 100755
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
