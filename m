Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF87C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02611613D8
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhE0Ezh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbhE0Eze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 00:55:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C829CC061760
        for <git@vger.kernel.org>; Wed, 26 May 2021 21:54:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j14so3297536wrq.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 21:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6AS3Ubpr/ly1FOWL9nSrgsmqQaRzOR5o3g0SYlbbPes=;
        b=EiAy4p8EiJA5vq8AFwy5Tu6rtgEw5BWjwSEjvEXhz7gxmTQUgS/ZhzTl6FNcJgMRwh
         sQgGiCHNzqg17NtYxOCwGg4YFUuMpQHVvWSth0dWPRfLNIpOyxUHyZ8+pYJSp2Fx8dLi
         KCRMkqf7XZRfIZe1ovu+hpJJ09B+Tw3Xb70xhyrqMYF4elX5upTANUmajS328ZPeM/cP
         BMCNO00k6rOSTLdy8x0YMKQU7b1jBdrCkWb1zizopbM67LwXi973eZMI+dby6rwQuxXw
         tTfzwrHWvR5nRIRQUDBDox3XgB82UscJ/15vkYMArutTTVnftCuCZXKr0cMOS+qQAElx
         HbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6AS3Ubpr/ly1FOWL9nSrgsmqQaRzOR5o3g0SYlbbPes=;
        b=bLYkAHJ9bOCQMkYHzqs8qd6pIw140SDOTWLkMy2PPspZs2iRKKBrFzYDF4HXaNRSp+
         6QWBP7/NOZOp3xSL4PNsfOFronx1h+I2rBBKWL/n9gS5Wp+2jtVEKi6Qxnc1GxnuohsM
         x4dPK9r5r3KA7D0znNxEPgI0RFiUqM1sbNdmgNp1TM0h3SQmdxjx4Ae4yPXV4uWq/CCj
         HHQtqoswhn9LiCRU07eZopjc81PAc0ydU5fPOfbSjubMft/5XddUsk1UCWMQ5++aegdg
         uPyUr3K1lBZMOXPqzS4b9gsZeevU2lrftxnqt3fvsjORuxNsYx79wqK69me3orAdxbI4
         nw3w==
X-Gm-Message-State: AOAM533an3dLmmNfQ+GCpO+RxJjp5yKBJjNFmC3iR1/zX2NdhDfj1S/J
        XWMCLKNSPMupXGnko2Qzt09LOSnVD7U=
X-Google-Smtp-Source: ABdhPJyh8gYZZA/fquoPxXYfVm2NMBqevK/KOMjRmsHdIvcj14bm3KngYY/9uARgjqvgm9zTmy/koQ==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr1222045wri.60.1622091239424;
        Wed, 26 May 2021 21:53:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm8995994wmj.39.2021.05.26.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 21:53:59 -0700 (PDT)
Message-Id: <c45644eaf69a3d753fff7ec1c926133b5ed7fa4b.1622091237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.961.git.1622091237.gitgitgadget@gmail.com>
References: <pull.961.git.1622091237.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 04:53:55 +0000
Subject: [PATCH 1/2] dir: update stale description of treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

The documentation comment for treat_directory() was originally written
in 095952 (Teach directory traversal about subprojects, 2007-04-11)
which was before the 'struct dir_struct' split its bitfield of named
options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
dir_struct into a single variable, 2009-02-16). When those flags
changed, the comment became stale, since members like
'show_other_directories' transitioned into flags like
DIR_SHOW_OTHER_DIRECTORIES.

Update the comments for treat_directory() to use these flag names rather
than the old member names.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index ed68b7e6412c..ff004b298b2a 100644
--- a/dir.c
+++ b/dir.c
@@ -1740,13 +1740,13 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
  * Case 3: if we didn't have it in the index previously, we
  * have a few sub-cases:
  *
- *  (a) if "show_other_directories" is true, we show it as
- *      just a directory, unless "hide_empty_directories" is
+ *  (a) if DIR_SHOW_OTHER_DIRECTORIES flag is set, we show it as
+ *      just a directory, unless DIR_HIDE_EMPTY_DIRECTORIES is
  *      also true, in which case we need to check if it contains any
  *      untracked and / or ignored files.
- *  (b) if it looks like a git directory, and we don't have
- *      'no_gitlinks' set we treat it as a gitlink, and show it
- *      as a directory.
+ *  (b) if it looks like a git directory and we don't have the
+ *      DIR_NO_GITLINKS flag, then we treat it as a gitlink, and
+ *      show it as a directory.
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
@@ -1834,7 +1834,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_recurse;
 	}
 
-	/* This is the "show_other_directories" case */
 	assert(dir->flags & DIR_SHOW_OTHER_DIRECTORIES);
 
 	/*
@@ -1849,7 +1848,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	/* Special cases for where this directory is excluded/ignored */
 	if (excluded) {
 		/*
-		 * In the show_other_directories case, if we're not
+		 * If DIR_SHOW_OTHER_DIRECTORIES is set and we're not
 		 * hiding empty directories, there is no need to
 		 * recurse into an ignored directory.
 		 */
-- 
gitgitgadget

