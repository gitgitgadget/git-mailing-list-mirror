Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03375C7619A
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 11:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjDBLhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDBLhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 07:37:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F11FD39
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 04:36:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so26611906wrq.4
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680435413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8IxfkyXm5K1GGrTltvAWklrRGE6WqBGvb0tvzAg/d8=;
        b=djBN84UWum2azxn+w54sjWLy7/qCM4sK86oOX9FmsTSWphT6rlkTKjyu+/M+X8oHgl
         97ebSGKCVsskgFTmhBa88sJP0Fh2lc8Fkr3tvsw64dSIze+jr9V0GWe+szRyrdk/jEYE
         O3eYOZEJj9iUsW8jKOPBFIXpA8azHAegTHaYc/2uYbu3/TiKLEEU+zxx5PMTZsXJ0ZtG
         T4waBBwbElbseXKiI7ywRd2dl6p2BArP3dEQuf0/60oKzL7JzErGQH1cUTxRdBqhzy21
         pCBUzszq+3U41HTuSIp4yfIqAaeT4QfnLIeBzzuyJnrajerGSqwaOxTnh/VesABL3AWD
         SHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680435413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8IxfkyXm5K1GGrTltvAWklrRGE6WqBGvb0tvzAg/d8=;
        b=1SBcx1sCEkrEjK9f2k4vTD+A+Cxhtlje1qI9N8H4OcI/PtHU/4lM2sito2DUrKuvRK
         upWrKwn+lP8lOmWl6JxGpSu4CAiFUmRlhxdourjOWQMnD2hKieBfc4w8JYoU525sPwKQ
         11QPiiGU+s9aIQwyNRUFwYCXfDU0W7v2iUqyJVqbZN0alMr46mLjQPsuS45n/EYGMocE
         nUH4qAmgeCKyrks1dZbHDiXsSzNrWcIuDIgXgac3jT3Ezazdmge1d5PeMNiPgWIOubE8
         9MFH5HLiZ5Rlk9m/zK4gwNKzDp2xeEc5NnfhgQepiDR92NXjTQsKgrVzYdA5S0kxmXYK
         UZ9w==
X-Gm-Message-State: AAQBX9d7Qbxwc+jDmr9r8KIRVEVecxbD3hl8BCHAw02WETK1acoNPMWT
        kJXM16BE05UTbMnMLwsq1IsWr+t6MXE9xAoQ
X-Google-Smtp-Source: AKy350ZxS5n5zl8rQFT7o8yNOiqtl6I//QJbF/nO6v8gD1ZkDYtsNxCzvrz4apJBvJxkE73czRif7w==
X-Received: by 2002:a05:6000:114b:b0:2e4:cbef:9f2a with SMTP id d11-20020a056000114b00b002e4cbef9f2amr8644953wrx.2.1680435413460;
        Sun, 02 Apr 2023 04:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2a0c:5bc0:40:2e25:76c6:3bff:fe8a:46ba])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b002de9a0b0a20sm7044343wrx.113.2023.04.02.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 04:36:53 -0700 (PDT)
From:   Edwin Fernando <edwinfernando734@gmail.com>
To:     git@vger.kernel.org
Cc:     Edwin Fernando <edwinfernando734@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSOC][PATCH v3] t3701: don't lose "git" exit codes in test scripts
Date:   Sun,  2 Apr 2023 12:36:07 +0100
Message-Id: <20230402113607.2394-1-edwinfernando734@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401194756.5954-1-edwinfernando734@gmail.com>
References: <20230401194756.5954-1-edwinfernando734@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exit codes are lost due to piping and command substitution:

- "git ... | <command>"
- "<command> $(git ... )"

Fix these issues using the intermediate step of writing output to file.

Signed-off-by: Edwin Fernando <edwinfernando734@gmail.com>
---
Changes from v2:
- use git rebase to squash commit history,
  and diff with upstream commit for review
- use present tense for code before the commit.

 t/t3701-add-interactive.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3a99837d9b..77aad9032a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -292,8 +292,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "n\\ny\\n" | git add -p &&
-	git show :file | grep content &&
-	git diff file | grep "new mode"
+	git show :file >show &&
+	grep content show &&
+	git diff file >diff &&
+	grep "new mode" diff
 '
 
 test_expect_success FILEMODE 'stage mode but not hunk' '
@@ -301,8 +303,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\nn\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff          file | grep "+content"
+	git diff --cached file >diff &&
+	grep "new mode" diff &&
+	git diff file >diff &&
+	grep "+content" diff
 '
 
 
@@ -311,9 +315,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff --cached file | grep "+content" &&
-	test -z "$(git diff file)"
+	git diff --cached file >diff &&
+	grep "new mode" diff &&
+	grep "+content" diff &&
+	git diff file >diff &&
+	test_must_be_empty diff
 '
 
 # end of tests disabled when filemode is not usable
-- 
2.40.0

