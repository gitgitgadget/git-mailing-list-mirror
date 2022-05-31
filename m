Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1AFC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbiEaN3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiEaN3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 09:29:12 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C968F82
        for <git@vger.kernel.org>; Tue, 31 May 2022 06:29:10 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id j3so12043973qvn.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 06:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBMJPev36MnTNAnCX/qJO5HtdX8ocdcKkehUdaPoyBg=;
        b=4R5kPbJbQRw6hB2DdL0B508jvbR67sBaXOa91Z8g5i4hBBuLpK4kSY1BwD4HCFsweA
         20CceqTLVuPVKNwi/fFXMUm+PMGFfKeli3vxd4MrsUATZM95udnj9vWd2N0hDOfHDvLs
         YLL8DeoKk57HG+TaFRhB36f9hfxrRchJ4f6IDNPZCKqW2gC5RYn98X0bBPgUCz0goydk
         KnGp0K1PfX6lFW3er/HAwnnp6AIlKQD1vBvOdcuYkS3V17I36Hr9AiF+A5vtBjBegQ8U
         DL8TwQbQQD8gv5lnSf6/eZKla212PgfhU5jLqh3SRuA5qCVhqe0vFlXp29XQXRxQquwW
         r3vg==
X-Gm-Message-State: AOAM532DtguwYg7HVw9RXztpg185cpf+BR24ah8aSK5CUMpQi/XyuTHq
        fyOwu2qKP5BZ0tiDkMGFIzgTVFxnQeE=
X-Google-Smtp-Source: ABdhPJx75lBFzj8aFjZOC4+jYE32utn91SsPhDkLKuMy3MmZDSZM7a9jnQbydAXOYUOwHNcAFbn0Rg==
X-Received: by 2002:a05:6214:ac9:b0:464:5f21:2c51 with SMTP id g9-20020a0562140ac900b004645f212c51mr2685529qvi.40.1654003749812;
        Tue, 31 May 2022 06:29:09 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u23-20020a05622a199700b00304b506eec2sm2717322qtc.93.2022.05.31.06.29.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 06:29:09 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ff7b90e635so139429167b3.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 06:29:09 -0700 (PDT)
X-Received: by 2002:a81:d53:0:b0:300:5ae1:353 with SMTP id 80-20020a810d53000000b003005ae10353mr32958371ywn.364.1654003749302;
 Tue, 31 May 2022 06:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com> <20220531073445.iuovy634ufp5xims@fs>
In-Reply-To: <20220531073445.iuovy634ufp5xims@fs>
From:   Andy Lindeman <andy@lindeman.io>
Date:   Tue, 31 May 2022 09:28:53 -0400
X-Gmail-Original-Message-ID: <CA+vJLfu1WyqP4V44iyZj+Fyr8O7JSB8tSJfOmS1SeSZ65fXh0w@mail.gmail.com>
Message-ID: <CA+vJLfu1WyqP4V44iyZj+Fyr8O7JSB8tSJfOmS1SeSZ65fXh0w@mail.gmail.com>
Subject: Re: [PATCH] ssh signing: Support ECDSA as literal SSH keys
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Andy Lindeman via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 31, 2022 at 3:34 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 30.05.2022 17:45, Andy Lindeman via GitGitGadget wrote:
> >From: Andy Lindeman <andy@lindeman.io>
> >
> >Keys generated using `ssh-keygen -t ecdsa` or similar are being rejected
> >as literal SSH keys because the prefix is `ecdsa-sha2-nistp256`,
> >`ecdsa-sha2-nistp384` or `ecdsa-sha2-nistp521`.
> >
> >This was acknowledged as an issue [1] in the past, but hasn't yet been
> >fixed.
>
> Hi Andy,
> thanks for your report. We have decided in the past to not explicitly cater
> to every key prefix and instead use `key::` for literal keys.
> See
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-usersigningKey
>
> `For backward compatibility, a raw key which begins with "ssh-", such as
> "ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa XXXXXX identifier",
> but this form is deprecated; use the key:: form instead.`

Thanks for replying, Fabian.

My main issue is that ecdsa-sha2-* keys currently seem incompatible
with `gpg.ssh.defaultKeyCommand = "ssh-add -L"`

The git-config documentation of `gpg.ssh.defaultKeyCommand` says:

> To automatically use the first available key from your ssh-agent set this to "ssh-add -L".

But this does not work with ecdsa keys because each line of the output
of the command is checked against `is_literal_ssh_key`. Because of
that check, keys that do not begin with `ssh-` are skipped.

I could certainly write my own shell script for `defaultKeyCommand`
that did something like `ssh-add -L | sed 's/^/key::/'` but it's a bit
awkward.

The code that runs `defaultKeyCommand` states:

> /*
> * We only use `is_literal_ssh_key` here to check validity
> * The prefix will be stripped when the key is used.
> */

but this is clearly not true because it is rejecting valid SSH keys.

Do you have thoughts on how to improve `gpg.ssh.defaultKeyCommand` for
keys whose prefix is not `ssh-` ?
