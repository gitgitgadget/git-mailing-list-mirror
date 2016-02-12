From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 4/7] submodule update: direct error message to stderr
Date: Fri, 12 Feb 2016 15:34:37 -0800
Message-ID: <1455320080-14648-5-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEo-0005Uj-36
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbcBLXew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:52 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33019 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbcBLXeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:50 -0500
Received: by mail-pf0-f181.google.com with SMTP id q63so54711468pfb.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTxOi8d66uKiAMK8qSyZDBOfGhxINsKuCUqAGRbB9x4=;
        b=pKmwY+1T35LImvb4KQiW03D2CXEfAXdfmHFjwaYHlQII3yfzLJnxq7LQUk+HARoZPd
         PAQar6BkoVS3HWCM717AoY+5OfrFqOdrzBzOgHFIHUt49XM1b9lSMfJxt68Whnw14/oW
         o54xvTeMbj5rwfJNd7dPifM8TFGPCAOphmRWtkzYa0dZaJ7W//dPmnUGaz9rdkDdfyfg
         a1L0WmutoUnE4HSAWByc6C978VMx2LBzRTC9QN9P22DEyeSl4gNYKEAWfSdtRz87i3Ua
         AeDmxBW2IXJBDTI9bSMA/D7UuxZKO0zC2isQ7Is/8Ms46EMP9Urk2dBUo7FLCyRk/Etp
         OwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTxOi8d66uKiAMK8qSyZDBOfGhxINsKuCUqAGRbB9x4=;
        b=Mk9pVAxa+Lahbf941EvObM00ANmDwBcZvvplqQr3AJAtu1tHyR72lZmjKKxKFlRV7o
         ntFmMCjk0mIvhm2fiItX3PerOl6sqJYJ+wpctTeke3ggqVOyDbYcW+yAJUo4tQX8NAey
         DgYd9+ihs8B/WiOV+JTIp4siQsPF99YZv9ncJ3oXlpt8RcHh26DrNNAy832KX4x7PEDG
         xA7FtTOPNvlSdc2q5NGx/UEOc2W9y11m2vLCMTw7VFuQkUvy8XM2tRg0gJFZVMl/zt3C
         ubdLP6qiy7NOZwh2EXn55sp2kagTGUCx+pL2leJy8qLBzxWASoh/3u9kieShbTUYqMOa
         IdFg==
X-Gm-Message-State: AG10YOSaCrElvUBxFr97HoZ7EwoPPyG+a9tAVFntutboSeyXfEXj8J5mCwfae9EgBvdbpAI+
X-Received: by 10.98.15.135 with SMTP id 7mr5945418pfp.142.1455320089393;
        Fri, 12 Feb 2016 15:34:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id a21sm21843650pfj.40.2016.02.12.15.34.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:48 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286089>

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
