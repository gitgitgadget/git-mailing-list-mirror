Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D11C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D6E64DF6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhBCPiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhBCPgR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:36:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D0C06178B
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so24872580wrq.6
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=33gxJd1Jklf/uB/iz/5tsYS9j18tcal8oRvrrvPdTOw=;
        b=hbdLGhzWf+qvVV+xb9EL17bjnfs6OTh/lBsRqArzvse+gMganj1SYoU0kdRIebqs3r
         x7SVRIyXPIjfbdaEydM7YvyaAtr9y0BXcr2Lkmbfr3rDwZ38Ju4LaWE3uoBbzbWLcfx8
         v9L57gK7ifAFae5MmGO6DnenmKZWvGa/UGv03lSmAjOFB90zH4KT6CzUhmaf1OQrSb2r
         r8d01h+U1HDF4qeC5aYtR7Fq09OFgCEAceqRCtkrlod0qzpT4nS1ej+zGZyGR9grX2ti
         b5DG558AcgoyBLlvxwrhJjwshalxbb2tQao59jwrw0te0gnVHSGaNcABLUFRTjHHSULU
         lpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=33gxJd1Jklf/uB/iz/5tsYS9j18tcal8oRvrrvPdTOw=;
        b=cB3q3FGjml8iWPUG1wNLlJFux46QeC2w6vN+bH3zDj8ONgSaIDV+qqDSyPXvTBkPZA
         f/1pBjcmh1oHPhrnm7yfydiDEl1nqb6splg9H3bju4AE1Gr0rqm1iWBhzcBM06tVE794
         35/pHFXiah8otV/qCTuywQNeMri4Sh/BafRUzVgjCX2SvLY2XPazZpuUey6JbL7WNPBX
         GHlQxWCsNMBOSIs/YmCsuGGQ0OHmHr+4HMoLiJdvpks3JHQrbMjEfuachccbhhLp0s5w
         bPBDycGJZGXtgOaFcNknTikl3sYg8BbKtyAQL87sNUyQXEazkmIUEHHc6J3mzXFO4hSJ
         IzTQ==
X-Gm-Message-State: AOAM533GGeAqYbGofmCeyQtEFCVsk1+XVDJWmw6SbtZMS2yujf6emM7V
        XSiVsXv4E/xXXcnHk9lLpAxIhJ/976k=
X-Google-Smtp-Source: ABdhPJzOnPM/HHj0cGdkWeT85o5vZ2c/Y9onb1zTZmVTp/+k5BB9dDl6rbxpsgUWIMiJZuSsx2IWZw==
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr4192434wrq.395.1612366494773;
        Wed, 03 Feb 2021 07:34:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm2269797wmj.23.2021.02.03.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:54 -0800 (PST)
Message-Id: <3042fc92fe6d5ff05fd2e4ac96ef936a69b2a2ff.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:41 +0000
Subject: [PATCH v2 02/11] p7519: fix watchman watch-list test on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Only use the final portion of the test trash directory file name
when verifying that Watchman was started.

On Windows and under the SDK, $GIT_WORKTREE is a cygwin-style
path with forward slashes and a "/c/" drive name.  However
`watchman watch-list` reports a proper Windows-style pathname
with drive letters and backslashes.  This causes the grep to
fail.  Since we don't really care about the full pathname (and
we really don't want to bother with normalizaing them), just see
if the test-name portion of the path is found.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 6677e0ef7ab..21d525541d5 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -101,7 +101,7 @@ test_expect_success "one time repo setup" '
 	# If Watchman exists, watch the work tree and attempt a query.
 	if test_have_prereq WATCHMAN; then
 		watchman watch "$GIT_WORK_TREE" &&
-		watchman watch-list | grep -q -F "$GIT_WORK_TREE"
+		watchman watch-list | grep -q -F "p7519-fsmonitor"
 	fi
 '
 
-- 
gitgitgadget

