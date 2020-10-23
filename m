Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E538C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F029921D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZfRIibC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbgJWQBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464808AbgJWQBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B46C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j7so2469973wrt.9
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xTh0/ZwZW6Ma8rEW81J5QgP6ZpGakFVaDbdYOH/CrOM=;
        b=iZfRIibCjadzxVHkbms8ZSYBQdmLx0Fb3MHsaDZKLdwK1C4/xxMJK2MBk97wvVomip
         XqmkfGuMz8DqpMnQJyC7bT1udmsvsOpRtGL3KvPMMxaXochw20sTePEpUPLOnH+y3bZy
         uyhMGZxlzvYlydxnsc+rDQH+hE6EzkIvHPR3Qx+dsMy2IiQYZKauZCDttPMel/iHn8HW
         q0XaUHnMIyRFlH5yObIMwKZ0SuN2euTTuYp0Vaugf6qNgvLuEqyNl9vTpJstRpT+xVLZ
         2btXthFc19gPuHl3mc18QsWLHxcOtPc4C3Nd2VPWJ9CxMEFYtIKuEYZBPseChUcpXAwo
         2KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xTh0/ZwZW6Ma8rEW81J5QgP6ZpGakFVaDbdYOH/CrOM=;
        b=FL3PFDl2ORWXEA88cov4Vxsu/FGic7IwIVHmgwngPn7EEQBQtgkC749iUBQcQA+rnQ
         rsLk47KzAk2jFN5k+8rx4EmvXICJvI6TFRj6rIERpDMbBHQZHLQEmNsqDBJyUdCczKa7
         XVU9NTDQXvctJP5cGaXsExFGtDg9D+WKdIhiC5L/lOQSsI4JX8sRc5w44qQwLz21Nwy2
         BYVu1sXyAVnx8szN/itpcsVky60V2bsSKsYpgahCjsc6hCAMAyZB8tEhRfqUjCvabOu/
         gJYMVJNEHR55BA/RpACK6Biir4E0qGU+f9vi0rNEgHZ8U2FxfgHqqXKV65KNSj/d74ii
         28ZQ==
X-Gm-Message-State: AOAM531Ri9Z2O8j+gwuwDavbAmB/4mJX/0urJCCvckbXZQd0miTjFOhI
        kk8fIuVzw5TXxXKmy6OCXEYxF6vr85s=
X-Google-Smtp-Source: ABdhPJxThrAnXzkGcpQSHQHCfUnCoQrvpsuJz2Bn2+IZmShmeg4YZiuhpiKy5Se6VHlhpm9KXn2okg==
X-Received: by 2002:adf:8484:: with SMTP id 4mr3486591wrg.334.1603468889648;
        Fri, 23 Oct 2020 09:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a185sm3878492wmf.24.2020.10.23.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:29 -0700 (PDT)
Message-Id: <554feb2aa734367bd9fcd4dd63726c985514be2a.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:19 +0000
Subject: [PATCH 4/9] t6404, t6423: expect improved rename/delete handling in
 ort backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When a file is renamed and has content conflicts, merge-recursive does
not have some stages for the old filename and some stages for the new
filename in the index; instead it copies all the stages corresponding to
the old filename over to the corresponding locations for the new
filename, so that there are three higher order stages all corresponding
to the new filename.  Doing things this way makes it easier for the user
to access the different versions and to resolve the conflict (no need to
manually 'git rm' the old version as well as 'git add' the new one).

rename/deletes should be handled similarly -- there should be two stages
for the renamed file rather than just one.  We do not want to
destabilize merge-recursive right now, so instead update relevant tests
to have different expectations depending on whether the "recursive" or
"ort" merge strategies are in use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6404-recursive-merge.sh          | 14 +++++-
 t/t6423-merge-rename-directories.sh | 70 ++++++++++++++++++++---------
 2 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index 332cfc53fd..b1c3d4dda4 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -118,12 +118,22 @@ test_expect_success 'mark rename/delete as unmerged' '
 	test_tick &&
 	git commit -m rename &&
 	test_must_fail git merge delete &&
-	test 1 = $(git ls-files --unmerged | wc -l) &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 2 = $(git ls-files --unmerged | wc -l)
+	else
+		test 1 = $(git ls-files --unmerged | wc -l)
+	fi &&
 	git rev-parse --verify :2:a2 &&
 	test_must_fail git rev-parse --verify :3:a2 &&
 	git checkout -f delete &&
 	test_must_fail git merge rename &&
-	test 1 = $(git ls-files --unmerged | wc -l) &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 2 = $(git ls-files --unmerged | wc -l)
+	else
+		test 1 = $(git ls-files --unmerged | wc -l)
+	fi &&
 	test_must_fail git rev-parse --verify :2:a2 &&
 	git rev-parse --verify :3:a2
 '
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 5ea77564d7..f9a3f24039 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -1271,17 +1271,32 @@ test_expect_success '6a: Tricky rename/delete' '
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 2 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
 
-		git rev-parse >actual \
-			:0:y/b :3:y/c &&
-		git rev-parse >expect \
-			 O:z/b  O:z/c &&
+			git rev-parse >actual \
+				:0:y/b :1:y/c :3:y/c &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c  O:z/c
+		else
+			git ls-files -s >out &&
+			test_line_count = 2 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >actual \
+				:0:y/b :3:y/c &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c
+		fi &&
 		test_cmp expect actual
 	)
 '
@@ -1934,17 +1949,32 @@ test_expect_success '7d: transitive rename involved in rename/delete; how is it
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 3 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
 
-		git rev-parse >actual \
-			:0:y/b :0:y/c :3:y/d &&
-		git rev-parse >expect \
-			 O:z/b  O:z/c  O:x/d &&
+			git rev-parse >actual \
+				:0:y/b :0:y/c :1:y/d :3:y/d &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c  O:x/d  O:x/d
+		else
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >actual \
+				:0:y/b :0:y/c :3:y/d &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c  O:x/d
+		fi &&
 		test_cmp expect actual
 	)
 '
-- 
gitgitgadget

