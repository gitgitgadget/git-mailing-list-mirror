Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6134C47258
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F78208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgUQy6eX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgEAPaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgEAPae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B47C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d15so11928608wrx.3
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=35ZUm74A7NtqM8sZEopnVoZ7DH1TKQD8huiWnIPF4N0=;
        b=ZgUQy6eXkSpynj2f6OKwaQmdZQHyGnFgzV3Ld+8ODaQWlh24yk2fldi9uNIScnKaxb
         udHPKKQbWrG9KXlKB08IxM9wSCJ4eDLPuI9nxm9i2EioDin80me95fnGEh+1rQcAraNj
         8Fj1OmZ2NPSBSNX1x0VglfQMu4wtD9uZ+2EHUmLUeWmQ97zTyHiEfmfl1a3YVMhIrmAn
         Yin1q+AxJPIA5iQ7iwVhvUOkVPTEkOVbamjLY3XlCV5nbe00/kh+S/dQ+5ibT6nzWA+1
         yN4+zktzf/EABJZpZ2lgrdyrOPgNcFBjg6luOdcZy2uJJFsL3ShYGfemFzkrqi7F2Sb7
         Tj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=35ZUm74A7NtqM8sZEopnVoZ7DH1TKQD8huiWnIPF4N0=;
        b=m722hsS22ZC17AAP/+qmmAnLAAl1F89ijXQAz91JRZknCWSByhZny5tiZCGiTR6UC5
         jgSfwRjkxf+f7L7tQHxIlvd7YuxpxJOvRZNCYX8Y5ezdb0Rt4y4Ug3myJAAyqEE1CMaf
         2LDL2szWVyI9lglg/a5DF1+H5ITeq3mUx4P9BQNScrRMDC2tt6Gn4fKCY/Xyl/RdqPHX
         fKIXu0/rusNizAphwo3N1EePKhErvF0WBD+nKSn+UPxY6Yiji0U5woWhFgl1EOmxqOvf
         Zym3Q52PvLkwT6zpF98rBdTGhCF03/WzzC1Pdx/jUOb9jdkhPiVlazdHrYt1D3kmjSxH
         fpSQ==
X-Gm-Message-State: AGi0PubSxGtfDTJ6cQRC1/Qkcb96aMaLFot0XZv61Pid1Y6LtZcO/Ogr
        mSuB0Flh3gTCyE0lkLBoOTTmFcF1
X-Google-Smtp-Source: APiQypJ6bUx6aFlVAZGIEnaZ6GGTKEi5BiVMLOhaKMfk1m3HRKdMMVvrUK7suVLYCNOyULQ5htMc1g==
X-Received: by 2002:adf:e943:: with SMTP id m3mr4572972wrn.248.1588347032429;
        Fri, 01 May 2020 08:30:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm4778744wrv.89.2020.05.01.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:31 -0700 (PDT)
Message-Id: <572d0508fe0364119d83c08e01a66153810958e9.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:19 +0000
Subject: [PATCH 02/12] test-bloom: fix usage typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-bloom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 77eb27adac7..00c1d44a561 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -44,7 +44,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 }
 
 static const char *bloom_usage = "\n"
-"  test-tool bloom get_murmer3 <string>\n"
+"  test-tool bloom get_murmur3 <string>\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
 "  test-tool get_filter_for_commit <commit-hex>\n";
 
-- 
gitgitgadget

