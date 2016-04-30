From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/10] submodule update: send messages to stderr
Date: Fri, 29 Apr 2016 17:40:43 -0700
Message-ID: <1461976845-18228-9-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyF-0006iW-J9
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbcD3AlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:03 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33065 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbcD3AlC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:41:02 -0400
Received: by mail-pa0-f52.google.com with SMTP id zm5so57500366pac.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UgG4HbX7a0TcyPgN/oL+WwYWn138UQL/dkhGDJb8mfI=;
        b=EXY4D4z/WQuz2S8bkH4jmWytN29VF22da4AbZiKq3nDoyPa5jgcU7PCOwEIC3U1cr3
         gNeF9zUDyxa0bHZfLBFNexeQ4n+WG2nFiDZUQFI/DupUd5gbCnkpXr79tHYD++HOphXD
         83AJyEHjW6D+nC2CrIDkxr6YE2tpCyi1BhDlRJrAYmBnmoVdEBbo1Qq3LgEOWYDiTqab
         rhpcauJrFOmNP4PK333MFB77VYwMcajOHAIdeseVJVr6nsL1UH+sfKH2wWkapI3g13Jn
         CjAAvVrftwc66v9Rbq8f0UTLf++8sCbAVlgvLuRruB7PiOGX+mFrz+8nRQhqLqUB3IyG
         Qygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UgG4HbX7a0TcyPgN/oL+WwYWn138UQL/dkhGDJb8mfI=;
        b=aRYe6SxWR/JSbyIOOFC+9Xvw7qlgiWVYRzRRWJxnX1DpMxvJu8LgemGB4Xo66P4clN
         LIyEBxqIWPGcwrmi/kk8HkVD97c+AI/ivGEQlswy3Udc2YamiDafHjiVxJlKYQEh6dZW
         x4p2J6YUxHPtZG0fqhliigO0g+VMMNn1JNSoLLt2dvxPee061Ix9YBZAe2JxAJX+8bYD
         AyXbC7rRTW5cs/3EPcYIxzoU+xlefQkGHS89Ox++9h6MFAXrayyNE1aIhkzUl1p6WhhU
         SI3+/vA49g6oZXHs1aiiYJ3VDVpLzJkoOY1A2Nmwe0ymfUZChdlhuQpCJs3H38Cpsjui
         C5ZQ==
X-Gm-Message-State: AOPr4FUisr+6AuUMEPbNJ2xrXwJ9BsfZUUrfoUlGaHrks6RnMQcK+azy3q0AQuEATCOTlOL0
X-Received: by 10.66.148.42 with SMTP id tp10mr33739915pab.159.1461976860887;
        Fri, 29 Apr 2016 17:41:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id m190sm26420735pfm.29.2016.04.29.17.41.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:41:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293090>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  2 +-
 t/t7406-submodule-update.sh | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 80270db..c86c2e5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -679,7 +679,7 @@ cmd_update()
 
 			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
 			then
-				say "$say_msg"
+				say >&2 "$say_msg"
 			elif test -n "$must_die_on_failure"
 			then
 				die_with_status 2 "$die_msg"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 5f27879..1f8faa8 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -106,15 +106,8 @@ rebasingsha1=$(git -C super/rebasing rev-parse HEAD)
 submodulesha1=$(git -C super/submodule rev-parse HEAD)
 pwd=$(pwd)
 
-cat <<EOF >expect
-Submodule path '../super': checked out '$supersha1'
-Submodule path '../super/merging': checked out '$mergingsha1'
-Submodule path '../super/none': checked out '$nonesha1'
-Submodule path '../super/rebasing': checked out '$rebasingsha1'
-Submodule path '../super/submodule': checked out '$submodulesha1'
-EOF
-
 cat <<EOF >expect2
+Submodule path '../super': checked out '$supersha1'
 Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
 Submodule 'none' ($pwd/none) registered for path '../super/none'
 Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
@@ -127,6 +120,10 @@ Cloning into '$pwd/recursivesuper/super/rebasing'...
 done.
 Cloning into '$pwd/recursivesuper/super/submodule'...
 done.
+Submodule path '../super/merging': checked out '$mergingsha1'
+Submodule path '../super/none': checked out '$nonesha1'
+Submodule path '../super/rebasing': checked out '$rebasingsha1'
+Submodule path '../super/submodule': checked out '$submodulesha1'
 EOF
 
 test_expect_success 'submodule update --init --recursive from subdirectory' '
@@ -136,7 +133,7 @@ test_expect_success 'submodule update --init --recursive from subdirectory' '
 	 cd tmp &&
 	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
 	) &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	test_cmp expect2 actual2
 '
 
@@ -156,8 +153,8 @@ test_expect_success 'submodule update does not fetch already present commits' '
 	(cd super &&
 	  git submodule update > ../actual 2> ../actual.err
 	) &&
-	test_i18ncmp expected actual &&
-	! test -s actual.err
+	test_must_be_empty actual &&
+	test_i18ncmp expected actual.err
 '
 
 test_expect_success 'submodule update should fail due to local changes' '
@@ -790,7 +787,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	rm -rf super_update_r2 &&
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
-	 git submodule update --init --recursive >actual &&
+	 git submodule update --init --recursive 2>actual &&
 	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
@@ -858,7 +855,7 @@ test_expect_success 'submodule update --recursive drops module name before recur
 	 (cd deeper/submodule/subsubmodule &&
 	  git checkout HEAD^
 	 ) &&
-	 git submodule update --recursive deeper/submodule >actual &&
+	 git submodule update --recursive deeper/submodule 2>actual &&
 	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
-- 
2.8.0.32.g71f8beb.dirty
