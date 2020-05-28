Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA10C433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D548207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaVViiXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406734AbgE1Tr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgE1Tq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:46:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F14C08C5C9
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so439010wru.12
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=CaVViiXO95GD7A3aVuWW9vneQQlhAsboGoSs0vA/SS1A+p78qUaT765/VDFtkzBAmp
         3Q4ArPzPJ/LqlFMd1KxIMokPTSckrZOrWtRrIS4i5IKF8Ug3HdurujN4Bijl6w9zIlzA
         bNPxrjYZmxmZOGOXLDpgdKwi4vSps+ye6HTqBySkNnamZ/PI+708ovwsxv6Nszur4A13
         1DFVT5o5WLJtZDgml6w6GdnBmBeIzbHLVnTHmG1V1hmOBXBnFY/e4LSKecO851jqupdx
         089qwQ8tuayHnWIVwXTFnhM+0A5nX5+eVWkJYN0g+I7VnmFDTsmUmDwgsnmZasfrDgB4
         fFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQfDs8/XlBupSRYoe1vXMMIhqbtOWX2QXYj0WtRX54k=;
        b=PywU7Wwmc0VdzdfP2bUPXAAanSb3ku+Uns2B06XnPjJJ+VcbXiu1NcsvTfzjazoOjj
         nCcKUfjNlA3TNU9HRyuQhiCo/SfmPGznknZd73e44fLKVmeIO6e1A5BKuyU5FK4bLX8/
         CEP0N3867eODE/ehQwikVXmz3wlX8ndF9Kp1PW0V07rK+T6XXA2eC2DBT/4K9eWUNvvv
         zy205Glh4EGzL5w3hoV2RR95Vt80EDMaFJu9cJVyyk7E34Vcmgg7aY+QlDWB8IESqi8b
         m7Je2pWhQjoh18i0lmBVvrrRU2l1WcMhvptX8ExBRoM8er5W42pzJQ2BV+S7+y6e2W02
         5C6Q==
X-Gm-Message-State: AOAM533GxNH6bc910xaYB7Zgkui8+Xfsgysz9pKVEsRHwhjcUDXpM9gp
        js0NIXpET6/leCOgaaBbkBHsHgax
X-Google-Smtp-Source: ABdhPJwYH6B7Rn8zh4R+jyjSnRndcvPb7JxyxqkqcCDeyrhlhPjnEcuTo6JnJdDUQe/1L3yLCTmtsw==
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr5280494wrp.90.1590695214862;
        Thu, 28 May 2020 12:46:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm6934981wrb.72.2020.05.28.12.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:54 -0700 (PDT)
Message-Id: <60a82678a1b0b221b6d43434f70f9475a929d2a6.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:39 +0000
Subject: [PATCH v15 03/13] Treat BISECT_HEAD as a pseudo ref
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

