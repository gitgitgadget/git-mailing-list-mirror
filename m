From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/12] git submodule update: Announce uninitialized modules on stderr
Date: Thu, 15 Oct 2015 18:52:03 -0700
Message-ID: <1444960333-16003-3-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuC1-000264-D7
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbJPBwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:21 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34161 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbJPBwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:19 -0400
Received: by payp3 with SMTP id p3so56445102pay.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0gZBY7XYXsyRr+JlP7COBqU3EPTOzQp0gt+IAW3VsM=;
        b=btEZOXzxX2HVcqG5Lx1PqT9xkRMCqG5mqZTsoeWw4y/RmDKQdUyD2tng6pTIW0tueq
         NksGExTQoSdDb5lbIZUaLTvkglSYOG7m9b0E6UNJ4YbWgglLjhhkcQYz5PLn+d9+P8R6
         a/wHB/uUE+5TBts81O3yTDsq59CAC7p2DEdb4ntEskkRwDZ+vVJmKSsG5O8LOfVsUP9r
         I3F0M/Qw5FzdzYPp+R+6vD3LkJvOcyiaXDt39o8mcJUANijhIluU+LMRSyhf2YPoEiyi
         s7ASq6+fw0mwdB+0+Vk0HnUOdSzbQz6HA8aQezPiSwm6OqKWYBKd1YXK9SGAmK+lJHwW
         AUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0gZBY7XYXsyRr+JlP7COBqU3EPTOzQp0gt+IAW3VsM=;
        b=HGD8SERHCANj03FqCAwDDO/BltipB8IxyvHRF1UYp0gYOwtBpx6FicLm32SV/lz+ZM
         QaY3SKhQq1uV69J42CCvxMc2wn8X7QnAn9afjM96kXPrnL7nnutsQo19lrSMYiYmTJzl
         Vm4tBipJRK/q90YYOZVlE5cjlbcOZ34lRHe64dPwK5xrW6BJ4v48BMVyegqTlou+pmxk
         XQBPA9CwBXZRM60v2+LI/8s7afisJBu1i4KRFoEZO5FrzUE8H/KZurc2cujfXFf39JS/
         f9O92UWBbPOdhai3MCXceq7AfHA6gXPoBHE2+KOVh56NSnWnY1mAQUP4+XmXfIin4qR5
         JjGA==
X-Gm-Message-State: ALoCoQkQimmIZHtsZDQUtvmGC6Kw9inIBdoUlhfb4t4Mdlwin0pd5KC97N1D0m733UKpdZAbnVgD
X-Received: by 10.67.4.9 with SMTP id ca9mr13372498pad.90.1444960338638;
        Thu, 15 Oct 2015 18:52:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id gi4sm17813429pbc.4.2015.10.15.18.52.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279714>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           |  2 +-
 t/t7400-submodule-basic.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 578ec48..eea27f8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -693,7 +693,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
+			say >&2 "$(eval_gettext "Submodule path '\$displaypath' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..32a89b8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -462,9 +462,9 @@ test_expect_success 'update --init' '
 	git config --remove-section submodule.example &&
 	test_must_fail git config submodule.example.url &&
 
-	git submodule update init > update.out &&
-	cat update.out &&
-	test_i18ngrep "not initialized" update.out &&
+	git submodule update init 2> update.err &&
+	cat update.err &&
+	test_i18ngrep "not initialized" update.err &&
 	test_must_fail git rev-parse --resolve-git-dir init/.git &&
 
 	git submodule update --init init &&
@@ -480,9 +480,9 @@ test_expect_success 'update --init from subdirectory' '
 	mkdir -p sub &&
 	(
 		cd sub &&
-		git submodule update ../init >update.out &&
-		cat update.out &&
-		test_i18ngrep "not initialized" update.out &&
+		git submodule update ../init 2>update.err &&
+		cat update.err &&
+		test_i18ngrep "not initialized" update.err &&
 		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&
 
 		git submodule update --init ../init
-- 
2.5.0.277.gfdc362b.dirty
