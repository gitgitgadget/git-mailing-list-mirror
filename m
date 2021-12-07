Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF9C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbhLGUX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbhLGUXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D5C0617A2
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 137so270847wma.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4MItie7vNQS2KAIdrLM9LL/xACe4+d25xi00b/lXefA=;
        b=pYmSPk3drz2zhmLO9gy0sDwn7QOLOLqpWXuGzyb6XBVgEZ/Kgqmq7G6o54iLpjMKcv
         xEx3wLjQ+QSn4yObQWq4z5pbogob9y2sD9qaZOVVcXfA4vtTHar7ZihHcLniS5NjGp41
         E+d4d3pYkW8VVs5ruFtGmcTfQ5xs1wlx4HqqNRvwydF2YRl9kdWdTX7dF7zevfJKGqHO
         n5kAPP0KBvnw0zflyN6nHTl7lXiQ+jVv0KYmxMnUSjDNQ6qpAJEAulxnBMLt4MUkDnSw
         7TBESzU2Lg970RRTYaP4o+0ft/+FMMDiHsP8RaFrlk6l6B46JCJambVuRA2BGwo3eq22
         l1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4MItie7vNQS2KAIdrLM9LL/xACe4+d25xi00b/lXefA=;
        b=W80OOttEB+MykuTTtM4Abbi8mKeEEFrsYZV0hW3UT70Yh3NnWZPAIEcE7K9v83Gbo2
         ee3JvcLUMAIBc/MPkjUKZQXhOSz4wTWX3c1QfILjt3Ih3dFmFWDxHdX0ZdvRPXaEc26N
         Y+93tX9vYrrxn6MXzgkFVMKtBC4i9x5brKVuQIrpPGP1Hru+OgYYdh8zXAmPoFsk7Cl4
         xT4aUSs0xkAThvQAHj0p1qFGd3GMdMVUliwa4708hJ5+Sz7Q/Ax8uRE3yzJGaJcZjmPt
         kDvKhuveAw4qDmbLa5FZdC4z/zWaK8iFlJ6QFiTpRRC589mk3jOQYpyPYLS2ZWf7O75p
         li7Q==
X-Gm-Message-State: AOAM532Hx//GIVGIkBnjl6ktaHUKw0m20xCGVEwF+R3mUOW7q+7bI7gV
        9v04dAvWAjd2sQcge0bf+U9WnN0hHJo=
X-Google-Smtp-Source: ABdhPJzI24CqmvWTL01P4NMCbvBpMehuMhDpJx8IJWvep68V3SC7tTrgNKSGaLeoXJbNWsMBBobHeQ==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr9678361wml.33.1638908419708;
        Tue, 07 Dec 2021 12:20:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm707436wrb.2.2021.12.07.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:19 -0800 (PST)
Message-Id: <d47b2c88242bfa3fb7fa4671b5c2fb7142ea8564.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:10 +0000
Subject: [PATCH v2 10/10] clone: avoid using deprecated `sparse-checkout init`
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
