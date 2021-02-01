Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2491AC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E546864EA3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBATX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBATX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:23:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D97C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:23:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a9so7785720ejr.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pWRkxk3emxV0qJ9RCEOObk6WyEQs28yTldUh/86mKWs=;
        b=f83B9U1cIZwkvfuA+enbjGVssPwOFJWk9lvwNpxB3k4puBnYCvuxactQ3CYD2odmZz
         uwyKXvZ1ZKCpOjcgIaB7VQwAu1rgm59XYme3BT8BGDMaer9/xFPOQvVGHp5TOgiXz/GG
         CPQsFf+nYT399rb+rIj4/4oQaLw+GMnrdqssGBYRz9BsaU07/DjjdDapIQUo/g/zuPKU
         tuJMotxTqJy8NmMI9AqPuccjrDO+MV0OWmbFuZLlynleBhJg/iC5IvNey5sYpi027xg6
         9z8ILI7eFKck6XGxC0KWniijhS5lXn81RQiTir+4P50AMDL4OOx/5HCrD2683NGLqe9E
         FMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pWRkxk3emxV0qJ9RCEOObk6WyEQs28yTldUh/86mKWs=;
        b=fn57W9I4zRoVTNcUVvPzu0pWvlnj8q79bIHnwTwDKg2f2KTw3QiXcOKHPuS6Lf54Rs
         /clEPJLeA2b7oZqLc0DZaLCOcxWd5knAUZqs4D8ZTT2Qijt1q7fnK8KJVng6H1+cYWwm
         o0DKl7w/u9id0EY3k2wgfo+bi7WPAN2J6fvq7bsA2C8SgYRbMUKMrUIpckQBySd1uxB/
         LtrJNnpjTFNPv2J/2kQIBfyardhk98pksk2O6YuekrZ8uYexm8RqphGD3xGGJhEK5aAo
         WWTeyavVU3PjLpucFfxSn0zfJrhGib6lMz95hf3u0PpiihP5+C5GOJTjuoye6GZ3AarH
         YzJA==
X-Gm-Message-State: AOAM530NVGv0oIWj8FTHfLLSTpI0RXDJrEtLdJpWrSmHjYTW3zYfifgu
        blGO+cAiZ4Yk2yyFKeK+Mxk=
X-Google-Smtp-Source: ABdhPJygcKiTbEM7NMPY8ryLp5cHva+Y/Ayq7ligvWb5MdSSpSFGuGgqaPWZo6ednfA6apa4Q1QYWQ==
X-Received: by 2002:a17:906:4a19:: with SMTP id w25mr19396464eju.153.1612207395888;
        Mon, 01 Feb 2021 11:23:15 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id x21sm8352112eje.118.2021.02.01.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:23:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        "Jeff Hostetler" <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/3] pager: properly log pager exit code when signalled
References: <87im7cng42.fsf@evledraar.gmail.com>
 <20210201144921.8664-4-avarab@gmail.com>
 <xmqqbld3mz85.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqbld3mz85.fsf@gitster.c.googlers.com>
Date:   Mon, 01 Feb 2021 20:23:14 +0100
Message-ID: <87zh0negnx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/run-command.c b/run-command.c
>> index ea4d0fb4b15..10e1c96c2bd 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -551,8 +551,12 @@ static int wait_or_whine(pid_t pid, const char *arg=
v0, int in_signal)
>>=20=20
>>  	while ((waiting =3D waitpid(pid, &status, 0)) < 0 && errno =3D=3D EINT=
R)
>>  		;	/* nothing */
>> -	if (in_signal)
>> -		return 0;
>> +	if (in_signal && WIFEXITED(status))
>> +		return WEXITSTATUS(status);
>> +	if (in_signal) {
>> +		BUG("was not expecting waitpid() status %d", status);
>> +		return -1;
>> +	}
>
> This starts reporting exit status of the pager back to
> finish_command() and finish_command_in_signal().  But the code in
> pager.c that call the finish_command*() ignore the returned value.
>
> So, is the net result of these three patches just that the trace2
> output gives the exit status of the pager, but "git" itself is not
> affected otherwise (not a complaint; trying to understand the
> intention) ?

Yes, it's just a bug fix for the trace2 output.

>> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
>> index c60886f43e6..1424466caf5 100755
>> --- a/t/t7006-pager.sh
>> +++ b/t/t7006-pager.sh
>> @@ -656,31 +656,74 @@ test_expect_success TTY 'git tag with auto-columns=
 ' '
>>  	test_cmp expect actual
>>  '
>>=20=20
>> -test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager exit=
' '
>> +test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
>
> I somehow find 2/3 of this change belongs to the previous step.
> That is, shouldn't this new test added in the previous step without
> the !MINGW prerequisite, but without the trace2 bits (i.e. the first
> three added lines and the last "grep" of trace.normal), and the change
> made in this step limited only to those trace2 bits?

Sure, I can re-arrange it like that. I figured 1/3 shouldn't assume 3/3,
there wouldn't be a reason not to use !MINGW except because 3/3 is going
to remove it later, but I guess it makes the overall history easier to
read...

>>  	test_when_finished "rm pager-used" &&
>>  	test_config core.pager ">pager-used; head -n 1; exit 0" &&
>> +	GIT_TRACE2=3D"$(pwd)/trace.normal" &&
>> +	export GIT_TRACE2 &&
>> +	test_when_finished "unset GIT_TRACE2" &&
>>=20=20
>> -	OUT=3D$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
>> -	test_match_signal 13 "$OUT" &&
>> +	if test_have_prereq !MINGW
>> +	then
>> +		OUT=3D$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
>> +		test_match_signal 13 "$OUT"
>> +	else
>> +		test_terminal git log
>> +	fi &&
>> +	grep "child_exit.* code:0 " trace.normal &&
>>  	test_path_is_file pager-used
>>  '
>
> The same comment applies to this new one added in this step.
> Shouldn't the bulk of the test (i.e. under !MINGW we get killed with
> signal 13) be introduced in the previous step?

*nod*

>> +test_expect_success TTY 'git logs nonexisting pager invocation' '
>> +	test_config core.pager "does-not-exist" &&
>> +	GIT_TRACE2=3D"$(pwd)/trace.normal" &&
>> +	export GIT_TRACE2 &&
>> +	test_when_finished "unset GIT_TRACE2" &&
>> +
>> +	if test_have_prereq !MINGW
>> +	then
>> +		OUT=3D$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
>> +		test_match_signal 13 "$OUT"
>> +	else
>> +		test_terminal git log
>> +	fi &&
>> +	grep "child_exit.* code:-1 " trace.normal
>> +'
>> +
>>  test_done

