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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D07C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603F560231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhEaRlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhEaRkx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64979C00874C
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so331122wmc.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+BPbvLVCW7CbY3eCuBiPAJMheh+AwpAkC8tDkYsrN8s=;
        b=HAFjpsBaNqOiGFykb+Zmy9F1nR+LZLdwqjlqIaeUp3CoVXluFlRp3hiWZe9FDkK2E8
         ghe6cdA91m8ZH+ORFM02CaF9LbIKQt1TiRYhIRy06/vrgQQU1+BhbUYEth0biV5pxl3q
         LLPz7lolsz61T10h3jMJhkDLkmR00cbHJ66CWyj8WTnUzIqcF2MYwSlUlz7EcqR+VraT
         aW0V4EfNdkDrJK7t6gwten8QfTQ7jNMP5i+bIeycYHneVvAierLLyEiBV2Ri4z8IxcC8
         0Gjxexo+UiGKdZPbOTsQcPzbMvOCgRS+EzcLuTIn15VdQBl4Z7LfftDSv4qGeUqHA5II
         hXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+BPbvLVCW7CbY3eCuBiPAJMheh+AwpAkC8tDkYsrN8s=;
        b=QRE+MSP7gR2WSH7NBLtnNqmHaqQlxKeREyZUGF/VDJ11s4lHwHHppmu3JCQZtND0V1
         Cx+XNu0dj2SznP9976uAsKCR3EjJJhdC8uOS5PtJsLi3r0Ko/561a58dqAHPEnHCGB1+
         VzIGs5hZ1VLdLNjReL2ZV6hdQxlYAy6skwD2xX2WXnxxr+i0TBzLQo2YhFFwBZzOkEB3
         rh9I+QFMRJJi4Mra8nRel4yS0sZLvobNsMDNoqyFCfqxiNKnABXLRU7FEcrM4S5V3Xks
         iazUujFAmgrQkZBHOxHG/Pb+Vmi4D9SVEkk7qr5uwHOXilz2fiSmTrVUIBFfF9zB38oX
         fonw==
X-Gm-Message-State: AOAM532AEdA/fHI2dY2n4ga0MUwPnOEmPKcjxUJXiRE1zTqwje+SjVt9
        4XpaAXlv+DeacLhDXKPCFJ6gtwUeA6Y=
X-Google-Smtp-Source: ABdhPJyc055YHgF/VXT/GSYyPFY32BwzLm+v3Vj0NYQMe6DRc32KPLdyWEDzEVQ3QNMxFg/sCm8MUw==
X-Received: by 2002:a1c:9a97:: with SMTP id c145mr67315wme.122.1622480205117;
        Mon, 31 May 2021 09:56:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 73sm271295wrk.17.2021.05.31.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:44 -0700 (PDT)
Message-Id: <a0605387d1537d1bfd7727fb7dfed838ae690f59.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:26 +0000
Subject: [PATCH v3 11/22] t7003: use rev-parse rather than FS inspection
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7003-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1349e5b2321c..cf30055c88dd 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -395,7 +395,7 @@ test_expect_success '--prune-empty is able to prune root commit' '
 test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
-	test_path_is_missing .git/refs/heads/prune-entire &&
+	test_must_fail git rev-parse refs/heads/prune-entire &&
 	test_must_fail git reflog exists refs/heads/prune-entire
 '
 
-- 
gitgitgadget

