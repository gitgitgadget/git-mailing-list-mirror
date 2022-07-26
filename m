Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E8C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiGZRJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiGZRJh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 13:09:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066D1D0D8
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:09:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so9133799wmn.4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=BW03v3Zyup3jb0vLo5ci1QTSO9zW1PDBUI3Hdl/HZis=;
        b=R/k6S5l8A+gdSnwzxNJUTEvcZjHP996sH+s701m/UssHnxDBMlmAtV1WeR7WBf83cF
         1n4g+KvYPaGuUT6Xzy4XXQxcIjCo6CQ2zK52Q3Kxl/SSc6w3oFRZ+v5oeTFdNNRbYvu3
         emuETJ3SVapDAO0LMwjU9/aThzDJg2r8BCtIq0MTdAGNgfuRI1SqoLzXeZv8480MWYtO
         hh4L9YPxlV2xf9B7osZXyF/djYPvUiqdVUZ6NiVOlzMXjUX0oCV8bk0UvNvwIsIfCf8t
         7uTCWenqnsVfY5gIRm8qOAC4JlZddsF661gZoyUmszQNG/JoaHEdyngDjky8zHrUB1MB
         0c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BW03v3Zyup3jb0vLo5ci1QTSO9zW1PDBUI3Hdl/HZis=;
        b=WTfS0Qe3vqwZJabuFGkGmw7LIZPvJIT9CL7WfsbPCNUeCGLuubIdg4ceSC3jQ5VIoB
         57OUVGjP9Sp757zOYmpizPJPXLmk94JEUECxmtG09Y/GEHDNZ4zHyJ54QaOEdLMqTMN7
         d1pfmWeIMF6hRj29To96E8qPc3GCHjdJcYGNwUN9b/5/KvvtstOE+iWjQogSAwvkZ120
         OwWAygpwpYnii7WdwPcWTNI/7b7GuhXkM82FWThC7MfEtiZ28lKyPZZTn0K2oGeRB8Pp
         mgvZ5Nx97h2XiI31uJDeog3NfpOxs5nZz97gH6omEtiUAzR4s5fL1tnQYOExhcwvwDCB
         2Ovw==
X-Gm-Message-State: AJIora9oihu4LLxB8vHzapFCDhcL+FNGpTpoqQym0i9uLwBEoQvynUjh
        Rn3EAcL+HoA6D2uqyd9FlA62YffgAAg=
X-Google-Smtp-Source: AGRyM1s1lFIYEW85LL2GAnSonP7nMsVo1iel7MIO0wkcz1lV3otyLY9m4JNVlCnqh2obMPFahRzfzw==
X-Received: by 2002:a05:600c:1f08:b0:3a3:1b00:c201 with SMTP id bd8-20020a05600c1f0800b003a31b00c201mr109767wmb.171.1658855374481;
        Tue, 26 Jul 2022 10:09:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003a30fbde91dsm24896724wms.20.2022.07.26.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:33 -0700 (PDT)
Message-Id: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 17:09:32 +0000
Subject: [PATCH] config.c: NULL check when reading protected config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In read_protected_config(), check whether each file name is NULL before
attempting to read it. This mirrors do_git_config_sequence() (which
read_protected_config() is modelled after).

Without these NULL checks,

 make SANITIZE=address test T=t0410*.sh

fails because xdg_config is NULL, causing us to call fopen(NULL).

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
    config.c: NULL check when reading protected config
    
    This fixes the SANITIZE=address failure on master, That was introduced
    by gc/bare-repo-discovery. Thanks again to Ævar for the original report
    [1] and for proposing a way to catch this in CI [2].
    
    [1]
    https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail.com
    [2]
    https://lore.kernel.org/git/patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1299%2Fchooglen%2Fconfig%2Ffix-sanitize-address-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1299/chooglen/config/fix-sanitize-address-v1
Pull-Request: https://github.com/git/git/pull/1299

 config.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 015bec360f5..b0ba7f439a4 100644
--- a/config.c
+++ b/config.c
@@ -2645,9 +2645,12 @@ static void read_protected_config(void)
 	system_config = git_system_config();
 	git_global_config(&user_config, &xdg_config);
 
-	git_configset_add_file(&protected_config, system_config);
-	git_configset_add_file(&protected_config, xdg_config);
-	git_configset_add_file(&protected_config, user_config);
+	if (system_config)
+		git_configset_add_file(&protected_config, system_config);
+	if (xdg_config)
+		git_configset_add_file(&protected_config, xdg_config);
+	if (user_config)
+		git_configset_add_file(&protected_config, user_config);
 	git_configset_add_parameters(&protected_config);
 
 	free(system_config);

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
