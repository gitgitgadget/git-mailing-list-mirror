Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE6BC433E2
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04B5206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8fN9e4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgFESDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgFESDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498E9C08C5C3
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c3so10627394wru.12
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=o8fN9e4PnhwPaIuj8fIlLnOb+dgSCs65KRGzCOhvnBZjVzTHUHkzF1fnJ3tRiRD5Da
         +9isZggEH5efD+JV7xyStVw//tFYkyy4ZYAZpwF/WH+01ogGb9WsVDtcZ2nIxEmzx//w
         InpcjZQldrqdLitlIPIaojSRhhJZWp448XkNKS/YmCryG0YBJKF6aVy9Hw9WCHE7u5jL
         1yLI/6DW5X1T5I+4vh6Ywz5CP0XyIHcoF267gCvLzdxr7lh2GPa17f4PuMHAM6CYsAvi
         oLRBRE7JXBMAuGm7oVRSk8ozBqMQ99WxcY87DjkyPk7/J1IujRomply1p0qiPFLndVVc
         S04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=suKI7UPvgfuzcDnllA5MMBFSpWXbav+RPMjdnawK0w6dzjbyBqBmm/puvBHmoyFSHZ
         wboIqSMmJBDdioe5CsU8m3l5tmk5BVJMQd/2pv4NoDfll22JqWfLTpjn5+zqqxzXQmiM
         Pw6YGJJm96De1O81n3sE7GcxOBiK+0WUYXWqLLPvkGpsk38gNt+vjum50f+3N/lXbBRy
         gRlKJ9zQRNfx60M1pNV7ohfNLCAsxOQCMQq1LGFGfarj5XrdjhADLC9hqCu9Ee3NAMfN
         y9bfuYUe3Qv41ViqhQqcOWoDiHZc9JbcXaN4Mu0Re0bZscRmt22SmPIqSQtsZl+b3lw7
         NzBA==
X-Gm-Message-State: AOAM5336vYCK9YigVeTDPfHhAuhLCKvHaOW9uCJ7Cn//XPnsMXS1l0gn
        lxU+Lj9tOsMSxtDdDiQOgjC2A86l
X-Google-Smtp-Source: ABdhPJxAWtXAgt5/xAxNbZT2rjK6f8XG7jIV0V33n8DOgyTvyiw0o/d6M9WOLmZs/iOgLSnZDO/eFw==
X-Received: by 2002:adf:f707:: with SMTP id r7mr11515442wrp.390.1591380209928;
        Fri, 05 Jun 2020 11:03:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm11481432wmj.22.2020.06.05.11.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:29 -0700 (PDT)
Message-Id: <78cb1930172144914c5c8760dedfa947560c9a33.1591380199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:12 +0000
Subject: [PATCH v16 08/14] Add .gitattributes for the reftable/ directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 00000000000..f44451a3795
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

