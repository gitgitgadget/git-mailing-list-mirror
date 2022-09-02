Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F92EC001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiIBQ2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIBQ2B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:28:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B257D7595
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:27:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y29so2435366pfq.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=DvVf7FnbGYmp4r2prLSIVUprlSEUdhVy1IP47h69TwM=;
        b=j0H8PWGJj3Le0qEdEMEyp/n4MgkNckq1JuOCg7ERjSZy88RNj89K/p4q2NRbFgNCJi
         e67cBMD9DR5JGq5vld1j8cYfqAsNExiNEelaJsK5Q1/7oYe2ePLlztoguOGc6XDqSGqT
         qQmLoOeG5dSaJsBdBEELrBDWjE8EK5i2qZfYbrvKVM/YcYOypiJvPNJIDCWsJfRp+MyS
         rnuyJH5FV7U0havoXAeD/v4sW4vhBuTF43KsNj6mdUk9w6nrn9Wh4SRzJUZtUoPpl1we
         kdUkOMAIQn3baH8EIVZR2cojgSvP4VTPUwIUP1YnxYmTqU4raJLxsh63Sco1jX7+L3Zu
         oppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DvVf7FnbGYmp4r2prLSIVUprlSEUdhVy1IP47h69TwM=;
        b=6E9A7KfVk5E4dcUC5k1i4go4Uz5fJIqn+opfewve20ouFKAqkWW9WjgYaAMzjjemQa
         fFGQ1qTOvJ8hpjPsoGy7m5ZWnnKg4DhfhKarzOD12foes9kniGHdQbpfvDmnN33Cuwnr
         y1lVghkAYxbT5R8UGj7rdFjQZvgrUNj/vx1iiCX9fdxePtNoYA/qFUv2dkmSjt6aheko
         HcivEPiHpDSxIP7B9VIFeXdRE3sSrGRa/Dic/CX40JEHFjJaoEwmSxf9Kz/eIh+VuA5A
         JhKOdp24KvtC/DkPi3+Xon7cKcqQL9joE1j3fmQuJs6hUWRlS1OxYXhapZZsX6VKm13G
         C2qQ==
X-Gm-Message-State: ACgBeo1MP2okH5iCcsXMRil6CSQ9FNX+VLwk7gbDHWhHoa0/GnQKgJbx
        87kR9A7adWY219C93MGhqgE=
X-Google-Smtp-Source: AA6agR6mlf+NfwI7zD1/utGYdDSm5/oyD9sxOXbm+o7jAquuM6hsQ4H28skjHdmp+wOu/5rwMKr0iA==
X-Received: by 2002:a05:6a00:1586:b0:537:f5f:11d0 with SMTP id u6-20020a056a00158600b005370f5f11d0mr37803294pfk.64.1662136077770;
        Fri, 02 Sep 2022 09:27:57 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y5-20020aa79ae5000000b00537aa0fbb57sm2025665pfp.51.2022.09.02.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:27:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org, ingy@ingy.net
Subject: Re: [PATCH] rev-parse: Detect missing opt-spec
References: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
        <20220902050621.94381-1-oystwa@gmail.com>
        <20220902064727.GA3606@szeder.dev>
Date:   Fri, 02 Sep 2022 09:27:56 -0700
In-Reply-To: <20220902064727.GA3606@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 2 Sep 2022 08:47:27 +0200")
Message-ID: <xmqq5yi5aghf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Sep 02, 2022 at 07:06:21AM +0200, Øystein Walle wrote:
>> If a line in parseopts's input starts with one of the flag characters it
>> is erroneously parsed as a opt-spec where the short name of the option
>> is the flag character itself and the long name is after the end of the
>> string. This makes Git want to allocate SIZE_MAX bytes of memory at this
>> line:
>> 
>>     o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
>> 
>> Since s and sb.buf are equal the second argument is -2 (except unsigned)
>> and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.
>
> I suspect (but didn't actually check) that this bug was added in
> 2d893dff4c (rev-parse --parseopt: allow [*=?!] in argument hints,
> 2015-07-14).

Good thing to add to the proposed log message.  Thanks.

Also, Øystein "Detect" -> "detect" on the title (you can see the
convention in the output from "git shortlog --no-merges").

>>  		if (!s)
>>  			s = help;
>>  
>> +		if (s == sb.buf)
>> +			die(_("Missing opt-spec before option flags"));
>> +

OK.

>> +test_expect_success 'test --parseopt invalid opt-spec' '
>> +	test_write_lines x -- "=, x" >spec &&
>> +	echo "fatal: Missing opt-spec before option flags" >expect &&
>> +	test_must_fail git rev-parse --parseopt -- >out <spec >actual 2>&1 &&
>
> When checking an error message please don't look for it on standard
> output; i.e. the redirection at the end should be '2>actual', or
> perheps even better '2>err'.

Again, very good point.

Thanks.
