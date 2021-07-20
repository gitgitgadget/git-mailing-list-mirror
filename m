Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE2C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 19:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E986101B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 19:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGTSym (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhGTSyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 14:54:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ABCC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 12:34:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gp5-20020a17090adf05b0290175c085e7a5so2604799pjb.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZhKv94D0FS3EpYLhXsX5c9GfozkziUyBJLH2iuHBRc=;
        b=Tr71EcJA6myP+mNk+4EYaHV5SxCB17HhzM9ZcPkgK8Nzi84n4TvkaL/DIKu/SjGQec
         T4RVPpWzAp2qkAXwFXFiHA6ujY8xvtgqhiUvcCmVCihPMdTYeN7eaB8VjxzATm0aDqzX
         4hAbzWhlTJSS/xigtY4+vdrkyyL0imTEl0abcXoCQHZnDsYPB5z5FU7CEkeQOyd0flif
         b12x1D+qtwcSdsSLcOH3eZynwlOi1BLPJWcoJnk+X1rqTIZ7AAxUzNSOEqgoRmsc1Zud
         cojeuUOTLm7r0wh6bSCqMGUoYvWHacZBY38UIWEvPYv5ecN8i2IJT+3mKKUzYcgwMJMY
         nDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZhKv94D0FS3EpYLhXsX5c9GfozkziUyBJLH2iuHBRc=;
        b=OmdlnDTYbNqSJrtWUp0KPkeNjcgYW1NZyd9Hcl+k1LZhPGe5aARvjXGH3OIY+T+qGf
         CZRT9CdsTkehHKYJ23Z3SdD9DYtik2bdNWosei+IteCysJFNawjFh1ecFi0txng3ceEo
         ifHKx8bmaFUMMYrJ/TmXU1qHzd0Ydj7X6D1+AP+MzIjaAEmTgmnRSsLl6ACbgSd0WffP
         la3pN/oFE/PCLrmSVSNWXPGxezQTAGuCJJNA9Abae0Wwr2Q11LxE0xhL7jo4lkri7cPj
         eRoIOAWPHY8EU+lamzFzvy7/ckQezy8dbLzMGC/REW06D/GWZKwq1xbY5k4oJwGKmIqD
         euNA==
X-Gm-Message-State: AOAM530qgSvwXfXLDJ2Gg+mk+NTwJGghmvFpdJuvM6olKZYW4cOn0kh3
        K6aceNU0R854KbxWcYcANB/g05Oz2FRQTS6no00=
X-Google-Smtp-Source: ABdhPJxRDfLmcs65hSSdUrc10UK4Z5prQUP5eqj7A+wISPIo8V8qMqLwaqqE48+DSOd/GHZSvkKcAV4ud5AvQZ3eQas=
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr35503490pjb.87.1626809694690;
 Tue, 20 Jul 2021 12:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net> <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
In-Reply-To: <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 20 Jul 2021 21:34:43 +0200
Message-ID: <CAN0heSoz8KmmtX8LVcY2wBM6Fm4TAYwDmQGPE8wpdZTmWRVzWA@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 15 Jul 2021 at 00:25, Jeff King <peff@peff.net> wrote:
> -       Use the given config file instead of the one specified by GIT_CONFIG.
> +       For writing options: write to the specified file rather than the
> +       repository `.git/config`.
> ++
> +For reading options: read only from the specified file rather than from all
> +avialable files.

s/avialable/available/

Martin
