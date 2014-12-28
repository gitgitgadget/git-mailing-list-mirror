From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v2 2/2] format-patch: ignore diff.submodule setting
Date: Sat, 27 Dec 2014 19:04:24 -0600
Message-ID: <1419728664-18627-2-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
 <1419728664-18627-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 02:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y52Hv-0003Hv-W3
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 02:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbaL1BEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 20:04:52 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:55501 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaL1BEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 20:04:51 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so37071338obc.8
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zKDa7F6KNu2GGI+vI5eN9SOza8SgZnciJ8z0q0/D9sA=;
        b=UhPFWdoqKfeXaqzxei7tucMHesi+wI5skEe9hNFXjkbfGmC4fQeE3COfr/MsjF3Eyv
         h+Hz9YbV/8Kg86Wxkl6lK5DMJ23MtyjtfD9O7xVlxLWIo7fWfclBTVi2u1shLBFlvwfr
         HlRpjn6yc1xZ4DxHAmjAHq3A/76qLQPh4N/oEiJj0sOrutUVisqWDu5proo6QHckagA7
         iueGNWxlDxrplvfX0CKbGdvSHrqUZhpURS6/04bFBsBAENWm53NgFv0ZITrSleCY5IVY
         jtwaQ/DIAQeQU0nPn7G+OGj8YWw2pojyjVX0Yr/haUUgt1tkpGKQ9gz9AQfRwyFW7fMv
         NbQg==
X-Received: by 10.202.66.7 with SMTP id p7mr19776718oia.33.1419728691055;
        Sat, 27 Dec 2014 17:04:51 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id y15sm16526262oia.20.2014.12.27.17.04.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 17:04:49 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419728664-18627-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261851>

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
index a2dc083..b7ec0f1 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -92,12 +92,12 @@ test_expect_success 'diff.submodule unset with extra file' '
 	run_test $THIRD second-submodule
 '
 
-test_expect_failure 'diff.submodule=log' '
+test_expect_success 'diff.submodule=log' '
 	git config diff.submodule log &&
 	run_test $SECOND first-submodule
 '
 
-test_expect_failure 'diff.submodule=log with extra file' '
+test_expect_success 'diff.submodule=log with extra file' '
 	git config diff.submodule log &&
 	run_test $THIRD second-submodule
 '
-- 
2.0.5
