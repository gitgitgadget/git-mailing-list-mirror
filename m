Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5BFC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiL2Q6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiL2Q6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 11:58:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3DF03A
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 08:58:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso7042611wms.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tL5JMqKJgzVtVHgN5fO33l2HxiL72xhZXb7JZB7n4U0=;
        b=DC+4yRZrZ0y/YXNS1XX+gbHqxX3La2ooFak+T8yQ5sUcuDFv395D4wc1ORzixqMF6D
         PXLg8VDTxTnWlEWAlkcsFQhQxO9zLBTmtL8tMUJaDQSU6zZReanMVWbGSHywnekHatVq
         UHts1+ePFnsGgRAif4cIV/BgBBXgQqFBlGj42fQ6659WidhsrXXzK3yu/GiQ6Gd5dktP
         +JzoxVIEOGVXsAUjwrJBF3axgIJACJCtVKLkRK2RRQpdl35qdqzJZiZU/TYK/BD4Ue3d
         DueTEw85nFwfPOVCMBZHGiAVZV9CnPXu8SfRJR2d4RjBFmEyqP+YUi5PhMTTVNIYxmXc
         BPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tL5JMqKJgzVtVHgN5fO33l2HxiL72xhZXb7JZB7n4U0=;
        b=gU/COdzWzBW8kP9DGWbAHy2N/FQm+VzDZeHG7IJ7JZ94IehTjs6ywKr/wHG1d+CJEZ
         wAH5WdbHLOYx5dQKvi8nCkxFdL2pXExTFa8AJzeV4RJJ80R97ZJc9LoDE7M9ewasxOaV
         txdWvHZ7yMdJrkP+qLnE7ciHU3vE+/LLxQ/zi5xzrDX9DOQq58qWhk+r3HVOGAhLabVM
         /5V1nSVMW1LUq7jNncntXs86/BrB0NjQiQZz2mbD2BlGcXwRA9bwF1E6ejmPeJlVJv30
         XcYMkeMafyPG1zLkPAUVRNTKO3xPc5AXVeh9LNYnhPxlqltpppRzCpl2xhVC0bkTwKhk
         xsTQ==
X-Gm-Message-State: AFqh2kqgwvmQljpwAmAii7zBZ6sWkEIaIfWdK0ycgGfgy9MpTOsQrUyp
        1me0m6i+sCZzyjJGhcc8f4HOzdS/plI=
X-Google-Smtp-Source: AMrXdXsZgyzQ1WcCeq43ClHrV7CnzmsmWElccS6idaj8ozfCfakOHMYFrPGeOesre4iVRT3GSlpNwg==
X-Received: by 2002:a05:600c:4c21:b0:3d3:468e:cedf with SMTP id d33-20020a05600c4c2100b003d3468ecedfmr20649031wmp.16.1672333123107;
        Thu, 29 Dec 2022 08:58:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003b4ff30e566sm49057922wms.3.2022.12.29.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:58:42 -0800 (PST)
Message-Id: <pull.1418.git.git.1672333122193.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Dec 2022 16:58:42 +0000
Subject: [PATCH] grep: simplify is_empty_line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    grep: simplify is_empty_line
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1418%2FAtariDreams%2FisEmpty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1418/AtariDreams/isEmpty-v1
Pull-Request: https://github.com/git/git/pull/1418

 grep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936..f29f4dd9e08 100644
--- a/grep.c
+++ b/grep.c
@@ -1483,9 +1483,10 @@ static int fill_textconv_grep(struct repository *r,
 
 static int is_empty_line(const char *bol, const char *eol)
 {
-	while (bol < eol && isspace(*bol))
-		bol++;
-	return bol == eol;
+	while (bol < eol)
+		if (!isspace(*bol))
+			return 0;
+	return 1;
 }
 
 static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)

base-commit: 6bae53b138a1f38d8887f6b46d17661357a1468b
-- 
gitgitgadget
