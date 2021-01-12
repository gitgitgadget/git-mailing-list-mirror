Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D04DC433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E07922E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405691AbhALItI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405682AbhALItH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F6C0617A3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r3so1581780wrt.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f8AOVoxbj+7nrUbSLitO3SHHi4LdQLQQHdmEiqObpu4=;
        b=GCcIVeQfVnP8/WF+bF3M1SCcQDrUW5Tv7Z/vujq8ebQLxUrgpXNL8AS2I53KCvxazX
         bpJd7LGXEmXjSGKdGjLztQdZG58Y/NQMpCLX/V8dtUmqsmpRD4n9KqATIuBf3aubt+IK
         pW587dR7BEglr4vNE2B39RD4Wa2DI9unwGOdWFha72r9BbTIsO+2KXoXBJd2+SExetk1
         TAtk2tXEyedWvHb80tY3Jx3mwq286BcpQu1aoJS7hsXWJgwynZHuUVNIBKrLpf7mquW2
         X1xddIsJFN7FrL9kz3JLv0QB/3cQ2057NakhdRZCBhHzkNs8flhthCCpemdzU2MZdevi
         rYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f8AOVoxbj+7nrUbSLitO3SHHi4LdQLQQHdmEiqObpu4=;
        b=tevjNwwF5AzRqIiAlHWlniNFIS4PvkORfcXlJu0jFT1X0XEC0OqZt/hCEcQQ5ouu61
         JfFRxj8oifjkap7yR8zYfKrWqtgt52yaatXmw9fg8jDTjyavlvEgynISP79RO/OYiKGZ
         AJCsG+WXb7oQa6DsriSB4yBnf1tjkuNLFtYWzADi375O8lEgP9fBjAWd9owMLGnhak0u
         aTwPQFOgHNKioCVrnZC8Yi+2HrrqaVF82r48pJGsorYB+s+Nk8L1SNS8tT2usJ/DLrFE
         zVq9vgYITrnscCZ9F4FDWbnHDhKUb/TvQ9c13fX5p2d71+stAxC54hzh7RFS7EPFqEo3
         Ty2g==
X-Gm-Message-State: AOAM533xkAVS7Mv89oTQqwxrfLP+FXMxemQ3+dYvtF77UvuosDqoKkEe
        GSz/Gb5iOZbBibyRvG3vGiMCQ9NiUBQ=
X-Google-Smtp-Source: ABdhPJxZNYp0wJPpnvxWt9gpUegIAy96rG1qWbK37ePsAdgg6YQoHAEGxr7SLtMAuhF+rgGmlt7k7g==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr2967648wru.327.1610441270132;
        Tue, 12 Jan 2021 00:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm3975831wro.60.2021.01.12.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:49 -0800 (PST)
Message-Id: <d8e645f5b85a8c9dbdfa9f87b7570622f470ae59.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:37 +0000
Subject: [PATCH 06/11] t0041: stop using `test_i18ngrep` on untranslated
 output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0041-usage.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 5b927b76fe5..27309b1a8f8 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -42,7 +42,7 @@ test_expect_success 'tag usage error' '
 
 test_expect_success 'branch --contains <existent_commit>' '
 	git branch --contains "master" >actual 2>actual.err &&
-	test_i18ngrep "master" actual &&
+	grep "master" actual &&
 	test_line_count = 0 actual.err
 '
 
-- 
gitgitgadget

