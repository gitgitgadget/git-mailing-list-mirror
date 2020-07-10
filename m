Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBDBC433E3
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3322078D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm3igkpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJRUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgGJRT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 13:19:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03879C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so6922834wmj.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HrYI9Mx2eeIzo3R0ewjP/R8rLxtFEodXejq8QewzwMY=;
        b=cm3igkpvNJbC1LkGrReEqPHGocgylY5MO62DMBVfIDaYS4G41yoPqk0gQwP1SE+BG0
         se3VkT7UxL0WHXEQY3gOk7j5OJ2CCSUBhPonnxsCEfC81Sv7zWm7DWC4LJ1uaGvMDm+G
         TcIH1au/VhO61lzeb0YgRuB3BwvmKoZpUAqICz/nTCrhvxWVVt9weCgj7ZX+8XpNeGHw
         ZaTwvc8RqEpfpSb0GlSBb2LjL2m30jOlgL0P4+lBgq0HQvueUSDYj5QCU078Im5hsU+i
         0bQ3rPneIPdO+slyel1JHGJpDGGn3e+NKYj08FnVt82WiJLNzJRo1nHvZOMg9PtfiiN6
         FJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HrYI9Mx2eeIzo3R0ewjP/R8rLxtFEodXejq8QewzwMY=;
        b=BqNC51kk+dqRVclD0TAky64isIWqt3CiXlCYE4a7pl5Tm95R8rtQKQtomEWmNe/NCL
         xcS8rhPJYgmGAGsjJP4jlCKTnt5ASZZG6xB4TnBrgteDeDR2QGqKW/3YSamdIc6qJMZ/
         ndWecxNMuDHQh/N/W5D8IsTGRnXDnaM9zxSb1bDq2J85KJjC4gLFWGAOj3hS1VZ3xgiE
         /P1dD+oxRTfSNI4PO/0EZftAREhGWeWuTlDMiZZw/v8Z9+OP6QmPXBT1wdTz6Qmk4P1Q
         jS6kj6hYG64T9bzD+AHGgaDREsHVKQiKxcUBxY4jQ4sIkKeUfkDBcIFc7DdKkxVAMGlx
         ONLA==
X-Gm-Message-State: AOAM533bOI0RQtyU/g7xH8nswg/LbCr6PRh8wlBFSI7cvw2MJ74RPNla
        PcnJ1uRSkWiYwLFHclzl3vW9MoHu
X-Google-Smtp-Source: ABdhPJy/2JydV+sSsM3FDGZAb9kviEYIUiSDvChHAISxu50kfk8MMaP4EyUex7Ek/CpwOXnI58rb2A==
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr6397464wma.181.1594401597484;
        Fri, 10 Jul 2020 10:19:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm12134738wro.0.2020.07.10.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:19:57 -0700 (PDT)
Message-Id: <d4007c2a5b785aac54d3ce7635cd6a50225c1361.1594401593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
        <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 17:19:52 +0000
Subject: [PATCH v2 3/4] Treat BISECT_HEAD as a pseudo ref
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
index ec4996282e..73f9324ad7 100644
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
index 08a6ed57dd..f03fbb18f0 100755
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

