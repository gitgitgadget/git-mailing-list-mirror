Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1209C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 08:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiKVIBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiKVIBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 03:01:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D41EC5C
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 00:01:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g12so22424919lfh.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 00:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jkroepke.de; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXgYEdJiuCNvrjAGdryz+aI6v7KHnHTh4aNRP1bLouk=;
        b=UpeWLe5m1mzwNKFchpV2uO77WKzOFozLOhtu4ANnQO8saCoxMHtGJqlseAuZylS6NT
         g2fw9BKDwwJcRrlj6zsl8Q991AlacZOdC49M2GFdGeEpG7x0j/Qe56Cwm/CFYBS7rRZo
         jzrX1fmr2JiS7aV+GdEzTyYDUzHU+355wsOfWAmx4ww0tWBcYEyP2VkZ9jv4ZZoQsyAY
         inNnH0dF8MSHj8CvPfL+CEi7t2GTnjZB7nJ14Cp2NhVReLcKHz+gW3clYwS7ImF6zb3F
         rMHV3tr2R0xe8lmaUpWBnP8/V4rJxkgCaASEjS3h0HScPeTufhfq6xZEpOQOlv5AlL9r
         ch2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXgYEdJiuCNvrjAGdryz+aI6v7KHnHTh4aNRP1bLouk=;
        b=joQTmcOEnQOZwtl3pDZMBPHIP3f8vDJZ2/ZJ8wwpwxeBuUxM6LLb2tvP1ROikGy/bv
         pSzhjQKxJW4kKmOu5WWfAOEfVy73VfPjjE5dlJSHuyhLUsRgX4zk4JzvZDkCQ3DKq4E+
         Vp/hhDWa4sv9qCtBk2M9HgVoMluvPuKr7Driq+ldkWzWREOxb0iWMY4kMPqBdB6G4c1P
         xypd3Rb8PbzdwwZr8K33Ii5QAgwVq7nb1CfnumDAoLs+d1mZq4tECflITlxQ8vwFm88Q
         WD4e+tOfSeTq25TUQDk2BLpTwH4UQ8Kzax9SW6/4oeJ9DeUuyXlNS6+k0Me7vc0AiEUi
         OQzw==
X-Gm-Message-State: ANoB5pns6KPwe2cFYCCMYvpd0bVfPJfcO9ycSwe4IK37phajH6WIZpVE
        nWUmH6/5PCuTM6Ntm+UT4u2MNWWW9areRntpVGIdG0nZtOrmJg==
X-Google-Smtp-Source: AA0mqf7WgSZ8UR3yggxBg0lHJGRI24sx02fDernAVgwFku1Ocl+JOIInLYJo9Jye8fXvxZ/7Zs8MqMY+VATW8AiYYZA=
X-Received: by 2002:a05:6512:3d1a:b0:4b1:2aab:7cc4 with SMTP id
 d26-20020a0565123d1a00b004b12aab7cc4mr7070542lfv.241.1669104087630; Tue, 22
 Nov 2022 00:01:27 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Jan=2DOtto_Kr=C3=B6pke?= <mail@jkroepke.de>
Date:   Tue, 22 Nov 2022 09:01:16 +0100
Message-ID: <CAAsn9Yxbb3-4iTfD8gf_EhVbE+yKJdT=Vb5ojeFZOHvMutUn2Q@mail.gmail.com>
Subject: git tag -l --format results into a malloc fatal error, if tag is signed.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Create a signed git tag signed by a SSH key and run this command
(orginally executed by goreleaser).
% git -c log.showSignature=false tag -l --format='%(contents:body)' v4.2.2

What did you expect to happen? (Expected behavior)
Command executed successfully

What happened instead? (Actual behavior)
% git -c log.showSignature=false tag -l --format='%(contents:body)' v4.2.2
fatal: Out of memory, malloc failed (tried to allocate
18446744073709551323 bytes)


What's different between what you expected and what actually happened?
See above

Anything else you want to add:

Reference repository: https://github.com/jkroepke/helm-secrets

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.1.0 Darwin Kernel Version 22.1.0: Sun Oct  9 20:14:54
PDT 2022; root:xnu-8792.41.9~2/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.102)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
