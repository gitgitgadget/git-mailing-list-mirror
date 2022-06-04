Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39BCC433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 16:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbiFDQXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiFDQW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 12:22:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A2107
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 09:22:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so21253876ejj.10
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=11F6gQUhp1kKIDEfmZlpR183dfwS1D/ACFByfcMV0oM=;
        b=UuszWYkZMreMDzgl32KOzY5VZj66JIw966hPnKk46aYDhmq1dIO5Fa5uyn/iAWAHQK
         Q/qnG3m6U3SyZusE0EMtKSqUaz+P5X9eEtvfuJd9YWGY4X1t2EjhpGFAxZibsw0+umnY
         vwlH6U/j7Ju6MsXN6Xk1dlqyWYKM8xxzqZ3S7Do+CXNBTIumJAUHuFvh629JtnNaRTFc
         ESzFgy548Q++NAg6xWcJt92aCsq/BuFLVQE0bAIrXh6UZxnOFe9WQPW+RFL9t8znnsET
         pzxdu4b0oKG9sp0A7t8KIMKIuQdjbYJfiDZLD5qxbk5lpOoPQQjumzzS4zyQx2fRUNUY
         E38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=11F6gQUhp1kKIDEfmZlpR183dfwS1D/ACFByfcMV0oM=;
        b=dt9l2CWzYmkXz6A6uFYKj1rl8baJYOCTn3AlRSVWOcb7Al6K4Ac3jmRc7HG0EIJcHN
         5LZv116gN4Qhiuw+3tLUbZzZ5aGBrdo9jGT50LcQIjpsydrSBEQ6VNjdEhLhjnEx4BbT
         lFYAZ5B/g6lUwfcew/n8cgOi2KuQU31vJzRdM5shR6hQp7YoNlJsgKfH8YQ805m+RD7J
         e3q0lufqoka3K92yVLXsySUcRYtHAvVRuYBCeL2aHMrnVU/Jrn3CnTKZDlO7eQT9StXl
         PVtGj4JVevy381qtwnv0kvuVYfOCYPrf5oGdhulBdFUSh4GnzTGJPFvfRgXHsj4o7pw8
         gVLQ==
X-Gm-Message-State: AOAM5328XU1UbsM0Xa/kJK5bwDcl7LYmMXtr3nJiNPadUfFaloXq9q4h
        /NRaCsrqhY+f5ZO6MqzYJ20=
X-Google-Smtp-Source: ABdhPJxe1XzPPEwwKT5MK3LRxomdigooM9+fz01+ConZhYtO5EQuqnB/J2yosKgNkvUmwJuNzsx0ig==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr13797410ejc.653.1654359776793;
        Sat, 04 Jun 2022 09:22:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7dc4f000000b0042defe37a42sm5518055edu.16.2022.06.04.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 09:22:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxWYB-00203s-0g;
        Sat, 04 Jun 2022 18:22:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 07/15] strbuf.c: placate -fanalyzer in strbuf_grow()
Date:   Sat, 04 Jun 2022 18:21:53 +0200
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
 <870925774.539833.1654346793623@apps.talktalk.co.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <870925774.539833.1654346793623@apps.talktalk.co.uk>
Message-ID: <220604.86czfowg81.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 04 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> [This is an old address that I only have webmail access to, please use
> phillip.wood@dunelm.org.uk when cc'ing me]

Hrm, I just grabbed it from an old commit of yours I found. Consider
sending in a patch to update .mailmap :)

>> On 03 June 2022 at 19:37 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>>=20
>>=20
>> Change the strbuf_grow() function so that GCC v12's -fanalyze doesn't
>> yell at us about sb->buf[0] dereferencing NULL, this also makes this
>> code easier to follow.
>>=20
>> This BUG() should be unreachable since the state of our "sb->buf" and
>> "sb->alloc" goes hand-in-hand, but -fanalyzer isn't smart enough to
>> know that, and adding the BUG() also makes it clearer to human readers
>> that that's what happens here.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  strbuf.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/strbuf.c b/strbuf.c
>> index dd9eb85527a..61c4630aeeb 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -97,6 +97,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>>  	if (new_buf)
>>  		sb->buf =3D NULL;
>>  	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>> +	if (new_buf && !sb->buf)
>> +		BUG("for a new buffer ALLOC_GROW() should always do work!");
>
> This is a bit ugly, have you tried adding
> __attribute__((malloc (free), returns_nonnull))
> to xmalloc() and xrealloc() ?
>

Will try to experiment with that, perhaps GCC can be massaged to grok
this somehow.

I do vaguely remember (but couldn't track down where it was) that we
have some config for coverity for this function, due to it also having
trouble with it.
