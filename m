Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636D7C54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A66320714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4YoYVaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgCYFzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:15 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:40630 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgCYFzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:15 -0400
Received: by mail-qv1-f47.google.com with SMTP id cy12so485058qvb.7
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r12iIEm0XSofXx3wqw9sbrMgiKngr/X8ryuhRvp0nSE=;
        b=U4YoYVaLspLIhpfCUu05gbfNAPYdCz8w5jQu33yBYiDvfhSuszYvsMyd87MWJoCCvh
         tVDBI7/v+r9wYn9qUKj5+kbnjmmY5RQ8QzBE/5pylRMzJshh66CGOlh6Fj8AHRBcma/f
         QKtMH6SUqkdpkeLln/2eTSwzZKjmwC2zxSK+KQNxwYQuEzT4Id3/bhRbWuZZsFoJCVUo
         Zw04olG84f5Yxs1R9lGQfho+hLeMviwMaew6GawnK5QURX/j/h2+IsChXAOr4U+0HY/w
         gukx+fkr2lCSGbls3DdCIdVJn16A2GTbN/HYCPrJkqRp8F/24Idcxafol+I2MPzVx6Of
         qxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r12iIEm0XSofXx3wqw9sbrMgiKngr/X8ryuhRvp0nSE=;
        b=Zhkh59iNkogFksUlMtcL8hdAjMTUm4amME8P36aGc7Jbs02t8E0gmT/5wQ8naE3jbs
         vin3fJltO6KSoX2gtVmBLGUGjBzALKKU7rcvymXZDpHa5hFNn0u7VoW40jPXHczMk+el
         uZq3K9yXn/sUFOs8y/gNJ2sG8lK0cIAxHtHd680Qq7mqg2EePT6bUD7cvQJbKOgiO3MY
         8+QqrbDGJd0FVXlP3Nkd8QgFQhKlQijKFMM1+aDSV6jLbe2b4KaNTZlIwcVXmPqsFlg7
         zhSh94GXATqqCd2ce8cQRE6o0ErPyCO2tOdd1eEZc9bEIfnZX/nTI4ztTmjYKrumn9hU
         pp5g==
X-Gm-Message-State: ANhLgQ3p8T9DTC0FVNTfAfYMXWu5HxjEDmGig9niXC+RnztPmWr1XLld
        er9bRUJm5kDxD9LmGusC8/UB2mnd
X-Google-Smtp-Source: ADFU+vuKz380U2vs5Vl53zfx5vC65FPHSh4/sQLjOCO5uDVV9t1eaz4S8Jwy1lWu4siEvrDWxlwAgQ==
X-Received: by 2002:ad4:4c82:: with SMTP id bs2mr1663072qvb.14.1585115713789;
        Tue, 24 Mar 2020 22:55:13 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:13 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/8] t5512: don't use `test_must_fail test_cmp`
Date:   Wed, 25 Mar 2020 01:54:48 -0400
Message-Id: <3d7dc8428d1992d3bc2802f5c828e8d77fe4de3b.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 04b35402c7..08b98f12b8 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -92,7 +92,7 @@ test_expect_success 'use "origin" when no remote specified' '
 
 test_expect_success 'suppress "From <url>" with -q' '
 	git ls-remote -q 2>actual_err &&
-	test_must_fail test_cmp exp_err actual_err
+	! test_cmp exp_err actual_err
 '
 
 test_expect_success 'use branch.<name>.remote if possible' '
-- 
2.25.0.114.g5b0ca878e0

