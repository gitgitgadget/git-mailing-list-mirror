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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C4C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A12A613B0
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhD0KkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbhD0KjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E848C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a22-20020a05600c2256b0290142870824e9so837141wmm.0
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dAozLuFTpL9NLEQKHVi1gFF55ofjw3vm812jKqeXhBg=;
        b=qHN51AiscLep55J1t/CTr7J0+lU6ljwWXXlhWcjj67LLT6GRRaWwoxfbZ6Sp5TcBby
         myqoq0xWkq+D8w53oZDirjLzC7u/AIrXeoPtnIblPcaksu4FOG4IE363zY02TxsG6t/6
         R1pnXhcq9hyNH4NGUOGeBjGi7bS3LAcdoVCJl75WDIQvd4Lrk/8H1tBE0p0tmVmG3FUS
         NO+7dT5UhWlt4Rwdki/zb6H0NfuhRXYBSqMaGLoBzOrCPR9O5euFYawC/9W0Ws1Eo7FT
         WLSWa0psFeWF13vTqjfhv/20qVJsdpXNz/ryFf8qjpjxCMdJ9km5kI/IVyADvlDAjo1R
         9KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dAozLuFTpL9NLEQKHVi1gFF55ofjw3vm812jKqeXhBg=;
        b=Vz0atuiELg/QlCRmhH4pERnMYvJccPTXWHy4MQS44+p9MVQKMP/X7rqEDC+wxYD6oN
         U8rss7u9MvjqwJIc3ZVhikT41WkArzZpCSaQqchBvHDXF5XFHGKOHrpn/Nyqh5nne709
         FZepg0t7wndKb684aDedooRYDm8II4yf7tSgqNiXT5vQwArMnb7p2xCG9ICIV0o/pbVh
         uNUkPmFLszwCFvCYK3Nth7zNvhWyZR0YRkpG+H8LIkJf3fG0a+DzINDksfeewgfDiHBb
         p61odRUB7kg3sEI2VaKfb4lZsRgR6i3Zp/Pjz2J34Dk9kvYO3YPl6SrVixHLDwDWz0up
         hLIg==
X-Gm-Message-State: AOAM53228ljFYy5zA28KKsvtsFAwpiscE9cQjLzk2i2JvMQ3Rc1z0KC0
        PJzhLZmFZkfqKJ++KEi21rVW5OMP9fY=
X-Google-Smtp-Source: ABdhPJweRICJs9a9gurx0b3Lb9RQoQT5kieT5FiV7cpgQ40Iy/6WsmEROQ5bcWXtq6DYthXChO48Ew==
X-Received: by 2002:a1c:7707:: with SMTP id t7mr3522585wmi.76.1619519914810;
        Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm2184765wmc.13.2021.04.27.03.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
Message-Id: <24dcf05d8fa6172d04ca047a860ad5019aad17b7.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:20 +0000
Subject: [PATCH v2 19/21] t7003: check reflog existence only for REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7003-filter-branch.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index cf30055c88dd..e18a21895238 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -396,7 +396,10 @@ test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
 	test_must_fail git rev-parse refs/heads/prune-entire &&
-	test_must_fail git reflog exists refs/heads/prune-entire
+	if test_have_prereq REFFILES
+	then
+		test_must_fail git reflog exists refs/heads/prune-entire
+	fi
 '
 
 test_expect_success '--remap-to-ancestor with filename filters' '
-- 
gitgitgadget

