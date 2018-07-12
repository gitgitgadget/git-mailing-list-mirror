Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467EE1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeGLUeH (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:34:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45608 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbeGLUeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:34:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so10266444wrs.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MHp8qOXVZFYZ0Mvk5I7QkOoTHkAt7AGOiBKVSc5WvWk=;
        b=DzAvY1R5Jh3Gjj1FZXAi23aEieXYH4IWP31ayS2piLNGvL8GWawoor8HoOMN/S6odj
         Pl1FGZKCSUqw0mz+3X0LiIVRItBCcsDsyjVUf4ugNPT4qB0JyZZA7kAgkWKuzFp9NUUO
         Wj4Hk5HNWa730jbLPJSKq2pwC6ZW0OeQEfkKsBn6ipJDqQkCUW/CQfNCpvJ5aectS6Lz
         XVaLZQ2+CPCfO4fcnNUNBVXO9hmBaXRXvYMH+M1HkBbl6MFETpULFVlBRnTj5mBPf0HC
         +g50YX7nzowJcYldcYX267xwfIsP3SMheedf8sduvtxZs2h2ibz8QcfWMQs8YhBbX0dL
         iblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MHp8qOXVZFYZ0Mvk5I7QkOoTHkAt7AGOiBKVSc5WvWk=;
        b=iK+Zi3BVfGzNpdqA2GnZ+BfxdDgcHE0BIhFfJDrs5EXPRWCj0Hu2LazwuOXidSTV+C
         7WE1glREeeV9jE0JzximxnvDjf4yF5l5PJ3Cpprt2XhmGJypoWI/bzNBsoaBxkXuwQYH
         Pxpar+uGJJBmM3IFO7CqbqzoyPlEPqUpgwGElQNT4q+dfH/Z0yBRRLHi5GnHKyvANIUM
         o1S9mBGvUdBUKv7pcE1o8dEyfgoIGdM6QX1EbicUMKAhnwmHfnAADiBFES7a/+Uaoqv+
         XwsNgTdiTc5ww6FGaS9Ahqa4wQDY161h26IECDS74iLanzYVPVfYhYzxlYsHSljk74ME
         /cjw==
X-Gm-Message-State: AOUpUlEB9MpcHYUw+38S/TayI2zNHBd9tcnjrNSib1dKwEaNZqLQrA1c
        WDoHoDYuD54hFrB7LcpTfPw=
X-Google-Smtp-Source: AAOMgpd2aOo1XyoQ0w3J75+cQFlgKVniiCUHI3BsXFSXFyM8XBE8bYWERX3fQW0WG8/EgpYaSUxpMA==
X-Received: by 2002:adf:b05c:: with SMTP id g28-v6mr2763183wra.128.1531426976051;
        Thu, 12 Jul 2018 13:22:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f2-v6sm21418232wre.16.2018.07.12.13.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:22:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3404: fix use of "VAR=VAL cmd" with a shell function
References: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com>
        <20180712201454.GA6281@sigill.intra.peff.net>
Date:   Thu, 12 Jul 2018 13:22:55 -0700
In-Reply-To: <20180712201454.GA6281@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 12 Jul 2018 16:14:54 -0400")
Message-ID: <xmqq4lh4w6e8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 12, 2018 at 01:07:51PM -0700, Junio C Hamano wrote:
>
>> Bash may take it happily but running test with dash reveals a breakage.
>> 
>> This was not discovered for a long time as no tests after this test
>> depended on GIT_AUTHOR_NAME to be reverted correctly back to the
>> original value after this step is done.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  * We could enclose the setting and exporting inside a subshell and
>>    do without the oGIT_AUTHOR_NAME temporary variable, but that
>>    would interfere with the timestamp increments done by
>>    test_commit, so I think doing it this way may be preferrable.
>
> Yeah, I agree that setting/unsetting is probably more sane for this
> case. Though...
>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 7e9f375a24..fd43443ff5 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -280,8 +280,11 @@ test_expect_success 'retain authorship w/ conflicts' '
>>  	git reset --hard twerp &&
>>  	test_commit a conflict a conflict-a &&
>>  	git reset --hard twerp &&
>> -	GIT_AUTHOR_NAME=AttributeMe \
>> +	oGIT_AUTHOR_NAME=$GIT_AUTHOR_NAME &&
>> +	GIT_AUTHOR_NAME=AttributeMe &&
>> +	export GIT_AUTHOR_NAME &&
>>  	test_commit b conflict b conflict-b &&
>> +	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&
>
> ...would you want to use test_when_finished here (both for robustness,
> but also to make it more clear to a reader what's going on)?

Perhaps.

I wish our test-lint caught "VAR=VAL shellfunc", but it is rather
hard to do so, I would imagine.


