From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv14 4/7] submodule update: direct error message to stderr
Date: Fri, 19 Feb 2016 10:17:10 -0800
Message-ID: <1455905833-7449-5-git-send-email-sbeller@google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:18:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpd1-0001SY-1n
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992867AbcBSSRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:17:50 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36150 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992807AbcBSSRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:17:34 -0500
Received: by mail-pf0-f180.google.com with SMTP id e127so55102680pfe.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOsGF6BlvpcETGhVDjmZTX/o4QdHF9IXxX+Q8oN3gJA=;
        b=INQFdCCtcljqOcE9kXyQhsiKHDFir3Z5FiRgWi5bNcZlrkdIGfW4F+Mgvut7WtwRKn
         K4fnQ+VCJ+yeF9KBy4MaS6rXYE0H8TnHxqD332HUtGRb76CyziptMRPJKVeb5zBsoLH1
         JO1l6+mTPUEwyxN7PRfxB9K2ndD+XN9M9upJupj7rM9erYcsyYVoY/5tub66de/c/I9s
         r3rc5Q4xiVxWCe7LuKWTTlTu55D8WvRjwWKKBfmDsZzmytWanwjIkLpl9lqiBS3g10FJ
         oJNNATzP0DAWT9zS8aZ6AlL34HVDeu+eQWM2VJS+q7wZxnSiDvKIhc+Z9w+WCA4EjiEn
         eLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOsGF6BlvpcETGhVDjmZTX/o4QdHF9IXxX+Q8oN3gJA=;
        b=HveHgbPYKzCYlkSIdm0vM31mGeaOo6TzlgbnBNtJg/pFEYrunkarSH0Nq72AuRd+zY
         QJBuhrAd5uM5w05yy3XdbR1aCeYaoGchfJ74ujJd6YIOqzLayXog0cSuf5ZiEGMfU/Bc
         /t2IxTLQ6xrV3c7eZovo7JiPrkN+6Dz9rJmj95bnOtCgGIz78l7ID81G+Gq4oMrfvhPZ
         keN9CuWsvlKDev7OufDxUb37LngfzShGlVbBlAJE92AP7YSvCk3m3UAVIdjmmn55AwK2
         CTVhI3zDRRyPbi51ny7jCR3iJQAQbxXo/4VRUBvhfd75EOUGdM5Uf95nGPAsCxo033I7
         onLA==
X-Gm-Message-State: AG10YOQZRjTZKH1efrjTBOqx9W7LcaW3jd1CYLb1/WYxG9rKpZdr8TDnGOy05C9Sko3kxpPx
X-Received: by 10.98.87.80 with SMTP id l77mr19944534pfb.101.1455905842939;
        Fri, 19 Feb 2016 10:17:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id o184sm19316463pfo.36.2016.02.19.10.17.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:17:22 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1455905833-7449-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286733>

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
2.7.0.rc0.34.ga06e0b3.dirty
