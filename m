Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C590220A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 06:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLJGy2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 01:54:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33391 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJGy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 01:54:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so9282702wrr.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 22:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GybbuXbNrRpQIAr/D/spieRxNP/nHaVz+uOv5ywlcEQ=;
        b=MJmaLQnyLCPh+erlPHxNAyaR1WHdpcjKtSxCSflheEgvb2hGHQZjKOIzyF2TYPvlUL
         xOSaRtA+mQ+uJbhcyEXuEglWRw8wI4Iou7bZvYJOprZ/U0iO0iygwtc9nLaLuL5HwiAs
         O9kYNTBOP7CEGUGxE3EQDhC4aV3LzCOv+m5iFpU2ojARoWMGT7/wPXPB+KctVsKoBBsZ
         /x+I9OBtU9orZ/nzEyPtqfR5urJ4ZAr15Bb7XPE/fnNAFdJX1fLjlVvX4nroWq2WUt6d
         8ilQEQchdcDOGEzjEj3ZXX8CsUM0Br4fyO2Aa08cX+/p0cdZ8PVEqTQgB8ylg9y8TA2u
         47Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GybbuXbNrRpQIAr/D/spieRxNP/nHaVz+uOv5ywlcEQ=;
        b=Y/YF9fevyhjB59EDNAefnEkXQTrbVIU1ixT0cfV+NGxkFyDBuVEPQRsxSoJeG98AER
         yG5VBxdFm9FUo67u+UEWzMT68bbVbVGIxb7eYKsSmsfYbP/EvsqxUugeg/orVWcnLgU8
         jRL2TIyPCquu7k7P2mmobJWLT+JKdKCiOVx7y6CrAWfihQhzfneO3Cska3Cuf4dMCf5C
         RkTh8SQ+D9QJmmhESY4PcwnvKaQpT5K9F/WId8I9LO/QpvjLDa7t2LuLIswgQKJIxGNe
         8Dm9Iw5ZRU5ofpHjWi1PXk0t2chUAO929qD4mAw4X/Q0UO/k8cVDhqk1xgeEgrk21S5Y
         FcFg==
X-Gm-Message-State: AA+aEWYhYZ5mLAuSIeL8jV3hjroyCTOBMMGgbGOanY8fPruCfvBL7Krv
        JQxgSsPHAIsTLbhxNR4pzgI=
X-Google-Smtp-Source: AFSGD/UY4bzfQnGIt4XhWcamWmxZUzq8vNxGUtNsZsDNSwLb7bTRqxWHoBXf0n+L2h7wwNytuFIUFw==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr8225414wrx.259.1544424865412;
        Sun, 09 Dec 2018 22:54:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y185sm7516293wmg.34.2018.12.09.22.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:54:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, pcre-dev@exim.org
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
References: <20181209230024.43444-1-carenas@gmail.com>
        <20181209230024.43444-2-carenas@gmail.com>
        <87r2eqxnru.fsf@evledraar.gmail.com>
Date:   Mon, 10 Dec 2018 15:54:23 +0900
In-Reply-To: <87r2eqxnru.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 10 Dec 2018 00:51:01 +0100")
Message-ID: <xmqqlg4xkh28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> @@ -32,14 +32,14 @@ all::
>>  # USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
>>  # instead if you'd like to use the legacy version 1 of the PCRE
>>  # library. Support for version 1 will likely be removed in some future
>> -# release of Git, as upstream has all but abandoned it.
>> +# release of Git, as upstream is focusing all development for new
>> +# features in the newer version instead.
>
> I think whatever we do here it makes sense to split this into its own
> patch, since it doesn't have to do with this fallback mechanism.
>
> FWIW I was trying to word this in some way that very briefly described
> the v1 v.s. v2 situation. Just saying "new features" doesn't quite
> capture it, e.g. some bugs in v1 are closed with some resolution like
> "this isn't trivial to fix, use v2 instead".

I actually think we should remove the paragraph that says "Support
for version 1 will likely to be removed...", as I do not see how it
helps the users.  If they have both available, on the day they hear
that we are planning to remove pcre1 support and realize that they
need to plan to upgrade to the first version of Git that drops pcre1
support, they can switch to pcre2 just fine, so telling them about
our future that we do not even know definite plan yet does not help
them.  It is quite unlikely, given that "upstream has all but
abandoned it", that there only is pcre1 support without pcre2 for an
obscure platform, and even if there are such platforms, the users on
them won't have much choice.  Discouraging them from using pcre1
would not help them make better choices anyway.


