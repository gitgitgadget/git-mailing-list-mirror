Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4632DC433FE
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378667AbhLDUED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbhLDUDy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C486C061D60
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y196so5055887wmc.3
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4MItie7vNQS2KAIdrLM9LL/xACe4+d25xi00b/lXefA=;
        b=g0eRzzKJRh1vyqOY1UvXCVXB4zQusmzHyFv9mAtfLoQQmPuQRvCxwDbvC7t3cR9EMd
         1YYT0zFJvgNluUugLstwCWF+NGlKYwTTcFVkssEXP7F0LrfK35aQ594XA8LAgSKG85xI
         p2x+f3wgpnQivQv7uGKEzfoS5cGLowNMz7mIjen4oFyDnbFSAqk4JGH9goqXPxAIZxSk
         v8qVuTkG31J+FRCxp0v2gWWg1uRlpr5Aj3Rg+JJ7hqBLSSS6DHYgdp/beBk5k96kWys4
         wxgV0Fl9AhpjdhMWmLF23N1Pm4Q6/59B/0KxdqHBo8E5XYDnSPoR5i2iwTL5iCW2dXUc
         4cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4MItie7vNQS2KAIdrLM9LL/xACe4+d25xi00b/lXefA=;
        b=uWW8EzKeQcUASuXponFTGaiyfiY6quabbH7N+pTx+q5bB5Aw/qT1sqZi7TCIjSgVN1
         VCHCMs3PQdCZmldZ0HgDja5Lib5ySLaM7PWbCORCbKmeLklV1QWUpDZkCY1ZIsNgr+3C
         ekeyOhA3eLDlyP+0mbm53gjvFUhCPmK0E2e077VhHRFHRRWHgDrYXZLtRnPpWlaYZOxU
         BClupjZNZOeVomJb4AUYPsc+RO7VBFYRe2qqdBAkzSuUXcl/XQ6+hnJz7mNF0tijDcug
         1gJHUF9W4XdBJw+PaEn+k3kn90+gsfwY5Sa5LqbQradg7HnaghJkXy/zKG9KEwd6xEuf
         k6nA==
X-Gm-Message-State: AOAM533FABE4VpmTgYo58NdR3O9QcNGpQZM7d0XwC+XPJZPmErn/I4xY
        F4YDeweXtijXTFdfeS1rWnDvZ5J9sUs=
X-Google-Smtp-Source: ABdhPJwlZIg6lwrr8kTnc3kS2Jp/Zu3D1FX5zqgTMtjaLDahWiNHHStydur2YnkxeFFGdrwzQY3VwA==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr25677236wmb.174.1638648026500;
        Sat, 04 Dec 2021 12:00:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm9334552wmb.24.2021.12.04.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:26 -0800 (PST)
Message-Id: <2ad404874eed9bebd3102466bbc1e0d92cdecc30.1638648020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:20 +0000
Subject: [PATCH 6/6] clone: avoid using deprecated `sparse-checkout init`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
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
