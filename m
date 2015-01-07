From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v4 2/2] format-patch: ignore diff.submodule setting
Date: Wed,  7 Jan 2015 14:13:43 -0600
Message-ID: <1420661623-30692-2-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
 <1420661623-30692-1-git-send-email-dougk.ff7@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:14:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8wzR-000628-QW
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbbAGUN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:13:58 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57220 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbbAGUN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:13:57 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so4902251obb.12
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nnQcwwoH/Z5TQQ6k8T8pEVP2HWgzxqhfF547qKJchNc=;
        b=gWiFF7xLHav+yk77of7m6G1624RzFNgqmJ1Bm7vzqFOPAvO6YddPTrDEKhNMi8FLJf
         ZEd74+BklETZHPpLZHclY3CyjPxTfUCKzf2tBTnqalMHyX0nLlztJLmkHQ7dCqaj5sTB
         /63JY8jw/9xRPQCN3Hfwf7uOvjaYn3oKqZKPeKYZRW0zKnQvUOqCfXG25ArhUBN+dYjv
         Clw+9tgqMoIPTnNClyeCHhQRIYLkv641oa6iOXux20bQt+Qnck42rjQUN01bzi3bcOtz
         Q9iQEJr1+zZ86KAX/mEnWR0M5Pa1JnEWXxbKOurGZDtCBpfdkPmc5dpEEcTxQmw6YpXf
         roRQ==
X-Received: by 10.202.224.198 with SMTP id x189mr3104917oig.62.1420661637025;
        Wed, 07 Jan 2015 12:13:57 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id vx15sm1470358oeb.6.2015.01.07.12.13.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 12:13:56 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1420661623-30692-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262149>

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
index a38c305..27ea698 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -78,12 +78,12 @@ test_expect_success 'diff.submodule unset with extra file' '
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
