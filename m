Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D52C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F30613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhEEMej (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhEEMee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:34:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38156C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:33:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s82so1326108wmf.3
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEmsMdLUxS/Od/2kYLvPnR6coc5iQ0Ibgy6ra5pTfvk=;
        b=VA6Rlix23e/RogrVENlPc8nThfQtcHcKH0cQmpVb3WtLv2Y91Bl4IQxOBlX0bkEzQb
         D1/OBHXY3AM+gmdGSnxF0OVX+DaLOV/f2bwzPaTEKfSUIKpERcyp88mRBOX0Wrk9Zt0y
         pLvFmyQLAKtbiKWS2nSj0zApXfgOgkb3YocCT3gMum2SRrjUlGoJrK/I52NUeLFiXLVa
         nNQT5KOM2bZemwMk4WNpBENgnPsoH5vF5Ka3B1UgMdTD5AdW6/NwZ8D2GKKPVqPndpCb
         YdX3YzXzyMYb5zFW80DwyCMPEnu7MMcHwYZGPqVhcYIaYKU/GyeqcSorHKptIZ5N2Y6e
         foSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEmsMdLUxS/Od/2kYLvPnR6coc5iQ0Ibgy6ra5pTfvk=;
        b=AQEimT83Ey7VlJUEgR34jwt4vzKLTooUb6cDxqDzi9Lebs2JigQ84zCQOI/P2u+PAe
         4dH2KYWMpR1rFyVbhah5fUBEY6c8tzBgqnqeZfU6CG7bl2LUzpdeM03qKuozJUqZGYof
         Arg0TGsY7Apyz72ckeIs7YIMQrLKHHwVPXfCGE3YCdNn4zVT8/ORgf3yV314wTSLo9kU
         yFAnqx/DGf9QZzUGsyP6FoiRKqXrGNeXDikLfdk5e6mZXo1gUHqQf9HssN16h9MQRVMJ
         mXPHtAXBT/ExNDfZAu2J6fSGTCF4rRR3AD7VMfdgUfrN/Dnvc84LGeUfvK5g/msM6N/n
         9y5g==
X-Gm-Message-State: AOAM530f/cZOiUFwVBSnoizWdqu3ml/6/oz2nBX3UWWrG5jreLs+iBa5
        8Gz+oBlSLupWkc4JTKhRp9ko9SVUbu7HGA==
X-Google-Smtp-Source: ABdhPJwt/Bcwzq9h2ybW3XPPjwzJqUrUnQJNFyvKL9bfsUQ92pMyZWma84dSp20aDYizHzfjUY6VSg==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr9945240wme.84.1620218016221;
        Wed, 05 May 2021 05:33:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q16sm5858755wmj.24.2021.05.05.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:33:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] streaming.c: refactor for smaller + easier to understand code
Date:   Wed,  5 May 2021 14:33:27 +0200
Message-Id: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a prep series for my yet-to-be-sent re-roll of [1],
aka. ab/fsck-unexpected-type.

Jeff King had a comment in [2] saying it was odd to have an "oi2"
variable, that was because there was on an "oi" name already defined
via the new-gone open_method_decl(loose) macro. As we'll see we could
do without the initial "oi" and a few other types of indirection in
this interface.

Junio: Could you eject ab/fsck-unexpected-type while this is being
considered/cooked? I didn't really see how to address Jeff's feedback
about that variable name in a way that wouldn't just make something
like this refactoring part of an even bigger series. I think ejecting
the functional changes & trying to get this in first is the least
worst approach at this point. Eventually I'll submit a re-roll of
ab/fsck-unexpected-type either based on this, or master (if it's
landed already).

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com/#t
2. https://lore.kernel.org/git/YILZHiuUyj0mt958@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (5):
  streaming.c: avoid forward declarations
  streaming.c: remove enum/function/vtbl indirection
  streaming.c: remove {open,close,read}_method_decl() macros
  streaming.c: stop passing around "object_info *" to open()
  streaming.c: move {open,close,read} from vtable to "struct
    git_istream"

 streaming.c | 268 ++++++++++++++++++++++------------------------------
 1 file changed, 115 insertions(+), 153 deletions(-)

-- 
2.31.1.838.g7ac6e98bb53

