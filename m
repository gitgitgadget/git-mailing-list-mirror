Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8FBC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4351461073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbhJPJme (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbhJPJlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2CC0613EF
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v127so4277163wme.5
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLmZ2zA0c5ZCqhb4v82laJzUYRGkOSKnuoZA4LgotXw=;
        b=fN9gwpWm2nx1IMwcsQhp4Gl0IJPRpkCCXK8UJfiOEvA75GoCNFdi8ZL5uIsapZ9GLD
         4Bww9UjJWWCn+2HEMkVee4ki8nSK4cjmTiTOadEHXF7NU6eej9KVkectSEgQZcsFf04e
         Q3UW6gQaStMDtH6N6AGygZVE4KGhOARQ3BNS8sdyPy5AKVnmttiltAcBLGuQTP6BzV+k
         VlAurxrG/BGjpsMpPPCP88Edm6PvC8xlzsre88rcZNcIuK1sQwWcMcHTeHB/bPI3t/zF
         ++Ndo8qzhGt9FT7shAXUo5rhbtxDHFNqZuz44FrV6aA63kwIAQGcQnKU04DA2j9yUEu3
         w3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLmZ2zA0c5ZCqhb4v82laJzUYRGkOSKnuoZA4LgotXw=;
        b=7Pa9NfosOKhTEC2kPAq2Xozgx5charvNqO6YPdm/ZfuA1Gf7EAn6iDcsS3ueV/KiBR
         o7GHnT6OhiuMBbPn7nC1xk6zyeLKLKi1dAMZ2G3jUSWXdnAhD8KXvSMClDphT5ZfRglk
         AOFhw/lIv+kvLOKB3u2tuxtYHXeHAaoyboFYn7uwZJB6gQPtRxuhTV6xGtSHoqdN44Fu
         P3wwdonr1HNQFXt+JHoQ00IEx7La3UwJtCPHmqz8/d9hfJRkjlXFcWq7nYx8vzf94cEq
         tjbddw54RNbaMpi4k6uzFAlAdZZyTn7yK8Mt2D977cC8fRFfV4mLTFhldSNFoTuJw2DY
         54Og==
X-Gm-Message-State: AOAM531oP58S0mk6PKP/Bltp351BgIvp60JmQRnZZyIxRbvKYF0IUJ+1
        KJOp39ZRiNkX/9ZBvDyD8/t8BxeE5pQN+Q==
X-Google-Smtp-Source: ABdhPJwtcztftDZCtCLIo3C08vxGn182Wueri85jJDuha+9/jolkQC7bD+1UXm1G9SisaGDBEFozfA==
X-Received: by 2002:a7b:ca4f:: with SMTP id m15mr17477656wml.113.1634377176952;
        Sat, 16 Oct 2021 02:39:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/21] refs API: make resolve_gitlink_ref() not set errno
Date:   Sat, 16 Oct 2021 11:39:15 +0200
Message-Id: <patch-v2-09.21-65beb51ae4e-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have carefully read the upstream callers of resolve_gitlink_ref()
and determined that they don't care about errno.

So let's move away from the errno-setting refs_resolve_ref_unsafe()
wrapper to refs_werrres_ref_unsafe(), and explicitly ignore the errno
it sets for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 80b85d244d2..dc6ed561492 100644
--- a/refs.c
+++ b/refs.c
@@ -1791,14 +1791,15 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 {
 	struct ref_store *refs;
 	int flags;
+	int ignore_errno;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
-	    is_null_oid(oid))
+	if (!refs_werrres_ref_unsafe(refs, refname, 0, oid, &flags,
+				     &ignore_errno) || is_null_oid(oid))
 		return -1;
 	return 0;
 }
-- 
2.33.1.1338.g20da966911a

