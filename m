Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E4C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 09:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiLSJPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 04:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLSJPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 04:15:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252D2D8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:15:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id tz12so19883022ejc.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3wX0jumOuTvZY0Lq7SzJYaU7NZOCRDiLUwpopz6Qcw=;
        b=D+94x31a0gRe4Yc05tMmI2ftN0OGUY0JvIJ58DT+VRqjsDB2j1REOBzBNL1RMxItfX
         j8k12sJc4dCjeLI5ddhwConSFASFBNVlzDr/5JSQ+g0rHRAQaafy2l0euqPlkPTajexB
         +MlbiqxdF4U2yoTBhiSMBfB8yfGoG/XYL/m5d3voIJjNjiab9wphk30iplpauNfPE38d
         +He2PkavbFCPu50uwx0xgjKAWrhcBIUVKl9y+Zf+NX+K7IBAKLwMhojeiotijRtEQA1v
         cPJ3KhSiwYR0PHD+pdWZB6g9e7uJGs2XhGvSYOk4CQvryd+kiDelrU04/9qvjxu5XQT/
         CjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3wX0jumOuTvZY0Lq7SzJYaU7NZOCRDiLUwpopz6Qcw=;
        b=KPMY6gPkMsDyl9Q3wWDQJQnM1j5fyQfQFgmn8J2zSRZ6K+QUG7ZaIxXJiAsPz/Hde/
         EPkR7MscDCWsnAQwEdubIgbRnZ7YqFmaXYQizEmAEefPL9Jm99teoBEPbdsBDNX8JCyW
         hwsgn8Uf0k8BYrqpNZapWL4tIZaORtA0PmKOMoF/TLtQKXMQOgMhcE3+I8uHJRGa0JRQ
         qxTnX4x1JzuYtkE5KUshXWqaxBRd8EvaD6DBp+GdYjZJbrAixS6PcyUIJy6ZqLyDOq4c
         nKhW8NNZ6/QZLXp/mA1Fl0Cge1cSHO57m0jvNl04ndUCaqtfBx3LNvgbWFjC8fatxNo8
         txCg==
X-Gm-Message-State: ANoB5pnBx+JWYUkUp9Qz3ipner7so/8nR4/tpx8XAmEgf/mvbjfAgcP/
        66a9AgG0tqOQgd488Q5Lve0=
X-Google-Smtp-Source: AA0mqf59ldue3iF4yhpWDKln06CfDaaB3ehH6WKvCeLs6aUavpSzqMvEfBJ7e3NPy2ZGBQgSjUfGdA==
X-Received: by 2002:a17:907:1110:b0:7c0:fd1a:79ef with SMTP id qu16-20020a170907111000b007c0fd1a79efmr34065544ejb.48.1671441333575;
        Mon, 19 Dec 2022 01:15:33 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090611d600b0073022b796a7sm4141554eja.93.2022.12.19.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:15:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7CFA-006UF4-0t;
        Mon, 19 Dec 2022 10:15:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mathias Krause <minipli@grsecurity.net>, git@vger.kernel.org,
        pcre-dev@exim.org
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Date:   Mon, 19 Dec 2022 10:00:11 +0100
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
 <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
 <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
Message-ID: <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 16 2022, Carlo Arenas wrote:

[CC-ing pcre-dev@ for this "future error API" discussion]

> On Fri, Dec 16, 2022 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Mathias Krause <minipli@grsecurity.net> writes:
>>
>> > ... However, from a user's point of view a fall back to
>> > interpreter mode might still be desired in this case, as a failing
>> > 'git grep' is simply not acceptable, IMHO.
>>
>> "git grep" that silently produces a wrong result (by falling back
>> after a problem is detected) would not be acceptable, either.
>
> except that an error at this point only invalidates the use of JIT,
> so calling pcre2_jit_match() is invalid but calling pcre2_match() is not.
>
> the later is setup to be used later by the code that is added,

I think we could stumble ahead, but if this were to happen our
assumptions about how the API works have been invalidated.

The pcre2_jit_compile() doesn't promise to return a finite set of error
codes, but:

	[...]0 for success, or a negative error code otherwise[...]

But if new codes were added it's anyone's guess what state we'd be in,
so I think the safe thing is to BUG() out if we get as far as
pcre2_jit_compile() and don't get either PCRE2_ERROR_JIT_BADOPTION or
PCRE2_ERROR_NOMEMORY.

>> Receiving BADOPTION could be a sign that there is something wrong in
>> the input, not from the end-user but from the code, in which case
>> stopping with BUG() may be a more appropriate?
>
> The way PCRE handles this kind of errors internally is to instruct pcre2_match()
> to use the interpreter.
>
> While a BUG() might be a way to ensure the code is using the right set
> of options
> I would expect that the failure will be reported by pcre2_compile
> instead, with the
> only cases left, only being interna to PCRE (ex: JIT can't yet support
> a feature the
> interpreter has)

I agree that it's possible in general that an external library might
start returning a "benign" error code that we could recover from, so
BUG(...) would be overdoing it.

I just don't see that libpcre would do that in this case. In general the
JIT supports all patterns that the normal engine does, so if we're past
the "is it available?" hump it should work.

If it starts not doing that I'd think they'd do a major version upgrade,
or opt-in with a new flag etc.

Note that it already has a way of checking for "we tried to do the jit
thing, but it wasn't on in the end". See the code I added in
a25b9085043[1] (grep: fix segfault under -P + PCRE2 <=10.30 + (*NO_JIT),
2017-11-23), which comes right after the pcre2_jit_compile().

So not only would a BUG() biting us here require them to create a new
code for the state of "we have the JIT, but can't use it here" (for some
reason I can't imagine, as "PCRE2_ERROR_NOMEMORY" is already
"overloaded" to mean that).

It would also require them to invent a new "soft" failure mode for the
JIT, i.e. not the facility added in a25b9085043, where we can use the
JIT, but it's not on after all due to a "(*NO_JIT)" in the pattern
itself.

But I may be wrong, so I've CC'd pcre-dev@ to see if they have any
commentary on this proposed API paranoia. For them: The greater context
of this thread on the git ML is at [2].

1. https://github.com/git/git/commit/a25b9085043b8029169b4d5b172b78ca3f38fb37
2. https://lore.kernel.org/git/20221216121557.30714-1-minipli@grsecurity.net/
