Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56490C433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18263619B7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 10:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhC3KXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhC3KW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC8C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 03:22:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7432217pjv.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O5cyMC2OgOgVvuu7akCFbd9r4+FSO7elDeBJQvpz5kA=;
        b=rFFJmCysMaprYaP83fLtyBbLur6wgdcJbBcc11O1GA7DQ8Xc497hR+yZCxMyxmHVBw
         GUi72VvsHHpjIVzeSC4p2nQLu5A0PddNxyr292UmAEhx6qKkFZ/IxNwSFFoPnfcecP5P
         QfrgVj78Xoshb4Ws1Obe61QUMHTe+tt82TooErJEnUzD8iQqzBgJLLUEVHfBuZNLb1GJ
         BUHVsJMtCxhv8jhzbnjwOdDvxSCAs4PgrCzICz+oA/VOlPWXZrYhRWL+rvzQFZBkiFrA
         1lwIRQ2u7N2SyQh1aN4tJsbsGikEFuDhnlaR80IHpGNdHnPL8/ys7behSeZ/2L+C7z2p
         KJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O5cyMC2OgOgVvuu7akCFbd9r4+FSO7elDeBJQvpz5kA=;
        b=BRV4liELIiHbgutQe1o0vOmz7z4LKBAp8dFT5zbXCAMgGxJWmPD3otlKAMerPCBJ7a
         /IT8Ei217zWFwY64uLpBXjWKnqC7Ss2G09cMX+aSxWXY3ItNbl7RkNnqbAKXqXThj/tN
         fVOWhdV9i5ljD7Qoib+HeLblz14y5roGsWOhoMKyhqLbFxHXLKbmj3BdSn60l7CQRYl3
         yaarBz0xDd1Yx3edDgDOkDvL0jw5/YjtRJPyNmaEo6y0gxaE0w/98HsRDp9XfyzRLfes
         1PYRe59V5pDYa6WC2yQIFa3n2PuwvR1AD/GIekPG8Eh/2+G8VSDyESZULa9jTxhKlHRV
         /QpQ==
X-Gm-Message-State: AOAM531B9GW8YvjxieOFo7ou/9/q4t6ekBNaquE4biAc24s4yjK18oiQ
        AhK+YDbNprZTd+3Atxuheck=
X-Google-Smtp-Source: ABdhPJzdFuAa5uaw2jB0yEOkLxB5d8QVzmpAZ2I9xsz0nWmIHHzno0h9Rkj5gku6z3dqZk0zayGSqQ==
X-Received: by 2002:a17:90a:6906:: with SMTP id r6mr3635100pjj.235.1617099774894;
        Tue, 30 Mar 2021 03:22:54 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id m16sm18416185pgj.26.2021.03.30.03.22.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:22:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <D8256AFA-898E-4388-8FCC-7D3D340C001E@gmail.com>
Date:   Tue, 30 Mar 2021 15:52:51 +0530
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3C3DD12-3C00-49ED-B427-37AAB4211C2A@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
 <D8256AFA-898E-4388-8FCC-7D3D340C001E@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 30-Mar-2021, at 12:34, Atharva Raykar <raykar.ath@gmail.com> wrote:
>=20
>=20
>=20
>> On 29-Mar-2021, at 15:48, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>>=20
>> Hi Atharva
>>=20
>> On 28/03/2021 13:23, Atharva Raykar wrote:
>>> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
>>> [...]
>>>>> diff --git a/t/t4018/scheme-local-define =
b/t/t4018/scheme-local-define
>>>>> new file mode 100644
>>>>> index 0000000000..90e75dcce8
>>>>> --- /dev/null
>>>>> +++ b/t/t4018/scheme-local-define
>>>>> @@ -0,0 +1,4 @@
>>>>> +(define (higher-order)
>>>>> +  (define local-function RIGHT
>>>>=20
>>>> ... this one, which is also indented and *is* marked as RIGHT.
>>> In this test case, I was explicitly testing for an indented =
'(define'
>>> whereas in the former, I was testing for the top-level =
'(define-syntax',
>>> which happened to have an internal define (which will inevitably =
show up
>>> in a lot of scheme code).
>>=20
>> It would be nice to include indented define forms but including them =
means that any change to the body of a function is attributed to the =
last internal definition rather than the actual function. For example
>>=20
>> (define (f arg)
>> (define (g x)
>>   (+ 1 x))
>>=20
>> (some-func ...)
>> ;;any change here will have '(define (g x)' in the hunk header, not =
'(define (f arg)'
>=20
> The reason I went for this over the top level forms, is because
> I felt it was useful to see the nearest definition for internal
> functions that often have a lot of the actual business logic of
> the program (at least a lot of SICP seems to follow this pattern).
> The disadvantage is as you said, it might also catch trivial inner
> functions and the developer might lose context.

Never mind this message, I had misunderstood the problem you were trying =
to
demonstrate. I wholeheartedly agree with what you are trying to say, and
the indentation heuristic discussed does look interesting. I shall have =
a
glance at the RFC you linked in the other reply.

> The disadvantage is as you said, it might also catch trivial inner
> functions and the developer might lose context.

Feel free to disregard me misquoting you here. You did not say that (:

> Another problem is it may match more trivial bindings, like:
>=20
> (define (some-func things)
>  ...
>  (define items '(eggs
>                  ham
>                  peanut-butter))
>  ...)
>=20
> What I have noticed *anecdotally* is that this is not common enough
> to be too much of a problem, and local define bindings seem to be more
> favoured in Racket than other Schemes, that use 'let' more often.
>=20
>> I don't think this can be avoided as we rely on regexs rather than =
parsing the source so it is probably best to only match toplevel =
defines.
>=20
> The other issue with only matching top level defines is that a
> lot of scheme programs are library definitions, something like
>=20
> (library
>    (foo bar)
>  (export ...)
>  (define ...)
>  (define ...)
>  ;; and a bunch of other definitions...
> )
>=20
> Only matching top level defines will completely ignore matching all
> the definitions in these files.

That said, I still stand by the fact that only catching top level =
defines
will lead to a lot of definitions being ignored. Maybe the occasional
mismatch may be worth the gain in the number of function contexts being
detected?


