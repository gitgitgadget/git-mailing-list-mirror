From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 4/7] submodule update: direct error message to stderr
Date: Thu, 11 Feb 2016 18:03:09 -0800
Message-ID: <1455242592-19352-5-git-send-email-sbeller@google.com>
References: <1455242592-19352-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 12 03:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU356-0000tr-7N
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 03:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcBLCDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 21:03:30 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36075 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbcBLCD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 21:03:27 -0500
Received: by mail-pf0-f177.google.com with SMTP id e127so39094249pfe.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 18:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTxOi8d66uKiAMK8qSyZDBOfGhxINsKuCUqAGRbB9x4=;
        b=HxRkOk/AFMyEe6+30TSvRKBdKCzGTU74Rf+Uf1kQ0udsQn4EZpmHu+uINzsoVX/Zp6
         g017/9zDdgrFYzcpXwZpdL1ubjjmffKH8kMn8MhoaVObqeQ4pRaMvIYXNB0tkPvasGgV
         Qwmqx84MB+3T4eo3bFS+Jcjek76FnQG/PCWzcVa6QDFy1mCgptI+LayOtF2tGJPcddox
         SKPWTnmevrXoIMlIMXIDVwRycj9hTTzJLw8W6tQYgkTScuauIbmqzRWVqtbA5th2Zp6Z
         sh65RxpQgYLRjkoRz/xcdfWhH5zxoINMLks1zKbszEQbb5dKKthzXw+IXyUMcMGiDehA
         Z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTxOi8d66uKiAMK8qSyZDBOfGhxINsKuCUqAGRbB9x4=;
        b=j1z7KkKZBRshL556jaMU7fCs1cPuqbprjBalAWWCdG/YgUDMwKzYJZRVCkm1N12fzJ
         PocpqWgucbXpTL36QBJXmix8xjQLcd2meOXaO/LciLE+g9sY5VQW0uXhoH32GPswATAi
         PawIF7wfrdTD7OhUFM1crRpEfQ54q6xxKzn7kUpIulPo4EC9uQDeIiTa/RVjCgQTUJP7
         B6+mPReJNWxlqzABErzdT5BzIvJgBhZ3ZYeD/LcAo/0aiTOeKh03JhveucqZJPxoqBXk
         R7rj+QMRhmPhqrfybRL+37kHLNBLP06u8CYWhVLQlBn9C8p7S09dCQVqfU3ojaChPyAg
         y64w==
X-Gm-Message-State: AG10YOQDkB8FwWv9lK0R20fALhDIUTSrwE/qXy6REvXFjhUYRh7uifNkDvyX7ID7b3dRuSBD
X-Received: by 10.98.13.86 with SMTP id v83mr71600178pfi.162.1455242607012;
        Thu, 11 Feb 2016 18:03:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:994e:7471:3f:c285])
        by smtp.gmail.com with ESMTPSA id p8sm15078158pfi.34.2016.02.11.18.03.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 18:03:26 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455242592-19352-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286030>

Reroute the error message for specified but initialized submodules
to stderr instead of stdout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           | 4 ++--
 t/t7400-submodule-basic.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..9ee86d4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -693,7 +693,7 @@ cmd_update()
 
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$displaypath'"
+			echo >&2 "Skipping submodule '$displaypath'"
 			continue
 		fi
 
@@ -702,7 +702,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
+			say >&2 "$(eval_gettext "Submodule path '\$displaypath' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..5991e3c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -462,7 +462,7 @@ test_expect_success 'update --init' '
 	git config --remove-section submodule.example &&
 	test_must_fail git config submodule.example.url &&
 
-	git submodule update init > update.out &&
+	git submodule update init 2> update.out &&
 	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
 	test_must_fail git rev-parse --resolve-git-dir init/.git &&
@@ -480,7 +480,7 @@ test_expect_success 'update --init from subdirectory' '
 	mkdir -p sub &&
 	(
 		cd sub &&
-		git submodule update ../init >update.out &&
+		git submodule update ../init 2>update.out &&
 		cat update.out &&
 		test_i18ngrep "not initialized" update.out &&
 		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&
-- 
2.7.1.292.g18a4ced.dirty
