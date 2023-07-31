Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D374C001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 17:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjGaRRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGaRQb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 13:16:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEE1B5
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:14:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso691343566b.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823677; x=1691428477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcn0FLYCV++at11UE20K/WU0PpuIkc/B9D/pzcUwkK0=;
        b=C2bB9sz229VouPFEp3MeNMCrQvclpVWzNVrAI8kmrXXTBoUKgu6Qs1GvTqz6PUzmm8
         R3gradTaM3dVvfw6FiF8jy2xxkM9LZKEeqgeRYh4RUPyc7Pzm7PwPdzH0b3+WFT97dOD
         J84lWDeQqbz1uLWIsOwKq5dWFxmd5F5NUdqktJabPf+Pqy/yqM99CjqciJuB71BRjCz/
         m/lClTKblGjRjIn0U3B6s+2XhpUwXipFhHCaS+YZNp5XzTvkBECLKHxtNoz5n6hdmoqv
         6bFJA7sX+ba2sW0Yy37iS93h94SRYCZUAbi6ULmjg8aAnlLgphj9ftffBpV/mU1VlMfW
         h09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823677; x=1691428477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcn0FLYCV++at11UE20K/WU0PpuIkc/B9D/pzcUwkK0=;
        b=O8EEttOKdZSN4izp5CY1/WBoj3kxeRfgONupsLdZOeas1TFdmTSzQB9+iyExY8lflQ
         5KYCtWsUvxLLpiXEhetU5gucnmVleqmY6ADLXY4Aeu0BEJWZ9POGNGOlqMEBC95g3Gdn
         VyEHqWyCVFRE+P7qrznbchTN6GGH6/bAuseH2K9T/6Y3UNewcrJipscLBllG51G3IKwO
         pm4us+kTE3NfdCPruXr4j3ssZOLKBXxWbMOL0p90mi/6I64TZBAM5l+YDhL4fP4osybI
         LRLCBcwYZueBJVr+iT/ZdkWFojhhF1v1tTtGqo0CmehPoWZted7ULsIsnvdB/UYrb4W8
         a1jw==
X-Gm-Message-State: ABy/qLZ13590a4PEhd/F8kybbovLzN0nLTGYZnPK3EzS4khMTuZ9YYkI
        xytGpeKxWiKFXfFs5AOlSkgwmz2frmZPK+iOUFs=
X-Google-Smtp-Source: APBJJlELZ8uDA2byQFmmPvb5iQk4YrxcHDWBz9GYKoYwixxG3oAvvDGZyR6nF+b2FZcHm7679TgRd1KAxTvYhIim7mA=
X-Received: by 2002:a17:906:845c:b0:99b:cb7a:c16e with SMTP id
 e28-20020a170906845c00b0099bcb7ac16emr332560ejy.33.1690823677474; Mon, 31 Jul
 2023 10:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1M3sRPEJ42v2=pQ_CQYY+PN64Swx70O7D_=VfbhSwKLg@mail.gmail.com>
 <a5c359d6-6c21-489c-a4a3-a21219ab727a@app.fastmail.com>
In-Reply-To: <a5c359d6-6c21-489c-a4a3-a21219ab727a@app.fastmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Jul 2023 19:14:25 +0200
Message-ID: <CAP8UFD0VJJ1b29W6VOmy+XR4Bi+gJeL1k7cb0a=cHkyp7O4Nsg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 101
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Canpolat <eren.canpolat@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Linus Arver <linusa@google.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 12:11=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> > The Magic of Empty Git Commit by Pradumna Saraf on DEV.to - a simple
> > description on how to create an empty commit, and why one would might
> > want one.
>
> The article does a poor job of motivating empty commits in my opinion.

...

> My opinion from the peanut gallery is that the article isn=E2=80=99t wort=
h the
> inclusion.

Thanks for your opinion!

Jakub what do you think about it?
