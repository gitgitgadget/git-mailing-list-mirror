Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE3C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377858AbiD2OuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377497AbiD2OuL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 10:50:11 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379298D68E
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 07:46:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v59so14830610ybi.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=i0JuZiphBocL/drGJY2RQqBciS68BwG/epWelMIFxos=;
        b=jtLDeR92hrZSMnGaQu/ISaDtCI9tXPivYehBFVKxLnQv4e23ly+KhDqS0uOGbjalKy
         Hyir9EVFZJ27yqJgAv2Zsg2U4C/gm9DHZSBRLJKqC89V+Nvfs7LR8ekDgm/oPH2PhINj
         FyK+AlFUdgFNBUPSayGPjPIKW+8W9e3I5tQ0RrUfdU+JrY9OARVUcVc5vCMMeCjorrV0
         u4v6JXbP6IQKlH2pg8T+AN0YNOSgCAxOShweI4GhZgoeK2aStcp5OqPW9jknNDiiXQdg
         MLjx6ezIIonjTEPAOn5XpQpqJa17TpVhYXOmu1SoH7aeelBrBvqIvufkdMDR18YpBNJF
         xNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i0JuZiphBocL/drGJY2RQqBciS68BwG/epWelMIFxos=;
        b=A9/AmlG8mAXsuVR5uMQ2nFns8bsRDCaHA8twmPOLPkGTf2WImvz5M9cG1tqv2UL/f3
         03ehg1Mx0AWosgm2DxmdNKyyZF1R1pIWDum7RvGSi+YtIgOfSNy+xoPGoMm4HcEIO+rU
         6/yfKWpIXAjUpoZI3YBFZZaPVjf5mazYqyKmeoGBP9nkMlfvjTRCpeNuGibEwFV8o3cr
         ZUDgIaHZC5cm78jJui8l6iADJusRmIM+jC0/R5yj004QKIdZigQiokF7GoC8HEJJEjjb
         UpFfxDketziIDbUmV8MpdK3HyMCFWButXris9f8CZvKLDamLJjJ/ATWSXVVnNPgexqvn
         azsg==
X-Gm-Message-State: AOAM532v5MgroAvnEGvzsJykU7FCNHSoiAmjOxaqksz6PBmSCjskLD2T
        knRWqJlhT7qOPrHuo7H0f3jLIzz9Q1F1Q4buD/2Eh03XwKk=
X-Google-Smtp-Source: ABdhPJzt4CuFjJ7K///iv1Hql6YBM67GsepJ8BdXVY2tA4bLl5H8k8A++Xn3RCBPINzzFz27yk7Fyckk9tUoTWPXhtE=
X-Received: by 2002:a25:5010:0:b0:648:3dd3:da22 with SMTP id
 e16-20020a255010000000b006483dd3da22mr28390355ybb.628.1651243609869; Fri, 29
 Apr 2022 07:46:49 -0700 (PDT)
MIME-Version: 1.0
From:   Benedek Kozma <cyberbeni@gmail.com>
Date:   Fri, 29 Apr 2022 16:46:36 +0200
Message-ID: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
Subject: Bugreport - submodules are fetched twice in some cases
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Run the following command with 1 remote:
`git fetch --all --prune --prune-tags`
I have the following in my config that could affect this:
```
[submodule]
recurse = true
[fetch]
parallel = 0
```

What did you expect to happen? (Expected behavior)
Submodules are only fetched once.

What happened instead? (Actual behavior)
Submodules are fetched twice.

What's different between what you expected and what actually happened?
The process takes longer

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.4.0 Darwin Kernel Version 21.4.0: Fri Mar 18 00:46:32
PDT 2022; root:xnu-8020.101.4~15/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.1.6 (clang-1316.0.21.2)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
