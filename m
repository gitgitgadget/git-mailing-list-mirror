Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE4C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2B06115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhGQSeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhGQSeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:34:14 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33849C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:31:17 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id e203-20020a4a55d40000b029025f4693434bso3313586oob.3
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=X/McIfze1p/YdYP4y3I9bPqx7hRw0EyMOo4elEYIwYI=;
        b=q8eSXFVa3W2F9mmeE+/rbHolLOBKsu+aVA8YhD5wq6IrMdKn+3zOc1UZFYaBoZf9XL
         nNlTD2Ep8XiNli3K4/C8CFVJ5c/B5ZUqSnhzHPSy+dtnfryniZOPbwY6+2QxAuR1LpBn
         fMCO4RXF0zqv0+aAny/58WTuHnCfy8+tWOeUXqUu4yVKS2tVd9jHH4aL8yWFbFLUw1Rr
         xZkCeMen5R0vZndAvOxvROoXbto95zKaGlg2avjiMt0OD7oWn2mONW11OlqklppVn8gN
         qUJ5CPfrsg9jceAK6wwJMoA44ksbDbXTbqrm3lOrLF5eBinHSH1L34HL793d7c8slzlF
         G6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=X/McIfze1p/YdYP4y3I9bPqx7hRw0EyMOo4elEYIwYI=;
        b=l1WnyEs90xJIN6s8zCfK/31X9h+FAXXFaZ3nBfUMKG5KoQWX1slXxUSaPGsqnIhaIB
         tc6v2GqN757nBq/+UPXxvD3aEF7fG8Gq0XyWssyvCA6s4ZlT42rRCkymuzpikE25FtsD
         SNgZwxzcICt6ziqZG/UdvfXrMYy22jMxM3JXQRfCyJSqkPJq6HsClQTQR9JPImtJPEox
         R5lekrpeiI2xheJmXEGejgc6N0De13TWsIGVgF3Jte0XcuCjxGC+wMhImK1qQz7+R8e1
         OGjxoppWftJ+MI8PLWF1TJinR1R48qBIsPuUsuBanS0F75k380SZw4gnP9WoWs67eVgo
         +S9Q==
X-Gm-Message-State: AOAM533cDBTRaEJJiqqjOWN0TDGR7mYGXOvAU5NgsfyCZHAEBu2R5EIT
        OycqoJDxXTBqRkljdgGf7dw=
X-Google-Smtp-Source: ABdhPJw7LD0W8zBH43V56MFVF9veXwUbnns+aDKCNKogLB6FMQjbDsuOW/kzuRB9afkqTVMKzsK1MA==
X-Received: by 2002:a4a:db42:: with SMTP id 2mr12175623oot.47.1626546676522;
        Sat, 17 Jul 2021 11:31:16 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y19sm2859941oia.22.2021.07.17.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:31:15 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:31:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f321f2cae74_25f2208b5@natae.notmuch>
In-Reply-To: <dca0455898a838b46546a29ee79f0a8b112fbff5.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <dca0455898a838b46546a29ee79f0a8b112fbff5.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 7/9] pull: abort by default when fast-forwarding is not
 possible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> We have for some time shown a long warning when the user does not
> specify how to reconcile divergent branches with git pull.  Make it an
> error now.

Once again. We have not warned the users of this upcoming change a
*single* day. We have not told them how to turn the new behavior, and
how to keep the old behavior.

If you want to guarantee user complaints, this is the way to do it.

-- 
Felipe Contreras
