Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC7BC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6DC60FE4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhCaODp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhCaODl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 10:03:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D10C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 07:03:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b7so30266456ejv.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5dyLTTXZTCUtsbnDvJf3WeB4O1k1WujrnGlOzgelBlM=;
        b=ZOR+99INy81IDjnzANNm0Tusp995GDZ7l3bV6WoNWpU+xFaJCTZpwNVTsZY2PSWjwy
         mcc1FAqgIz39zeFdtkpDRNGMtkOVgsEIuJXR6/x4ApBt5y9PzrI8X/i0SQFLy+VYK+hp
         k7R7TJpuFZu53y+T+wKfng+X9ZId9xit28tLvrlQdVuepFIHZV+bXY1itd5+4TX21sod
         W9Tas83fWKHPmPRjRsgApJzkWd4UzEPXk17i0sQhZJ/Gs0cwkW1OBZ8OS4VCnNtc1lH0
         boKY6yqLUQfWhSvTlw7MNZ1t6u7c2EfNJAtDNl3ZdVgPWVXpBvpqEOwvkLyh/AN3EMSh
         iiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5dyLTTXZTCUtsbnDvJf3WeB4O1k1WujrnGlOzgelBlM=;
        b=HZRno1HCGj7vIWWzQWOYHiP7UOnKA+uHggP22QbqmKCHqgq6TRrR3HZ5GMBK/ZloRx
         R3aOXNMEU2MoWJPVvnPHo30sGhTnhWeB5zAl7GGE4JDbmfTOqwMpnWM/KeTLHV0UjBmq
         ZFYfMLVt7vTEmiefseXlVajQ+XMRTh+6KLF9YvghmR2cAg8Hm4W4w8t32FETKee8yzj+
         kyyG2lzHWi8a6OdkyHhuca749BBRd6CZebdB4I17jC5SvnNY1//512ILNIwtzVS+3D1+
         F92QR63g0jyx/7HbrCC+jYRiKBdba/KsYuncT57TlF/kpZbhhHaMU3btwkwPLWrPIDSS
         nDzw==
X-Gm-Message-State: AOAM5311ARfcd3sXcDY7shtu3Ep/7q4OA7L1pgQkQwDZSZIZpzP76Cvd
        QLN4Ub3h+S/74Ksy/fE41eMgbRk6/wc=
X-Google-Smtp-Source: ABdhPJxsEpPIV2Jaj6XuUck7r7iotTajMQhWE8SeXobLW7FHafCcMb/sgus6/SMTEcWMi1QfNfmllg==
X-Received: by 2002:a17:906:5ad2:: with SMTP id x18mr3717481ejs.117.1617199419805;
        Wed, 31 Mar 2021 07:03:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s4sm1242776ejf.108.2021.03.31.07.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 07:03:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Makefile: add a INSTALL_FALLBACK_LN_CP mode
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
 <patch-6.7-9ada8979890-20210329T162327Z-avarab@gmail.com>
 <xmqqeefxh8rl.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqeefxh8rl.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 16:03:38 +0200
Message-ID: <87v997l8sl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 30 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the default behavior on "make install" where we fallback
>> through a chain of "ln || ln -s || cp" to instead error out when we
>> can't symlink or hardlink, and not then fallback on a "cp" (or from a
>> symlink to hardlink etc.).
>>
>> The fallback behavior was introduced in 3e073dc5611 (Makefile: always
>> provide a fallback when hardlinks fail, 2008-08-25), since then we've
>> gained the ability to specify e.g. that we'd like symlinks via the
>> INSTALL_SYMLINKS setting.
>
> Hmph, I am not so sure.  "Use hardlink if we can, as that would not
> consume inode, but where hardlinks cannot be used, it is OK to use
> symlink, and I do not want to waste disk blocks with cp" is probably
> one of the sensible wishes, but at least without "ln || ln -s" fallback,
> you cannot do that, no?
>
> So I would understand if there are two orthogonal knobs
>
>  - the order of preference (e.g. hardlink > symlink > copy)
>  - which ones are allowed (e.g. "no symlinks please")
>
> but I cannot quite imagine how a system without any fallback would
> be useful.

Because with explicit knobs I'd like to tell it what to do and not have
it auto-guess. E.g. if I say I want openssl I don't want it to see it's
not there and auto-fallback on gnutls or whatever.

The same for "I want hardlinks/symlinks", usually someone picking one is
building a package, and under a lot of packaging formats that difference
really matters, and either won't be notinced in time or will break
further down the chain.

>> +main_no_fallbacks () {
>> +	if test -n "$no_install_hardlinks" -a -z "$install_symlinks"
>
> As the values of these variables are (presumably) tightly under our
> control, the use of -a/-o with test may be safe in these examples,
> but to avoid letting clueless shell script newbies to cargo cult
> this code, let's use the safer "test -n A && test -z B" form.

*nod*
