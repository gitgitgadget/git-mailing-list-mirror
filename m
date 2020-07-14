Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D5C433E3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381F521548
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 01:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8iRAtaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGNB1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGNB1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 21:27:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27853C061794
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 18:27:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so2497547wmi.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xLWvmZncztdOJGNuHjprQcrUknXU72k88Ho/oRimezw=;
        b=q8iRAtaW2Unl6Rw0hAI7rdD/PA9Hm/za9zqeFZp8pjUeQNIBuHJdqsto2pEl/baD/L
         sw3J7SI9C88K14d0oGbW2Ook4yRUpE8Cdbg2Oz1/A0NFpGMN3NP4qgEuvifnTmmJmvjc
         KpBGo0cYSyWOSRd/sJ08H/lDRdz8QS/7X+L9851ONZ1eaU5P5q+HUADqhBfesgzxxop6
         PfVIKFW5eAhvhVxvxTXgQfRKcVE9eJNNsqlhl3aBH054vGEoa/ilW3yGkzN5oTKTqlg2
         uZ4lyrerq2x16p4xGmOuq+YKaaJPRhAe1o+olGQC0KL108rnYwJQonoW8SxnEc25WytN
         ws6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xLWvmZncztdOJGNuHjprQcrUknXU72k88Ho/oRimezw=;
        b=Ufu+Wnhh8YSp+xU0oeP7IlsQHogZfQeJhYBLc3VMP4OwBNEVFtTeOCc5yX3oGJKW2U
         fCBZaid+zpJoj6oH4J1yZMA0iwojRjeXDqt/uTkFqUNLjpDRgjFnhIvRfviYyrytqxXp
         RMpFqMM9CH4lLbjv3suDZNjVETY8BO2N0JMJOiGJHJGuau/9o3+OrPsXiqyGaplqJ3bv
         dgAB7QJAMz99dI+VbbA69JRxEoF131eVsXuv9hT56r5BWFq9nkD4SJx5DmeMFQ42Xsab
         m9/IebGW3TQQo3DOe6V6vxKcVgjYDx1kkTexGGCQu0N1DS7BDTBLS8KkvDoP2+M0ODUq
         2FLA==
X-Gm-Message-State: AOAM533rAsIzEqiw1nx2/JHe/rK+D+PfVY5RCeqLg5fsb+YKJQQ1E9dG
        NHfh4Ja9W6JIFggcYZibBykBAi4A
X-Google-Smtp-Source: ABdhPJw1Bcr3AmyP+olU9uIfFNnoe2je3kT1btVH+ko6/Fi44Wx0nTWkeJx3+Ta1cxMVLSnMsct+wA==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr1948334wmi.83.1594690020740;
        Mon, 13 Jul 2020 18:27:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm1851228wmi.34.2020.07.13.18.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 18:27:00 -0700 (PDT)
Message-Id: <e11e973c6fff6a523da090f7294234902e65a9d0.1594690017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
        <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jul 2020 01:26:57 +0000
Subject: [PATCH v2 2/2] config: provide extra detail about worktree config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, delphij@google.com, peff@peff.net,
        johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When any `extensions.*` setting is configured, we newly ignore it unless
`core.repositoryFormatVersion` is set to a positive value.

This might be quite surprising, e.g. when calling `git config --worktree
[...]` elicits a warning that it requires
`extensions.worktreeConfig = true` when that setting _is_ configured
(but ignored because `core.repositoryFormatVersion` is unset).

Let's warn about this situation specifically, especially because there
might be already setups out there that configured a sparse worktree
using Git v2.27.0 (which does set `extensions.worktreeConfig` but not
`core.repositoryFormatVersion`) and users might want to work in those
setups with Git v2.28.0, too.

This warning is specifically placed inside an existing error message
for 'git config --worktree' that already fails if the repository format
version is not 1.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/config.c           |  5 +++--
 t/t2404-worktree-config.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ee4aef6a35..2cdc293ae5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -678,8 +678,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (worktrees[0] && worktrees[1])
 			die(_("--worktree cannot be used with multiple "
 			      "working trees unless the config\n"
-			      "extension worktreeConfig is enabled. "
-			      "Please read \"CONFIGURATION FILE\"\n"
+			      "extension worktreeConfig is enabled "
+			      "and core.repositoryFormatVersion is at least\n"
+			      "1. Please read \"CONFIGURATION FILE\""
 			      "section in \"git help worktree\" for details"));
 		else
 			given_config_source.file = git_pathdup("config");
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 9536d10919..303a2644bd 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -77,5 +77,17 @@ test_expect_success 'config.worktree no longer read without extension' '
 	test_cmp_config -C wt1 shared this.is &&
 	test_cmp_config -C wt2 shared this.is
 '
+test_expect_success 'show advice when extensions.* are not enabled' '
+	test_config core.repositoryformatversion 1 &&
+	test_config extensions.worktreeConfig true &&
+	git config --worktree test.one true &&
+	test_cmp_config true test.one &&
+	test_config core.repositoryformatversion 0 &&
+	test_must_fail git config --worktree test.two true 2>err &&
+	test_i18ngrep "extension worktreeConfig is enabled" err &&
+	git config --unset core.repositoryformatversion &&
+	test_must_fail git config --worktree test.three true 2>err &&
+	test_i18ngrep "core.repositoryFormatVersion is at least" err
+'
 
 test_done
-- 
gitgitgadget
