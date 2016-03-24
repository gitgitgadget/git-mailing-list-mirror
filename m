From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] submodule: add more tests for recursive submodule behavior
Date: Thu, 24 Mar 2016 16:34:28 -0700
Message-ID: <1458862468-12460-5-git-send-email-sbeller@google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 00:34:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEmE-0005nC-2L
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcCXXev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:34:51 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33172 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcCXXeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:34:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id 4so69586418pfd.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1qyC+4Cfj7Y4TdO0GwFbg6jP3mAiVl9SnXOQyBTJOA=;
        b=FHOHlQBYl23PCl4wLidnDU0kWJOnFnO6mJiwszqMSTEYxVCpstyLfxUqgm7ivn6IG2
         MdYOMaLN5f7Q1DUxW1AyuD7w5xmDhU90gDCZGucTnV7K5CUalv1lFgTpQhRgNY1YoaT9
         L6Ve/LJxLQ78G3de7N4GtFcB87VO5uq4YBclh2Hd/fc0c+aampBrkjgfTANkPauE3HKf
         2x6/J8O+3GqkDAtq/J1DyhjsjXconHuUTfauNO8bIbcnUTJQGXfEm0b2sFd1vHMHqi/g
         xDxKjtu6S77ElzcnU5APhNAYv3xvyYEhFJwRCBWcoUgxlP/4/0sCW8Xyki5m+1bxl9WB
         s0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C1qyC+4Cfj7Y4TdO0GwFbg6jP3mAiVl9SnXOQyBTJOA=;
        b=QKel7DV8WH9i6E/QfnJza+4p05NSBa7jAGPsLRm1oeNGizkGVd+47NJWBKp6EmXERw
         Fk+Vwu1tgS28AxIJdlQ/G6wlid3dn5IkadUG7peKsRhsQjGYsKaY7j/I6LtzY2G3wnwU
         U9P3wV/oIlzhoxEQ+nP6YgCRUeIRhkkNqJl1NdUZl3HrXWRB1yu+kmJ2Lqe2winQhMqB
         S4DGvxpHkGC5j2BQBhDZSFe9CIOlBeb14bv5qKw45z+FUAGclxgYfOnbcCF31nfBktFJ
         jM+T6qKG7yhPOYErxhefg/ZitWAFf3UCiO00hVdEjTab8tX1+V9TVZt4v+CPWIlWloiI
         syaQ==
X-Gm-Message-State: AD7BkJJI6HWRFTYZpc3wJBXfVDWPAgVowuRPRIszHI/3BCP5XR+/nKey8p8VJKRU0HDO8guC
X-Received: by 10.98.65.82 with SMTP id o79mr16368702pfa.115.1458862485109;
        Thu, 24 Mar 2016 16:34:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a88b:7b22:8e5b:edac])
        by smtp.gmail.com with ESMTPSA id qh8sm12405134pac.40.2016.03.24.16.34.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 16:34:44 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33
In-Reply-To: <1458862468-12460-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289827>

This adds a test for "submodule update", wich calls "submodule update"
from an untracked repository in the superproject. When doing creating
the parent patch a similar test failed for "submodule sync", but
all tests passed for "submodule update". It took me a long time
to figure out this was a difference in test coverage instead of
commands behaving differently. Let's improve the test coverage such
to make it a better place.

When trying to fix the issue in the parent patch I could get
the test suite passing when removing the $@ argument from module_list
in the sync command. This also indicates a low test coverage, so
fix that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7403-submodule-sync.sh   | 13 +++++++++----
 t/t7406-submodule-update.sh | 12 ++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..5dde123 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -28,6 +28,9 @@ test_expect_success setup '
 		git submodule add ../submodule submodule &&
 		test_tick &&
 		git commit -m "submodule"
+		git submodule add ../submodule submodule2 &&
+		test_tick &&
+		git commit -m "second submodule"
 	) &&
 	git clone super super-clone &&
 	(
@@ -149,15 +152,16 @@ test_expect_success 'reset submodule URLs' '
 	reset_submodule_urls super-clone
 '
 
-test_expect_success '"git submodule sync" should update submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync" should update specified submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync >../../output
+		git submodule sync ../submodule >../../output
 	) &&
 	grep "\\.\\./submodule" output &&
+	! grep submodule2 output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
@@ -177,7 +181,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 	)
 '
 
-test_expect_success '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync --recursive" should update all specified submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		(
@@ -186,9 +190,10 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 		) &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync --recursive >../../output
+		git submodule sync --recursive ../submodule >../../output
 	) &&
 	grep "\\.\\./submodule/sub-submodule" output &&
+	! grep submodule2 output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..628da7f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -774,4 +774,16 @@ test_expect_success 'submodule update --recursive drops module name before recur
 	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
+
+test_expect_success 'submodule update --recursive works from subdirectory' '
+	(cd super2 &&
+	 (cd deeper/submodule/subsubmodule &&
+	  git checkout HEAD^
+	 ) &&
+	 mkdir untracked &&
+	 cd untracked &&
+	 git submodule update --recursive >actual &&
+	 test_i18ngrep "Submodule path .../deeper/submodule/subsubmodule.: checked out" actual
+	)
+'
 test_done
-- 
2.8.0.rc4.10.g52f3f33
