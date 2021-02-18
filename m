Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C6C4332D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F3E60C3D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhBRMf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhBRMIW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 07:08:22 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF5C061756
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 04:07:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j9so4097220edp.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 04:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x0dz7af7+scW6g34vxIDUcXAMYjy7ebV7LArZ6r3I6Y=;
        b=loPciDonB0nJZmckkSkSe4E50T+JjuRLF2xpZbY4s4bQ/coLrjuFlrPM93HiMvXLYQ
         +Rcxo9BMz9BpfXbcsPvThtPIGiOSGqneUkpsnl6iSwZbQ8Fhq3yNg7P2epiQoG52gRYq
         IcYNFck8bhiWoNJRETKe+bRtZTgU3AYda0ElmMRQe/xtJUscfIzCN5sduxsYtNYfeDNu
         MZ0ElBXvFVBSFtpvX4n5XNWwGURBd2UbIt6n9wS/2YVfMhDO27q5yK9AnbZKIIRsMFtf
         7grZFxOSKfrQVJi4dDAhds3ZG8iCKV3KXDHuSjtreHcOsDID3PPi/lzUA4pBfShgVRw5
         n+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x0dz7af7+scW6g34vxIDUcXAMYjy7ebV7LArZ6r3I6Y=;
        b=PYCBA+Df9OigsJIb8ZL5UqsXpD7LBQlj2j216umAzkaXTqpjh6nuu6Y27G4ICLneYr
         9hJWqsdCaNhUeeP8oOr5AWzoPueUIilEqyF5rXmoOYYPEfBu/AJJNCCDe8Prh6egiKlF
         6ZpLeC4WsPfzAxSk9+wyEZHkOuxZT1Lc83tjDjvJilj+dnyb4XeYYU3AVR5KTlrPbrlB
         u0WIUuXsk/r5Fau2P66uC4DcdekSnFHU5Ftjv9QHPEiArfnZw+uvSQJZ0p6lIkktXKC4
         KaNDkmLsWlSoKw/uOdzBS4W8wt6RPIjkpVXWhuZS2Pay2e3XipKY5lTuCabLfDelKa9M
         BoVw==
X-Gm-Message-State: AOAM530BNRJiIlqYLVgQmEAvXbQmlk7+xeGI1hTTTUkHpRoUV7H1r01e
        dnslshv+fpu/mHQQ8Fhd5D4xYktUOE3ohA==
X-Google-Smtp-Source: ABdhPJznOeQksnivfWFhqhh4oI1KevHOHb25APyibVprhtYiJPnz1EgmzmokLC6hxcM8gaSNPa1PVg==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr3857279edb.103.1613650052055;
        Thu, 18 Feb 2021 04:07:32 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f2sm2612080edm.95.2021.02.18.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:07:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <878s7na1h6.fsf@evledraar.gmail.com>
 <20210217201006.877438-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210217201006.877438-1-jonathantanmy@google.com>
Date:   Thu, 18 Feb 2021 13:07:30 +0100
Message-ID: <87o8gh8tq5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 17 2021, Jonathan Tan wrote:

>> Sorry for being unclear here. I don't think (honestly I don't remember,
>> it's been almost a month) that I meant to you should use the skipList.
>> 
>> Looking at that code again we use object_on_skiplist() to do an early
>> punt in report(), but also fsck_blob(), presumably you never want the
>> latter, and that early punting wouldn't be needed if your report()
>> function intercepted the modules blob id for stashing it away / later
>> reporting / whatever.
>> 
>> So yeah, I'm 99% sure now that's not what I meant :)
>> 
>> What I meant with:
>> 
>>     Or if we want to keep the "print <list> | process"[...]
>> 
>> Is that we have an existing ad-hoc IPC model for these commands in
>> passing along the skipList, which is made more complex because sometimes
>> the initial process reads the file, sometimes it passes it along as-is
>> to the child.
>> 
>> And then there's this patch that passes OIDs too, but through a
>> different mechanism.
>> 
>> I was suggesting that perhaps it made more sense to refactor both so
>> they could use the same mechanism, because we're potentially passing two
>> lists of OIDs between the two. Just one goes via line-at-a-time in the
>> output, the other via a config option on the command-line.
>
> Thanks for your explanation. I still think that they are quite different
> - skiplist is a user-written file containing a list of OIDs that will
> likely never change, whereas my list of dangling .gitmodules is a list
> of OIDs dynamically generated (and thus, always different) whenever a
> fetch is done. So I think it's quite reasonable to pass skiplist as a
> file name, and my list should be passed line-by-line.

Sure, but I'm not talking about passing it as a tempfile.

Yes, I suggested that in the third-to-last paragraph of [1] but then
went on to say that we could also move to some IPC mechanism where you
spew in the list of dangling .gitmodules, and we also spew in the
skipList and anything else we want to pass in.

I'm not saying this needs to be part of this series. But let me
rephrase:

We now have some combination of
{receive-pack,upload-pack,send-pack,fetch-pack,unpack-objects} that need
to communicate locally or pass data back & forth, passing data either
via a CLI option to read a file, packnames/refs on --stdin, or (now) a
single list of OIDs on stdout.

Let's say we don't just need to pass the .gitmodules OIDs, but also
e.g. .mailmap OIDs or whatever (due to some future vulnerability).

Would this IPC mechanism deal with that, or would we need to introduce a
breaking change (Re: my recently send mail about concurrent updates of
libexec programs)? Can we use soemething like pkt-line to talk back &
forth in an extensible way?

Not needed now, just food for thought...

1. https://lore.kernel.org/git/87czxu7c15.fsf@evledraar.gmail.com/
