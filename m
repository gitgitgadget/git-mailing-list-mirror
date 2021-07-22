Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25634C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE8360E8F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhGVUsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhGVUsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B88C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso2093188wms.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CpONMo1NgsRjmLqGOdzgyXEs+Ovf29aJOIu4Ra261PI=;
        b=NQ4iEEpVFX817oF1nFGBDysJeryCeSG1r/iwAzF4s7qtyKvN0Vdbw0aj5DsBXSOFQ+
         6V9u9qv73Z+Q0JxevNjcfd+UQXBQwQgBCJ2voVs80MkawVzpoMZeveR23Wj6xCi59fyW
         AjBgU9ooUD4Da2lCoZXAdqcx/csnpmWTfYtQf1ENWzsdf/FjVX30SWn72AGE6FIYgGND
         PKpjZJyzrKUlxWpaNYDXj8QqBlfzSgutZ2jSuTsxxcJLkjAnjASmOPtfIHHkEUOrVNUF
         DvtYg8eQWOyiDQTl99KgTj9n9lGNywJcHR5kH6z3exAg46XvH53WIWflsqCLwOM2kfsI
         Jfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CpONMo1NgsRjmLqGOdzgyXEs+Ovf29aJOIu4Ra261PI=;
        b=PLMV1Col5Ue6dAGpYEX7IX25lj+sKW2Xo+GfDMJMCk/9QcR0f9qfDpEGOGrNxwkklC
         KZ+AXlv8X1pI0NGV7SzB4mbLDxQZpzRt+811zzoG3vNRVASpiw/UDdktJjgEIem0afGS
         0DviWEk1F8v5Y5eZTa37aW6T9qco0eKvEdkRuciqgZnFe5yRP0W1TplRAfezM2EJkVbQ
         XMRBnp61XOZK1ttPHyEWSi2oSo/dnqpQNSjW4EEq0Gv0KzAHDSe5y/xOgtqZkIC3vwlg
         b+czBVWotMCJd8zp+hbbOM9OJiZhv8QqkUCMmh5I0epRZZK4gVPPU8MgJ8/PEdpcXgpn
         Q2+Q==
X-Gm-Message-State: AOAM530vnzDIo0j8aZe6HKWJCX+tIrEYkFsbFOTZ0bXvAEYMDfR59pSM
        sFrPVNJcWnXsI2f30DrAzMQfwHeK8Pw=
X-Google-Smtp-Source: ABdhPJzGXh1yhSCFvnloyn2NSrOx8yKEjwgTITjKuTWX2FM+m+BQGqGu0sz1bWU9tuwf8akIq9R+Rw==
X-Received: by 2002:a05:600c:19d3:: with SMTP id u19mr11470912wmq.115.1626989335266;
        Thu, 22 Jul 2021 14:28:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm3558927wmh.40.2021.07.22.14.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
Message-Id: <81e46f955363fee8576b378f22273436e28b3675.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:47 +0000
Subject: [PATCH v2 11/11] t6001: avoid direct file system access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6001-rev-list-graft.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 90d93f77fa7..7294147334a 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -23,7 +23,8 @@ test_expect_success setup '
 	git commit -a -m "Third in one history." &&
 	A2=$(git rev-parse --verify HEAD) &&
 
-	rm -f .git/refs/heads/main .git/index &&
+	git update-ref -d refs/heads/main &&
+	rm -f .git/index &&
 
 	echo >fileA fileA again &&
 	echo >subdir/fileB fileB again &&
-- 
gitgitgadget
