Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768BC4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLGP63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLGP60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:58:26 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097D3E090
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:58:26 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c140so23192886ybf.11
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+jFz+BKhOlJEUiQ3eiZEIsW1DwLd4NoIfriC9CLjL/U=;
        b=HhVP+gk4siVax5sOjR+SL61ScCNTR87pVuNXuzQMAGmaxig63DiX2ZtxsyhQfy0VW8
         GqBx5R8T+B5GzqkumrGsuZ3A5+8ec1PEHsNwNmxDF8uTiex9sL7jpt/uFHjq00aB89CU
         lh97/3yOVLL7gVb6PULnvyhvCvDOQRUJE70LS5kFWr4zDVzZczhQD8gdTiPejI6eaVwf
         xVwrna9E5/0QkPE0EX2F+xeBQawy8xLLtsDg6I0XgrotFLmNmbsr7sZ+frLIui0/uDrG
         f19fbdWZJLaploFTF9t+hg04sc3TQ+0AvLh9addtTpICZQCz1p5JfENuHS28F0s+K4Ew
         Xp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jFz+BKhOlJEUiQ3eiZEIsW1DwLd4NoIfriC9CLjL/U=;
        b=ymKNicOiQ98h91cHRFTe0LzZTJmaf6Bp6mzziSNYbhJlnEtDahByaQjDQTAG37mQIk
         nQ6JQ4qXCjP3XUeUG8pSLfWaABYTJEmsl72JYofszQUpLVuYEYI2lS9vY+XjTc+eyZQQ
         WugGICJVmC7Q2uZsng9HquVh3K+GwbDfY42ZdvvCB71c8nhbl+sYBAlFpIKbPJZnM4ON
         6Xs1b+/+9omQktSIkM/tnJwoqCMRqz24uzOkb+U6Cwgk9Cklk2IQxDY7C8XDGcfhAteH
         i1bGsHwkvkWJ6zZLT5l8UbeGvDgA80ChoNfVrEImH13BJD7DXK2lCa/vqPeQGCWuAqSu
         KH7Q==
X-Gm-Message-State: ANoB5pnnjZLD3ESvTCxCFX1xz9RT70yrIBSsxYh4GGyYY/fGLIc0Rk/R
        LtcpuRa8wII47u1zPHnnDEDkfkhNKVuZNYbtF8QU8zRaXmqZc6AW
X-Google-Smtp-Source: AA0mqf6EH2W3f8JCkWXZrquD1eMT+P2+mgrVPKT0ZXfDvaMnZp5YwzLlb1AQXVBFR1yiQpfiqdhI0wBYv6tmRP2RwOs=
X-Received: by 2002:a25:ac64:0:b0:706:f408:5c63 with SMTP id
 r36-20020a25ac64000000b00706f4085c63mr4899743ybd.221.1670428705125; Wed, 07
 Dec 2022 07:58:25 -0800 (PST)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 7 Dec 2022 23:58:13 +0800
Message-ID: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
Subject: Question: How to execute git-gc correctly on the git server
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to run git gc on my git server periodically, which should help
reduce storage space and optimize the read performance of the repository.
I know github, gitlab all have this process...

But the concurrency between git gc and other git commands is holding
me back a bit.

git-gc [1] docs say:

    On the other hand, when git gc runs concurrently with another process,
    there is a risk of it deleting an object that the other process is usin=
g but
    hasn=E2=80=99t created a reference to. This may just cause the other pr=
ocess to
    fail or may corrupt the repository if the other process later adds
a reference
    to the deleted object.

It seems that git gc is a dangerous operation that may cause data corruptio=
n
concurrently with other git commands.

Then I read the contents of Github's blog [2], git gc ---cruft seems to be =
used
to keep those expiring unreachable objects in a cruft pack, but the blog sa=
ys
github use some special "limbo" repository to keep the cruft pack for git d=
ata
recover. Well, a lot of the details here are pretty hard to understand for =
me :(

However, on the other hand, my git server is still at v2.35, and --cruft wa=
s
introduced in v2.38, so I'm actually more curious about: how did the server
execute git gc correctly in the past? Do we need a repository level "big lo=
ck"
that blocks most/all other git operations? What should the behavior of user=
s'
git clone/push be at this time? Report error that the git server is perform=
ing
git gc? Or just wait for git gc to complete?

Thanks for any comments and help!

[1]: https://git-scm.com/docs/git-gc
[2]: https://github.blog/2022-09-13-scaling-gits-garbage-collection/
