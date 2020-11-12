Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF11CC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8520A8B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4hWz8uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgKLWuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgKLWuC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:50:02 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE11C0613D6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:49:52 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id g19so7197583otp.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9nVL/dorCCVkE+Ics2KeVkw7mgrd8hr0iScRJ1OoNA=;
        b=j4hWz8uVMQxlGec2whoRsKjYInBss7LYbucItPII68Y0U4W7F12Pm9Fe9brLjbnuBD
         US56lm48mmmLDlQ8M8nhMTq+usDY4Yd27XijMW73oIWJ5hGoS3oI5a0evpeUQu6ATG2/
         Er+imWYZ9PnMGemjKMRLB4+ZsEBkcHhchi8UhFn32hkcrcD666cZLf2BVzvwWkMFKKyd
         lZbC8yLZ3ZvNtlyZ8NKKVLclNvxYUoKgD/6+EXT7GPOKEj6eFxPTOO4/dTOM9nC/y2+g
         Z0n4NtMjTxm+H0c4tf+7e6/OkFVUXVBlXoSNLnt2j5snViVr9b8gtiE46sOUZXrSl8Kc
         pUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9nVL/dorCCVkE+Ics2KeVkw7mgrd8hr0iScRJ1OoNA=;
        b=l7DYSWElWg/d3LRteQzndixOBz/ycOEjyDKsQB2aPKbO7M+2VRhDCnW7R8I0UhDLiw
         4UHTE2Ra56PqJNBM/3auatyk84qeKoDif1zCgZ6EanuNlLyjmeAs2gfbk3OprEBW/bVr
         Dd+K5oZ0lotNv3CnCis7K7AWNBJFwuFZ06vU3+2RQAbMucbt/u1TWzMnAF5pCbf3INaN
         xMpHkISl559jBFlZMnORtQKU+j3ZsD3Ff983WGDQH+3hM/Zp1LREZULnsR519vuF52KB
         APx57QWmrAqsFFdexf7ZMJPTH0hdU/4EFoa26bYGPwQr1ybMOCdpZAOkeA2OFiIx5cij
         bKoQ==
X-Gm-Message-State: AOAM5315HfAxuQxezndqwdUqBobD2i2DTcSBNc+dfFlsChL4LnOIo9Sh
        bkErlsxKffW8J+8TyoiYZQIimJNoByJk8g==
X-Google-Smtp-Source: ABdhPJzfTx36d2EN0GTT4sTq+aOdq+vkdoEx5Q8UzlRv10aGuIH0z8D5fdyM7ciAImrZHdpp4GjJWA==
X-Received: by 2002:a9d:6647:: with SMTP id q7mr1149542otm.196.1605221392010;
        Thu, 12 Nov 2020 14:49:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m65sm1554467otm.40.2020.11.12.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:49:51 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: zsh: fix file completion with prefix
Date:   Thu, 12 Nov 2020 16:49:50 -0600
Message-Id: <20201112224950.1528143-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out we always need to set the ignored prefix (compset) to have
similar behavior as in default Bash.

The issue can be seen with:

  git show master:<tab>

Commit 94b2901cfe wrongly removed it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This is a regression since the last big chunk of changes.

 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e0fda27f4c..6c56296997 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -116,6 +116,7 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
+	compset -P '*[=:]'
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-- 
2.29.2

