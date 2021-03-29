Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3655C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCFA61938
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC2OGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC2OGl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 10:06:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D237C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:06:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bf3so14373101edb.6
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SmALv6NFxHNsEPTVICnVK4oVeFvNjeJ8c7K6eBmNIkw=;
        b=eoPqIe4Eez3iTpYu5TNJqIN+dzXgeUvXOyK0QmGUD3jaw1c3ccL4eY2co8wpc75jOT
         sipw30Pwtmpd37dAdDK/OvMjo6irW8IfkjNx1BGL+/A0ccgXoggiCeo2ITQujWeqdw7i
         FrWEC7WDzZs/wrvAE12Qkkf15VzgCa6SC8H+sfxyVqI0ghFYMkb32aLe2tRgdqSDjwmD
         YzND/d3980EG89gdpspVZp4Gc2KgX/NvymHiZA4qkbEotZzA2zPajBOjxn4TlscVGzgc
         D2IAO9ilt3GDFroYNW21dEw/h9r7zaQA9T+NCAxfD3rAhYYmYaxKbb/4OlDrPsxdD25T
         euxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SmALv6NFxHNsEPTVICnVK4oVeFvNjeJ8c7K6eBmNIkw=;
        b=KV1dpPH1DGMHZQ1lGHEVqqBf7Y02Ze79Fpn//+qDdG1LX1pKsCcmzWRikFTEJmW3x5
         YfY1MA9tE7VQdwpAd7js46QNPCd4eiFyEPiz2ODkgh4O/Mkbst3MqQQG95I1EryDIWbv
         XYcvR4zHqMCCvLz3AJmSuoXwC84bOa+txO8cqA+t3FPyn0TfTovU44C0zoFw/bk6jJtm
         uSiSaU+B9rcWnTDKJH38FaaItH2uYTF5TiFCvw0GS5rLa5ai3vy/krtpUDGoz1dKP/04
         dGGJByXeUjvkvY8vOwx7XdB4xOeEMW1/GUsK3AZkf2eaEGyUJXpl/m8Tu/1iap3sbyBf
         8aWQ==
X-Gm-Message-State: AOAM5322mFCrh6Mc8YeRRgfo/CzYRA2hj4MDM/323fA+VlR2Q+NLudgr
        iJc788JfOXSJ4QXJUjui/RI=
X-Google-Smtp-Source: ABdhPJyvMhrvJthuCPcxxrmSi9DIYdouRi5xSINra4TtuPpW5n1AlpU0jC7fN7qGhbPtZsTDrjgi/w==
X-Received: by 2002:a05:6402:3122:: with SMTP id dd2mr28347454edb.253.1617026799753;
        Mon, 29 Mar 2021 07:06:39 -0700 (PDT)
Received: from [192.168.1.240] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.gmail.com with ESMTPSA id a17sm8413505ejf.20.2021.03.29.07.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:06:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
 <71c34328-9814-2777-3a9d-f908602dd36f@kdbg.org>
 <87wntqm7dj.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7edaee06-2149-a547-4fa9-c91b241ff966@gmail.com>
Date:   Mon, 29 Mar 2021 15:06:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87wntqm7dj.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/2021 14:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 29 2021, Johannes Sixt wrote:
> 
>> Am 29.03.21 um 12:18 schrieb Phillip Wood:
>>> It would be nice to include indented define forms but including them
>>> means that any change to the body of a function is attributed to the
>>> last internal definition rather than the actual function. For example
>>>
>>> (define (f arg)
>>>    (define (g x)
>>>      (+ 1 x))
>>>
>>>    (some-func ...)
>>>    ;;any change here will have '(define (g x)' in the hunk header, not
>>> '(define (f arg)'
>>>
>>> I don't think this can be avoided as we rely on regexs rather than
>>> parsing the source so it is probably best to only match toplevel defines.
>>
>> There can be two rules, one that matches '(define-' that is indented,
>> and another one that matches all non-indented forms of definitions. If
>> that is what you mean.
> 
> Yes, but that doesn't help in these sorts of cases because what a rule
> like that really wants is some version of "don't match this line, but
> only if you can reasonably match this other rule".
> 
> We can only do rule precedence on a per-line basis via the inverted
> matches.
> 
> So for languages like cl/elisp/scheme and others where it's common to
> have nested function definitions (then -W would like the top-level) *OR*
> similarly looking nested function definitions, but the top-level isn't a
> function but a (setq) or whatever we're basically stuck with picking one
> or the other.

Exactly

> I've pondered how to get around this problem in my userdiff.c hacking
> without resorting to supporting some general-purpose Turing machine, and
> have so far come up with nothing.

I think using an indentation heuristic would probably work quite well 
for most languages - see 
https://public-inbox.org/git/20200923215859.102981-1-rtzoeller@rtzoeller.com/ 
for a discussion from last year (from memory there were some problems 
with the approach in those patches but I think there are some suggestion 
from Peff and me later in the thread on how they could be overcome)

Best Wishes

Phillip


> You can see lots of prior art by grepping Emacs's source code for
> beginning-of-defun, it solves this problem by exposing a Turing machine
> :)
> 
