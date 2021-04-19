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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A58EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EA661077
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhDSKxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbhDSKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D9C06138B
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k26so17086571wrc.8
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X0PzUSzC+SRtK99yWFnIg18G/Wq5vdZArXandSlRw4g=;
        b=ePWx/YFYhMZNf9mdCz6Nm7iKtTMXNYh53edORNUXhFLjfL2RdSAxJoSE0kZs/B0jxR
         KOMG8cjXQ+WWkI682DhEFn1ci/XQ83y29bZc0REO9SWTWqbCtV2DZ/YYmNu/7Wcirhdw
         gMWZCBepSCvKerdGekras3JxGwjrHERxl/Ij3bDyVoRA4Y4+8RJLL7sXzJsw2xhuVcBI
         xs2uS4GsqjYPPJj4NPTOX7T+Q8YnwsmRM/udvCKpoC/UzsaTeF7x6dq0hlMa3n5T1QTg
         9TcwREfImLoQcopa2dKWwYon97OeiiWpI+mlxpaQIWpQ72xrNPt7yD0roNZchCoWZZcX
         7Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X0PzUSzC+SRtK99yWFnIg18G/Wq5vdZArXandSlRw4g=;
        b=G1UowMllfsktHZbsXROwzeajqyufs895o8MlMZYf6M+on5MoNNsqy8AputgJyEMHPm
         IolIdjz5A0VWwW9wL4Dih2VnT8CzACPAvRdn5Zkj6oBqS0KcX8e7DcVufC8rUYxivUFn
         kzwk8xwUmkc3iadgsHxWTzpfShJWqa0Eux9+lYibUKpmJA56+gk7nVD8kfjMwRYkuYiS
         mM8Gfbp5/4okDqtMSODDRHtxZQH62+vIuGrPiu5SWln7c1V528eDXjLyFTB7+2E2dAq9
         PHmw5aIgEjoZWliArZKdPJyRWltrhOAp7HzDxac6LV0wwzcfcQNQsLJ/d2NAYhDv4ky/
         5ITQ==
X-Gm-Message-State: AOAM5300Mo1EWtqFqOV5fR58p2746GFORmM81q+rk3FMYHVuGhihoHw7
        8s3uJDGI6QT5ZdJ59LjqePSHyJnqNz4=
X-Google-Smtp-Source: ABdhPJzE5qxwUWSZs0tCKX0sUL51iV34GbxRiYLiy+u39kRwj0MVS4hvhDRnhX4RCfgacwB5zdPOCA==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr13541275wrw.78.1618829589191;
        Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm23798884wrm.52.2021.04.19.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:08 -0700 (PDT)
Message-Id: <dbb81b5b89d8c168d5583ade113d789de6cba4e3.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:53 +0000
Subject: [PATCH 08/18] t7003: use rev-parse rather than FS inspection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7003-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1349e5b2321c..cf30055c88dd 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -395,7 +395,7 @@ test_expect_success '--prune-empty is able to prune root commit' '
 test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
-	test_path_is_missing .git/refs/heads/prune-entire &&
+	test_must_fail git rev-parse refs/heads/prune-entire &&
 	test_must_fail git reflog exists refs/heads/prune-entire
 '
 
-- 
gitgitgadget

