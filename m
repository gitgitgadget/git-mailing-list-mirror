Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D673DC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52BD60240
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhJYMhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhJYMhq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 08:37:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC29C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:35:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r6-20020a1c4406000000b0032cb5539960so3042982wma.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rP6GXnKQtVpHD2+xUcA3quMcO0QFkNP6BnALI2pIoMY=;
        b=OunAUF0t33GHZ4GOOBj8QjcnzGFTW2I7yOiiXg2jZBY58OuZDsyDDYE5YwA+EdVb/B
         je/OLWlhBZs3CA4LMpkAVVBpWBOPJTIJPhT/i9gXET4jpUqCunYo8q9SNofrCQsp7qoe
         JLXiOI1EMKaOWYZK4Z5iiKg+zWfGrkiv2GVoJ2mfc4KA+zSK9tuuIShMOpAC2HjioRyP
         UKZDCwLDN9MPCw/PRdg3ySlv99nhx1Png0DvUDYmGVKCx1wAEvHIbOQ238DeMK+D6yiA
         J/glOnGGMxxgVaAVQuMrzbNn2yeMMPQCfF3zkwxvCl+qlbm0qSOkpU05x89GYDZIQ1F3
         Wx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rP6GXnKQtVpHD2+xUcA3quMcO0QFkNP6BnALI2pIoMY=;
        b=0smLOQwlWxsxYZZ9gEMfQMUr3hIUduP5U/hBFparADXYc6fXQ0RLBJB4Q9JpVWNuPT
         CUDXh3bddAfI/PgmiDvhzlNKnYjDZ4le/ThCN+f1VLet8HvSVymoNYwLEFLzkxc4K5/o
         1c6huDp/BxpCrzaIrlVLYeXXPQpskLdNPGd7JB5ZFKL2BQ940Ntw94iS3XuEvCMaLWPm
         esvGQFZBtnN2kVgVnMkPj8BlHuyA1UMLTCwIq82EMj07SvPnts+saTI6wpCpUUugCTUP
         B/p/M/ZLdan6W1eqfjiXtFl/Nv/HOzOjWwqVCpYth1FgPq8fhNOlG1CIkTxfJkFrC7Xb
         K4cw==
X-Gm-Message-State: AOAM531yiI/ewjCwiKocFphJqaEw2iyP+x7u4TnfJZTaID1LoKW67kjc
        0zKmzpSns9qCEwx4KCPhOv0=
X-Google-Smtp-Source: ABdhPJxt86LY8HjJ7lst20ktGDFDfCzWIqrbuqRfR50Q7f8lkR3PHLwN2LxRB39vIHK5wYCQgOFysg==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr12139224wmj.107.1635165322681;
        Mon, 25 Oct 2021 05:35:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g7sm14177065wrd.81.2021.10.25.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:35:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mezCD-001Wd6-IV;
        Mon, 25 Oct 2021 14:35:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] progress.c: add & assert a "global_progress"
 variable
Date:   Mon, 25 Oct 2021 14:29:36 +0200
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
 <patch-v4-8.8-06124e8ac5e-20211025T111915Z-avarab@gmail.com>
 <c65c0a54-b66f-a043-01d9-192f9ca1efde@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <c65c0a54-b66f-a043-01d9-192f9ca1efde@kdbg.org>
Message-ID: <211025.8635opi8om.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Johannes Sixt wrote:

> Am 25.10.21 um 13:25 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Once we have a
>> global current progress object we'll be able to update that object via
>> SIGALRM, this will cover cases where we're busy, but either haven't
>> invoked our first display_progress() yet, or the time between
>> display_progress() is too long. See [3] for early code to do that.
>
> This can't be a goal. You cannot do serious stuff in a signal handler.
> Don't proliferate complicated signal handlers.

I'd missed some of the nuances with signal safety when I hacked that up
initially. For the purposes of this patch the commit message is
discussing a POC that suggests an interesting direction to go in.

My current implementation of this which I've run with for some time
relies on undefined behavior and glibc being forgiving, but for any
future submission I'll make sure it's signal-safe.

In particular to format a progress line etc. we we need sprintf() and
the like, but to have a "stalled" message we can pre-format that at
start_progress() time, and inside the signal handler all we'll need is a
write(), which should be safe in most places...

> On top of that, our SIGALRM handler on Windows runs in its own thread
> and can't do more than set a volatile sigatomic_t (and even that is
> undefined behavior, strictly speaking).

... but we may need to disable it entirely on some platforms, I didn't
know about that Windows edge case.

Anyway, for this patch having the BUG() is useful even if we never went
for that.
