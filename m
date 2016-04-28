From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/2] submodule init: fail gracefully with a missing .gitmodules file
Date: Thu, 28 Apr 2016 13:02:45 -0700
Message-ID: <1461873766-14703-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 28 22:02:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avs9H-0005dx-IH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbcD1UCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 16:02:50 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35750 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcD1UCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 16:02:49 -0400
Received: by mail-pa0-f42.google.com with SMTP id iv1so36251244pac.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qOImSaFYn2tXamNCfLv0iF/SICebvEMCcTpzd3dydt8=;
        b=H03WLTipE5VJOGnHf6vRBK8E4noV8XbXnKIeLCipPL8cWa+jKHsvjYOI8zxnm8UZ8F
         BDc4UR4MUG5nNDacam4BeS3qeedMfUATCIBZFV4bmDuL5QqgC+QikwzQLa3ih21FIJzx
         lgIpGSIXn2Akr9PmoRgENQ08IXMhXF/RA4Fm5TPdAFRPfGmvrdwqo3jTxB+6IMYEKyM3
         uMOhL/ByjYIDx0jVghR+wqiIJFK0ZHjZP14xCq/QuM+zfgu3AH43De3tOHIHs6XORa5l
         yWK3pjE7/I6Fd5UF8vL11lzKRf7kpgtMy8t25dOIarOs1bc969nOEPuWsqlYTNymvfWk
         ldmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qOImSaFYn2tXamNCfLv0iF/SICebvEMCcTpzd3dydt8=;
        b=YbB6OtgQr7v0jA7ozqYgxPJpEpeIbA6eFWfwV3iAKZrc91NhkLJ05Mi5XPyqQG43Ic
         t+8OiLLixMfR2M+RY+FzVeVxPb3lTUdiD+6Vv1pHJgXaAHSgqt2peX6QROxOLLKIVRzt
         WW45UmugxGd6PNP+27a/OeFwu6i5GAzdNc/VPo2mBf4owwfHMRIkmLhyO7uny4R5DwV3
         +BracWQZUU0ci2txI7mUOsjDf4oeqzAQ6pS5sfjpQqBNXXF4LgQsnap1VU/aabQ9hI6s
         ZMKzjCbq7O5BdyI6pSYnSqPcHdFlncCirxHjWagG+lLWDG1giYQorNWTne1i0Ow9tueF
         L0eg==
X-Gm-Message-State: AOPr4FXrxtGI5NqqNsAgBmQ/V9xjlt/obSrLWuS1or9699jbDZCpd2CZB5VL8AmM7+7QSdUt
X-Received: by 10.67.1.233 with SMTP id bj9mr23523770pad.46.1461873768891;
        Thu, 28 Apr 2016 13:02:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fce0:3f2f:7f7d:8246])
        by smtp.gmail.com with ESMTPSA id h6sm15633770paf.23.2016.04.28.13.02.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 13:02:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.28.ga4e36c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292946>

When there is no .gitmodules file availabe to initialize a submodule
from, `submodule_from_path` just returns NULL. We need to check for
that and abort gracefully. When `submodule init` was implemented in shell,
a missing .gitmodules file would result in an error message

    No url found for submodule path '%s' in .gitmodules

Replicate that error message for now.

When the .gitmodules file is missing we can probably fail even earlier
for all of the submodules with an improved error message.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  applies on submodule-init.
  
  Thanks,
  Stefan

 builtin/submodule--helper.c | 10 +++++++---
 t/t7400-submodule-basic.sh  |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6d4f27..ce9d11e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -314,13 +314,17 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
 
-	sub = submodule_from_path(null_sha1, path);
-
 	if (prefix) {
 		strbuf_addf(&sb, "%s%s", prefix, path);
 		displaypath = strbuf_detach(&sb, NULL);
 	} else
-		displaypath = xstrdup(sub->path);
+		displaypath = xstrdup(path);
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+			displaypath);
 
 	/*
 	 * Copy url setting when it is not set yet.
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f99f674..df6b4da 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -18,6 +18,14 @@ test_expect_success 'setup - initial commit' '
 	git branch initial
 '
 
+test_expect_success 'submodule init aborts on missing .gitmodules file' '
+	test_when_finished "git update-index --remove sub" &&
+	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
+	# missing the .gitmodules file here
+	test_must_fail git submodule init 2>actual &&
+	test_i18ngrep "No url found for submodule path" actual
+'
+
 test_expect_success 'configuration parsing' '
 	test_when_finished "rm -f .gitmodules" &&
 	cat >.gitmodules <<-\EOF &&
-- 
2.8.0.28.ga4e36c9
