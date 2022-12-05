Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B7BC4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 14:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLEOst (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 09:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiLEOsh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 09:48:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C31B7A6
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 06:48:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n7so8899636wms.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=smBiknFvBOb/pWyPHDMNF4jgHU9zm10tMz+NKUJJcH0=;
        b=GNAPnXGakAltySI/AZCnR273VRHcQB0nuR7/7GJQGaXena9XUlB4qPHXVgbVquoPKk
         t8uRVtYHmy8lLqpD9WiVEinLaRGuILXjut1Gg5UVGBh94FhsNqa/mQwA9NN1qtHIkIoa
         pYKYNtkThxuS33ubvDtQd3b9S6WQ1O2TmSa1HOOQ0PQ1BJgZJ9l7OTfIs9kPgy2MjT72
         FhpQYLM03NB9vwSzxhWPZJcZIpO3xY8dLwY3J0CiWERRZerobn232/N2YVeJRDmoT25S
         EP9JjAOkwhDfAwx2PBQRiH3C5t/YQ9SkCNsV1A9ryvecjmddt2+dbDoJJh+8fwk7yAoL
         lX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smBiknFvBOb/pWyPHDMNF4jgHU9zm10tMz+NKUJJcH0=;
        b=rx69cGEgWcApVNXE6LHKIxNRl1K21NjT7BWH+5ggsK7rSDMphyySJc4rEZ5kz/d5p3
         qNS9om1D1rrXWWPtvPCqbE4BU55EyI3qSh45ONWkshvYYTE0HirgCyCzBk+Pb4pPn6eW
         5F1xClqub1VevdFulnhJMqnpM9xhm9tPZ+spgSQbhYJlkOrdphkAqOCpdKmehByqasWU
         XHGVbq9YZwOLY/OBr9Yk8mI/z8Jyr9kD48JI7PV3OiUHMOtK6WQROX0y/ZE9FPQdcU8q
         21+FYOwjjA75FMC1OgcdMvmQD4vN4u1N1ebu6fELE/88buS1l6VRxgc8+qIY7YLeuSPg
         4oFw==
X-Gm-Message-State: ANoB5pkIHPYZAFLXrnHlXjBK/bDV87Vkmnaq8TJTgfY6J87GhhhJzF05
        gh2bIFnM8uKOH4eQC8VxVRKgkWe8HQc=
X-Google-Smtp-Source: AA0mqf6VSVyrI0a8pQRgPsjE/E4Nc5QaWwhUfB8Dal8REzNUi1K3vCLOWiDeeXjyDAG5Ik4nI+LQ2g==
X-Received: by 2002:a1c:5406:0:b0:3d1:e3ba:3bb6 with SMTP id i6-20020a1c5406000000b003d1e3ba3bb6mr984210wmb.29.1670251714949;
        Mon, 05 Dec 2022 06:48:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d4f8f000000b0024246991121sm8922957wru.116.2022.12.05.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 06:48:34 -0800 (PST)
Message-Id: <pull.1390.git.git.1670251713061.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 14:48:32 +0000
Subject: [PATCH] maintenance: use xcalloc instead of xmalloc where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija <doremylover123@gmail.com>

We can avoid having to call memset by calling xcalloc directly

Signed-off-by: Seija doremylover123@gmail.com
---
    maintenance: use xcalloc instead of xmalloc where possible
    
    We can avoid having to call memset by calling xcalloc directly
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v1
Pull-Request: https://github.com/git/git/pull/1390

 remote.c    | 4 +---
 submodule.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 60869beebe7..75315f3563f 100644
--- a/remote.c
+++ b/remote.c
@@ -2741,9 +2741,7 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
-
-	memset(r, 0, sizeof(*r));
+	struct remote_state *r = xcalloc(1, sizeof(*r));
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 8ac2fca855d..4ca4f6c6590 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1464,8 +1464,7 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	ret = xcalloc(1, sizeof(*ret));
 	ret->path = name;
 	ret->name = name;
 

base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
-- 
gitgitgadget
