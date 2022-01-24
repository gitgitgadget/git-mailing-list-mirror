Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2438FC4332F
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360900AbiAYCCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2371524AbiAYAIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 19:08:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1F8C07E285
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 13:55:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ka4so25279915ejc.11
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YELayO/CoiOmLwNOfSallKxt7fXRJXkiGoBt01TpH9k=;
        b=iyEpDaxmrang0uWAN//St341no2azK+Q0xtT9CzALpaUoPKqAHrjMCtpe5LvqNnwzC
         BXZd3YZMN2FSXuGg/U7E/uMl3TnxuHmtTAhM5XXBJO4+E6dtUFOLVPXbi5q67ZuxslDd
         s2STJqaYCYe99NjUA23UmFfDRuKxqGMECHIvc+xYNhYFkTqRk+gznF86K9hKjV2D0CAW
         SZptt88NRWPZgL3gMaX6+8FT27kw+piy1zySJUkwt0jLMyN4KNkSGC+9SqQ0o7b3gbjr
         OptPMI04HwgXBth9QMM5SMxdO/WUUShg8GLJCKz1r8OC9ZSilagUN82LSuXHa/YudFcB
         B35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YELayO/CoiOmLwNOfSallKxt7fXRJXkiGoBt01TpH9k=;
        b=rbTzZwjNMDXienpwPtXGD/VRsUp9FHtW82TZr7UhJVtwIRnjAgUZaCs1yZdypmIRNl
         J1DeLc6Nou4LWEfza+SPli+SWJ4Sjy1pdQA4YxJh5/5S7MF/rtOdVsQR11GuO5TsJlAX
         zFiz6ktbEPloFGvW8OTgtYd1tc2ku/6LTj3dnfdYQa9XXKTSUCUTs1ltQXA332IXqeEV
         5rt1rSKYzZ4K9Q5W9piiH9zHuzai4qQUEH7nYHu94oqoANCVa+18edz0LsFfdWKzB0Ol
         FXE6ZYbmbjCaWYjJ5tbBl2/CHU0E7OJHKqCzKegYSe4ForTz38je70qhZ0SCSb2oE0Sj
         H4QQ==
X-Gm-Message-State: AOAM531zVfjgMb7jyuGhtwHsF/PCxHbT5jM83Lc4TxygKTUCwhryKgFT
        08bicRLXkpf5PWeBH+tu+Tc=
X-Google-Smtp-Source: ABdhPJxyhgH9KudyJVtWBf4fd9QS9fcbZJGcLaUhQuK3jd8MtWe2xKTRl8Zn+MQZpSHoirTImcrkZA==
X-Received: by 2002:a17:906:1dc3:: with SMTP id v3mr14008199ejh.264.1643061317137;
        Mon, 24 Jan 2022 13:55:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g17sm3657665ejd.82.2022.01.24.13.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 13:55:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nC7Ix-002c1k-JY;
        Mon, 24 Jan 2022 22:55:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 14/16] reftable: make reftable_record a tagged union
Date:   Mon, 24 Jan 2022 22:54:29 +0100
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
 <047bbb75fcbb67c41d307bf5fa44587a76cc0777.1643051624.git.gitgitgadget@gmail.com>
 <220124.86ilu8hqag.gmgdl@evledraar.gmail.com>
 <CAFQ2z_M7s9Y_FH5x+qJxyZO0iHq+b_mf8=-dKcmADzFEoGLJUg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_M7s9Y_FH5x+qJxyZO0iHq+b_mf8=-dKcmADzFEoGLJUg@mail.gmail.com>
Message-ID: <220124.86a6fkhk8s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Han-Wen Nienhuys wrote:

> On Mon, Jan 24, 2022 at 8:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> I didn't test the v6 on xlc on AIX 7.1, but found that it refuses to
>> compile this code (but the one on AIX 7.2 is OK with it):
>>
>>     "reftable/generic.c", line 135.26: 1506-196 (S) Initialization betwe=
en types "char*" and "struct reftable_ref_record" is not allowed.
>>     "reftable/generic.c", line 147.26: 1506-196 (S) Initialization betwe=
en types "char*" and "struct reftable_log_record" is not allowed.
>>     "reftable/writer.c", line 261.26: 1506-196 (S) Initialization betwee=
n types "char*" and "struct reftable_ref_record" is not allowed.
>>     "reftable/writer.c", line 312.26: 1506-196 (S) Initialization betwee=
n types "char*" and "struct reftable_log_record" is not allowed.
>>     "reftable/writer.c", line 406.45: 1506-196 (S) Initialization betwee=
n types "unsigned long long" and "struct reftable_index_record" is not allo=
wed.
>>
>
>> I.e. you're dereferencing a struct type here to get at its first member,
>
> No, that's not what I'm doing.
>
>> > +   struct reftable_record rec =3D {
>> > +             .type =3D BLOCK_TYPE_REF,
>> > +             .u.ref =3D *ref,
>> > +     };
>
> reftable_record is tagged union, and u.ref is a reftable_ref_record. I
> intend to shallow-copying the parameter (a reftable_record called
> 'ref') into 'rec.u.ref' , precisely as it is written.
>
> Does this patch pass the unittests?

No, sorry about that. It fails. I didn't have time to run them earlier
(and it takes a while on that platform).

I don't know how to work around it then...
