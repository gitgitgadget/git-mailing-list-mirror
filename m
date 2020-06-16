Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB687C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9118820776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSCIiSQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgFPTU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgFPTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B284C0613ED
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so21949433wrw.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=GSCIiSQmYsBs11WgAJC7aPlHZG4nhQPb62EbxweKBBGgljBnq/DASFRLITJUNLQwGX
         95dCgtTHwjaYkz7AN1ncu5w4/WfZNu6mnCzzIxU3F9eIHRaohq5Nls7sv7tch+ucwGQA
         TEDyCvr6y/MY0Eussu8bNAqirwnd3l8BszGDqrboOVkY64lfyudHyD9CS6gaJDo/lOci
         hjm7tAxFcfXpb+R4pewrJD6v7rGrRkvcUiZOTpOsTB8YMPYKqIroNA1B90rrMzTxWf5n
         8yQSf6IFiFnXXYoacdjqlHtSUY/JC4Ajjzvq0OUcz+gEg8rB3UUzAtYjVQLhoZiTsAan
         yo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=oCPRZZqO/MK8slkGbGW+GJHkTIhB0KeXm2lwewkT9/MfA7bP8NE/8Ej2sk+sqtiRSP
         jrY+PF3OcPJKZWzWh/s8oac+54Bc26PtWmbW3peqdVF7859lBznEXYMCMipbJFXnfvCF
         0HBIPEd7s7A58GEeyLNgYPfL/nKNN1hKJTHtlxD7Eta6nDBkgbWRY8i7EVl9u6yTHFJ/
         smRQTquh60IYyrHPShTdMO25pOnk3PUOpaLT7HlO+q8gBMRMhOmG/quyXW+rUMSyaV1S
         VXf5nzQFi43fbev0PjL4G/mDJWq5TYFxyMGRN1TZRi8MLwxn2Lalxevv8edNjJ8+e7SA
         xhJQ==
X-Gm-Message-State: AOAM531VFxJwwQrF20t6/5kVdgbryOwo3s6cVyZngSOtq+tVYZfjuljA
        gRlIRKQxD9MhAYJiSRNmRARUQo8R
X-Google-Smtp-Source: ABdhPJzFlDZBGyjSAIkjAVzx3wckJaXaqG3rldeYnGJhMPjJvx1xdF4aUCFE3q2iNXulahpABmMdTQ==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr4476874wrv.51.1592335248976;
        Tue, 16 Jun 2020 12:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm5137048wml.45.2020.06.16.12.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:48 -0700 (PDT)
Message-Id: <7f376a76d8483846d5553129270e654612c661e1.1592335242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:30 +0000
Subject: [PATCH v17 05/17] Treat BISECT_HEAD as a pseudo ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Both the git-bisect.sh as bisect--helper inspected the file system directly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/bisect--helper.c | 3 +--
 git-bisect.sh            | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e3..73f9324ad7d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -13,7 +13,6 @@ static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
-static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
@@ -164,7 +163,7 @@ static int bisect_reset(const char *commit)
 		strbuf_addstr(&branch, commit);
 	}
 
-	if (!file_exists(git_path_bisect_head())) {
+	if (!ref_exists("BISECT_HEAD")) {
 		struct argv_array argv = ARGV_ARRAY_INIT;
 
 		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
diff --git a/git-bisect.sh b/git-bisect.sh
index 08a6ed57ddb..f03fbb18f00 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -41,7 +41,7 @@ TERM_GOOD=good
 
 bisect_head()
 {
-	if test -f "$GIT_DIR/BISECT_HEAD"
+	if git rev-parse --verify -q BISECT_HEAD > /dev/null
 	then
 		echo BISECT_HEAD
 	else
@@ -153,7 +153,7 @@ bisect_next() {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
+	git bisect--helper --next-all $(git rev-parse --verify -q BISECT_HEAD > /dev/null && echo --no-checkout)
 	res=$?
 
 	# Check if we should exit because bisection is finished
-- 
gitgitgadget

