Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2FCC19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 05:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiHGFvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 01:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiHGFvK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 01:51:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC32711
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 22:51:09 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q124so4852458iod.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=SeYBtAc6J9mthoHh1Nqk0MYJ8fd3CbGb3n6gxYpH/ZM=;
        b=b4Id7M4SY4qSg/8yNs0E1Y/axVbD5yL3B5AtZoYgTHvB7VPDBk7Sej6EwDrxG+C2Z+
         uLRdcy3JdMVyfoBbYGqqWTmDx5GuW+/wGxnTuPjC1onuwSudzSVebH8Mpz2weSOlM7L3
         wUxlwNtto8lzfVDbSHLhVMuc++n8hwXjlmT4GlRfNVDjzd9VqTeN8ofWHrGqVXrezHhX
         JMhmC07BOj1xEociuNkoCN2HnEPmwiT8YZTt6B8Dlcryv/D0SaABtSAkqYUQYmwRPVRC
         sGR7jeG0DoNR4EUndu5zQGlOTWkdhX99T99IZKNCdU4+fHhRrCeZHJLBa2gucMZlMKeZ
         z11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=SeYBtAc6J9mthoHh1Nqk0MYJ8fd3CbGb3n6gxYpH/ZM=;
        b=rAOy28P9T8UaKCl46rsfLYsC2jZ6ejT8LweH4UT0mZ9yOVG/pUGbN9j1eNS8MQaw9a
         qyHIx7D9x5DC/OE3jslTdQwn+hOhaTa4ZpbVRxiEzFc5mrhGpCYmyj7UljwNnw+FZ99+
         SsjQQJwQyGg/AYO7NvBwlHDFHhr3YS2P+CK4BdEj69TgC0Ex4EqQfqk8BK5NfFcu9d0Q
         2yMGcvWjP+R5dejk6Ehqxdi31ojAQ0LB1IMg467Rlc7dZNgLIghlowAY3wTqErsH2vpK
         SG+F5yRScYveY9EVHwuN3ibdB21lg8VPPbtWNJvNKVZUraw8tHKp34MliL3H9wv/xEgr
         4ycQ==
X-Gm-Message-State: ACgBeo05G6ia/7akSuqLazU3T0g3jMYv2WlouzXXdoG+KB59dNMaPxjs
        W1Tt2MplPwzfNiKARb8PGhh5TC10TPMoZq4a0eTj/C+h3Kelrg==
X-Google-Smtp-Source: AA6agR6nJf2pyPMwqpyqLd9N8hGujI2PXn2XLwuPPJmLZDFT0G+vHSWkrEA+xOyticmtDYS2zqlmldyLSyaEinpfKBo=
X-Received: by 2002:a05:6638:12d4:b0:33f:aaab:8d84 with SMTP id
 v20-20020a05663812d400b0033faaab8d84mr6286235jas.67.1659851468772; Sat, 06
 Aug 2022 22:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-7-calvinwan@google.com> <220729.86tu70ig47.gmgdl@evledraar.gmail.com>
In-Reply-To: <220729.86tu70ig47.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 7 Aug 2022 13:50:57 +0800
Message-ID: <CAOLTT8RrjcqXoFrq540ur5B=cdkLhwteZje23Nn3+wtdZZdZMg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.email>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B47=E6=9C=8829=E6=97=A5=E5=91=A8=E4=BA=94 14:33=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Thu, Jul 28 2022, Calvin Wan wrote:
>
> > Since the `info` command in cat-file --batch-command prints object info
> > for a given object, it is natural to add another command in cat-file
> > --batch-command to print object info for a given object from a remote.
>
> Is it ?:)
>
> > Add `remote-object-info` to cat-file --batch-command.
>
> I realize this bit of implementation changed in v4, i.e. it used to be
> in "fetch", and I'm happy to have it moved out of there, we don't need
> to overload it more.
>
> But I remember thinking (and perhaps commenting on-list, I can't
> remember) that the "object-info" server verb was a bit odd at the time
> that it was implemented. I understand the motivation, but surely it was
> stumbling its way towards being something more generic, i.e. being able
> to just expose cmd_cat_file() in some form.
>
> Which is one of the goals I've had in mind with working on fixing memory
> leaks in various places, i.e. once you get common commands to clean up
> after themselves it usually becomes to have a "command server".
>

Now I'm starting to agree with you on this:

Maybe now git doesn't have a good interface to execute normal git commands
(except git-upload-pack, git-receive-pack...) on remote git server.

This patch wants to get remote object-info by the git-upload-pack interface=
.
But this thing can easily work by some RPC server e.g. Gitaly in Gitlab.

I don't know if git itself has the need to reimplement these remote
calls In some
secure environment?... Is it perhaps possible to get better
performance and versatility
than Gitaly? I donno.

> So (and I don't mind if this is longer term, just asking), is there a
> reason for why we wouldn't want to do away with object-info and this
> "cat-file talks to a remote", in favor of just having support for
> invoking arbitrary commands from a remote.
>
> Of course that set of allowed RCE commands would be zero by default, but
> if we had some way to define tha "cat-file" was allowed to be called,
> and only if you invoked:
>
>         cat-file --batch=3D"%(objectsize)"
>
> Or whatever, but over the v2 protocol, wouldn't we basically have
> object-info in a more roundabout way?

ZheNing Hu
