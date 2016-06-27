Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD031F744
	for <e@80x24.org>; Mon, 27 Jun 2016 07:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbcF0H0m (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 03:26:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36108 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcF0H0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 03:26:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so22124110wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 00:26:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Azvo6b5KP/y8PpkavoCZ4ZvzYQwAcXFriqvuxBhtzMM=;
        b=x+Ukdwb28oNeAGW3OTS3KaT+wsT6cqYCJZTOtQvehb5Yy6Uc8J/NJ9RysrMSwkADVZ
         /Upg2U64m9ARhnJp7KrCYE5HNqAmA/0llQ3hKRe7Y0YWD9wuM9Agxl7qGWN7AxoZ293j
         y8DBk2vXGnb3hoNmsxiUl/PXJ9T04wOKxthSXjErzEsi4YMApEOWilyD0bjq0f9tIlyB
         x9kt91BH97LDN0a14RDr13Wld5U7wl4HtHUCqpunXMTUzpZZ0Or/Vmq8d/dFK2ZnA3rI
         DXGeBWpCgUKiiU5FwaJHq9lqCmzP3PJPEN+XLXRRKPmMhldVOlgMGPoyAFo1VsSvYi4X
         VjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Azvo6b5KP/y8PpkavoCZ4ZvzYQwAcXFriqvuxBhtzMM=;
        b=MhxIBvL1VgJ6+rEQMyGuubzYH9FDLEFTRFCAnkqG/dc+T8W3P8+V4QpwjPcj7Qgvom
         y4XfwHR5m5P08A1xruu2UQdTuBsgPhGJtW7vOv5pBHnqLaoM1C8BKpe2FroAYokA7htE
         jxjHcKVH/0cso1q3ZDIr5N6ZeEry9Z7cuhcRxkn680zUajR0qMKIGXHwLdc1AYROdAOf
         ZF1DLlowPAyY75N/rHMnk76LUTcLngaSKvSL5PWDGB7Jhzb+VLWzsw5S9TtoVMKyrnwy
         WxGkBO0DW7wrohS9MfdJhtDPpA7ZhMKgwracOQC5QxpVGHbdBMIUutFpzcLt+rnMDcgZ
         QQ0g==
X-Gm-Message-State: ALyK8tKNoHCcaomewYTa2Zjz0pAQSZZAUpxumDOSCgD7CMiYiLIRFOIWGc6ikbr3e6K+vg==
X-Received: by 10.28.129.197 with SMTP id c188mr9597366wmd.46.1467012400194;
        Mon, 27 Jun 2016 00:26:40 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB4A71.dip0.t-ipconnect.de. [93.219.74.113])
        by smtp.gmail.com with ESMTPSA id bh7sm2517121wjb.22.2016.06.27.00.26.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 00:26:39 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	mhagger@alum.mit.edu, luke@diamand.org, vitor.hda@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] git-p4: place temporary refs used for branch import under ref/git-p4-tmp
Date:	Mon, 27 Jun 2016 09:26:38 +0200
Message-Id: <1467012398-7357-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git-P4 used to place temporary refs under "git-p4-tmp". Since 3da1f37
Git checks that all refs are placed under "ref". Instruct Git-P4 to
place temporary refs under "ref/git-p4-tmp". There are no backwards
compatibility considerations as these refs are transient.

All refs under "ref" are shared across all worktrees. This is not
desired for temporary Git-P4 refs and will be adressed in a later patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Please note: As mentioned in $gmane/297703 I am no expert for the Git-P4
branch import. I post this patch to make the Git-P4 unit tests working,
again. Critical review highly appreciated :-)

Thanks,
Lars


 git-p4.py                | 2 +-
 t/t9801-git-p4-branch.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b6593cf..6b252df 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
         self.useClientSpec_from_options = False
         self.clientSpecDirs = None
         self.tempBranches = []
-        self.tempBranchLocation = "git-p4-tmp"
+        self.tempBranchLocation = "refs/git-p4-tmp"
         self.largeFileSystem = None

         if gitConfig('git-p4.largeFileSystem'):
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 0aafd03..8f28ed2 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -300,7 +300,7 @@ test_expect_success 'git p4 clone complex branches' '
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
 		! grep update file2 &&
-		test_path_is_missing .git/git-p4-tmp
+		test_path_is_missing .git/ref/git-p4-tmp
 	)
 '

@@ -352,7 +352,7 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
 		! grep update file2 &&
-		test_path_is_missing .git/git-p4-tmp
+		test_path_is_missing .git/ref/git-p4-tmp
 	)
 '

--
2.5.1

