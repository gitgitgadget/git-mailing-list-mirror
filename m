Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A1C433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhLJEAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 23:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhLJD75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DFBC0617A2
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so12932670wrb.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y3fl9hDWXuCSYMuW6+ZA/aC18Vkow8+QcGnZipJ9ido=;
        b=ORhiQdbTr9P1p04pXq5ATf0gV4SGVXXOsDjBjy8KS1GLzjlSipFlm259fCBHF3GELH
         qGOK0Qwy30FZ7SU2/b17KL0bQcj+2K5WyvS3m3AG2LPDUHchQvd+vBxiLvphtjoshVK6
         PBBYXNjTVF7rvBRUu7J7yQCnCoF5YThAxLs0RGFjEw6XWzfSXZYmg7Gy9yH9HWHOKjnA
         smakkxPlwFcjmbl5wk8uBJf3TUwFTpZ41CJeZz940rU/G6PxJpjIZXl/YkXzBlS85/TT
         2tsTvqCtdlRKe7FRvxpjW6jaa/oSCk3YZ+kZ8rcdnUDTzRYVdu74N0qR2vOtkIUgO66F
         RVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y3fl9hDWXuCSYMuW6+ZA/aC18Vkow8+QcGnZipJ9ido=;
        b=pF1IaJK48ym/ziwADlU8P89/Q9mg5P2xXEEFDpBrDK1S5tU+wAgwfQR8kLXkXHo3kB
         Y2V9q2i1IaHDs4zoCar3iZ9Zfw+ZB28g4Uv0VEtUyZgKi1+bxcMUGh5oLq22/hGJAZR0
         34DOtNnMTcn2Pjt8E+Ra4MOsu0qVmJK8jGb99QDFaEVo2FuSNLtOFFu47xdOPbehH00M
         dn/88mj0hFIo5RwcVfatWKIzFTQgtHAR3xSJ7xMKbtHPMSZRmQWP85OKd4nzVPEjXE3J
         Idq2lvNlMm6dY5bUGI36Ala/W7Y2lAC2vUcAfrQD9CWw5y8L1AgklXARk/TP7GiCILVE
         ujQA==
X-Gm-Message-State: AOAM532EQeg3I2x19pIsbBEnaKpddYOUynB5DeKKZDVGHNxjXn7D3DUF
        tuRjsYU5AelkhgIFyXnCCyA/ttdkKhM=
X-Google-Smtp-Source: ABdhPJx5l6dRcifYwd/PFyJYf7hQ7vfOSkpdp06sSsfofkiZstv97s8aqB7wJ/fjkD6p7x9OAD9/Kg==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr11462171wrd.3.1639108581768;
        Thu, 09 Dec 2021 19:56:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm12103748wmq.14.2021.12.09.19.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:21 -0800 (PST)
Message-Id: <395d9b194d3236b01b3c6abf19f7556c425999f0.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:13 +0000
Subject: [PATCH v3 10/10] clone: avoid using deprecated `sparse-checkout init`
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
