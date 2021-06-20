Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E8BC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB960C3D
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 19:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFTTsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFTTsA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 15:48:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5BC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 12:45:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k42so7158756wms.0
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zuePTB05fG5G0U9QcDypY55d1NxH1jVG0F8RPfHMj/A=;
        b=NB7Iey1X6kLGyhslMHAJyelbZYaTOsofKoPGmS30yyAuLgDzAPNxKwR9QDdBHaMTJv
         54L/F1/sACkzql23LX+T/q39BMZ/ylZwrnwZV4kv4CTTO+3+bWii1pAVWkoT1DjzpwwX
         HJnu0FjLU2CK9bCjMgpvFtnbQrfEY9RUJ66sSmFCod/+jwPedwUx93k4TntJjW7tgZ2i
         n7qEl9O3LZ34cjKVhPr4quu7fBx2nxjMVsjprQry8xgOmXuMLNRLWBN++ogk9HF9f+4H
         g/T27Lnwttjkp7bLvtci+WpQg8vLxjNV1sS8Swii7IqJd1/uSrVhk0QfP5JqXsgAofM2
         ZS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zuePTB05fG5G0U9QcDypY55d1NxH1jVG0F8RPfHMj/A=;
        b=oBZ+StglIoKHj+iaO8nfc5Pw5IcoiOZn4d3aLdtjhAwSb9QFvzhBSpE5ZzlzxRCjq/
         MCj6Gd0jV6m16zvi804xO0I7stijx45OCvIEaYzHuH9WxWK/MMiOp5I6qa6GcnaDTteI
         1tlerpLA++RAFDnC7IDUfpWyO1JIpi35zBOKeJX2VABUAyFg26v+G5gnii6nBWU6iArp
         cvw8FCyKZuMQDEgGVIti+zcUjvQxuzPslcCpl430KKtV5MyRhA6GtbbTVGoWbPrZ304t
         utVOF7i/yqqbHjrD74gQaBNA0Ol+BcyItUI01Y8QPx/GYP5mtskDpwWG+NsE/OU7PjUJ
         tppA==
X-Gm-Message-State: AOAM5303QPfrjp2Cg5APK/F/T/WPbI/YMHFE1m17pFoJvyK0RJEAQ4DE
        DfdpHBLlmS6BXbvPNieaz0ALA3iCm+fVPySdJa3F8+43O1hyuQ==
X-Google-Smtp-Source: ABdhPJy53z1le5SD++CQdsdRuA6523sGzt7ZO3oXDoR3Vi4m12aAEdr8b2cFV0uM3RAs+yOGr6ScL0XQ/4nSU68VaL0=
X-Received: by 2002:a05:600c:a07:: with SMTP id z7mr23031028wmp.83.1624218345953;
 Sun, 20 Jun 2021 12:45:45 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Hutt <tdhutt@gmail.com>
Date:   Sun, 20 Jun 2021 20:45:35 +0100
Message-ID: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
Subject: Bug: branch checkout is detached if the case doesn't match
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you try to switch to a branch (e.g. `master`), but get the case wrong, e.g:

    git switch MASTER
    git checkout MASTER
    git switch Master
    git checkout Master

etc. then it autocorrects the case (bad idea but ok), but it also
enables the `--detach` flag! In other words

    git switch Master

acts like

    git switch -d master

Very unexpected!

Cheers,

Tim

[System Info]
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Fri Mar  5 01:14:14
PST 2021; root:xnu-7195.101.1~3/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.5 (clang-1205.0.22.9)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

[Enabled Hooks]
