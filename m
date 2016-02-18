From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 4/7] submodule update: direct error message to stderr
Date: Thu, 18 Feb 2016 14:19:21 -0800
Message-ID: <1455833964-3629-5-git-send-email-sbeller@google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 18 23:19:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWvR-0005mx-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946984AbcBRWTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:19:41 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35016 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946730AbcBRWTe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:19:34 -0500
Received: by mail-pa0-f49.google.com with SMTP id ho8so39127674pac.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 14:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MvvEYHK92ZNZPdnopBgfZTbjRtFT9g8rcXl2Lalbges=;
        b=ThmEN3bMLYCJKinSYmeZ8mCo3hBS9wg4Rt4Xcv/YKnqSrnK0x2IEkkqxJUStS34N7D
         nQ1trNu15S3Qx9G9OjrZUe14Ux2UWvuMTD1oi8ajjt9NBwD1R4sf0NoPMCIBcoIGhesO
         yWlk9ZP836/7ZdFMNXNvJtShExelyakP5eCrMq7tg2eDrMl+6tRwGWiiIJJyz0g6dIaM
         wKd7L8bqfIYNL83cGN56Orux7+QKNVa/YXdoLUphrrHe8DoASNOyRZqBOlsLeJFVM2Oe
         NTtz9i34i5Qpr/YaNEcrZWzDPOKy9E1DrFLpYCDkZUbGIO1BwXLmY2e8I0Z5A6f/DqON
         070Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MvvEYHK92ZNZPdnopBgfZTbjRtFT9g8rcXl2Lalbges=;
        b=gnICNdDyQev1FHKWrdaHGv8XSOqqBeQ2f9VS0wGQF/glew8xxR10b8F57hmAvxhh49
         5QboZISpI83UzK8Qe1Z4L1nNIH7hrENT2KI0tKiTuAxLZ+IA2Ib5LRZHCR680QSrj1sy
         nb75SSvWnqifFeLb1enkDgNdg9CfuhGSYFW2l/nl8PslDlnKhMtq2nJclnlEvRVtAnZ1
         lAcDmy7PFFWTssf9IS5mUFIJ/+6OdbC+JyVJdiVu8GG2LjnjVkYnkTq3OoY25zu+AXcg
         7a1iRTzp+qqARTsNqd9TUqrfcDmyw8XhkwCL9ASlSlEQesff++u58l+YF8YZC15cvG69
         dgEg==
X-Gm-Message-State: AG10YORiTBO5pHsUuHBiHPbMIBaLB9Cqn17+Kdh9Qd09JOGZv8VR9EQy6LRGbDfmn2Y066Va
X-Received: by 10.66.55.39 with SMTP id o7mr13425278pap.13.1455833973255;
        Thu, 18 Feb 2016 14:19:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id d81sm12582076pfj.77.2016.02.18.14.19.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 14:19:32 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455833964-3629-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286631>

Reroute the error message for specified but initialized submodules
to stderr instead of stdout.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.7.0.rc0.34.g65aed89
