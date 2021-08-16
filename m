Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CADC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879B560F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhHPRta (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhHPRta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 13:49:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F5C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:48:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso474822wms.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5XCwsBS46h84k+aCMhr8Q9TTHGH4tvWl9ugrxm+Z3YE=;
        b=N3O9dH5HKDuiA4wMUNHWCpcOg4MlQ5IvmcmfC2qJMYWe/AnzFlsQqLICNepoauaUqs
         y7Aei1Cn+O7xkYCOTmFqXpdRBQ7DO9Uf18QKlpxEAeOC3LE9m0kByfxqmD9RlYrMfBkN
         59o3tS4bmGSpGKsbeJjdc0LhSNLmMYtzzuNwk6oOvfn5DW+VtT39jgaX7cmAifr01CA8
         rttE8trhGfML9Gpk7xlINSmQ5BbKc8gvZ7OAuSrhdk+MPxvXOCJKK8nD5oTKO2OJ6dGd
         Nn0FGu6oy64VOGB8LanBxmmIe3sqKEwMMXxk6MOMfCv79mfUylHPXqnyIZv4zgZVnk3S
         1CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5XCwsBS46h84k+aCMhr8Q9TTHGH4tvWl9ugrxm+Z3YE=;
        b=W73SiequFsaGgbaOkYsHNpgfqcq5WzsEb2u83c97nXcj3/9i0xXXPqbiziAWEftefr
         uPPuesDw7VvPIlLlZJQvCrJB73478bipssrHepCaSA4qgJSpSTGpK8cbLC6UCOI6QtYW
         /RYh4qiy5t7qoktbQfDCHSLFiRQalOBZR9A6KeR9eWFcUrwtXa8o/yTsmrN57+3gPYdO
         z/TzkwXLTkxA03hp/13Vf0FASulAEv/MBonnA8m12nQj3U7PBHXPHsGAjOeNJnZ5GpIG
         zd2OxDF4tF0gQ5AQAYucZrIe9yg2ultKYddByCYCgpT8b+HL3haWovLymslP5mBUQO/d
         kcbw==
X-Gm-Message-State: AOAM532cQi7aEoXAXAwNlAVDf01Si664Cq8bRj22RU9QEejKnHvx4TOq
        YxhbtvrUhsDj6rRN5FgBLiYpaeD+chE=
X-Google-Smtp-Source: ABdhPJwwruExBDGoOFiQg4evn9rQJL3OFnSuJWvSUabbH8wDY4H1ww/XzVhFH0SM44/H1UTxot7Q5A==
X-Received: by 2002:a05:600c:4e87:: with SMTP id f7mr293424wmq.42.1629136136523;
        Mon, 16 Aug 2021 10:48:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm226804wmi.0.2021.08.16.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:48:56 -0700 (PDT)
Message-Id: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 17:48:55 +0000
Subject: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Copy the 'index_state->dir_hash' back to the real istate after expanding
a sparse index.

A crash was observed in 'git status' during some hashmap lookups with
corrupted hashmap entries.  During an index expansion, new cache-entries
are added to the 'index_state->name_hash' and the 'dir_hash' in a
temporary 'index_state' variable 'full'.  However, only the 'name_hash'
hashmap from this temp variable was copied back into the real 'istate'
variable.  The original copy of the 'dir_hash' was incorrectly
preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
the stale version (in 'istate') would be corrupted.

The test suite does not operate on index sizes sufficiently large to
trigger this reallocation, so they do not cover this behavior.
Increasing the test suite to cover such scale is fragile and likely
wasteful.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    sparse-index: copy dir_hash in ensure_full_index()
    
    This fix is an issue we discovered in our first experimental release of
    the sparse index in the microsoft/git fork. We fixed it in the latest
    experimental release [1] and then I almost forgot about it until we
    started rebasing sparse-index work on top of the 2.33.0 release
    candidates.
    
    [1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp
    
    This is a change that can be taken anywhere since 4300f8 (sparse-index:
    implement ensure_full_index(), 2021-03-30), but this version is based on
    v2.33.0-rc2.
    
    While the bug is alarming for users who hit it (seg fault) it requires
    sufficient scale and use of the optional sparse index feature. We are
    not recommending wide adoption of the sparse index yet because we don't
    have a sufficient density of integrated commands. For that reason, I
    don't think this should halt progress towards the full v2.33.0 release.
    I did want to send this as soon as possible so that could be at the
    discretion of the maintainer.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1017%2Fderrickstolee%2Fsparse-index%2Ffix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1017/derrickstolee/sparse-index/fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1017

 sparse-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sparse-index.c b/sparse-index.c
index c6b4feec413..56eb65dc349 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -283,6 +283,7 @@ void ensure_full_index(struct index_state *istate)
 
 	/* Copy back into original index. */
 	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
+	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
 	istate->sparse_index = 0;
 	free(istate->cache);
 	istate->cache = full->cache;

base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
-- 
gitgitgadget
