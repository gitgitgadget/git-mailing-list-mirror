Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D0C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiDYKA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiDYKA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 06:00:57 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987961C934
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:57:50 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z144so4264093vsz.13
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/UCBuJ6xkxEerzGhdlDiqmS7Pgxh8w1udsC7S7TuXGE=;
        b=Ak39IU+pJ7VZ9t1gJDz5WTqi/1sHN1s01/kIsGuc4UDpYmraISqCJZ2dK1QsPpm2ha
         hBQP+Edf8WMQ5yYh9+zFFEfmHL2YfoHRYdOVBPPqSwDx4DPYNQFNRY3AGMdfMimiAz6Z
         p8zCK2pNq51NuOXkauafCI93UozC2v3m7SwsgXUl89rocnlAOZwuRgktn4U+ryV5eak1
         wtxYgXzOPGq1+R9AexmJBt6/3mE33L+toTDCKP5uZxNr5v2VVKQf1MY+zaMna9P1N4ct
         e4WzKN/ecQJxPdSBkE0r3pQPIUIlL+wY8L1vczipsC9uQvkxq8oGMsBwBMYVTurDZVNF
         5fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/UCBuJ6xkxEerzGhdlDiqmS7Pgxh8w1udsC7S7TuXGE=;
        b=Ce+4vymNCASUeKBuhgKCbCD7Gd1+tSylEUfQGKBkPlfRFjpxBLkBKrX3D6/DiBcXkZ
         S9prpcKCXLz7IRsQ+ROufJNsplDCa9Jh1gftpj8MCxVbM9vVhfJfOlo1bbVvXT2lUZ/3
         ZpirP7KGTRaVvWuLskcKsowJnzTAdDrv8Ep9eXjsrsDMnXGztoM5EcDuIJkfgQTrBdOL
         iZtJKGy8gpm8l7z81tZ8pxIFjcHGeGqiveSQ+Ghq8owLwKAfD4578MeoF3wDPfXw9y5a
         CvG6K6z1dxA8RezjgAYYyDMT2omrbUcRcRsbZnwCvWfyHp5cA47FXKiBnFvlGyUYjAci
         67pg==
X-Gm-Message-State: AOAM533zSJNXVhNgrdyHSypsBFR6VUP0FMjf9d2/5qyHMxhV6Nm1Krhb
        Sb4oQmY48eonN5RwhmW7oGC8bZQEL6Yprx6IYUbFAg==
X-Google-Smtp-Source: ABdhPJyRN76AXYcyABhOQF4BMUPMHIDvVHbTPWiQ2lDQXu7m/zQv1xFLKrE/kwv4n7EQEV4CzH5z0MhFKqrVWVxd7es=
X-Received: by 2002:a67:ea51:0:b0:320:c3a9:414b with SMTP id
 r17-20020a67ea51000000b00320c3a9414bmr4794766vso.81.1650880669666; Mon, 25
 Apr 2022 02:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220415083058.29495-1-carenas@gmail.com> <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-1.2-76ed86bf88c-20220415T101740Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-1.2-76ed86bf88c-20220415T101740Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 25 Apr 2022 11:57:38 +0200
Message-ID: <CAFQ2z_O7ytx=AsXuJbYnOdMwT0u03sMP-ZjRRjt4HFn48HT-2g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] reftable: remove the "return_block" abstraction
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 12:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This abstraction added in 1214aa841bc (reftable: add blocksource, an
> abstraction for random access reads, 2021-10-07) has the caller
> provide a "blockp->data", so there's not point in having the vtable
> have a custom free() function.
>
> In addition this had what looked like a poor man's SANITIZE=3Daddress
> doing a memset() to 0xff just before the data was free'd.

>  void reftable_block_done(struct reftable_block *blockp)
>  {
> -       struct reftable_block_source source =3D blockp->source;
> -       if (blockp && source.ops)
> -               source.ops->return_block(source.arg, blockp);
> +       FREE_AND_NULL(blockp->data);


My thinking here is that we could mmap the reftable file to do reads.
In that case, discarding the block would imply decreasing a refcount
somewhere, rather than deallocating memory.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
