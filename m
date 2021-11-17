Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFBC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 21:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A44761B31
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 21:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbhKQVE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhKQVE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 16:04:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A0C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 13:01:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so16912491edb.8
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UZsApruv5eWMSEW0OXm8ykChnrionH2AfG+5OJfK1E4=;
        b=jfAvk/x/ZI6Jb+RrBFLiUj4dCzB7KlK2a+PKV92iN/NCAa/WxbbwmrvxbGs6pdKP9R
         cIzYuldudCNYHDD+fG74T+XBfjZ3C5kvGHtTQnpqeNt+H8jg3lZSAH2s64PYJ4cU8d0j
         WY6t+b9bQcX48XduD9ia/G6TQqTDlZWSAja+6uKHNYUsw1cWVA+Kj4+TxMfg7nKbNQxA
         AB84VCtjakFj/xtYThDs86dzhjZWSPrfCOIC/YzC5O3DlVG+RsGRVwfa8TmXWkUw0GEV
         L0VnEJnx7SgcfJqqgjBYV5mLDZt9h6kbyp4rBxPfETnQR+T2kq4ughBSamsvW+ZaNBHw
         v19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UZsApruv5eWMSEW0OXm8ykChnrionH2AfG+5OJfK1E4=;
        b=mx1PLTzp61NDZRQKwKEbncqo7Ro1ZQhErLW3QEJ4Had1UI3UfVXZx3WE5NUZCLD/Dj
         aQRwo0W/pDZhWMpwWgz9SOfPBrKvQX3+zzpq8l2aKC4OkfF0OnbexCzV0UQT/KKINwxX
         OBOcRx+YHuUN7yYJbFTmWNDz4aJ+B8BMonXMcwyvG8CK6bBRol0prkBGVRAzOx1ek5nZ
         SZaykn2SZuEqcoeevA55rtJR4IjH8vWGMChUVs+yNfAa0gbMxnUy+Uo9RDPWhoVkna5D
         e/UBwYEug2fXoaqK/tad1jAipzhl+FSrutsXj5o/v1CfPDVB43QTO58AErN5Uw4ol70G
         n0Ng==
X-Gm-Message-State: AOAM531aPdndBjaOMRNsgn+kdU0tMIphEHZOYwQyYZK01eWjuNexHmIB
        h3bDFQxbMb10eqHDU6N3PW4=
X-Google-Smtp-Source: ABdhPJy/ITl0DuAZO8gudKVNJwpstfxw0xl+vNXvUWHrJbawJqvlzbNPYMRE1et8wElwpg3gQdwfdA==
X-Received: by 2002:a17:906:dfe4:: with SMTP id lc4mr27319070ejc.125.1637182885681;
        Wed, 17 Nov 2021 13:01:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m16sm250440edd.61.2021.11.17.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:01:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnS3Y-000FuP-MK;
        Wed, 17 Nov 2021 22:01:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Wed, 17 Nov 2021 21:59:45 +0100
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <877dd9i1zj.fsf@igel.home> <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
 <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home>
 <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
 <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
Message-ID: <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Ren=C3=A9 Scharfe wrote:

> Am 16.11.21 um 10:38 schrieb Carlo Arenas:
>> On Tue, Nov 16, 2021 at 1:30 AM Andreas Schwab <schwab@linux-m68k.org> w=
rote:
>>>
>>> expecting success of 7812.13 'PCRE v2: grep ASCII from invalid UTF-8 da=
ta':
>>>         git grep -h "var" invalid-0x80 >actual &&
>>>         test_cmp expected actual &&
>>>         git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
>>>         test_cmp expected actual
>>>
>>> ++ git grep -h var invalid-0x80
>>> ++ test_cmp expected actual
>>> ++ test 2 -ne 2
>>> ++ eval 'diff -u' '"$@"'
>>> +++ diff -u expected actual
>>> ++ git grep -h '(*NO_JIT)var' invalid-0x80
>>> fatal: pcre2_match failed with error code -22: UTF-8 error: isolated by=
te with 0x80 bit set
>>
>> That is exactly what I was worried about, this is not failing one
>> test, but making `git grep` unusable in any repository that has any
>> binary files that might be reachable by it, and it is likely affecting
>> anyone using PCRE older than 10.34
>
> Let's have a look at the map.  Here are the differences between the
> versions regarding use of PCRE2_UTF:
>
> o: opt->ignore_locale
> h: has_non_ascii(p->pattern)
> i: is_utf8_locale()
> l: !opt->ignore_case && (p->fixed || p->is_fixed)
>
> o h i l master hamza rene2
> 0 0 0 0      0     1     0
> 0 0 0 1      0     1     0
> 0 0 1 0      0     1     1
> 0 0 1 1      0     1     0  <=3D=3D 7812.13, confirmed using fprint() deb=
ugging
>
> So http://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@web.d=
e/
> should not have this breakage, because it doesn't enable PCRE2_UTF for
> literal patterns.

PCRE2_UTF will also matter for literal patterns. Try to peel apart the
two bytes in "=C3=A9" and match them under -i with/without PCRE_UTF.

I don't know what the right behavior should be here (haven't had time to
dig), but it matters for matching.
