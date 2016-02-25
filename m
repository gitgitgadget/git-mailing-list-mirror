From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 04/11] submodule update: direct error message to stderr
Date: Wed, 24 Feb 2016 19:06:51 -0800
Message-ID: <1456369618-18127-5-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmHS-0001Ao-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759212AbcBYDHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:48 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33488 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759894AbcBYDHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:16 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so24322702pfb.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cH1E57OpDAIlzubZEIt7DKbePgvillGSDwG92x4AT+0=;
        b=V6IHspAe44msXFcTTsQvBzdQEMsSkREvYh+mYw7AfeYggUsw7LQvsBj9r0CHrGOEe1
         X4hhU9uns1JnsJFqgK7TSpYT9EF1/T0Xjkln5WaMbJHrug7YoVdjq0qkIPuBo1AYu9nf
         djV/khJMBMbHIVr+Vn4+dUFwAC5XJ9Ma0ACRJsNcnRAThWUip2Tkn1ws+gJysFl29mk4
         fl/h2j3vveCdRkxvEZkb/B+49CcanD1O7pvw9tnOH5rPX6TpydLI9jkdTkKHKUH1yTle
         vwUWnBB3+r7O7DEnNCEE2ox7pKSCjbktYLipXQ+LhoYoRq5K+ZeWskfD0Se6gwhCRjy4
         fj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cH1E57OpDAIlzubZEIt7DKbePgvillGSDwG92x4AT+0=;
        b=F3HAKwMCVobYmmZcnCmRcTgMWqN4g38ek8zrQfogx78nrwowkjxvOGWeuDLJmDBNpt
         /CJVGrLpnsvCUebGs3F8kSMxV1uhnsgmGbwRHs+/sIqVQmyJTcC5AMGGBYOsxwTLTjLU
         079i8Xh7iXjEM7qO4jrO4ANqKl7z6ZXy50AvMdj3MnJAsLXLeKkMD0apAO/m2ydOI80c
         0URU64IiDokSk+Ch47zP1ggS+UHZFOgQfjfeAccPrGiygVfhEHhOF662d8HDSlgziZKc
         upNP3pvqeYSURLQ51aIWJ7qpWhsNIhOUNJrUGfIREoqZpAfUnvygTj0EupjyOrXL2ka1
         dHtg==
X-Gm-Message-State: AG10YOQt+Lu8iVgYneP1ocnNIddMCVwKLIvSXQlxEOwuD6KLk6xMDa/dVR7voTP5iPjxQ1DC
X-Received: by 10.98.70.139 with SMTP id o11mr59858863pfi.123.1456369629434;
        Wed, 24 Feb 2016 19:07:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id lq10sm7963815pab.36.2016.02.24.19.07.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:08 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287325>

Reroute the error message for specified but initialized submodules
to stderr instead of stdout.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.7.2.373.g1655498.dirty
