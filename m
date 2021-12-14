Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E04C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhLNEJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhLNEJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357DC06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so30426710wra.0
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y3fl9hDWXuCSYMuW6+ZA/aC18Vkow8+QcGnZipJ9ido=;
        b=G+p43dvciZFLLIFHBV2+iXvOpQmX2WrcNBvmBWttzKkJN9w1HOWtx1kSwKgnjMAaLD
         dnum9BzkvoN7rR0EpSVDOm3Dxah46MYa43m+bGM4xBnVh+zRht0Swo+v7jX8M1WjpCgT
         UtZeieQJIo/b4p3V6RCR4dsE2xTb4wBg5DBIRk9M4S/nLc9vQQV6cTLiPpWQl3Fwqaz7
         2QSEEMlBjEXaSW51RnZTJdBreyKDtRrT+/9nQlr8sZdEg44plk/iylcHbMSAzVfRVRax
         SZOLYLEcD6+U+yMJYOkjG1XnEytzZzxDSpJ80L/la6vKCZeJonHNHq3lsI6elHn4aOI2
         /zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y3fl9hDWXuCSYMuW6+ZA/aC18Vkow8+QcGnZipJ9ido=;
        b=U0a3fS7R8IAGKarAriW80nAaBSp8TmfqvHseLQBY5FoRM5ix1DwPmo1NYPxp6lzcRr
         L4ZgjVplrp3YalLWFqsGgeT4bepH+legGt5B7BgYj7B8PH2l3lrlaKh3JFbNUt5tPJDb
         lGWnHQjXKEmjSok5szqcKO6UZm+wtEQUXHT4YYFBBySCwcYjZd/RKjHArSHaFCA4tdBc
         SrKQz5OYsSCjsVeOQQkajHkjrmUzgkoivxlkdne/hkmOJkNpQUfUwBpcvu46nECigKaD
         tgcNdg3yHpVxJIgoVlkO9KB+qkjwdTP20tTYV1lAisiSWsabDfvpE5qIkGDnxtdH6mKb
         kLUQ==
X-Gm-Message-State: AOAM532TH7eo+IiV3VQANXwl9f4agLhAfKts1eToqm9SkfVe8L5MLU2T
        viXjfTexBUcqCwkLKpxpCvTuIgkYa8Q=
X-Google-Smtp-Source: ABdhPJwjMLhlMs+Idyidcoo8dTUTAsiVwKWmZ7boF7hFOnU6m4O2pGwrtBlYkgNGCHkjZmD29unjdA==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr3018197wrk.225.1639454959441;
        Mon, 13 Dec 2021 20:09:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm12575855wrt.44.2021.12.13.20.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:19 -0800 (PST)
Message-Id: <ae671aa615ac93161ef2260faea0f5df28f5f029.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:12 +0000
Subject: [PATCH v4 10/10] clone: avoid using deprecated `sparse-checkout init`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous commits marked `sparse-checkout init` as deprecated; we
can just use `set` instead here and pass it no paths.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fb377b27657..5bed37f8b51 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -633,7 +633,7 @@ static int git_sparse_checkout_init(const char *repo)
 {
 	struct strvec argv = STRVEC_INIT;
 	int result = 0;
-	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
+	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "set", NULL);
 
 	/*
 	 * We must apply the setting in the current process
-- 
gitgitgadget
