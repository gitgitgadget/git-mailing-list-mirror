Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC7C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjBAWvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBAWvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:51:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88F6C12C
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:51:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bk15so936112ejb.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQMhJB9sW7xASvN5U2nHYbXOFoVb0N6iBKuf27ai3d4=;
        b=fyKIzb+L9y4p2YmgL33daLSVvm1KosS946AAgaqCUaLNKpwHa7UafoSnJmTouuwEM1
         TS0Vs83Y09j43Bbud1WG1RcTtIJ0vxsQsQyUX+atS7K0ky6pF+l1nzduK8do2N+FXG2H
         w6iC3Oosk9BcdDCka7PQ3twKt0NPzpc+Cs5L0FvOlGtyVekJrrmUWU133SP3nyLDFNWK
         laCQvBSr83tT07weH1XXtWfMsApJZ7jTYJvOxS04YZXI+duP1Pym6yMz5ijuOdeZsBfw
         GGkgFN37t8oaltJxSCArpXnXP3edsMiH1rpXiybCYFl7SAPyuHzWIhrGOHbe/FTsZLsA
         nCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQMhJB9sW7xASvN5U2nHYbXOFoVb0N6iBKuf27ai3d4=;
        b=HCbzX9XZs9PA0eCL9QZh/KWxLT62wuw+C2GWODBKwdb3NVXmRfAZPuLd2WjGraRKDo
         /FtLWgM03VEz5Q/bRb/LhgVIo4EPNirtFJ7T07E856hCWDdJzYrjTOFEiVPkqhOOKh3a
         tc/2yUxjeoPVKzLwiJ0b1kvSRvkU/c/CtHTPyg7QlhqTQHH9anJWDdfu2v2Tql4bfUkt
         1nUoxMCLJAIilvPEX5Pjt5ArRSn1KG6K4QvtGMUPpOce6LOHp7GNivti5DduaaNPAsZt
         T+4my4mPI+tRTmIhSytfSf3xjFF2LezIZDIHi5fy2yg1OsJQHQ4/iMhyuylWIWCvx7ca
         rhMw==
X-Gm-Message-State: AO0yUKU+9f3sxLt9+HJYtCfN2Hxx7CF1oes2Uy7UPH5a8Yn3SJ3GtRTE
        2i6aN7dxZlcZwdivQNpiBLc=
X-Google-Smtp-Source: AK7set8uPsLilfjZW9l8Uve5IPpV8G7Mi0duj6VG2KOq4/v8W6b8YLkd5wnuJERdpO5kMrW15ngEsQ==
X-Received: by 2002:a17:906:11c7:b0:887:3732:f584 with SMTP id o7-20020a17090611c700b008873732f584mr3987541eja.71.1675291874537;
        Wed, 01 Feb 2023 14:51:14 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906762200b0087851a76573sm10836597ejn.74.2023.02.01.14.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:51:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNLwf-002KSG-09;
        Wed, 01 Feb 2023 23:51:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rafael Dulfer <rafael@dulfer.be>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
Date:   Wed, 01 Feb 2023 23:28:05 +0100
References: <20230201155712.86577-1-rafael@dulfer.be>
 <xmqq5ycl1c6h.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqq5ycl1c6h.fsf@gitster.g>
Message-ID: <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 01 2023, Junio C Hamano wrote:

> Rafael Dulfer <rafael@dulfer.be> writes:
>
>> From: Rafael Dulfer <rafael.dulfer@gmail.com>
>>
>> Currently, the documentation is slightly incomplete, not explaining
>> all the differences the default format has with rfc2822. Leading to
>> confusion for people trying to parse the date format outputted by
>> git log
>>
>> This patch adds 2 more exceptions when compared to rfc2822. Also
>> adds an example of what the format looks like (I originally wanted
>> to specify this in strftime notation, but because of the way
>> day-of-month is formatted this is impossible)
>
> Overly long lines.
>
>>
>> Signed-off-by: Rafael Dulfer <rafael.dulfer@gmail.com>
>> ---
>>  Documentation/rev-list-options.txt | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index ff68e48406..8bc8475f3e 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -1103,9 +1103,15 @@ format placeholders. When using `-local`, the correct syntax is
>>  `--date=default` is the default format, and is similar to
>>  `--date=rfc2822`, with a few exceptions:
>>  --
>> -	- there is no comma after the day-of-week
>> +	- There is no comma after the day-of-week
>>  
>> -	- the time zone is omitted when the local time zone is used
>> +	- The time zone is omitted when the local time zone is used
>> +
>> +	- Day-of-month and month are switched around
>> +
>> +	- Time-of-day and the year are switched around
>> +
>> +As a result, the format looks as follows: `Thu Jan 1 00:00:00 1970 +0000` with `+0000` being omitted when the local time zone is used.
>
> All of the above may technically be correct, but I wonder if it
> makes it easier to follow to simply stop saying "is similar to".
> That is
>
>     The default format `--date=default` shows a single line with
>     three-letter day of the week, three-letter month, day-of-month,
>     hour-minute-second in the "HH:MM:SS" format, followed by 4-digit
>     year, plus timezone information unless the local time zone is
>     used (e.g. "Thu Jan 1 00:00:00 1970 +0000").
>
> or something like that.

I think that following such a description in prose is still more
confusing than just showing an example. E.g. we could say:
	
	Assuming a user in timezone +0200 (Central Europe) values of
	these `--date` argument would produce:
	
	|---------------+--------------------------------|
	| rfc2822       | Thu, 7 Apr 2005 15:13:13 -0700 |
	| rfc2822-local | Fri, 8 Apr 2005 00:13:13 +0200 |
	| default       | Thu Apr 7 15:13:13 2005 -0700  |
	| default-local | Fri Apr 8 00:13:13 2005        |
	|---------------+--------------------------------|
	
In particular your example says "unless the local time zone is used",
but then shows an example that's 'default', not 'default-local'.
