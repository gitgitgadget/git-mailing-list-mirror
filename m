Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B9C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07F361B98
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhKRAVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhKRAVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:21:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15570C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:18:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b15so18774721edd.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tXkvrwHFUE+b5x3YExziIsfsczZ5X/cN8yuwr5pdvSM=;
        b=JR6+ytKUwDF3Sr3BtMQYm2N1ezud841IqSfWDzk1hKqbjQOtFdMJHtb5rLfCHoLETD
         f7epUU6Xr7ONdKBezaDu4DLIxuood7LA7/ARWa58pwqWoEhwDw5JGjL/9T3qW/zZXnjl
         +fYM98XlNR4+ffcwtMRlAZqI76y020Az7hYpOSbHabB4aXx4Pj+5wmXtjRzCw9gTD/jD
         Jr/fH5nzYQiGH1atSSR7Vtyr7QGTyPi+SXZy9Yt5q5vSHkHS4tsgQazUetJTx62Fis15
         N0wn83Ik35N5wNt5m10P8QfxxOYaOgzwlEfACdlrsrjQPkdVp/M4ONBsQpTp7mwlzOlP
         3o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tXkvrwHFUE+b5x3YExziIsfsczZ5X/cN8yuwr5pdvSM=;
        b=izI3rYV4kDot2AjUEckk4ryKSeBibvNINB+lo6r+xH143au6jhuOvpF6Ivvy0EVkat
         G25WR2rdf2OuwBodp8KvtcxSAke953ETnAkSbGtyktlhMoZvheCzxFugoCSveikrC5IL
         W9874XohPR+UVYcgYhFG6s0HBI8EcaUSsYCtnXHUuaYFizzXyMRyYkIUaI6r6Btpg+Ra
         Vh+8m+ceguC7MB5y0ZnSeAfAPYfxop0xyB7Crj6qaOOogObPOXL6PNLxhiKVvCKQU+6Z
         6l1lc95DNLzYsaz+D/4egOjUbDsYtAf6WNdlJfZf6Dr+P9ZeGrZ//lLxYvS6ulsJYlQ/
         ksIA==
X-Gm-Message-State: AOAM530NtohbQ7G9mecgVB3a2qzEsqazFRKfgiwqkXz4OhmWDFYaWWET
        3rtbHg307uNvcoCcdTqVeuE=
X-Google-Smtp-Source: ABdhPJz7jdi+mzi2as2akPuApxqO7o4EARBXlOKriG8rUM4ii1o5rU7e6dzSLbnK4tg0Y8nZB2UzjA==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr4456980ede.28.1637194693507;
        Wed, 17 Nov 2021 16:18:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb28sm625551ejc.93.2021.11.17.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:18:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnV80-000Gkr-5u;
        Thu, 18 Nov 2021 01:18:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Thu, 18 Nov 2021 01:00:26 +0100
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <877dd9i1zj.fsf@igel.home> <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
 <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home>
 <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
 <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
 <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
 <CAPUEsph8NMJtK2r_fuT6UPsgmoPAeGVfTLOj8uz6NaOj4UZ1dg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPUEsph8NMJtK2r_fuT6UPsgmoPAeGVfTLOj8uz6NaOj4UZ1dg@mail.gmail.com>
Message-ID: <211118.86pmqy5naz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Carlo Arenas wrote:

> On Wed, Nov 17, 2021 at 1:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> PCRE2_UTF will also matter for literal patterns. Try to peel apart the
>> two bytes in "=C3=A9" and match them under -i with/without PCRE_UTF.
>
> Is there a real use case for why someone would do that? and how is
> that "literal" valid UTF to warrant setting PCRE2_UTF?

We don't check the validity of the input pattern as correct UTF-8 before
feeding it to PCRE. We don't even check if you're under a UTF-8 locale,
a call to is_utf8_locale() is one of the conditions we'll try (but check
how loose we are under NO_GETTEXT=3DY even then), but it's not a necessary
one.

So in practice we'll likely have users pasting say Big5, UTF-32, JIS
encoding or whatever into "git grep" and then grepping arbitrary binary
data.

I don't really have a specific use-case in mind. I'm just trying to
counter the apparent recurring misconception that's popped up more than
once in these recent threads that the UTF-8 *mode* is only something we
need to worry about if the pattern contains non-ASCII.

The implications of UTF-8 as a matching mode go much deeper than that in
Perl's and PCRE's regex engines, e.g. in this case what's considered a
character boundary.

> I would expect that someone including random bytes in the expression
> is really more interested in binary matching anyway and the use of -i
> with it probably should be an error.
>
> Indeed I suspect the fact that pcre2_compile lets it through might be
> a bug in PCRE2
>
> $ pcre2test
> PCRE2 version 10.39 2021-10-29
>   re> /\303/utf,caseless
> data> \303
>  0: \x{c3}
> data> =C3=A9
> No match

It's really not "random bytes".

We're not talking about someone doing a git grep where the argument is
fed from a "cat" of /dev/urandom. Just plain old boring natural language
encodings in common use can and will conflict with what's considered a
character boundary in UTF-8,

Anyway, I haven't had time to re-page this topic at large into my
wetware and really don't know what we should be doing exactly at this
point to move forward, except my previous suggestion to either revert
the recent changes, or at least to narrow them down so that we get the
old behavior for everything except the revision.c "git log" caller.

I think a really good next step aside from dealing with that immediate
problem would be to harden some of our test data in a way similar to
what we've got in t7816-grep-binary-pattern.sh, but for partial matches,
mixtures of valid/invalid/partial character patterns and subjects etc.

We might be able to lift some tests from existing test suites,
perl.git's t/re/re_tests and pcre2.git's RunGrepTest (And testdata/
directory) are probably good places to start looking.

We don't need to test e.g. PCRE itself independently, but it is worth
testing how whatever special-sauce we add on top (if and when to turn on
its flags based on heuristics) impacts things.

We've also got the problem that whatever code we write will target
multiple PCREv2 versions, which isn't something PCREv2 itself needs to
deal with.

