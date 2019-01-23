Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FBE1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 17:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfAWRvs (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 12:51:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33157 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWRvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 12:51:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so460017wmh.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yi5Ol9Bzuh0bE1DjHwQnVtjpiw4kEf973iSOHhKbdCQ=;
        b=RErXigJ0Necc3OCr2UjRP697f8flx6D5x6+MVrInF46IW8AFsVY3gsOKiFJJju2a78
         Ei5MbTq1R1h0xg3b6g7l+Q5CCg23x2GjBAvw1iuljI/0PLj2OJKC0Up5wLJG5mI9Ow3r
         dRMHII3iRMpePtAEMTfwJoDMHcyJkRKOYjwkmZ/mRbOFxhX3Ds/HyAZoAYadZLqFb7wV
         Yf6z9IbDq5y9B/SMzCfzQOJoRE2BIjvbeOKDmWi4tS8MDM8KjmQOxG29oyM3jzx9U/8h
         kdakeIS4CFCwpHYjpt7WpG9iJQ3xw8fZdmVy9ZJGQpsgbUKgZN8cb8OBXl7kYPQ214wI
         ZrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yi5Ol9Bzuh0bE1DjHwQnVtjpiw4kEf973iSOHhKbdCQ=;
        b=m/+F9HutTdlQycglOPKMQ/iF3a/w2IILXBTmNJ7bKiRSUxzhYb+Fu3md8ovGvPr36k
         NEFugnubeTYvRH42AcnLwokNYyxyznWlpu/hRsL8FPA4PiRPtdUBxXaU18IS281QKpIX
         eSRtB81eaLpKC/d8y2C2l0N/yKL/D6UbOKuWVctdImmwnSaNV42+D4R7qYUfHkA/7dUG
         hGgdAFd/m9UKpFu09r5MzHYLeTog1Iec7GVnYaLEvcIodtEPtMLJzHye7XZ9OUCeEMC6
         IZ/RkgsQoM2EzIIwxVdQIAR9P3S+5dCLSpPkRooErFSVx8dN7IO/0G9TAp41v0wVoXS/
         uC6g==
X-Gm-Message-State: AJcUukfp0imAoyoTh3KaoG3GDHI77LMQoUIGELLO7zNwMZkrDk6OdHTA
        phWQGMR9R/bLusK8kGqHOow=
X-Google-Smtp-Source: ALg8bN7fT62uW3kgY5sK2/3Xl0uHEennb0Jt7/lEgBg73bXrGAUfHAWwSP6F29IjHEj3R/+f7BCKkQ==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr3469344wme.20.1548265905719;
        Wed, 23 Jan 2019 09:51:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a17sm92383335wrs.58.2019.01.23.09.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 09:51:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
References: <20190119154337.6556-1-phogg@novamoon.net>
        <xmqq1s54e2ju.fsf@gitster-ct.c.googlers.com>
        <CAFOcBz==BunV48U94ZSnc2gmBTOcOpY4XO-dPugKMUVNZGjzZA@mail.gmail.com>
Date:   Wed, 23 Jan 2019 09:51:44 -0800
In-Reply-To: <CAFOcBz==BunV48U94ZSnc2gmBTOcOpY4XO-dPugKMUVNZGjzZA@mail.gmail.com>
        (Patrick Hogg's message of "Tue, 22 Jan 2019 18:54:24 -0500")
Message-ID: <xmqqh8dzcle7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Hogg <phogg@novamoon.net> writes:

> On Tue, Jan 22, 2019 at 5:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Patrick Hogg <phogg@novamoon.net> writes:
>>
>> > As I mentioned in the prior thread I think that it will be simpler
>> > to simply use the existing lock in packing_data instead of moving
>> > read_mutex. I can go back to simply moving read_mutex to the
>> > packing_data struct if that that is preferable, though.
>>
>> I'll let others comment on this to show preference between the two
>> approaches.
>>
>> > I also removed the #ifndef NO_PTHREADS in prepare_packing_data around
>> > the initialization of &pdata->lock since I had to upgrade the lock to
>> > a recursive mutex. As far as I can tell init_recursive_mutex (and
>> > pthread_mutex_init for that matter) have that protection already so it
>> > appears to be redundant.
>>
>> If you can defer "I also" to a separate patch, please do so.
>> Keeping the fix alone as small as possible and not tangled with
>> other changes would make it easier for people to cherry-pick the fix
>> to older maintenance tracks if they choose to.
>
> That's a fair point.  To confirm (as I'm rather new to submitting git
> patches), do you mean to submit a two-patch series or to just leave
> out the #ifndef removal altogether for now?

Either would work ;-)

> If this does become a two patch series I could simply move the
> read_mutex to packing_data in the first patch and merge the two
> mutexes (and remove the #ifndef) in the second.  That would keep the
> fix alone even smaller (just the first patch) to simplify
> cherry-picking.
>
> (There is also the option of going back to the v1 change and
> correcting the cleanup in the early return.)

Yes, but as I said, I'll let others show their preferences between
approaches v1/v2.
