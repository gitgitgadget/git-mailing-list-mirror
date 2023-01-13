Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE14C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 08:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjAMIeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 03:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbjAMIds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 03:33:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE56EC92
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 00:33:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vm8so50597009ejc.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=acWVDJt/piL2L06EmX46WDdpcumtnxtpmdaVf/rGbJg=;
        b=ntU+xO28H5q5KoF2qfm4NzS05ke6ub9azVRH9u1LLt0dIBcTeGI/8M87mx89W1MiUE
         Le2tSFb/1N0+9gjNq6HsRRqZ7WnRFlOBqhXc0Mu/dkMN1JtLGnSUy/6Be++wohkIqIf/
         knzKSaDlXI++2SZAYTNQYKGC9Oviiz7oOpHV1xYNVDKLZnOme4luxom8FVZViRvLi6oS
         XiGwwMmY8PjLfHs5ALtfhbzzIT7lAZUI1L8VfI2GgybcyhPMmANFzNjUMHTFBzlwnvEU
         oUcnpEohn6UfPTvF3eRu13IfSqaiGow0Uk534e2aQjEfcMJYArgWTyychKT2J2Fr3qjX
         Lt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acWVDJt/piL2L06EmX46WDdpcumtnxtpmdaVf/rGbJg=;
        b=R346HuGsNIEHlWB/kza6qj2+SDz5JbeEdBC4WUl0mvHFlw2O8CFpljgWexpc/Y37Vm
         jjxjAoYF9zLcDispJDV/X3rZ+9CdxaevGqAsgoflMkWJ7bZujS37amSJobdJ/6lmUw1e
         Zm5djpGx9IOzj4TTHaEFEPbBWzGOutr9+XAczqnZ5/lc0IA76Gpvhe+DdDkOgQiIwASG
         gZksjmSycDU71UzMYCUm+DW0HpK1xbjcLbrVvY+HImAmod9lfe1R4LnNdk2aV4ylivtf
         Mm+Um8R8EfzkpEOIzAJGI4lgTZMJc5lmzZomKASlm6xT0O5yQYGGMEXF81x5n06qXemE
         4RwA==
X-Gm-Message-State: AFqh2kr/Jkj/yQmsxKSpCH4taMM9Futz5+IRgb9gsnlSkGamjlPVBaXg
        Hap8Ugwot7sjUYXHMpWW1VQ=
X-Google-Smtp-Source: AMrXdXsju36y2rMwEOkx+QjUbVIogsuPXmAo+voRKJ4iVWBIdiu8H0sW19HyawrTvE+T4pf1ASBIqw==
X-Received: by 2002:a17:907:c088:b0:846:8c9a:68a1 with SMTP id st8-20020a170907c08800b008468c9a68a1mr63540374ejc.18.1673598796713;
        Fri, 13 Jan 2023 00:33:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0073d796a1043sm8156457eju.123.2023.01.13.00.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:33:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pGFUw-000Pu8-2Y;
        Fri, 13 Jan 2023 09:33:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git grep behave oddly with alternatives
Date:   Fri, 13 Jan 2023 09:28:59 +0100
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
 <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
 <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
Message-ID: <230113.86ilhazved.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Jeff King wrote:

> On Thu, Jan 12, 2023 at 06:13:13PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> > I'm not quite sure what you mean here by "non-greedy repetitions".
>> > Something like:
>> >
>> >   # prefer "foo bar" to "foo bar bar"; only matters for colorizing or
>> >   # --only-matching
>> >   git grep -E 'foo.*?bar'
>> >
>> > ? If so, then yeah, that changes the meaning of a bare "?" and people
>> > might be surprised by it.
>>=20
>> Right.  To be fair, question mark is a special character and you'd
>> probably need to quote it anyway if you want to match a literal
>> question mark.  Otherwise I get:
>>=20
>>    $ git grep -E 'foo.*?bar'
>>    fatal: command line, 'foo.*?bar': repetition-operator operand invalid
>
> This is on macOS, I assume? With glibc it seems to be quietly ignored:
>
>   $ git grep -E -o 'foo.*?ba' .clang-format
>   .clang-format:foo, bar, ba
>
> So it is not treated literally (as it would be without -E). But nor does
> it make the match non-greedy (otherwise it would have output "foo, ba",
> as "git grep -P" does).
>
> So it does seem like all bets are off for what people can and should
> expect here. Which isn't to say we should make things worse. I mostly
> wondered if REG_ENHANCED might take us closer to what glibc was doing by
> default, but it doesn't seem like it.

There's a couple of ways out of this that I don't see in this thread:

- Declare it not a problem: We have -G, -E and -P to map to BRE, ERE and
  PCRE. One view is to say the first two must match POSIX, another is
  tha whatever the platform thinks they should do is how they should
  act.

  Of course that makes git regex invocations "unportable", but it might
  be acceptable. People can always use PCRE if they want "portability".

- Just mandate PCRE for Mac OS, then map -E to -P. We could do this with
  the pcre2convert() API and PCRE2_CONVERT_POSIX_EXTENDED flag,
  i.e. PCRE's own "translate this to ERE".

  But Perl/PCRE syntax is already a superset of ERE syntax, minus things
  like (*VERB), (?: etc., which people are unlikely to write without
  intending to get the PCRE semantics.
