Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A3CC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBA8610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhDITpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhDITpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 15:45:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC98C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 12:44:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so10454874ejr.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UgEnZCsp95GPt/2WriCULq6lrMqb7R7i5PoWndLMJDQ=;
        b=NDY0uCXHJ+zQA3xXXk9jXaA6tZbYI/BFiOWKRAmDLJWxY1FC6UgSWK7k2Gq+p2j/l9
         9hcV/NC828ccgbsrQ2fSHp0JZ92l9Q3arZWR7vJOtSRkPTtC55M28fVgUUKrFvxay/zF
         s57FZL3QADua6IE4QtbfClq+z9CbcI3yNOg4OR+c/jXza1cu1x8xHu+l4owj4oMBIVKM
         y3RnPTel6A5U40Ets816riMFaSPFaz8/+QCHdAzQvhy0BFhEdF13WV4njdlIIWp15Qfe
         cukF5w//5kXaxkX5z8XEdE/9g5KdnEGW8R4NLNaQfjQ120XKdJvyPcLsbrxzOB+XZ4Fr
         W4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=UgEnZCsp95GPt/2WriCULq6lrMqb7R7i5PoWndLMJDQ=;
        b=Xq72FIvT/WevNxbzIhfsfL+468K5+V1kFXBlQCFKBuzcqFm8TGaW4v8ZzWIWZdLQCn
         kn6M3+dHxdL4L0jSfII3lI2horszYFPITqCCmFwkVfehIncJo+8uNKu+sBbk3tFWVgFU
         nR6csIgNh1D+B9FF8mjH5VAlPi9m641RUkr3utTDWPoQ124RsMBb3yRboc4W7RXiU70p
         Xt3JXAoM/X+aKxKP2JapBSWvg8KVWdsX3FYr9kjqVXJZTOFhAEdF33iHA1N3uWj2e9Rh
         USRozAvAKKpsEE5mNSKXQz8DzJYjoqrHOze/tJYfzZpzF5hS3C0fUwDDoEgpD+xel7ed
         c1uQ==
X-Gm-Message-State: AOAM53038ec23DA8Xh611igCBLPtREerQKjG3TjhYSNE+g/EuvDLK9Ce
        LrMgrFZ8HpHoDsgJFfgSG8Y0THu5rPIcGQ==
X-Google-Smtp-Source: ABdhPJxEHKbARIP0nOV5ulDRjrc8KQ4vuvFLWBvvS2hjfGcp7znQV1VOfs6zUijAFlSRVjFMMigmBQ==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr17691961ejz.318.1617997498255;
        Fri, 09 Apr 2021 12:44:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s17sm1665953ejx.10.2021.04.09.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:44:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
 <87im5gp2ze.fsf@evledraar.gmail.com>
 <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
 <87czvoowg2.fsf@evledraar.gmail.com>
 <YF1UuNBrAWvHSCp1@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YF1UuNBrAWvHSCp1@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 21:44:57 +0200
Message-ID: <87czv3gs3q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, Jeff King wrote:

> On Thu, Mar 25, 2021 at 02:26:21AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >>     We could add a ifuncname and xifuncname or whatever for it I gues=
s,
>> >>     but currently the ICASE behavior in the C code is magic.
>> >
>> > Good point. IMHO that is something we should consider fixing
>> > independently. It was a mistake to add builtins that couldn't be
>> > replicated via the config (though I notice it happened quite a while
>> > ago, and nobody seems to have cared, so perhaps it isn't that
>> > important).
>>=20
>> I'm conspiring to eventually optimistically replace these ERE patterns
>> with PCRE if we build with that at some point.
>>=20
>> Then you could just prefix your pattern with (?i) here in this and other
>> things that want icase...
>
> I really like PCRE myself, but is it portable/common enough for us to
> start using it for baked-in funcname patterns? I sort of assumed there
> were exotic platforms where libpcre wouldn't build (or at least it would
> be inconvenient or uncommon to have it). And it would be nice to degrade
> those gracefully (or at least better than "I guess you don't get any
> builtin funcnames. Tough luck").

I think it's as portable as git, the JIT backend isn't, but PCRE itself
is portably C code, and e.g. everything that python, PHP and any other
number of things that depend on PCRE has had PCRE ported to it.

That plan involves an "git rm -r compat/regex" and a compat/pcre
instead, I have some long-left-over patches for that.
