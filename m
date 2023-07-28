Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E137C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 08:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjG1IXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjG1IWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 04:22:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C01BC6
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 01:21:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3177f520802so1166149f8f.1
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532504; x=1691137304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HqoO2HNZl6Vd2n+Hd1Mew9CJXg7jIQShrDnysNXUapc=;
        b=aAcRAHSGkhGmFSAVlT2xKkO8eiIOdE0qEJ3Nc8idBKntQRzBiqojKF1lFnHuWo1ga6
         sF16C2di8wxQ4AI6LmsgSLeW+sWzXQmoUWoyY9eM5LOFdHABOrBqMn+vTWMNehy4Gh2i
         5dHv/9rhtbAwqkJhwe37vA+zsmPGKmvrwZ0W5QfLvWF1GWT/BiYfNVA6S4PTPyCGMVsY
         03hcNCDXfxTJq2tOmR8AoxXdfrbm9sNKFoZiOzQacCqgJNQEQ6URIURgciIkRbEqYj0e
         tBM50R+bMcwyC4TFB4CHsqD6lzOXnYx4SU8g3xYgeVoNiuY3uQnRNw/sXWIIiPfBW0j3
         DJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532504; x=1691137304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqoO2HNZl6Vd2n+Hd1Mew9CJXg7jIQShrDnysNXUapc=;
        b=HGz/4wBk7RjqjMCg2aNLDGR4brg/MHpAOeyQdzoDtfasugC2IJG8mW6oakoKnXEx88
         QbYpI/9WZhFu2u5WC38WaSXujz4EPKhY8iR3uIYPzuDiwh0K7zQQjPdcuMy7RvBwlnzX
         3yYgQB0E+d+7JE90IGxW5ULUlA7DWMX/3Kw3MiNS3yI84oXd2+67khHe2hbuArIaETGw
         50JzDyYHjscjJFLBR6jfCvxd4UWic8XZM30YDM6fkZpCrudoj7pGIE3m16mZWD0GGnGS
         f01ylmPk5sN1EjC/wAToNlL9jGwvIx0JygOTTK7TQocNGtM7yy7hKjyqNSjBL+5jqasT
         G5DA==
X-Gm-Message-State: ABy/qLb6bavzK84OqfPt+wsxoZ3YOi96oWISkuinlJqk5ovzXsgtqZQr
        +UnfCZozi0xJiu2I3m726bcivX+XGLg=
X-Google-Smtp-Source: APBJJlHHmXLH59R90oPhLi6KRT6MQ1d/AC9ml1gxAMRTfIz/61FrDh221RVPc8G4s60CBJTGfPo2yA==
X-Received: by 2002:a05:6000:1205:b0:317:650d:f7ce with SMTP id e5-20020a056000120500b00317650df7cemr1455534wrx.29.1690532503559;
        Fri, 28 Jul 2023 01:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a0560001b9000b0031769585da4sm4144348wru.57.2023.07.28.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:21:43 -0700 (PDT)
Message-ID: <pull.1559.git.1690532502648.gitgitgadget@gmail.com>
From:   "Jeongho Lee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jul 2023 08:21:42 +0000
Subject: [PATCH] mergetool: set diff flag for vimdiff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeongho Lee <bivoje49@gmail.com>, Jeongho Lee <bivoje49@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeongho Lee <bivoje49@gmail.com>

The 'diff' flag is set when invoking vim with the '-d' option or as
'vimdiff'. However, the flag is not set before processing the .vimrc
file when vim is invoked via `git mergetool` since some point. This
can cause issues if the user has configurations in their vimrc that
depend on the 'diff' flag.

When using `git mergetool` for vimdiff, git generates commandline
parameters using the gen_cmd function in the mergetool/vimdiff script.
Commit 0041797449 removes the '-d' flag from the generated command.
Simply adding the flag back would ruin the layout, as the '-d' option
also tries to generate window layouts apart from the custom layout
commands of git.

The 'diff' flag is eventually set when 'diffthis' in git's layout
command is run. Unfortunately, these layout commands are specified with
'-c', which gets executed after the vimrc file processing. We can use
the '--cmd' option instead to make them execute before the vimrc, a
feature provided since vim-6-0ah. However, constructing the layout
before vimrc might change the behavior. So, I added '--cmd' only to turn
the 'diff' flag on.

Signed-off-by: Jeongho Lee <bivoje49@gmail.com>
---
    mergetool: set diff flag for vimdiff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1559%2Fbivoje%2Fvimdiff-flag-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1559/bivoje/vimdiff-flag-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1559

 mergetools/vimdiff | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 06937acbf54..cefe74f9604 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -337,7 +337,7 @@ gen_cmd () {
 
 	CMD="$CMD | execute 'tabdo windo diffthis'"
 
-	FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | $CMD | tabfirst\""
+	FINAL_CMD="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | $CMD | tabfirst\""
 }
 
 
@@ -541,22 +541,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | silent execute 'bufdo diffthis' | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_01="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_02="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_03="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_04="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | silent execute 'bufdo diffthis' | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_05="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_06="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_07="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_08="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_09="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_10="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_11="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_12="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_13="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_14="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_15="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_16="--cmd 'set diff' -c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -620,6 +620,8 @@ run_unit_tests () {
 
 	cat >expect <<-\EOF
 	-f
+	--cmd
+	set diff
 	-c
 	set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst
 	lo cal

base-commit: fb7d80edcae482f4fa5d4be0227dc3054734e5f3
-- 
gitgitgadget
