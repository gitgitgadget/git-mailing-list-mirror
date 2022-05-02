Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA0C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiEBOqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiEBOqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 10:46:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62FFDCA
        for <git@vger.kernel.org>; Mon,  2 May 2022 07:42:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h85so4887950iof.12
        for <git@vger.kernel.org>; Mon, 02 May 2022 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schrodinger.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=lmjnWifarokJAKINXhTeLJ9496W9EFCTDZMkK1c/VL4=;
        b=I2Gik8MtjWlYYKaHkn15dHaguiFnFu251FKcKkjiaID/q4byfzOC+npc4VPXjw+jZ1
         OJI1qLLtdDMxu0SnW65viJgSuoLPY+IXFyKs/J6QDZG/5m5mC2P0uymcLXvBu6hMmwv4
         sOFSX2/RvdoRdt72qHhSrgJ2e+tBmCG0FQQewZI63b2y/R9onJQ4fgWXakfoCAOLUMP/
         CURZZQQkcu9J7lo5edBBacHajn1Mucgfp/UPhC+II2lwW5K7nciPiSryFA5Z3BwSOkPm
         DkZCIuQ8OmJUAuAWvImhMgSCqkhC+gQ3l7X33d2UrP46f003CRzh8zjDyDUFsyJzQbM3
         b5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lmjnWifarokJAKINXhTeLJ9496W9EFCTDZMkK1c/VL4=;
        b=GZS3dscXT6D8RoPvXSs4O3jTlvMqtYFt8pwYXfAyo7wvG+TpEPzATUruX/sqfPZDja
         k/IA1FyRaA0NRlwJJWknBFg7qs+4lQvIlXcUKNGcuhgvzTo9xeBx5HDnfRtrMLYPUDjY
         +/AuZPfjT3S37kRUPrJYClLpRXOnvO54F+TOePKOPpEd3CBZ4fZQ6vbdnNKxQ4oIvPaB
         SnNReDlOnyOki3GLWk2x70A0IDOQ877r9XlZAUbscwyPgLVXXWSi85Dp/zQKmBDp4gpm
         /ofQks54UdSITY+28YIebtfISop+qBAinuCxawRp9Iq5iSvbjYJsyRW3HyjWZv6LCbMF
         aMug==
X-Gm-Message-State: AOAM532Lb4hMDCvef1N+d8XJhx69/sf5H2yMFlv069nHQgl/JvgNUtjI
        7c6l1l2sQrnq5gMpvhZZrDFhf60gL1UfDMRBL49LpMthei2r4w==
X-Google-Smtp-Source: ABdhPJyR2llgx2WsMrqgGN5NvZ0ZgtZGW4mbnetGi648FtT/CKJTtKfkAkG5QxHMUCB2bAwpVzGpa6bTaZJaOh3o+Go=
X-Received: by 2002:a05:6638:25c2:b0:32a:9cfc:1d7b with SMTP id
 u2-20020a05663825c200b0032a9cfc1d7bmr5260365jat.22.1651502564057; Mon, 02 May
 2022 07:42:44 -0700 (PDT)
MIME-Version: 1.0
From:   Huang Zou <huang.zou@schrodinger.com>
Date:   Mon, 2 May 2022 10:42:33 -0400
Message-ID: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
Subject: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1) Set the following configs:
 git config submodule.recurse true
 git config fetch.recurseSubmodules false
2) On a repo with submodules, run:
git pull

What did you expect to happen? (Expected behavior)
git pull doesn't recursively fetch submodules

What happened instead? (Actual behavior)
Submodules are fetched recursively

What's different between what you expected and what actually happened?
Submodules are fetched recursively

Anything else you want to add:
git fetch works as intended. The documentation for fetch.recurseSubmodules
states that "This option controls whether git fetch (and the underlying
fetch in git pull)" so I would naturally expect git pull to behave the same
as git fetch



[System Info]
git version:
git version 2.36.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Aug 24 20:28:00 PDT
2021; root:xnu-6153.141.40~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]
pre-commit

Thanks,
Huang
