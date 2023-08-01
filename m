Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4AEB64DD
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 09:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjHAJT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjHAJTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 05:19:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1D1735
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 02:17:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0cb7285fso319371166b.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20221208.gappssmtp.com; s=20221208; t=1690881439; x=1691486239;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnPYeL85R/48qfAH+rI5fb1jzw54jK+rb8VKjVGrlIs=;
        b=sY+gTfRXIRuZbKFv5Chx/aHQjH047S05uRFIQG3HExCL4/IPbLJcZTAVar0F3uOgEY
         0NuwMpDw6EcsGMjrtp1NxPAZKcQWzQCrggEgEtJ+30XERmyNv9deYUPU+h+JXdNyXuXH
         F564knMY6OdaFc1inrCCBrrJuimmoQ7xr3BaOp4zhDJLaFHqjotZLylCnfn6lFG9ZDmF
         3uqM0pUjHR77DcNAZIPk+SsW2FDhoH2xH3SpvDUacemAA+KFieEWOky9wPWckmAQRTnV
         tf3bd1v4eJPA8GSUODkzsZcGrLuwgzRcoZHgD1RTcKHoWmIGfxSKQK3JvNtini5gpazX
         FVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690881439; x=1691486239;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnPYeL85R/48qfAH+rI5fb1jzw54jK+rb8VKjVGrlIs=;
        b=KPOpTE+o7EAn8eeJ/E2E4aFYOnW3spuEMIPvu/aVaRUrrj2Y87kxxJWewOYrr05rPK
         0cJ2a8kP7TwGBQUdJCsIKA8cFdN+kud8enCh9RcC1Q47h2DHOWSoYMeR5VKkylpsxFQ8
         9xPaScAe66oUZmay1Gcr1giNBGlcZdcvKuZ5AFazF+gOxLP/zNT8zcpVGMgQYxBaJbVJ
         KR4FJXBmMqh7jWFH0Zm3RQeL8xrb7d7Vm+ZYx4pAWEGd4ZokF5rPB+5xv1XrFABPPBJd
         E2VN9iGiUWB/mQTo4ZNb9Qy1eExnocn4SnbBd2NZEzl+2JLn3UDACn/wUjhwz2Cn7Z5e
         6KGg==
X-Gm-Message-State: ABy/qLaRjVqaCv5pBBAWcSN/sQEta17K2ORO7rJUcr22aV12UCyjYcFz
        j8s+GIKEQUd/MjIL3RW6ekY8VdV8FnS/yLS4AlA=
X-Google-Smtp-Source: APBJJlEnxY6Rz4wDDks1TAHeAS3rc9TL9uPcOngZZQOXWajPrqoFVN/cyt66isvxDNMK/5wGGNMMPw==
X-Received: by 2002:a17:906:2258:b0:982:8c28:c50d with SMTP id 24-20020a170906225800b009828c28c50dmr1893633ejr.58.1690881439176;
        Tue, 01 Aug 2023 02:17:19 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170906c35200b0098ec690e6d7sm7458937ejb.73.2023.08.01.02.17.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 02:17:18 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99c0290f0a8so387256666b.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 02:17:18 -0700 (PDT)
X-Received: by 2002:a17:906:3018:b0:99c:2289:63bc with SMTP id
 24-20020a170906301800b0099c228963bcmr1891811ejz.74.1690881438059; Tue, 01 Aug
 2023 02:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
 <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de> <xmqq7cr5uonp.fsf@gitster.g>
 <xmqqpm4wswny.fsf@gitster.g> <CADWu+UnvastFbWsjfHvJhvS1RBgD8M1LXuA2VMBMSkTqpiLS5w@mail.gmail.com>
In-Reply-To: <CADWu+UnvastFbWsjfHvJhvS1RBgD8M1LXuA2VMBMSkTqpiLS5w@mail.gmail.com>
Reply-To: ak@akorzy.net
From:   =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date:   Tue, 1 Aug 2023 11:17:06 +0200
X-Gmail-Original-Message-ID: <CADWu+UmjFiKa2h4qqumA-jOfEGvVnsV85bOTKgYhpQwYCf=VFw@mail.gmail.com>
Message-ID: <CADWu+UmjFiKa2h4qqumA-jOfEGvVnsV85bOTKgYhpQwYCf=VFw@mail.gmail.com>
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
To:     ak@akorzy.net
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks again for your responses, Junio and Johannes. I'm looking to
implement the discussed structure in git. As the first step, I'd like
to implement:

git merge -s theirs

The name of the `theirs` strategy above is inspired by the existing
`ours` strategy. The command above is going to be the equivalent of
the following three commands:

git merge --no-commit -s ours <commit>
git read-tree --reset -u <commit>
git commit --no-edit

The new command is going to be used to create the last "welding merge"
at the end of the structure below:

     o---o---o---o---o  upstream/main
          \           \
           \           a'---b'---c'
            \                     \
             a---b---c-------------M main

The strategy above could be called "rebase & weld". The new command
can also be used with the "weld & rebase" strategy described by
Johannes:

   o---o---o---o---o  upstream/main
        \           \
         a---b---c---M---a'---b'---c' main

In addition, `git merge -s theirs` could be called `git weld`, which
would make it shorter to type. What do you think?

Also, I'm thinking about the eventual interface for creating the
entire structure. Perhaps "rebase & weld" could be created with the
following command:

git rebase --weld

and "weld & rebase" with the following:

git rebase --pre-weld

What are your thoughts?

--
Best regards,
Aleksander Korzynski
