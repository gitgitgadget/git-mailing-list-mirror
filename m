From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 04/11] submodule update: direct error message to stderr
Date: Thu, 25 Feb 2016 15:08:21 -0800
Message-ID: <1456441708-13512-5-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ521-00089u-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbcBYXJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:07 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35419 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcBYXJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:04 -0500
Received: by mail-pf0-f182.google.com with SMTP id c10so41930646pfc.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=veOa7UbyW66FxpG/HGX3J0xysuplbTPQHnxgPapN9Kw=;
        b=NF7E8rPhrvls4wKy6hDaUJ5YxhPOtCW4KKnEf6+3l+65Glx2k0Qbc6xcO3yAOo4Lhu
         5N7bAuRi6ucDf1/Axa3jZqlePkJYxM/s+sfamAeQMSC17TZjbxE8rqOB8M+T/bhgOuTQ
         1zAjx8OFLco7uvtz1I0e78UUKEAVIzQJ4PFyGAuevdqvGIdQBrJrmtBUlEchLoqSAA7s
         4cG6vk0BEMa2LoHkxT3TEnI/Di1rAWiM4+nQLoH146N1jZmFiu+2D9qvfJBZBVp/XSpv
         MpJZRxko9XKVGLSwt8zMI17ztuWArp0Jx7l7Hc0O62nUnITpu/XYsat+XfYoCQSRFnJ1
         xr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=veOa7UbyW66FxpG/HGX3J0xysuplbTPQHnxgPapN9Kw=;
        b=M84bW2dw1v9GhGPesH/epoKzmDWVe404DsepCiGZwE4x68fbz75wN7SBeie1Ncm+kH
         lPowNoN+fgvhC7zb8+42BpIBb+Y7KTlwDTVN1Mwr58A7U13+tg1kgywMltybzbpp+KV4
         K4sVXqz6GEHrbsB2i6fEQSCexuGoAkHc4+jGK5ZW4t2epec4YoxwvNl2TAHE8hfcbaI3
         X1wsPCBkPhIkcttIAuQSg4Y1UZIl68Y/sHJk3QXuhdEbTtr/JkMR2uMlg1lyltnwzjvx
         s+6NbC8CKzl5pcxtd0mR4T3CVrkj9t4KXq6Ltct6ekxScgV8ir2Oky+hgzQHvcs1UtM4
         RvFg==
X-Gm-Message-State: AG10YOQ1yjZ7enBoLyJxoZRqY7sTyBuRvU/P/GwFp/O60dJOKkX2Z6WA0XkH8fj98UvcSAXP
X-Received: by 10.98.13.68 with SMTP id v65mr66367560pfi.150.1456441743391;
        Thu, 25 Feb 2016 15:09:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id ux2sm14517795pac.46.2016.02.25.15.09.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:09:02 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287475>

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
