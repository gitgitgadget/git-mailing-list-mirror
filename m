Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890681F597
	for <e@80x24.org>; Wed,  1 Aug 2018 18:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbeHAUNR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 16:13:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41057 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbeHAUNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 16:13:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so21075551wrr.8
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fCOhTwRb37MXDzGGfVQDUYHjI5i2BddhYXRWG4j9a3Q=;
        b=Du38pJ9QF6+8bLEUc+iUeoqeq5s2z8pXO04fDtaqsqJnUCXH02RHIU+j6P3PSwi3x6
         PD2vXJeK1xTYaDka1Xo4Qx6A4Am4UesTbdR60ofgkV6zfl47m+NPpOWV+ZAyW40tjyGj
         du+qlFjJvJ5TJG3tQ8ByezFKP6ltflxRMYNhrJis9II+kL2xYPnrqmLWiiQot27HGdFa
         FnVfmvPpryrzLY3U3pFt/Y0hpnQPOlLVgimPHF64MemK3gQGUtNYjffndZ/TPQPUt39j
         AxtORR2kO1JcIt/hQUt8ACGt2HQSobibYKWiFiSAS1vdeyR06hIoNyYyEttZlhxxBb4H
         jTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fCOhTwRb37MXDzGGfVQDUYHjI5i2BddhYXRWG4j9a3Q=;
        b=nz+cptp9v18uypmYK5BkgXU7BCMAMeBY3OjPgj8oJpDsvp5+rTXp4ZqY7WyrRpbnjj
         sRlcy9wSp1klMEloiZc2Dpla9VpTsl3a23o1x9ObEr4MZSFdcOvRRr55w29/fWj4Uemg
         AyM9HTKviiFI4qyVDek9Sh8qJLhkXTdfSTUwQnNJHFro86tbRyZZT89DxwXnvXyoik5z
         Xm8XvHYyX18+GM5nk+WBVNWV/lvi97pVSjRoav5243MM4J142H0k5J2RvHq8QGBjmUk2
         5AwJa/pYm/MN+f2saG6/l4ShpxQorhPQTOAvDunoKwROhGoonV8zul4mqKu6vl38Jrvr
         Ghjg==
X-Gm-Message-State: AOUpUlHoLSAUAvbGgPNonQl39QqM/kwDVpTPLGFm2Hd+8IOggxwfuHws
        R2Sa3k3fyTHf2aIv/UWbY8Aog3+i
X-Google-Smtp-Source: AAOMgpdZDWxvSzfJAPuUXbMINio0V/fhVxwsm2tiVKBbIOg7A3YMSwxNGUq/sdDoukoxKm5x1DuNZw==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr25165066wrc.93.1533147974476;
        Wed, 01 Aug 2018 11:26:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z9-v6sm34631wmh.11.2018.08.01.11.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 11:26:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] remote: make refspec follow the same disambiguation rule as local refs
References: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
        <20180801181348.106679-1-jonathantanmy@google.com>
Date:   Wed, 01 Aug 2018 11:26:13 -0700
In-Reply-To: <20180801181348.106679-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 1 Aug 2018 11:13:48 -0700")
Message-ID: <xmqqo9em6j0a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> +test_expect_success 'LHS of refspec follows ref disambiguation rules' '
>> +	mkdir lhs-ambiguous &&
>> +	(
>> +		cd lhs-ambiguous &&
>> +		git init server &&
>> +		test_commit -C server unwanted &&
>> +		test_commit -C server wanted &&
>> +
>> +		git init client &&
>> +
>> +		# Check a name coming after "refs" alphabetically ...
>> +		git -C server update-ref refs/heads/s wanted &&
>> +		git -C server update-ref refs/heads/refs/heads/s unwanted &&
>> +		git -C client fetch ../server +refs/heads/s:refs/heads/checkthis &&
>> +		git -C server rev-parse wanted >expect &&
>> +		git -C client rev-parse checkthis >actual &&
>> +		test_cmp expect actual &&
>> +
>> +		# ... and one before.
>> +		git -C server update-ref refs/heads/q wanted &&
>> +		git -C server update-ref refs/heads/refs/heads/q unwanted &&
>> +		git -C client fetch ../server +refs/heads/q:refs/heads/checkthis &&
>> +		git -C server rev-parse wanted >expect &&
>> +		git -C client rev-parse checkthis >actual &&
>> +		test_cmp expect actual &&
>> +
>> +		# Tags are preferred over branches like refs/{heads,tags}/*
>> +		git -C server update-ref refs/tags/t wanted &&
>> +		git -C server update-ref refs/heads/t unwanted &&
>> +		git -C client fetch ../server +t:refs/heads/checkthis &&
>> +		git -C server rev-parse wanted >expect &&
>> +		git -C client rev-parse checkthis >actual
>> +	)
>> +'
>
> Thanks, this looks good to me. Also thanks for adding the "+" in the
> fetch commands in the test.

Yup, otherwise the fetch may fail because "checkthis" may have to be
rewound when we fetch different things.
