Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D4C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5CE60F4B
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhJKNZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhJKNZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 09:25:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF104C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 06:23:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w19so7850625edd.2
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hy23xRQcdft7RdY4Q13sp6FjyN89MHzIoHzRWglx34c=;
        b=UKr77NXQJqL71aEKbzKvm+OeCBaK/7JHREtj7UK1KvHmNdGczwwfIfIaurBVOp5Oho
         xQmwJEsnsXVacNDhw26HhNEMAk1NUsfmlcDo5dcCBleQq202hqCz8NNpv9bWceJcB++6
         Ex2HU3ZtkCiu1QUSgD8DI5iHoKiZkZd3W23uwZMIHcMu03PcKZ/rc/riyhbZU9wMk9FS
         91KaWSzMTgY6KsoMaV+6hYGYzOYsKwRlPojj7HpvC3Z8s0UjGeYKHQuz0ZVJiChNPBhO
         Jydd1qsegiXuni4zk13D2WG5Zd9HUMzC/7ppZlqZBriUBsamu1PkS5ESXmp6Zwz7h835
         Yr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hy23xRQcdft7RdY4Q13sp6FjyN89MHzIoHzRWglx34c=;
        b=Mgr4i2viFJI2ITmfHbscjV0RwreF/O3/Fz9WmfO+50dGJQAaSxIhGuTXfi0FCIP8q9
         LDtBFqLi0b0RdkOCNQctdZHu0XjE7qe7xcJs2C/T7dFPQ2o7B9hPtWUc+adFqRx7YI09
         pa3cFtS83I5pV/A7+YE7wwmAQKA4/MX1e2Hkxe0YrkItZxRpfrZpA4zNoK7b7swxRE51
         Px+ql2BX8wWPly7nV/Imc0rtWnwLyVPjixYFaUtoEUQfMCPJzFwgY/0H4bUmajhtopeg
         62by1g0A7RxdveGyb0+GWYMsDVJ3VolcGI8MEogyefHuQdJyHuCEBTHKwpfMIjKNI+lJ
         Quvw==
X-Gm-Message-State: AOAM532lOTKpho8IHXf4ZozupR3lHHweH8+P//62bQQ8fnI8egre6qUv
        WcYUr6MTk/+Y3KZObsKPPvQ=
X-Google-Smtp-Source: ABdhPJzDXwGUd5UHrp4+X96hmC4+csZDy0VGbnrXcVnnmTmdQ+OzdVFFRj9AliH69/XSbv/ACzwygw==
X-Received: by 2002:a17:906:4f82:: with SMTP id o2mr25714947eju.10.1633958633724;
        Mon, 11 Oct 2021 06:23:53 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o3sm3493206ejg.52.2021.10.11.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:23:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when
 emitting errors
Date:   Mon, 11 Oct 2021 15:23:02 +0200
References: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
 <20211010214209.GE571180@szeder.dev> <87o87wl485.fsf@evledraar.gmail.com>
 <20211011044730.GF571180@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211011044730.GF571180@szeder.dev>
Message-ID: <87k0ijlmon.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Oct 11, 2021 at 03:49:39AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Sun, Oct 10 2021, SZEDER G=C3=A1bor wrote:
>>=20
>> > On Fri, Sep 24, 2021 at 12:08:20PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> Change the error shown when a http.pinnedPubKey doesn't match to point
>> >> the http.pinnedPubKey variable=20
>> >
>> > I'm not sure what this means.  Between the repeated
>> > 'http.pinnedPubKey' config variable name and the "doesn't match to
>> > point the ..." part I can't decipher it.
>>=20
>> It should be "point to the" (but this grammar error is already in
>> "next").
>
> So it's supposed to be
>
>   ... a http.pinnedPubKey doesn't point to the http.pinnedPubKey
>   variable ...
>
> ?  I still have no idea because of the repeated config variable name.

We emit this currently:

    $ git -c http.pinnedPubKey=3Dsha256/someNonMatchingKey ls-remote https:=
//github.com/git/git.git
    fatal: unable to access 'https://github.com/git/git.git/': SSL: public =
key does not match pinned public key!

And with this change, this:

    $ git -c http.pinnedPubKey=3Dsha256/someNonMatchingKey ls-remote https:=
//github.com/git/git.git
    fatal: unable to access 'https://github.com/git/git.git/' with http.pin=
nedPubkey configuration: SSL: public key does not match pinned public key!

I.e. this replaces a generic error message from curl with something that
points the user at the config variable in question.
