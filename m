Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37DDC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C8B23436
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbhAOJjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbhAOJjx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 04:39:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C655C0613D3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 01:39:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g1so8164876edu.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 01:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2agYPhsQWjV7rCygc9qpNrvIk+swaTbUWECMQwApKgo=;
        b=fuiuEmoy7gBSFGarRaw+YRGE+5AZCchqxWjV2tmF7TjkyNC1uGB402ENidpgpn0t0+
         xhK8+hGGOHEKmDjgHM4QHrG1igLAhuLu54TK1Jgq3+Owr9qK0JD9zjr76OCfv7I4nLhT
         pM0hyoZHIogxPf1nzQbYYBGXbyJiCA6YkZ15HAO8a5RT5EBN8q40Y5QIgCiDd+dLVH8S
         pmUiLBotqaBXSGG8Q8u/oPU7mF6JXWe/oq9Mc1C3bzBjkf+aVj6eL/tcuZSXzoKOZd4v
         FcoGWP2802mJQF5og/B10FduvBy4yN8IVi8BXXwZiIo351zyDAUk3IH2shNzVbwEsW92
         XZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2agYPhsQWjV7rCygc9qpNrvIk+swaTbUWECMQwApKgo=;
        b=syFk+YDTSevf3g/pxiZlo3J6E3vlIc03xmPLPeKoS7TXQW5Ffjy6e8y/JvWik3kDoH
         Vh0nC66duGlgnczHG4xxywWuBmBe/xOHEoHn9tBS2G0CGGfTiJoXvU9JVSXAGQxLNF/g
         GPnJGxKgGxUsk1DimP9FQ02mL2C1Ob1JeZHvXSHQWcf40jjx6QioJ/LjO80ZlQD9lqCD
         apTpr+MtRTfukJp0x8yGGJkFRSh0oSK9QjL5aAnFtvdX0koEwZq8GHxSPI4Wl6D8QQGp
         GuPCKamV+EU46WdfDESkHbaZAJEiwBe98TmlFhb7dpcdZ3wTn0cmTDwk/W1owM3cxNQ3
         MdJA==
X-Gm-Message-State: AOAM530oi2ISvyRcQdBw/HYCQo7Y5pSEeoV5mNXtwODTivftE8Mb54lk
        tm0vvgubh6qGeGjayhzFgQGKULrV1qR6AQ==
X-Google-Smtp-Source: ABdhPJzbqMVS7RN9Yex5yxoVusWXRdTQt9gir2GybgsOz9PgTWflEXvUS9fZ1W8iXFhCJ5Sr1glyhg==
X-Received: by 2002:a05:6402:1d9a:: with SMTP id dk26mr8901900edb.283.1610703559206;
        Fri, 15 Jan 2021 01:39:19 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id t15sm3334769eds.38.2021.01.15.01.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 01:39:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] test_lib: allow test_{must,might}_fail to accept
 non-git on "sigpipe"
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-4-avarab@gmail.com>
 <YAFPDJHH7ChvnVSD@generichostname>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <YAFPDJHH7ChvnVSD@generichostname>
Date:   Fri, 15 Jan 2021 10:39:17 +0100
Message-ID: <87o8hq4jzu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, Denton Liu wrote:

> Hi =C3=86var,
>
> First of all, thanks for reviving this series! I hope that Bash accepts
> your proposed patch because it would definitely be helpful.

*nod*

> On Fri, Jan 15, 2021 at 12:35:12AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As the documentation here notes you usually do not want to do:
>>=20
>>     test_might_fail grep ...
>>=20
>> But instead:
>>=20
>>     ! grep ...
>>=20
>> However, as a future commit will show it's handy to be able to do:
>>=20
>>     some | test_might_fail ok=3Dsigpipe grep | commands | here
>>=20
>> To allow "grep" to fail in the middle of a pipe, if we're in a mode
>> such as a "set -o pipefail" that knows how to accept check intra-pipe
>> failures.
>
> From what I can see, there presently aren't any other use cases here
> except for with grep. I propose writing a wrapper around
> grep, =C3=A0 la [0]:
>
> 	test_filter () {
> 		grep "$@" || :
> 	}
>
> This has two main advantanges: the first would be that we could avoid
> complicating the test_must_fail_acceptable() code. The second is that
> it would be much less of a mouthful to write and it would be more
> readable.
>
> Compare
>
> 	some | test_might_fail ok=3Dsigpipe grep | commands | here
>
> to
>
> 	some | test_filter | commands | here

I saw your original series/patch. including Junio's suggestion that
test_grep_return_success was a bit too verbose & the suggestion for
"test_filter".

I think the "test_might_fail" in this case is more readable, readable !=3D
short. I.e. imagine you haven't just been looking at this code & open
that test file. If it's using "test_{might,must}_fail ok=3D*" you're more
likely to immediately understand it since you've seen those functions in
lots of places before.

If not, then "test might fail ok=3Dsigpipe" is almost so self-documenting
that you don't need to look at the function.

Whereas a "test_filter" for me at least would prompt an immediate "hrm?
what's that?", followed by grepping it and the side-quest of reading the
source for that function we use in a grand total of <10 places.

Anyway, just my 0.02. I also think it makes conceptual sense to just
have a limited whitelist in "test_{might,must}_fail", since in this case
the reason we recommend against its use for non-git doesn't
apply. I.e. we're normally not in the business of testing the OS, but in
this case it's got the useful behavior of knowing how to handle the exit
code & signal special-case, so we might as well use it.


> [0]: https://lore.kernel.org/git/3f79d23b40c0586d0351f4d721097be4f7ba26b8=
.1573779465.git.liu.denton@gmail.com/
>
>> To test this in t0000-basic.sh we don't actually need to have
>> test_{might,must}_fail in the middle of a pipe, it'll just that it
>> accepts e.g. "grep" when we provide ok=3Dsigpipe.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

