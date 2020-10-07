Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D06C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B6E20872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4csAjmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgJGHpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgJGHpy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:45:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFE5C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:45:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c6so574968plr.9
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkvB3G62TFKpE81EEzyUox61+9m/2ksYD1FBXeYodyc=;
        b=j4csAjmd374X4Rlb3VCXxSkXKQBlrUzXBx2i2mBDKMU3ngkpVyfpRP6ml53FXUEdwi
         ZjgtwXS5U+ZLLlJep5HwmuM6gomTvIQyHNOwY5PWqfHdw9IiPVrO8whN8TpON9CV83Bt
         TsPzel4wRiTknsffqVLPn5kAB3vPBXiapfNRfs7HW9ljIAI5chVn8gfS5IT3jYtAGV4Z
         u87W3N17lpMRBxdsSBH7MHae3jQAtH51aVGDbdtSruqFKo5xMs9NUbcW4IxnJ/URWYit
         mBjshy8Lj48FE1ggEaaJy4CN3Hp8vC/QvkCa7r9WhAna1ePZEK2K/DQ9+CrGl63BueBF
         PugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkvB3G62TFKpE81EEzyUox61+9m/2ksYD1FBXeYodyc=;
        b=Q6PLde8snPIebZipQGQDlHULnfnt2cnxa871vWowwmOt8/MuHorOeAzRDOfsXiMaZX
         t8JWV3HJlzMhhKRKLvoCRF+Jq2sWIswKSAdbhd2wBROHETNKF2mIvxtMIFYMuKW7WJ31
         3ynchq95OzndLfW4zIpdlrNkCf/ZNneuuKy83mm6+U7wB7Z5V44WdT96evRP5vlucHJM
         m31HgWHxLufv8T0+yOqwOFvT9ARjkGcvOJuiXoPeULwuHK/bhG5CGYfHQzchVRynOnGU
         SEx8IPGEeQsBu/sRda5C3GxV+UM5gETos42iF+KIaWnmZFYLJ69JKfSU8GJ7SljZR/s9
         D/qg==
X-Gm-Message-State: AOAM531V5rnT3XLRBWCHzjilW/+w4l/N9A8IhBZKW9o4AKmy1XYCbu4T
        yrnCNxOvb0QMz5oaFiL+3EUEGLKOCELrWw==
X-Google-Smtp-Source: ABdhPJwhXb1bKNlq/yVXVlWsdKRh0EEJuGdXHZNjnoWT6qp8+QejVc4mMpa1WoJedcywrQ/p//kxQQ==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr1839618pjg.60.1602056753741;
        Wed, 07 Oct 2020 00:45:53 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.141])
        by smtp.gmail.com with ESMTPSA id o17sm1273728pji.30.2020.10.07.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:45:52 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 1/3] dir: change the scope of function 'directory_exists_in_index()'
Date:   Wed,  7 Oct 2020 13:15:36 +0530
Message-Id: <20201007074538.25891-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the scope of the function 'directory_exists_in_index()' as well
as declare it in 'dir.h'.

Since the return type of the function is the enumerator 'exist_status',
change its scope as well and declare it in 'dir.h'.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 dir.c | 10 ++--------
 dir.h |  9 +++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 78387110e6..e67cf52fec 100644
--- a/dir.c
+++ b/dir.c
@@ -1655,12 +1655,6 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
 }
 
-enum exist_status {
-	index_nonexistent = 0,
-	index_directory,
-	index_gitdir
-};
-
 /*
  * Do not use the alphabetically sorted index to look up
  * the directory name; instead, use the case insensitive
@@ -1688,8 +1682,8 @@ static enum exist_status directory_exists_in_index_icase(struct index_state *ist
  * the files it contains) will sort with the '/' at the
  * end.
  */
-static enum exist_status directory_exists_in_index(struct index_state *istate,
-						   const char *dirname, int len)
+enum exist_status directory_exists_in_index(struct index_state *istate,
+					    const char *dirname, int len)
 {
 	int pos;
 
diff --git a/dir.h b/dir.h
index a3c40dec51..e46f240528 100644
--- a/dir.h
+++ b/dir.h
@@ -370,6 +370,15 @@ int read_directory(struct dir_struct *, struct index_state *istate,
 		   const char *path, int len,
 		   const struct pathspec *pathspec);
 
+enum exist_status {
+	index_nonexistent = 0,
+	index_directory,
+	index_gitdir
+};
+
+enum exist_status directory_exists_in_index(struct index_state *istate,
+					    const char *dirname, int len);
+
 enum pattern_match_result {
 	UNDECIDED = -1,
 	NOT_MATCHED = 0,
-- 
2.28.0

