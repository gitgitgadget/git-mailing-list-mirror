Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0447C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbhLHVxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbhLHVx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3900C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t18so6412290wrg.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=qA+Dv+tMHZneapriRbSVKpTRDGidk8etOG2aZKvLLVUowDAftni+I8YlothgMcqs0M
         FkF9YrkZQ/epl2REmnjXpbsCMis3OqSe/Dg5ezTWSSNzQYNcrKdYszaD/ky9LQ67wD9k
         /F0LmGwUWwLzemMhD5nPLBUCO1O9k+hMeVXGOe0IJoZl0Guf44QU2LvGvXYGFqoHqILn
         Yni2l5AWGiRqCSbf3XjvS8rpLep/aRYz9J5Pc3AsSUePjzFUqfOcN/ywrPwW2SHhpyFM
         pp9QrG31g7zBDAHD34JzUuwvOfAsBxtZg6wS2Avw9rXMtlLlt4bIChKTohV+xE5z332T
         +MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=rc1L7D/O3XAJwCd1m9qCxSqeoKyhHWvAxhTjzC/DmsUohlFWFJkzAcPIyehZbnZTQ0
         +2HZ8Z7COH3wiDMXnW/sE45qAnFFSlu4V6tBRQ8GN8qvaYCILkzrZ9giKTniWUxOj/EJ
         rdStz2aCLSgDhpUVSey1/BLP9H70eYL0u77taTUcWQt1yhZesGi8sA5h3gXSpf2yM1ka
         ALsdtn/Jlz4Jp67x7xXmqXylptCAycMbCoLfyAUV0AbRItVxujxEBXMZNvnCmJVOm53Z
         YupeYWamW5rZgeDRM0ed5BVOSIuVjLMZrs0PH/atjI+qP8OKjf4D201/6xwSfuadsKsN
         S33Q==
X-Gm-Message-State: AOAM532jvZsTYtU5bIcwkGC/xYeBfwuk/KMC+4JGequsoR40JKpaLzSu
        x2akSYfkE+lUKOqEnPuC0SbRtBdV46w=
X-Google-Smtp-Source: ABdhPJwN+0jx0vMtKi1Yj2N8C2lYD2acRauwhp3WudfGY+hmFx74mnfLGxYE4a3aT29IvZwVewBqLw==
X-Received: by 2002:a5d:4bc9:: with SMTP id l9mr1516094wrt.503.1639000192372;
        Wed, 08 Dec 2021 13:49:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm3777127wmc.14.2021.12.08.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:52 -0800 (PST)
Message-Id: <64c18d01cad70545e43c6a8e8d0547881051055b.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:41 +0000
Subject: [PATCH v2 06/11] reftable: fix resource warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would trigger in the unlikely event that we are compacting, and the next
available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index df5021ebf08..10dfd370e8e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -877,7 +877,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -911,7 +911,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -932,7 +932,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 
 		sublock_file_fd = open(subtab_lock.buf,
 				       O_EXCL | O_CREAT | O_WRONLY, 0644);
-		if (sublock_file_fd > 0) {
+		if (sublock_file_fd >= 0) {
 			close(sublock_file_fd);
 		} else if (sublock_file_fd < 0) {
 			if (errno == EEXIST) {
@@ -1013,7 +1013,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1050,9 +1050,9 @@ done:
 		listp++;
 	}
 	free_names(subtable_locks);
-	if (lock_file_fd > 0) {
+	if (lock_file_fd >= 0) {
 		close(lock_file_fd);
-		lock_file_fd = 0;
+		lock_file_fd = -1;
 	}
 	if (have_lock) {
 		unlink(lock_file_name.buf);
-- 
gitgitgadget

