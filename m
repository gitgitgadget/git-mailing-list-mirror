Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99221C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4864E6B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBQB1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 20:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBQB1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 20:27:46 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D0C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 17:27:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n13so13036702ejx.12
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 17:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yN/RzrkBv4AReQdLLWjUs7toxa/CHiUAp115ByNsjvI=;
        b=bSNHMm4KBbzzFjlqTAuaCB08ydgFH0qyp/HpIIxIo2dT6ZiMeBtsmpyXbwKk2pKcCx
         S+erWzQEUX2p5c8uxsLII84tZJQedcfC9R5VqzURdapKDn8z8RKaoJ8zaVkoCoqTlpG9
         GFUV5/NyEiv0dxqh1HjBgs+q3N7nCqHTRjvw/wLmSBzzBJSGQgXan2ball8ez+0y8ukw
         nwOjKZ5u0ruUnn+Ja554RfyPXTbgft4M6Qwr65+t0E5t4OUav8qDOpXfkpkvtySRfwmq
         xe8nGAUBkfX7OXscePlLg+3USn8xnh+ki9yNEcgDl1dxKg3C5PDrQrGSpJCXP82S7lgW
         mvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yN/RzrkBv4AReQdLLWjUs7toxa/CHiUAp115ByNsjvI=;
        b=jdaSpN3m8zONw97AzhGY5u8YnGA2g5KwH5fXBsKVbRRyY7QHC2ATBAgRMiaGUCXHb/
         Mzai5pRaIME1/uSDhO33nuKL+iVtd4ir+sFgXBl5xzmBA6pd1mGrTCa0YQxLLc9pZ9s3
         UcEq0Y2hJF/j0hbPlL4glJ1tpvz/PHUNIcvBNhBft7uZVLSR8i/Gc9f8A5DICq0myj/2
         XHA+Bes4jQX7Rn9IqWGd7bFJxLo2XWy01BGjV0+a2qHMzzgi2fmE9s152UdrAyiQ0Njm
         mLVNlc+wdkBlGLWWhr9xIG5zGjdw/LXgssCoLZ5tIz6+Clt0nGNSMXZqWjf5sluhjEI+
         o5Vg==
X-Gm-Message-State: AOAM531M0ZUXyXSqx2TPWDFzUB7/aio3VuR9pf7fPgnMPzzYXTCQ2eJF
        1WtiNx7eWB4F+P+a431TazoW0pt7yiqwbg==
X-Google-Smtp-Source: ABdhPJxGGx2EqV2NuKw3U1wto8/1Jb/gPByKhOipTCAqKrVFIs3XQrTBi6dhxwIzDe2SkT/6AJ8ewA==
X-Received: by 2002:a17:906:5fd5:: with SMTP id k21mr14843099ejv.13.1613525225167;
        Tue, 16 Feb 2021 17:27:05 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ha21sm271908ejb.97.2021.02.16.17.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 17:27:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-10-avarab@gmail.com>
        <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
        <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
        <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
Date:   Wed, 17 Feb 2021 02:27:04 +0100
Message-ID: <87h7mba3h3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 16 2021, Johannes Sixt wrote:

> Am 16.02.21 um 19:32 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>>>>    t/t4018-diff-funcname.sh                      |  7 +++---
>>>>    t/t4018/README                                | 22 +++++++++----------
>>>>    t/t4018/README.ctx                            |  1 +
>>>>    t/t4018/bash-arithmetic-function.ctx          |  1 +
>>>>    t/t4018/bash-bashism-style-compact.ctx        |  1 +
>>>>    [...and so on...]
>>>
>>> This is what I meant by "without burdening test writers with lots of
>>> subtleties".
>>>
>>> I'm not a friend of this change :-(
>>>
>>> I think you are going overboard with required test precision. To have
>>> useful tests for userdiff patterns that demonstrate its features,
>>> authors should write *many* tests. The right balance should be on the
>>> coverage of userdiff pattern features, not on the subtle details of
>>> each and everyone of it. Requiring that many additional context files
>>> makes it *really hard* to comply.
>> Yeah, the first time I saw the t4018 test framework appeared in my
>> tree, I truly appreciated its simplicity, how the test input file is
>> self-documenting and self-contained, with the clever use of "RIGHT",
>> "broken" and "ChangeMe" magic tokens, admired the cleverness of the
>> approach, and wished I was clever enough to invent that pattern to
>> apply to other tests myself.
>> A little new for each and every test for the miniscule gain of
>> checking which part of the function header line is extracted feels a
>> bit too much noise and rubs my sense of aesthetics, spoiled by the
>> existing t4018 tests, the wrong way.
>> This is a rough sketch of a different approach aiming for the same.
>> I converted only a few files, but I hope that this is enough to
>> illustrate the idea.
>>   t/t4018-diff-funcname.sh         | 17 ++++++++++++++---
>>   t/t4018/README                   |  9 ++++++---
>>   t/t4018/bash-arithmetic-function |  3 +++
>>   3 files changed, 23 insertions(+), 6 deletions(-)
>> diff --git c/t/t4018-diff-funcname.sh w/t/t4018-diff-funcname.sh
>> index 9675bc17db..dd79c99fc5 100755
>> --- c/t/t4018-diff-funcname.sh
>> +++ w/t/t4018-diff-funcname.sh
>> @@ -107,10 +107,21 @@ do
>>   	else
>>   		result=success
>>   	fi
>> -	test_expect_$result "hunk header: $i" "
>> +
>> +	test_expect_$result "hunk header: $i" '
>> +		HEAD=$(sed -n \
>> +			-e "s/^.*HEADER.*|\(.*\)right\(.*\)|.*/ \1RIGHT\2/p" "$i") &&
>> +
>>   		git diff -U1 $i >actual &&
>> -		grep '@@ .* @@.*RIGHT' actual
>> -	"
>> +
>> +		sed -ne "s/^@@[^@]*@@//p" actual |
>> +		if test -n "$HEAD"
>> +		then
>> +			grep -F "$HEAD"
>> +		else
>> +			grep "^.*RIGHT"
>> +		fi
>> +	'
>>   done
>>     test_done
>
>> diff --git c/t/t4018/bash-arithmetic-function w/t/t4018/bash-arithmetic-function
>> index c0b276cb50..935f18d96d 100644
>> --- c/t/t4018/bash-arithmetic-function
>> +++ w/t/t4018/bash-arithmetic-function
>> @@ -2,3 +2,6 @@ RIGHT() ((
>>         ChangeMe = "$x" + "$y"
>>   ))
>> +
>> +
>> +# HEADER |right()|
>> 
>
> Clever! Opt-in for those who desire precise tests.

Tests aren't only for testing a subjective "good enough" in the
estimation of the author of the code in question, but also for others
who later touch the same area and want to avoid regressions.

Which is why I think it's an anti-pattern to use "grep SOME-SUBSTR" in
lieu of test_cmp if we can easily do the latter.

So e.g. in this case part of my motivation is that this is one of the
things I want to look at porting to some general PCREv2 powered backend
regex matching library once some of the pickaxe work I have pending
lands.

I'm very interested in whether such a port subtly breaks existing
semantics, and it's not useful if such regressions are hidden because
someone who wrote a userdiff rule didn't think they needed to care about
exact matching for their own purposes.

I find this notion that patch authors who we'd expect to hack userdiff.c
and somehow understand the arcane rules of the list form of
diff.<func>.xfunction (which wasn't even documented until this series),
and to carefully read t/t4018/README to see how their test is parsed,
would be discouraged by some pretty plain shell syntax to pass in two
strings to be implausible.

Whenever I've tried to hack up userdiff.c rules my first stumbling block
has been that if you fail the previous test gave you no output, because
it used grep instead of test_cmp.

So you'd need to monkeypatch it to dump the value, or know about "-d"
and trash directory inspection. So much for sparing prospective authors
from the intricacies of our sh-based tests.

The old test format also forces you to try to mix real examples of a
programming language with our need to shove an all-caps "RIGHT"
identifier somewhere on the hunk line.

In languages like Go, Perl or Elisp such an identifier is somewhere
between so strongly discouraged that you'd never see one in the wild, or
in others even a syntax error.

It seems much simpler to just ask the author to paste in their snippet,
test it, and then then paste what they got on the @@ line as another
parameter to their test.
