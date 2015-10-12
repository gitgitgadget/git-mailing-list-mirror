From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: Test a shallow branch
Date: Mon, 12 Oct 2015 14:36:24 -0700
Message-ID: <1444685784-29598-1-git-send-email-sbeller@google.com>
References: <CAELgYhcmzDEVRH9neGwZeqVBduL-nb=d+XoSMwRGKpmLUeX83g@mail.gmail.com>
Cc: git@vger.kernel.org, carlosjosepita@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 23:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlklo-0005XB-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbJLVgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:36:32 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33303 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbJLVg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:36:29 -0400
Received: by pabrc13 with SMTP id rc13so28813239pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/s01Ne6VzL2u+9rvsfq//C33W/5Mpr2MgA3wC2UpH0=;
        b=JtKx7zoBtI2Dea7K7mWJQdA4hR/bip5HcjpfeML9dajGjpUdfpcLL/C0qyVbWj9IE+
         Pa5us4M2qrlXPjx7kkbZgVV/5kOlKwq0chdJXWDIhwqICRWcBBTOPjIkeIV5wW6YLxin
         xZGkFskshY4fY7mk/BcugsWUKHmn6W+yK9gvwM36+J15/Jo/oxNLzVp6WH38UBj4XVX8
         6L1zHKDjXA+DY0+h7zNT7jawfrEwKrofq7L0k7h/I9XuuIROy9kCoRvi2WTgJPFVglzO
         wnI6zKBBM8JV19xdREGrP8QoCXaBI9tbL/Gcozk4N3KeX9NQt8DtSp5lLlX+lSMOg+Gu
         aN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/s01Ne6VzL2u+9rvsfq//C33W/5Mpr2MgA3wC2UpH0=;
        b=EJ+7DrZQpAkOi3VQrtvDs8cayuNgwF/L6+NuxFF9IUwyZ/Rfwm5FZDtMvp50+ps9Ms
         qTRt37n2nC+LeMkSwu1dT278DFlRpEe2eDoAbY3hWpBJyB0FDTIqcJEfkqf8TPkRcKxE
         3hqSfVFmsDLN26FyiagDpZqY1OesUBFR5H12eQkTpGXQnfYg3d7IoM4ChSaTE4v/eygJ
         8naOnHrmTERASex/4epQ/N8CPHr3sx0d+xkAeYx559TZ9GbLCS5p0rMLUskS+OqGZwWc
         maxXrMf45Rbwpbf6Mk3gSUpgLcDcmLuBgCNFc+H7z7ajGldkjYChkItgGxy6SWghuvCi
         U4Vw==
X-Gm-Message-State: ALoCoQnlDLpnb+rXEw4lO6kK3uDDXcSiKQ0n6laki3TBnaEG2DE04a6h7Y2a7mgtQzixGftzG4Ft
X-Received: by 10.68.238.69 with SMTP id vi5mr36713810pbc.29.1444685788397;
        Mon, 12 Oct 2015 14:36:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id qp5sm20092192pbc.43.2015.10.12.14.36.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 14:36:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <CAELgYhcmzDEVRH9neGwZeqVBduL-nb=d+XoSMwRGKpmLUeX83g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279419>

Instead of tracking the submodule at the specified branch, using a shallow
clone, we get the following error:

fatal: Cannot update paths and switch to branch 'anotherbranch' at the same time.
Did you intend to checkout 'origin/anotherbranch' which can not be resolved as commit?
Unable to checkout submodule 'submodule'

Noticed-by: Carlos Pita <carlosjosepita@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Hi Carlos,
 
 I can reproduce your issue and have a patch which we can add to the
 testing suite to document this faulty behavior.
 
 Thanks,
 Stefan

 t/t7400-submodule-basic.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..cee74cb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -846,7 +846,8 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 
 test_expect_success 'set up a second submodule' '
 	git submodule add ./init2 example2 &&
-	git commit -m "submodule example2 added"
+	git commit -m "submodule example2 added" &&
+	git checkout -b anotherbranch
 '
 
 test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
@@ -987,6 +988,7 @@ test_expect_success 'submodule with UTF-8 name' '
 
 test_expect_success 'submodule add clone shallow submodule' '
 	mkdir super &&
+	test_when_finished "rm -rf super" &&
 	pwd=$(pwd) &&
 	(
 		cd super &&
@@ -999,5 +1001,21 @@ test_expect_success 'submodule add clone shallow submodule' '
 	)
 '
 
+test_expect_failure 'submodule add a shallow branch' '
+	mkdir super &&
+	test_when_finished "rm -rf super" &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --depth=1 --branch anotherbranch file://"$pwd"/example2 submodule &&
+		(
+			cd submodule &&
+			test 1 = $(git log --oneline | wc -l)
+		)
+	)
+'
+
+
 
 test_done
-- 
2.5.0.268.g453a26a
