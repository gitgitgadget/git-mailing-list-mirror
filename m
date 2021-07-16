Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182ACC636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036BD613F7
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhGPOQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbhGPOQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0639FC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso3505915wmm.1
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vS8cpxYaUJiKejehV8UbxlfqqpZAb1uy3HabawGtWGs=;
        b=O4f6mUElDYRERyEYVluXTPoMCJ3e2kRz/qVy6JwZQ2zS9zsQiqQCaGrTp7npJbc536
         zQTVPiyHJ5LKhixOqhhaaGN/8hIN2CNUB2mIabhGX3cTG3OXUvNnhJnwE/LEwSTUsrky
         FQIxEMf2U+rp+uNhaCU9SVWx0qiJrgZawh/7/ZaL2+x+dQodPgo2aChxSHESwBE93M/c
         UqosOQ4Yknja874iwI1dLCcq9UxTImtGvcT1LI6a/DjbkrtoowA2zkWPQwqTLNBpW4nV
         UfaLeTTez8SXr6lF6Av81qYuzj9cxAgy4uLj4SlD4PXqq166zLM5D/2Yr/WdOLU4KWit
         Dxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vS8cpxYaUJiKejehV8UbxlfqqpZAb1uy3HabawGtWGs=;
        b=bNa3pvrSlRLDRa+dVNcUHAoRcjRfTTMMaCZR3KIG0EPooYVD02nG1z0hMH4OgjZGyy
         8vEQ3Cvi8Atfq17oES0ph9L+OgH02bQMTw8Uwnbdpm3dxVcqdEnB17V3PEpmGBv6uUf5
         JI1nzrQ1U+a/zlJTpfAvUdkaqizdS8VjeFCiWum9WFmv080LezavwXQnsDjjOo42FXs0
         FtTx9cpVCopNQJTQlwOs+V4poxeamiw08XQHML2kLHTCiUn/roIdlcRqRAUumCHXHuPt
         1BPuvakjgqCP7HjKTTgm78myVCTZlAlg3hUP22PlPtvZ8PWCWMPbjEFxyFZh8WxfZ2tC
         fbOg==
X-Gm-Message-State: AOAM530zGrVvW5HyFFCCCjIvNyX3Trt7MelR81qxCUFrjyCOKCmhtYq1
        NVm1VxdFNUB+2IT20NxikJsdh+r9ynLnBQ==
X-Google-Smtp-Source: ABdhPJyVFtHSy+0MXJRAM4q4iFHvue7e67xyNoTkuhMGJ9/ezOLiROB2yq0ndxh/iKXCAMadEupn5A==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr10504502wmc.111.1626444803273;
        Fri, 16 Jul 2021 07:13:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] refs/files: add a comment about refs_reflog_exists() call
Date:   Fri, 16 Jul 2021 16:13:04 +0200
Message-Id: <patch-08.11-1e25b7c59c5-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about why it is that we need to check for the the
existence of a reflog we're deleting after we've successfully acquired
the lock in files_reflog_expire(). As noted in [1] the lock protocol
for reflogs is somewhat intuitive.

This early exit code the comment applies to dates all the way back to
4264dc15e19 (git reflog expire, 2006-12-19).

1. https://lore.kernel.org/git/54DCDA42.2060800@alum.mit.edu/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ec9c70d79cc..f73637fa087 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3068,6 +3068,17 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
+
+	/*
+	 * When refs are deleted their reflog is deleted before the
+	 * ref itself deleted. This race happens because there's no
+	 * such thing as a lock on the reflog, instead we always lock
+	 * the "loose ref" (even if packet) above with
+	 * lock_ref_oid_basic().
+	 *
+	 * If race happens we've got nothing more to do, we were asked
+	 * to delete the reflog, and it's not there anymore. Great!
+	 */
 	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.32.0.873.gb6f2f696497

