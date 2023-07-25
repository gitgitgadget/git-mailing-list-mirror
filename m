Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5FC001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGYPp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYPpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 11:45:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDA1FFE
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 08:45:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso3540597a12.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690299923; x=1690904723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pr+PNCX5BA/xhURj2+KR5mT9PW988/h6ZXOVmiWaOI=;
        b=BS18754m7NiklRil5f7R5YN2RLGxT7zbhs6IOxfiWRzbKQ7xotYVyyA4Z60+/P5/Dd
         rjfDjjziRabzGUN2q54/Bh/4f67lUxPVL4164enVZt0oa1l4lRNP8mDxfItTXL+hsfZE
         BpiuTfe5PPc/QNpPqt88dRY1mEgkxddSfnsWgpS3JDHt2NzlaEyGZh5erS+6wecy6a5L
         YjcJLYO4MQ9L6bjGuGuM2f0BNIGREbuYr2U1h0NTDsnGXMI3EKoaw++/xdbmMCEN5HHQ
         o1jZ7nMSnkw9FMP6XsIA8r5kWjvJK2Atso75Oqt9gYZDUns89qUexenAGsNQKkW1msGU
         YpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299923; x=1690904723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pr+PNCX5BA/xhURj2+KR5mT9PW988/h6ZXOVmiWaOI=;
        b=P9Zv7hWmeYLm4Ls63SODFlDqvHBI90Q/ioQbYDtca6aMaQptNZgfPCWmKtr3ijTN+g
         fB7h8Rd40hObD++wB2gtQszuhsdgJeQM9xwJAPqxD2MLfof5WQonuZwsBc9pLVJh4bXL
         8eKlvHuHUliR6bcM+h/+OU2/nPGQ3rk9Bz1lmOI/x2tXT9472u6bNYdAdBFK6XDjHEMX
         av3v/qeY4GlfbAwnLhr1/xUEeCFHJfNAGShHRedflybkCRWtIs854PGXc7HEpAYtlRPx
         mLF4KtDablOncAhDkBVrBmDP2Rt8qNMci/uBgiGMd6576bcXiFBMRT2Acc78C0UTWLOr
         xwrg==
X-Gm-Message-State: ABy/qLaqdXKoQTxovp7pbj74o5o/oJVQs1UjljL4Io//6kS+W2ad5Obj
        wjD5VJ0RsTI29hr8MVg+F+JdMqQP7Mwj0wMD1FA=
X-Google-Smtp-Source: APBJJlHme4lQ1bsl/3Y1SbzVJsn/mRRlY+btcdKgDKXoObRpyxFGwOv4MpAecThFJuWRmF1wifcerl2HIQsghyHZK5M=
X-Received: by 2002:a17:906:32cd:b0:993:6845:89d6 with SMTP id
 k13-20020a17090632cd00b00993684589d6mr13749523ejk.47.1690299923013; Tue, 25
 Jul 2023 08:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-8-christian.couder@gmail.com>
 <xmqq5y6y1agl.fsf@gitster.g> <CAP8UFD1tqzp744j0KORw-zcgOn6Tufm4Kk3yct3vHGY29pbm-w@mail.gmail.com>
 <xmqqy1j5p40f.fsf@gitster.g>
In-Reply-To: <xmqqy1j5p40f.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Jul 2023 17:45:10 +0200
Message-ID: <CAP8UFD0YzYR0y7st3CXbed9OdzbxRKK3wy1TzFGWxx+m3DfiDw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] repack: implement `--filter-to` for storing
 filtered out objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 8:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In version 3, the doc for the --filter-to option and the corresponding
> > gc.repackFilterTo config flag look like this:
> >
> > +--filter-to=3D<dir>::
> > +       Write the pack containing filtered out objects to the
> > +       directory `<dir>`. Only useful with `--filter`. This can be
> > +       used for putting the pack on a separate object directory that
> > +       is accessed through the Git alternates mechanism. **WARNING:**
> > +       If the packfile containing the filtered out objects is not
> > +       accessible, the repo could be considered corrupt by Git as it
>
> "could be considered" -> "can become".
>
> > +       migh not be able to access the objects in that packfile. See
>
> "migh" -> "might".
>
> > +       the `objects` and `objects/info/alternates` sections of
> > +       linkgit:gitrepository-layout[5].

Thanks for catching these, they are fixed in my current version.
