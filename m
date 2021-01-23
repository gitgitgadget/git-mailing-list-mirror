Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574CC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684DD23A3A
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 09:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAWJlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 04:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbhAWJli (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 04:41:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE98C061793
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 01:40:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g24so9295957edw.9
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ykblYB8lNl5BJr2OnjQpFYXnxnxexWHvLD5pcwIv5V8=;
        b=qiqcEPKJj2DfxWnh7Mjy9ZXObKQYVmr8i9mHdS8tbWxexpRqCuCNhuS694PvQwZDrI
         4of7loWDmPWoBjeM3GscUYt+8DVBGQzEnrKQfPI4Ks4v42ez7hvxLWVPTW6gCT1fphaR
         xMLspHl2eEtdfh6xk8/HYFDLJbCUVZ49xgPBBpLx2rI39gKBK0Fe+EiF3SY4pBVQJO8O
         xIsfuIly9LwDyLjx1h5JpLUCl1i9xT0nWjfP30GTOMEjrPbegpdpFlLkAHsncGQjj/Y5
         GEAb7vkU6mDN6ocXhPH95qSgHDuFJi1WPba8bedanFoDZOTiisHq29yR3Rsubs+ejqUY
         N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ykblYB8lNl5BJr2OnjQpFYXnxnxexWHvLD5pcwIv5V8=;
        b=twHj6xN/OW/ChWgE8Webvrr5RekuU7X2psJw+OgTZeWEkOHT8o+jjVsEni3qoZcGbn
         InS+5/wODVRx0HVERW1GkkZoJJn4DHjQZYTEP6D+/iyuJoxipaeHrUqHUoTLeS7PFT9Q
         2ZsWAfVcHb+/h4xKvBSH8WKHPwkJH/RBQ1vj3h9TOe7pKsgcuQNSfgxj75MTsKvGkvKL
         lulb9I62WHwyWyW+JxDyS8jX/oY6ClFZSHHdMfwLShkJGol5ucD4UB53vk6N+wgu2mjv
         9XWCwP5q6ro8EkOvuHhKWLBCUL/rJCv6afrCm4aThm2RHJjXSdERt/15KvgfhVgvqEYI
         1lDA==
X-Gm-Message-State: AOAM533pR+0dqKz4DFT+A/ukcvTdHAWWDXcxpZDqi7TMR4llcxpbC+el
        lSnM1kasuHwcyYiWiyXfd2I=
X-Google-Smtp-Source: ABdhPJy6+aT6AHLARvQDC1NlN2GE52Uys1ss7DpH0j87Rjq9VW0s5jZcpjqyEpV3SjzBtLGesMKdZQ==
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr6315603edd.62.1611394837481;
        Sat, 23 Jan 2021 01:40:37 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id g10sm5675005ejp.37.2021.01.23.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 01:40:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] tests: add a "set -o pipefail" for a patched bash
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-12-avarab@gmail.com>
 <xmqq5z3o5n8c.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <xmqq5z3o5n8c.fsf@gitster.c.googlers.com>
Date:   Sat, 23 Jan 2021 10:40:36 +0100
Message-ID: <87pn1w6lez.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 23 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
>> +test_expect_success !MINGW,!BASH_SET_O_PIPEFAIL 'a constipated git dies=
 with SIGPIPE' '
>>  	OUT=3D$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
>>  	test_match_signal 13 "$OUT"
>>  '
>>=20=20
>> -test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if=
 parent ignores it' '
>> +test_expect_success !MINGW,!BASH_SET_O_PIPEFAIL 'a constipated git dies=
 with SIGPIPE even if parent ignores it' '
>>  	OUT=3D$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
>>  	test_match_signal 13 "$OUT"
>>  '
>
> The above have already !MINGW
>
>> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
>> index 4f7e62d05c..7b5d92add5 100755
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -251,7 +251,10 @@ test_expect_success 'choking "git rm" should not le=
t it die with cruft' '
>>  		i=3D$(( $i + 1 ))
>>  	done | git update-index --index-info &&
>>  	OUT=3D$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3=
>&1 ) &&
>> -	test_match_signal 13 "$OUT" &&
>> +	if ! test_have_prereq BASH_SET_O_PIPEFAIL
>> +	then
>> +		test_match_signal 13 "$OUT"
>> +	fi &&
>>  	test_path_is_missing .git/index.lock
>>  '
>
> but this one does not.  Yet, we've been using test_match_signal on 13
> without issues, it appears.
>
> And somehow with the lazy prereq on SET_O_PIPEFAIL, this part starts
> to break, like so:
>
>   https://github.com/git/git/runs/1752687552?check_suite_focus=3Dtrue#ste=
p:7:37042
>
> The output captured in OUT is 0 as we can see on #37032 in the test
> log.
>
> I am tempted to eject 11/11 and probably 10/11 out of the topic, as
> the earlier patches before them look more or less uncontroversial
> cleanups, and 11/11 seems to be more trouble than it is worth at
> this moment.

I think that makes sense, once I fix the breakage on 07/11 you noted
downthread.

> It's not like this would allow us to loosen the rule that we
> shouldn't put a "git" invocation of the git subcommand being tested
> on the upstream side of a pipe[...]

FWIW it seems from my off-list discussion with the bash maintainer that
no version of my patch is likely to make it into bash. He views it as a
feature that "pipefail" treats all non-zero exit codes equally.

But as it pertains to our test suite I mainly wrote this to check if we
had any failures that didn't make sense once SIGPIPE was ignored. I
think smoking out any potential historical cases (and finding we didn't
have any that mattered) was probably an effort worth it in itself. Then
we just have to continue not putting git on the LHS on a pipe for new
tests.

> [...]---not everybody is running bash, and it is unrealistic to tell
> our developers "if you want to make sure your tests are good, you must
> install and use this patched bash".

I think if others think this was worth keeping and bash never accepted
the patches we could rather easily get most of the benefit from it by
having a CI job that ran with such a patched bash. To test with "set -o
pipefail" it's enough that it's done semi-regularly by someone if you
want to smoke out bugs in the tests, not everyone has to do it all the
time.

