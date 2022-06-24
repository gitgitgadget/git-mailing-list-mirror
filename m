Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B479EC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 13:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiFXNtw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 24 Jun 2022 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiFXNtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 09:49:51 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5A4BFE8
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:49:48 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id n16so865966ual.12
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XReL6H/xYbZP/YENERcydtBArpizVBGfqxh3hQRXmGI=;
        b=6BxDX8qXNkqOAVkBSVysDfS93qW/KhJuGIIHGBFlc/rDHaXebpVDWSVA6D3iJz8lHO
         +SVX0/L8lHQi1+GyrMrX9w4dw7/5fhDdXj2D1W17O7vrGXAd2mtKKoWIYr9yj3FU0le+
         Cp5CC5IBSn1b5lOuLJMwzmhDwU4vdFP/y90HRQk60fojSa6//EamLC641X4n/Ax3Yybs
         wd4XQM35AuZLJYtKrC5PdMj5ocez3je8CBOHcYIqB8DBKVxNBv8UAbjhaJYCEo2Cft5o
         D/6L4SGj+mPBuZOSpj9PPfxt4xWudmzv9BXbet92hnJnaq6YgTj7nw5/EUzfZTvW0Wj7
         hXgw==
X-Gm-Message-State: AJIora/MvUU0PTMTRY8LGekAo4kqYQ/JzMlHTeIlw/POxA6dGlAervRV
        lwsAPG2vvH1LN1P4/NRiMC8HGO+5CS8PhpEo5KfpbBAk
X-Google-Smtp-Source: AGRyM1tyWizNNMzlPfa8Jc2TXKYoHW4vfJUwtdMK41JMqUFAuhxz9ticYsnBDainbKP4Ywws8AQ69zqvMNAzNJ+ZVms=
X-Received: by 2002:a9f:2982:0:b0:369:26d9:3d2b with SMTP id
 s2-20020a9f2982000000b0036926d93d2bmr7574878uas.53.1656078587211; Fri, 24 Jun
 2022 06:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220621142618.239b02cd@bigbox.attlocal.net> <220624.86tu8ai4mr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220624.86tu8ai4mr.gmgdl@evledraar.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 24 Jun 2022 15:49:08 +0200
Message-ID: <CA+JQ7M8gaEWHHdx2or2kQfYpp=XBxQS=pXtEOS4x5SBdpPWdkQ@mail.gmail.com>
Subject: Re: stashing only unstaged changes?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tim Chase <git@tim.thechases.com>, git@vger.kernel.org,
        Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2022 at 3:20 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
> Is what you want equivalent to:
>
>     # save the "git add -p"'d chunks
>     git stash push --staged
>     # save the "uncommitted"
>     git stash push
>     # pop the previously staged
>     git stash pop --index stash@{1}
>
> ?

Never noticed --staged before.
I just tried to
  seq 1 3 >> bar
then git add -p to stage with 2 and 3
followed by a git stash push --staged but that gave me the error

> error: patch failed: bar:2
> error: bar: patch does not apply
> Cannot remove worktree changes

But I'm guessing the command (and approach) work fine if the
staged/unstaged are in different files.
