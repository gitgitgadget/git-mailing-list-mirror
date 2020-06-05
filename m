Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F8C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074522074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSeMC9Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgFESD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFESD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8075BC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r9so9226870wmh.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=FSeMC9IdUHA+rP0Ui5i8XDlUIbxfOw90B71JrYCxZ+ECq5QnNp/VTPbg/EjBqDs4uc
         YSH/K3qE33N1UmP4mSQA6cXBARMRsyJ7WVcHGdr8J2H+NyX9adspMpB0J8mgoeo/oXkC
         EBuRjYHA5i6p4Dy3WY+vggdWQs8vNCqf1WGu/0Dqq+JuKEFZYzA00AkQGK//6b7wWiGq
         OESdlNTDJSluk3+zJesdU39xpG14bDwYw1TS2sCzj9sFa3eIvzaiIanMKF5DcECNg8jm
         jYzvaOy0zql6eDRkSjOjYzHFMos5f0cdZO9+6cAvIVcCtkBzA7zr3yjujzpofWmg8w1z
         dXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=gkDQy2HlJoYpI97ooxYqkrSpfJqcb98BWuJBNj8+2siw26RAu/+nZfKIdmESwlBKno
         hrBgiRlXgqXhNfLz7lfve9nL7QtvkZH83/YyFPAZNAP33hZ9mAgPL14ij/iV/r3cjBhj
         ktfsJNV2sLsX33Rsq4OQ4F5SlfgeGnauJ4A8N3Y1rVN/1+BWVgKEmusnSDWjRIgWcAyp
         jIb1a1XEA4ZynWMNZUaDg/FhrNHkTyDbYqc2dDldF9JfFQbAxp0EhJKxYBCQ8YZrFwOg
         zyP7a9eHCuL0+PjvjuvF+J+kY/oerZIOOuvjQtReyCaigJ8T7lHvmTkGuzC5D6qXIijV
         pxTA==
X-Gm-Message-State: AOAM531mgvM2ZwUuEBxEe811ug2BLzUj0oRo84UqL9hPb5H9KV1Gx4wq
        r7lIy39sOpnlWcjm4wv81OsabZNF
X-Google-Smtp-Source: ABdhPJwVoiD6KxOJfOzTPomT3AV26bmPi1dwWbx5gz5N7OujN5NTrtkQ8AjePTFLy1iLaoCYc5/AAg==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr4029090wmc.142.1591380204985;
        Fri, 05 Jun 2020 11:03:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm12046276wma.48.2020.06.05.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:24 -0700 (PDT)
Message-Id: <ecd6591d86f5d48806f2c7367955b296b5dbf40c.1591380199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:07 +0000
Subject: [PATCH v16 03/14] Treat BISECT_HEAD as a pseudo ref
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

