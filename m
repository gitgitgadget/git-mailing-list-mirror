From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/10] submodule deinit: send messages to stderr
Date: Fri, 29 Apr 2016 17:40:41 -0700
Message-ID: <1461976845-18228-7-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyN-0006nO-6I
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbcD3AlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:21 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35463 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbcD3Ak7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:40:59 -0400
Received: by mail-pa0-f45.google.com with SMTP id iv1so51668497pac.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pFKZ8+fHU6fy4zvjmbS68h3FFmC5R8xMF3LYCGBzulk=;
        b=E/CxQ9VW5/rmGxr9qDf5T3W4txEJPWBGy3PHugHXwmK/aBJ4mIOM9zwXyxzjmquohB
         eSnjhqeS1OgOdbk/YHYvslLy1suSe4pHOjaEaxgxAjwNKgLZ58L5IUq+K3Q8rMPJw1lz
         2ZnmaA8dn3SMOQzNa9lSaldZbJRBHx+/CWMQVDeZ5XYaTXNytJhht1NINbUwIRrlEy+1
         hv4oSUykxuSByRyyD2coPsb5lKHVzlj3l3cXDA/+FELUXUJsz9aibXsdZU0u6uf7lsQA
         xtqMgmI0dOKq8AHwf3+q5aBfk4Y0BSDuMJrWaJ4A2Q+bbR9RFtrMi+q5/3BJplyzWtTW
         i70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pFKZ8+fHU6fy4zvjmbS68h3FFmC5R8xMF3LYCGBzulk=;
        b=UrvQ2kgR+DvHN/SDr4g7wVWuS8wfj9lco6wNx3o2CIz/WuwEiKpnOc5uy5TcbHoLPb
         x8Pj4hZXhhh4XQMvfoPmvMX6DDk9GIYr+k6rtemTbGOUw3zUcwNZc2wULb7RU8XBwKGu
         UVKr7kj4DIPIVGuCiNAF9h1XhHEIjdZb+a/2iCG15vM6YyBCCNZ0WzoY9PbpfeK9Br03
         xE7/PC+Yk1t5XmowT5PzCdYp6zgPx92IFrQ77sF+rK2sofWVg9KLAkIAiBrNUgpdjELk
         NJ2urwskd9dnlJJhi4boLP6XYpSKcjqq8cChPPevC18TEf0DvA6FmyAgI5XEGbgIFQ1s
         qmBg==
X-Gm-Message-State: AOPr4FXnkVbsjHUf/reh9RY1xPkn0666Q01Hwmgdq/sMEC3WwHNvHgwzpW3KrUEbBAKdnFVJ
X-Received: by 10.66.190.131 with SMTP id gq3mr33060829pac.42.1461976858012;
        Fri, 29 Apr 2016 17:40:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id p80sm26406663pfj.58.2016.04.29.17.40.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293095>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           |  8 ++++----
 t/t7400-submodule-basic.sh | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f4d500e..3f67f4e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -452,11 +452,11 @@ cmd_deinit()
 				die "$(eval_gettext "Submodule work tree '\$displaypath' contains local modifications; use '-f' to discard them")"
 			fi
 			rm -rf "$sm_path" &&
-			say "$(eval_gettext "Cleared directory '\$displaypath'")" ||
-			say "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
+			say >&2 "$(eval_gettext "Cleared directory '\$displaypath'")" ||
+			say >&2 "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
 		fi
 
-		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
+		mkdir "$sm_path" || say >&2 "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
 
 		# Remove the .git/config entries (unless the user already did it)
 		if test -n "$(git config --get-regexp submodule."$name\.")"
@@ -465,7 +465,7 @@ cmd_deinit()
 			# the user later decides to init this submodule again
 			url=$(git config submodule."$name".url)
 			git config --remove-section submodule."$name" 2>/dev/null &&
-			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
+			say >&2 "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
 		fi
 	done
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a6231f1..53644da 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -935,7 +935,7 @@ test_expect_success 'submodule deinit from subdirectory' '
 	mkdir -p sub &&
 	(
 		cd sub &&
-		git submodule deinit ../init >../output
+		git submodule deinit ../init 2>../output
 	) &&
 	grep "\\.\\./init" output &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
@@ -948,7 +948,7 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
-	git submodule deinit . >actual &&
+	git submodule deinit . 2>actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
 	test_i18ngrep "Cleared directory .init" actual &&
@@ -959,7 +959,7 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
 	git submodule update --init &&
 	rm -rf init example2/* example2/.git &&
-	git submodule deinit init example2 >actual &&
+	git submodule deinit init example2 2>actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
 	test_i18ngrep ! "Cleared directory .init" actual &&
@@ -973,7 +973,7 @@ test_expect_success 'submodule deinit fails when the submodule contains modifica
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
 	test -f example2/.git &&
-	git submodule deinit -f init >actual &&
+	git submodule deinit -f init 2>actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init
@@ -985,7 +985,7 @@ test_expect_success 'submodule deinit fails when the submodule contains untracke
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
 	test -f example2/.git &&
-	git submodule deinit -f init >actual &&
+	git submodule deinit -f init 2>actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init
@@ -1000,7 +1000,7 @@ test_expect_success 'submodule deinit fails when the submodule HEAD does not mat
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
 	test -f example2/.git &&
-	git submodule deinit -f init >actual &&
+	git submodule deinit -f init 2>actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init
@@ -1008,17 +1008,17 @@ test_expect_success 'submodule deinit fails when the submodule HEAD does not mat
 
 test_expect_success 'submodule deinit is silent when used on an uninitialized submodule' '
 	git submodule update --init &&
-	git submodule deinit init >actual &&
+	git submodule deinit init 2>actual &&
 	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-	git submodule deinit init >actual &&
+	git submodule deinit init 2>actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-	git submodule deinit . >actual &&
+	git submodule deinit . 2>actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-	git submodule deinit . >actual &&
+	git submodule deinit . 2>actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-- 
2.8.0.32.g71f8beb.dirty
