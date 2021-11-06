Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE99C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF51460EFE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhKFE1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 00:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhKFE1L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 00:27:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D1FC061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 21:24:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j21so39676974edt.11
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 21:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5vxJ6HqkO6mBwOaNQz7V4WVZfQahuf7mfUyWlfADa88=;
        b=XrgmNgFkFQS5l7wES1huPMp7HEl0y02rHRw1JDhsr78011iXMz9fFE4zpN+4qE5wOv
         swh9mo0lR5/ZCohX7wb9G0KcWCEy/mx4f/yAc2W0CYKTbUMplCgsruhGHCfwzsN7KxwL
         WzsM5oAtiAt1NEkKwz1rkUyXooEXhTiqwgQ+cEcwZUJAdUEoHK6c7FoB/JukLEATq6nS
         Yfb+b55rbFpENgr6f4EYkAFFUYocJaBstqP2hwoBberxxo+2smb74RJoAllU8ndy1THB
         1oTJEoeGL/oqyP9ix2gT6qXopb2DLS1ig11sA5Y5wVyDdrmqUmwXmdjg/09BBFzT0KfX
         8bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5vxJ6HqkO6mBwOaNQz7V4WVZfQahuf7mfUyWlfADa88=;
        b=2+XEx3eoqGvixK9Knin9wJLJZgsNwUha7NvwvnqUBZTQ6zpf8g3kAMyAu/yQ6fjv8t
         L12VzlHrDHGoh8rOaat94hdIAgUDjIpIH8DdH2VIhh/WYXY02Sl3dSTrJKRYEAbxYwEf
         KccKh+m45auYXwCVJUnG+O6okuEN3N41omse4hI/HtYWAtpBtXQfQLXxTJV8rQIO5umO
         /+TDAUtM9+CyNItr3HGSp8yZjzz0kC7XIb7se77zhb9XbwsOJzle2lVKWvFbolsWiIlf
         NQ+RKiIt1I3Jx5YN5GcSjBjP8MvUhUkUuRUF08QGmR+xFaO3jBjpAp+HsyMCHl4/3m0R
         O48Q==
X-Gm-Message-State: AOAM532cmAMxk/iYuIQT62hN6GrmkHQt6x4mHuen2vs1cQnYliE9ewTB
        V5dxz1yrujTNUz+aRy4v3Xc=
X-Google-Smtp-Source: ABdhPJyi0WHhS8HeugiELQQkaKfwWF7lr8JGnPs5sQBkcFCMXi84Z7tjooio2ps/O2AK6xkP7y6HqQ==
X-Received: by 2002:a17:906:fcba:: with SMTP id qw26mr4051285ejb.448.1636172669531;
        Fri, 05 Nov 2021 21:24:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g26sm4908836ejz.21.2021.11.05.21.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 21:24:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjDFk-000ZWc-IY;
        Sat, 06 Nov 2021 05:24:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 03/10] generate-cmdlist.sh: spawn fewer processes
Date:   Sat, 06 Nov 2021 05:23:05 +0100
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
 <patch-v3-03.10-737cca59d99-20211105T135058Z-avarab@gmail.com>
 <xmqq7ddmw77y.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq7ddmw77y.fsf@gitster.g>
Message-ID: <211106.86bl2xhpxf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 05 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
>> index 5114f46680a..27367915611 100755
>> --- a/generate-cmdlist.sh
>> +++ b/generate-cmdlist.sh
>> @@ -11,15 +11,14 @@ command_list () {
>>=20=20
>>  get_categories () {
>>  	tr ' ' '\012' |
>> -	grep -v '^$' |
>> -	sort |
>> -	uniq
>> +	LC_ALL=3DC sort -u
>>  }
>>=20=20
>>  category_list () {
>>  	command_list "$1" |
>>  	cut -c 40- |
>> -	get_categories
>> +	get_categories |
>> +	grep -v '^$'
>>  }
>
> It is funny that this changes "grep then sort" into "sort then
> grep", which will be "corrected" in two steps down.  The series
> seems a bit over-engineered and broken down too much, at least to
> me, but let's not waste any more time on it by an extra reroll.

Yes, it's a bit of back and forth, but I didn't want to outright drop
Johannes's patches which I'd integrated here, and thought it would be
helpful to others to distill the history of various optimization steps
(starting with Johannes's work here) into the permanent commit history.
