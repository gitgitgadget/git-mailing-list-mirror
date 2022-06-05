Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68AC433EF
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 13:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiFENhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFENhc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 09:37:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3892253A
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 06:37:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q15so3211398wmj.2
        for <git@vger.kernel.org>; Sun, 05 Jun 2022 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6B8QfVINBugm9XRqjG7W3DyOBSmzhL97w0SqhZMuy80=;
        b=SRSSV5e2FcliWwjodvibcccEps4ZSVbxy7R7PlaqzW3IM22RXXiu8DrEcE0VnNeJ3H
         oJ739LHWM0hIJM6x3B6eaxx5o7KN4CCR4v9FLOp4jEl/RlP4oWNUf+8twwP5aKozClmR
         +ByHaTJU4xuRmCWZGJ6T14gWwisLerZsDnNJ4G0y10l3iUXHQfXu0uuqWr170YwUMARq
         2WLUnYh7+RW6c+XQXdt7spAHY4mGIOC1xSlg+Lj1cMk3M/rNCVecpJXzTy51mXOzNmW/
         V8u/2OlZNZhnEu6ejAUtxi/yx1t8Z1E9pABVdlu/Dg/R0faJvOuep9apTqKU3I4fSj2c
         hE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6B8QfVINBugm9XRqjG7W3DyOBSmzhL97w0SqhZMuy80=;
        b=x0ImYCVjeHe9Ki+d2LPHxurdcaXg3WqxsQqlWo5XVzOxwfoAtu5GfbWdtKhWUSxOhl
         9PSFiRYtjiQKUFMXWskjYzBx47JBJ4dqMofSkbOLFf4UDPGcYX75veTp7Aw1axEx6ltK
         wCIuftukl5/qYQEcAEcR5G8KW+SHVArvUGhlsgnaQGYfrYCfZkZINjoM/9XbTQmgr/iP
         EfuDcO0Gp872BuICEkPXJqO5nEXZqEj5WH40Bzhqy1r7Vlx2jm1bz78X1wThnhKE6Tw7
         woeXXdp7/v3LIxeAIWeuqvV5tUWx92nQnTw/dUPkT4J9+BvkBDjZoEkbKjqmBp85EHHs
         AQkQ==
X-Gm-Message-State: AOAM5300f7y2SVxK7yflVTqodGcyepAh0JLEvUqt0xHDLFAHMLhS0xrM
        D0BFRJTfWYh14XbEx1GPTVhnk88kVCx2+JDU
X-Google-Smtp-Source: ABdhPJzxxJMVHSPdScuptazwb2Hpe3wMurZ6r7mvsqRgo+iIYXuYWMBscvzo5pTKFkd6baQ9woGG8Q==
X-Received: by 2002:a05:600c:1d9f:b0:397:4192:4302 with SMTP id p31-20020a05600c1d9f00b0039741924302mr46889398wms.193.1654436249612;
        Sun, 05 Jun 2022 06:37:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020adfa4c6000000b0020fe61acd09sm13311999wrb.12.2022.06.05.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 06:37:28 -0700 (PDT)
Message-Id: <pull.1249.git.1654436248249.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Jun 2022 13:37:28 +0000
Subject: [PATCH] read-cache.c: reduce unnecessary cache entry name copying
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In function create_from_disk, we have already copy the cache
entries name from disk or previous cache entry, we can reduce
unnecessary copy before that.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    read-cache.c: reduce unnecessary cache entry name copying
    
    Index cache entries name are copied twice wrongly, so reduce the first
    one to fix it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1249%2Fadlternative%2Fzh%2Frm-ce-copy-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1249/adlternative/zh/rm-ce-copy-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1249

 read-cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 96ce489c7c5..e61af3a3d4d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1944,8 +1944,6 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	ce->ce_namelen = len;
 	ce->index = 0;
 	oidread(&ce->oid, ondisk->data);
-	memcpy(ce->name, name, len);
-	ce->name[len] = '\0';
 
 	if (expand_name_field) {
 		if (copy_len)

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
