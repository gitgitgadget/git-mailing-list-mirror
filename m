Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A6C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9541B6193A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhC2NMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhC2NMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:12:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D660C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:12:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h13so14153720eds.5
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zQR1HZDNJI6XXeyRhE7TiGU6VCNHpkab8yD3Q8WYCpg=;
        b=LyBtWD0JsL6vFhFwtL3Ncu0KyD44UPGaFSd0+9gntvFU37cTZojD6P66/sQJ+XpaSv
         IMMnFqHMdc6ksJBA1U2pNwb262yk1GKBUthh0g5rHIj1n/bjTnVplCasz4d9nSElWPKt
         Rp6JQApMfnE1JfhIY/U1XbwQ0rs6zhidiU+Yi0d0hTSGn50L2SrxZ6Df+JpYA70ty/LH
         m25HWt4Cf0LekMu9pESv62VegMK+e/p+Hq+BKOYz7hmLz3cgHvpgj3gg9/dEj0tbrcWs
         sPIUNVXzXsIm18HzfQtD2gSLh9HdTmYM58gXsd3Eq7NCTR6OE9UnLOSe89SKueP2KcOC
         e4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zQR1HZDNJI6XXeyRhE7TiGU6VCNHpkab8yD3Q8WYCpg=;
        b=FBmpsV6NxmUpcSC/3cR0TTjgmjn2ZYy6iFcOmxm7Ea6CSEKz8HjvgXcjclwiO0IbC2
         8Yc2uB9BlT9W+Op5FW9aei2XdO6uwepiSeZjTWVViZhlLiWYXBp0ETLu2zTn7Gt5VoC0
         bKMGqqm1Q6LH0k3Xdus8v7v5tW96X/sru2H6Adai4hFN+S0+SXjOB2xmULfo9674BAfk
         wtriN2s2xaMCIjbJBMS4P+tAaolRSHzXWpO/bLicsnd5OmlW5+lsixfJVrq69ysO7Jyr
         t4uqCfbYz2hbwP22pEDEfBctbnqmGRinUyYk9WruTLPF/sznPweoEkKYLN57X2XXn3To
         HnQg==
X-Gm-Message-State: AOAM532VReX1HHhQasX+pHDAfM1PHn74/K5KyZ4EhqJXhLYIfNs5hj1J
        IL+C0tvyuZb3fG04NHB1CK8=
X-Google-Smtp-Source: ABdhPJwKh/JbgoyjZ12vXf7KPkv1ovau6qTKhW1ba7RDWBgK54JKUJ2iAGfJjDnVm5GS/3ypmWVjEA==
X-Received: by 2002:aa7:c1d0:: with SMTP id d16mr28053902edp.153.1617023529193;
        Mon, 29 Mar 2021 06:12:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p19sm9140236edr.57.2021.03.29.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:12:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
 <71c34328-9814-2777-3a9d-f908602dd36f@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <71c34328-9814-2777-3a9d-f908602dd36f@kdbg.org>
Date:   Mon, 29 Mar 2021 15:12:08 +0200
Message-ID: <87wntqm7dj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Johannes Sixt wrote:

> Am 29.03.21 um 12:18 schrieb Phillip Wood:
>> It would be nice to include indented define forms but including them
>> means that any change to the body of a function is attributed to the
>> last internal definition rather than the actual function. For example
>> 
>> (define (f arg)
>>   (define (g x)
>>     (+ 1 x))
>> 
>>   (some-func ...)
>>   ;;any change here will have '(define (g x)' in the hunk header, not
>> '(define (f arg)'
>> 
>> I don't think this can be avoided as we rely on regexs rather than
>> parsing the source so it is probably best to only match toplevel defines.
>
> There can be two rules, one that matches '(define-' that is indented,
> and another one that matches all non-indented forms of definitions. If
> that is what you mean.

Yes, but that doesn't help in these sorts of cases because what a rule
like that really wants is some version of "don't match this line, but
only if you can reasonably match this other rule".

We can only do rule precedence on a per-line basis via the inverted
matches.

So for languages like cl/elisp/scheme and others where it's common to
have nested function definitions (then -W would like the top-level) *OR*
similarly looking nested function definitions, but the top-level isn't a
function but a (setq) or whatever we're basically stuck with picking one
or the other.

I've pondered how to get around this problem in my userdiff.c hacking
without resorting to supporting some general-purpose Turing machine, and
have so far come up with nothing.

You can see lots of prior art by grepping Emacs's source code for
beginning-of-defun, it solves this problem by exposing a Turing machine
:)
