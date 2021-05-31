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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5D1C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B4960231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhEaRmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhEaRk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67DC008752
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so327469wmh.4
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Hc16cJZj0WT37i2tRkJhQ4h9RnXT3tJIuOwqOUuGoXs=;
        b=raouN68mSfQAzdJp9ds+F3BaEtspayrD/zz1DZkK0lOpX4nmGoNW+yJIZLMi2lcX37
         Wp4kTqLW51rJ/nLOiRCDdM7Uj2LBRUvyWt0HFpq9jLMow6VJvOfaxSoByWX/EsxZreYW
         HU6WmTwyNvqAHOvn69y+tWLbK3XkyxJRxeUYozcfN/nOx3Rl9EiooXzWn3JpOH+mSaCU
         Fl8ReCZYv/FK3Mp5B87bbOTFzO4m+IbM046AxJYgO92HJDHj72ZkOzYUEZCon7I9CEgv
         YNdBFN7MPSBNw2gYov3syQ7VeOxONajZE8aQHTRZkF7H1UopAuyPg/jBE7q/QsvmpY2m
         7/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Hc16cJZj0WT37i2tRkJhQ4h9RnXT3tJIuOwqOUuGoXs=;
        b=AiZZWF8Xsc1XF3Fo4EblgWsabXiMrnVM0ZuepyPcFwlyAfWMVDxuKwi18U4J7Zpexh
         8FrehJLlWJ6vtUAsLp1sqQ8u7jPBaV5FW2ltJmZEocBIxkKi5QILaPTPfzAIFhA+3cQQ
         wE6qs//ambExOJQyOG1obFjjKwgZqqg4/oggnjUsN7B7Lm1AwzwsqgcCz/uHQwU2XtZO
         1N4yrdAsr9j2vmq0zSNUAOzsLjUoWo81z5brzFDzgUs/YhNbSFNrrVEP6tBXRF8Otxv0
         5DJVOiwy76vGe4nuaC5MySzH8nx5bh9YS6d27JR5qYqXD3AlyNqHqRCKu6/tY+u1JjCB
         IRkw==
X-Gm-Message-State: AOAM532eE2b3IWZkfz31UykjxnJsXtAC1LFoE8WWMscxIyS7oLVst62B
        dzgfSudFJUrQdvYHbt6gkbsFkcDpUjc=
X-Google-Smtp-Source: ABdhPJzRmjB96zrICGb0t2F8V/gJZQPttN89n97+saWa26CcipwpAtaCf0hoirSi8+ZIsL6KtUKuNQ==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr43272wma.111.1622480207619;
        Mon, 31 May 2021 09:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17sm400713wrg.26.2021.05.31.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:47 -0700 (PDT)
Message-Id: <5fe2dc0efce99a64222e1e479b9475fde4a607d2.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:31 +0000
Subject: [PATCH v3 16/22] t1414: mark corruption test with REFFILES
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The test checks what happens if reflog and ref database disagree on the state of
the latest commit. This seems to require accessing reflog storage directly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1414-reflog-walk.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 80d94704d012..ea64cecf47bf 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -119,7 +119,9 @@ test_expect_success 'min/max age uses entry date to limit' '
 	test_cmp expect actual
 '
 
-test_expect_success 'walk prefers reflog to ref tip' '
+# Create a situation where the reflog and ref database disagree about the latest
+# state of HEAD.
+test_expect_success REFFILES 'walk prefers reflog to ref tip' '
 	head=$(git rev-parse HEAD) &&
 	one=$(git rev-parse one) &&
 	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
-- 
gitgitgadget

