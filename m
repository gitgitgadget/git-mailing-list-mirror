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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F20C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5BF6103E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbhIGVGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhIGVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08BC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso2841547wms.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BrIOyyYw+jCFvpv61hsUXTft4vxNbyrxYjFHyiRi1Vo=;
        b=C0WzcyK7JjCaBlxCiAgra/QRH0eW479GnBwSd55YdDbuFtdnBo5hTRcNH0ZKsx0QQH
         pWIxxb9RcD+FsqMLtWF6R2SEGBN2JCh59e1XxGxTij2gM+zC/i6cmJ/YvtUBmO8v3DwL
         FzmDNd/9zLuI7oEpT0Jf/IvcDaDNkQC6suKpkd6TOG04VNJ6Ra8QB60WYkaiZgFIKhsw
         OvFsybsjckpQqG1B/Vg2hUXM2yRp1smYqHMBKrTZ9SGaQzA7ZvXvN9PTgeBElR8S9qwj
         o2BpdLxuGwwnmhnpCVUJMSPAsgXuFZ4KGEXFrGbL4loD92y9IjVmzvfRGw36r7Z1NuTd
         TqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BrIOyyYw+jCFvpv61hsUXTft4vxNbyrxYjFHyiRi1Vo=;
        b=oregTSuzVOlP9IEsRdSnJj4bf1ji2S8EPUquqsmuE3DNnSXbAS7kh4usojj2CG6+1j
         p2WoaKCFjegjJDsvFQqJ8adHHxWTLpmK+IYWYM89nM4NCSdP0Kd8cXVmEQoXmIq+luvM
         8iIrSu1UQx2COpGztjnPw4u3gPDVFIcFBmH1F9DDc3iJ/W25Oc9mKT8ChqhlkU8pE1ef
         gTo81Inlbxlw5iS4Q5QHKdDJfaUJH+pq0v1PXEB7c5eKVQe7Fea1FVHXhqJ2j4lwumYS
         qNZ50qKaPBr3KoDt4mtJaWQuYBWGLxpeMoK4/eTXGqNdLIprX2hXPEv21W1+wt2Of8+z
         X8hQ==
X-Gm-Message-State: AOAM533lR+J5fbQFLKitxjdk9C+i6e4DsTWAYft1Rx45PbZvf6SdurV2
        pC9xR/YBclpqtZ5ONwsbbyQDxK2JoOQ=
X-Google-Smtp-Source: ABdhPJxvAUhm2GcWKk8h6Nf3Set19og3fBSoNOE3rYAFKZyFAk+u7mXN+t9N4+sP1vsmUuRgvAkq8Q==
X-Received: by 2002:a1c:443:: with SMTP id 64mr175429wme.180.1631048715001;
        Tue, 07 Sep 2021 14:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm141166wrv.18.2021.09.07.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:14 -0700 (PDT)
Message-Id: <8da29d539fc2c9700630d5ec4a80cacf64d44aa0.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:02 +0000
Subject: [PATCH v3 01/11] t5520: do not use `pull.rebase=preserve`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even if those tests try to override that setting, let's not use it
because it is deprecated: let's use `merges` instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e2c0c510222..bb9b6b900eb 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -598,7 +598,7 @@ test_expect_success '--rebase=false create a new merge commit' '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.rebase merges &&
 	git pull --rebase=true . copy &&
 	test_cmp_rev HEAD^^ copy &&
 	echo file3 >expect &&
@@ -620,9 +620,9 @@ test_expect_success '--rebase=invalid fails' '
 	test_must_fail git pull --rebase=invalid . copy
 '
 
-test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+test_expect_success '--rebase overrides pull.rebase=merges and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.rebase merges &&
 	git pull --rebase . copy &&
 	test_cmp_rev HEAD^^ copy &&
 	echo file3 >expect &&
-- 
gitgitgadget

