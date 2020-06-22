Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EFC433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0073C206E2
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG8RPrdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgFVVzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbgFVVz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DFC061795
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q2so15885013wrv.8
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=ZG8RPrdyK5CBRBza1MGgDeqAjggW1m0jvuksolP+xZVt5mTH1cHrUIJFWReKLCV1/6
         Zg8V0O0w2UsHRp3AXvV5Pq0ELQcTd9denMYBrIjmvhC5IDxTy0qo0t2c8I7FgMoYDqrP
         vTI+Cu18HkPr7Fg77i8+T6wRhZ6SourtTKO0YrQEuFx4jaVIKV5yMrYPRqVx73w4OmB6
         GZWo0g7c1rKjVbrkMQktFWdrkLPSKXQEo9YHlOB7l/d2LYbkw/nkwGaiEBVoH99jtr7o
         I+jKTWcVnNdH+w9n9Og8LFyflicKnIk9Qq1LBcALgZOof89u7v5BhezNozbkYzqtvoKc
         5arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=Q032nTvfxYA6QcvIMjd3tlEly0+H06n4MZze7wfQsqS4FoYfpXKfPe2LgY1j3A3vS5
         aWm45gVd/zGQAa++j4RLS6QW5RTNvXup9ge2IaWqIL5y5h+zYj1DhO2UvtTy9/ulqlFh
         pdMUyMNemDs14l+9YATuVIaSLJxPLvnIIpyGEXpYj1v23bTr3rfIrFTrHqVyrHAxH2rE
         u6gOgv/vXhTqFJYUpKs/63Hr/EeR8kMD3N6C3QTdXlY+J10mokX/phkmOrO5PeMdyBRa
         PXgJsD5homytQTK5/L5wp1bRtqGlF5LjvWuyVcwdx75sFb9o0JC7tPxqWsUmzd94nuR+
         Ii4Q==
X-Gm-Message-State: AOAM530VM51H0WqE8xp9SupAiYYcw8HczrWlPTnULC/a8wvXwjeExKWX
        XqtE4RdUS/GDhMIpwdPlophSa/VU
X-Google-Smtp-Source: ABdhPJx2KcXup9SmEVx2ekutHdyRLdUkk6l7s+PT0FWCNEXZx1eknJn3OtGU8hn0ylerDNZFJE3aJA==
X-Received: by 2002:adf:8b18:: with SMTP id n24mr22439499wra.372.1592862927673;
        Mon, 22 Jun 2020 14:55:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16sm19834239wrm.70.2020.06.22.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:27 -0700 (PDT)
Message-Id: <a29d898907a83b6e8b6a42884397d4148d8920ff.1592862920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:06 +0000
Subject: [PATCH v18 05/19] Treat BISECT_HEAD as a pseudo ref
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

