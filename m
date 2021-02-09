Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3901AC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED41E64E9C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhBIRfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhBIReb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:34:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C14C061794
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl8so1970897pjb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F8vdh7XjqgjUgLdZmx1mpnnQVoOPhzxzXWk4x8TiI30=;
        b=Q1vE7LEHx+PiCYMM7LuLHzOBktheNs/l3BDxL1EXTTtKfTaxCvsXG0/PGX6xdOTtNk
         sJxuSHcPqJMCRJnfeWcKFUzet1uduO8FlWDZ9R7TxACQzLqIaFruzGOs9LGCN20PhSxZ
         tNQ3jlTzgJzx0J1S0u6qLY/YkvME24JaH0BsIXxouugE6jwxI7R1DLUMoOM8PF1+3+wp
         jGOHgqNICRRRS32Y9SwKuYLLR7IX6DEG3mTLgdRFGoAUsiayPKG7GMTKN1+dl0Xrfxco
         nUfnS2qg5oQMFYpYArTB9hOKKBcxDcnNc4Vuu7in33s98kR7v7JcQA+0uhW/ZEQ215zY
         zD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8vdh7XjqgjUgLdZmx1mpnnQVoOPhzxzXWk4x8TiI30=;
        b=oGS+AJY1KsUPjAriEfzpxuzZZGDH3JN/IyRxygby3Xn3DwhG0SrFq7QRrYl1ip4yzK
         1DjpKZFmuMTu8zjqn5OJ4ZuPSWTosMeKGfkrwmAEri5INaIh73CzHhbzW+EXjGckkIeF
         LQKj6EaqaPNuKRswG1Y4sid437q6K24WJf/s1cuKS92lkN192A//2Fu1v8kTsfIX5A0n
         zw9x3UTDh0j/wn3rFSGnoEAyZPlBHbf71s6GG2fJJR52P5PQlSX3QTvGsw22khR28vxP
         W+istw91SHGXy8Zin84RvZh5dxSnaRTfdeNfThDv2sRwp1xtUaDcfoZvAEKzvf3rbtks
         zOBw==
X-Gm-Message-State: AOAM531cYMLM1ZuVy5yohv/HSKtBqUBk8xXpLKnyfs0s4fzG47ukolCw
        medxh2UCeUgD3lycoGhXNS+vDr5CiH91uA==
X-Google-Smtp-Source: ABdhPJwNnmuBAdQghobvwbJ1eXxX4GOdrYvXVkNh+TXg3EjnnYgvevp37Jt3gzHMPyRli+MeDergSQ==
X-Received: by 2002:a17:902:aa8f:b029:df:c8a9:f8b4 with SMTP id d15-20020a170902aa8fb02900dfc8a9f8b4mr21704545plr.48.1612892001966;
        Tue, 09 Feb 2021 09:33:21 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:21 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 09/10] t7001: use here-docs instead of echo
Date:   Tue,  9 Feb 2021 23:02:53 +0530
Message-Id: <20210209173254.17712-10-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from old style to current style by taking advantage of
here-docs instead of echo commands.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 9a73232c7c..2e2e60e0d3 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -226,7 +226,10 @@ test_expect_success 'git mv to move multiple sources into a directory' '
 	git add dir/?.txt &&
 	git mv dir/a.txt dir/b.txt other &&
 	git ls-files >actual &&
-	{ echo other/a.txt; echo other/b.txt; } >expect &&
+	cat >expect <<-\EOF &&
+	other/a.txt
+	other/b.txt
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.25.1

