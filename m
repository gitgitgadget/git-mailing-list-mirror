From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 04/11] submodule update: direct error message to stderr
Date: Thu, 25 Feb 2016 15:48:32 -0800
Message-ID: <1456444119-6934-5-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5eZ-0008Ca-2i
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbcBYXsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:48:54 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34532 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcBYXsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:53 -0500
Received: by mail-pa0-f54.google.com with SMTP id fy10so40218578pac.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=veOa7UbyW66FxpG/HGX3J0xysuplbTPQHnxgPapN9Kw=;
        b=KZJSl99TIuo+IlToqXTBmpHqyRS7tah0FfePp525xW0xAwwh//riaJ/cJr8U5x0G5S
         B0nwCAZHJSE3WMfYtNEjl6UdTNsaxjK0e6OInoegCWsNVUvp0V2sj08eYxJluZfQibEI
         Mflk497gLVJQmACy09TStER4FXinH80Y8c6vaHkpB8fvOB1YY7DZK19dVcUMzlQnQyEF
         o4Q4jXjXGQhMIQfShRYaULOn0A01qC2Y1MAh897b1xKc5OVBWUbZrTe42EQVY2tIAfLt
         EQStziev4R8s6EsfJpqpqVmFdxFM1brsUqnmP6jl+g0nsfdkHAxPvPnckGxNrrCIz9A3
         xvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=veOa7UbyW66FxpG/HGX3J0xysuplbTPQHnxgPapN9Kw=;
        b=etqNXk2rxDsi3UQfA3D13yp7kabPTtHGFN5LJFJ5+MED8ym73aL1YyDQFm1m/OP+kc
         vjtID3WZGV1229I4Z9Hc4xsFxQWDfleZkFEGuEs46Bnp2hbrPpaSKkfDS05+aTe7Lj/F
         Iv272nDPGl+gZICUiLSDGGp1QSJ17n1KpudXZi1HY6UiEwNOXvuCieHECGP/YeWtV3It
         EUOCpUVEBCDYbuXG73aNGVa035on3fe+yJyzgnaeF4+P1j27S/yrq7q3Hbix+0ckDA74
         Wy4hj9vQIgRsQd2yiQm7CgcWzb36SxGILKIY3hK061+Daar+D1m37ucvVPOaL3xyn8MV
         xgyA==
X-Gm-Message-State: AG10YOR5W61BnRY87mljbDzb1AJMHqFIof6gzJaQQCEBVM9jdFBgwVoThPZwMa87L3KEfunX
X-Received: by 10.66.55.73 with SMTP id q9mr66842670pap.50.1456444132449;
        Thu, 25 Feb 2016 15:48:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id r77sm14595662pfa.47.2016.02.25.15.48.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:51 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287501>

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
2.7.0.rc0.36.g75877e4.dirty
