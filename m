Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C655C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA8206A1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZDtPgRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbgF2VOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgF2S5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE78C031C41
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so17627063wrc.7
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HrYI9Mx2eeIzo3R0ewjP/R8rLxtFEodXejq8QewzwMY=;
        b=TZDtPgRvI9J7ef3DFUKK/RZIxy4g8jddB2SNSL40btz2Vr+102EJXGvn523JpkdXnh
         Iw8NEWE1hd9iM0NYWL86p+IxoeTBScR6hquIDG91BK1bDax/fvXJPjfKydO7ziQiFsra
         KRDUW4xLmZCL3831IN2IpEirFonQ1Hbbbs1kgdBgCCsHX/q3HZ+OODS9AY1ElRlQaL9Q
         FE/DaHgkd1ZtmZ4acULnSWSPU+eAeftX7SdN0wSuefrllo80ye8hROaHkjlPUpwGt+At
         qyHK7rc1qYK3uO3Mc4x7Fa2IeqWvOG3G0JD6u2WTnNlooQUxDpSUJIpLsQ/eR+NAEebA
         M37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HrYI9Mx2eeIzo3R0ewjP/R8rLxtFEodXejq8QewzwMY=;
        b=VPsItAk8zuwoOM2W/yFkWqezNELj+B+TFsjTKC8v3572OhMAfZfNZeHeT0SlsYKlBg
         ZL1qfOJnoko+GX0xfMc4kqPH/hDZDEyYMgF+Gq6ZMYTWouZFDq5n84Y7FaC82fdOW4eV
         B0tEqG3zd/3iXDm+ZleWC17GwtK5ifIozIqw5KHHxuHkVdl+0Vao/FUh0XMJ207jIUnu
         yhFAN4lqOCXxmDx5XbTjaAI9ZCESVP7MlUepJuPDJbBgmKWHMnV4ZFlkePA9w3YZ9pmj
         3OmBNcuFlzM0X+BGNsDwn6oELd1XmdJ5d6e5DFVENcc7yvzWAFawcnd2YL02phxQZVcG
         h8/w==
X-Gm-Message-State: AOAM5302vF3LnZmjDp4uqGU0ddon4R5ZX2G9Ctg7EB8q929RvyHoChuX
        o4INv8Rr/LGglSIMdZ/+QTuHp1iq3yw=
X-Google-Smtp-Source: ABdhPJxr9cVy5HGQmAmW7tC+R1L5VEFIUoA7axd98bUv5jqwkfbnu10F7mr7nAPfKvfH/F2kcLGpqg==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr20364649wrs.60.1593457025572;
        Mon, 29 Jun 2020 11:57:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm808941wre.83.2020.06.29.11.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:05 -0700 (PDT)
Message-Id: <e36b29de7949b1a1ed5c10b5d40699c4d37a93d1.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:44 +0000
Subject: [PATCH v19 06/20] Treat BISECT_HEAD as a pseudo ref
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

