Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260BC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F1864EA0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhBATWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhBATWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:22:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11628C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:21:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id df22so4256765edb.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K66Ec0S4fHlTkWWXHbGLBYGszocrkrFc4yQPXaPq9qY=;
        b=Tbb6Eko//MskrRrFwcAmKcjVMGwjSwUMOQSrgnvObkgNmP2/MrXc2XOPQC1DGpsI0d
         T9QH7d6nH+weuJkUEEOcqJ4zB4tccSB/v7Ad6L+B7OtsgcptdNXxNwNnTheF5neanozF
         lpu1GdIeYvKQ1j023GH5OiwJzWjCEWcLzAIyKF7bpAMuVaFpJBY0tigGXZWilnl3JIWN
         DbHi7AfFr7No1uKSqmNUOlzv4vxOiZfscXlyMwIGx/h7ul1pJBBykwMf+r0XtEtTbDdX
         9ZD3ExHWA1JY30nef6TmIWkuL50AuVCI2eC3LheUElbtLMr63sZw8rOV3akHfxtxyh+A
         60hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K66Ec0S4fHlTkWWXHbGLBYGszocrkrFc4yQPXaPq9qY=;
        b=b+l4/FmkDBvc1YYvOd4sZGQDehdL/bq/IpihvACbP5zwoWjCRLc5so961Xj54KXApq
         3LVEX3s2mbgVbgg85+hQQ2Alj1D2IEpAzBd0C2TxqjWQoiTYD1J/tNGOTGWpopJ9tCUL
         Kv3BrDBUlfwCi5rYblBv+CBAtJBRWVxKnxYf+dXYw/8wKC3/v9iIHtzXN6DsMRuszBSf
         PLYF4cSud3WpA88MznXFMZX3gE7ZI/nzY6Q/RmL/SAQAUkznVcXTBeYsFtjAn/mYundN
         xxjBv5yVEqsqOGWg/gx9mir7iiElrnbQB2RT34gZ/PvVc3Jo1jh2RGzVB3PiZbWFtIRo
         5VMw==
X-Gm-Message-State: AOAM532sIA/6cwyDjEYlTPEBQBlYyO2FRvWUz6sDiHURH7F2uPKaUBKU
        oiPjByCqZRJqjXYvY1FLWtA=
X-Google-Smtp-Source: ABdhPJzDOilKeSFQgWaHaDLa/F1IFkf4e0n91MTFlukyhKkcc11DmJzfGG1PwjuoO5Q5fSLxQzLhQg==
X-Received: by 2002:a05:6402:c9c:: with SMTP id cm28mr20929812edb.281.1612207282649;
        Mon, 01 Feb 2021 11:21:22 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k6sm8351299ejb.84.2021.02.01.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:21:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        "Jeff Hostetler" <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/3] pager: properly log pager exit code when signalled
References: <87im7cng42.fsf@evledraar.gmail.com>
 <20210201144921.8664-4-avarab@gmail.com>
 <xmqqft2fmzk6.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqft2fmzk6.fsf@gitster.c.googlers.com>
Date:   Mon, 01 Feb 2021 20:21:20 +0100
Message-ID: <8735yffvbj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> When git invokes a pager that exits with non-zero the common case is
>> that we'll already return the correct SIGPIPE failure from git itself,
>> but the exit code logged in trace2 has always been incorrectly
>> reported[1]. Fix that and log the correct exit code in the logs.
>>
>> Since this gives us something to test outside of our recently-added
>> tests needing a !MINGW prerequisite, let's refactor the test to run on
>> MINGW and actually check for SIGPIPE outside of MINGW.
>>
>> The wait_or_whine() is only called with a true "in_signal" from from
>> finish_command_in_signal(), which in turn is only used in pager.c.
>>
>> I'm not quite sure about that BUG() case. Can we have a true in_signal
>> and not have a true WIFEXITED(status)? I haven't been able to think of
>> a test case for it.
>>
>> 1. The incorrect logging of the exit code in was seemingly copy/pasted
>>    into finish_command_in_signal() in ee4512ed481 (trace2: create new
>>    combined trace facility, 2019-02-22)
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  run-command.c    |  8 +++++--
>>  t/t7006-pager.sh | 61 +++++++++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 58 insertions(+), 11 deletions(-)
>>
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
> Doesn't BUG die, never to return control back to us?  How about
> "warning()" or "error()"?

Maybe I shouldn't do that, but I'm doing it reflexively because SunCC
will yell at me otherwise. See 56f56ac50b9 (style: do not "break" in
switch() after "return", 2020-12-16).

Maybe I should just deal with its complaints, or add an "/* unreachable
*/" comment there...
