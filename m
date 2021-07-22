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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13303C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F338160C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGVUsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhGVUsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5DC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o1so196022wrp.5
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dkjFbKCqgkmzb3ALYM/j8lsueduBg9xjD6SXKLT3gIk=;
        b=qgGi3DanEp/0KDz0WpoW7T1Tu4IfGM15/U0ICKejM6Gy9o8RSkcA4TbYc9ZrWbC6hT
         hLRwVw9QrR5UsXMwE0SebEk6uhUhnzTnM+wg/hQS2PLAJWL5omr3h6Mq+PguhQxdzRqu
         eeQ7EkczQB5Yr3Wd2duQvUsJVW76ASs5vKMbua8aJQNcNTxUosJdyzvfIBi3Fv6FLo9s
         kIGshJKBeiuo24FHuGFjPDNmHE3jh+Qv5V4P6rBmCNR/V3sQ6kZXj+FKDDPbZj8g+lHK
         Vzgh7/VaTRK6u/4yP0XvGnduFY9wmnKDSKqFddiy+Traf5cO1sgPj2D08pnQEIpMwLvj
         SBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dkjFbKCqgkmzb3ALYM/j8lsueduBg9xjD6SXKLT3gIk=;
        b=EpFn6iQEgdx4MHe19o9H4zctS+yzjwjIKyhrVHD1nAE4FKhpPo85hhMowXwOdNovpT
         tc/K5TDSeQMNowjHKNvWixPL207fCSFBsu4vBHtxojafImzAHxRcXIKrfwevbOYmK2mG
         cO7f589K4nT4pdbWFWTrwjwmBXCOpz3AVRiIrVDi6zc8GgRBXUMBYztMOf2w01jla6SF
         GPDisIneoeWyicQX4wJ/igh9DMap9MXjXuY2cBUkYUpTw6kDinD1CMMZ2EVcZagOpY1z
         QqLozW76mwojaLrRJQMG8MGv8tflct1iZCXEgOKwVsOoV8WPpDl8fwxngyepJq+Q/wyG
         fkhw==
X-Gm-Message-State: AOAM5306Fa5PH+aG9E7rloGKkOAciMaLZR6JOnfteqzLdXDYNDRITjlJ
        W2IkWu6nXpvx3b4rhNw59+H7kwQFmnc=
X-Google-Smtp-Source: ABdhPJwU/AWVB01UW95L9btykDFy8n2BiVOkPHAHnSAOrda7P3F1vHgtp9FRwgUwkWhh6KW10FmNQg==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr1983949wrr.148.1626989329753;
        Thu, 22 Jul 2021 14:28:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm31409234wro.1.2021.07.22.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:49 -0700 (PDT)
Message-Id: <cbd2128c3313ea7627f16d3758ed402a280d3ea9.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:38 +0000
Subject: [PATCH v2 02/11] t1503: mark symlink test as REFFILES
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
 t/t1503-rev-parse-verify.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index bf081023917..40958615ebb 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -142,7 +142,7 @@ test_expect_success 'main@{n} for various n' '
 	test_must_fail git rev-parse --verify main@{$Np1}
 '
 
-test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
+test_expect_success SYMLINKS,REFFILES 'ref resolution not confused by broken symlinks' '
 	ln -s does-not-exist .git/refs/heads/broken &&
 	test_must_fail git rev-parse --verify broken
 '
-- 
gitgitgadget

