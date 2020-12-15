Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3EC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 11:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC552226A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 11:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgLOLQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 06:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgLOLPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 06:15:50 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9232C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 03:15:09 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id jx16so27080197ejb.10
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qmtnY8wn2clUJ7aHFPs4TnWbpfki13e1oitOwbqs29o=;
        b=O35DSqqWw42LWwtNW76QGSjV+hpXMe6s0FMilQ+7QwTBbUX5MH+S5uoH13d0lOWvHr
         OcAz1G9mMS+xjYU6oDijONRhwS26hUJrLimnSzBuSE25wDHW/x65uJCu3HYCjvKdaPK5
         HOsrJ6yP/S9GJBKJS3TWp0+2V2zi764w4+5KcPIx9f6FOpgarSi1WGNwELzh7Hb53KxI
         H73k5Vn/gMK51KGTQl34GcS9L6DFxEZNust9oT01tGEa1NXNymdWu2CXfNHAxDKz0jRW
         Icl3ghBipzT4JPB3fQeXE/sCiTjZCr8qkhM4uEYLYUioysgjaQFTC9sjZmdALrRwcHtF
         YlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qmtnY8wn2clUJ7aHFPs4TnWbpfki13e1oitOwbqs29o=;
        b=mJPPld1zpScrK1QRjlYJUyOWQzc4V63EyWA+iZkdOXRNyUntWjtkIkC13BRnUBogj0
         sieAYiusrNSh7/gaI5JoED8pkcIY32iaEztS891smZ7WfGy6YmTDsc2mzjNv1kk+6hXn
         Tfizjo1U5o1cAT8jXrWiExvezvxGT/1W1lAQyRSup1PPy/1iTckZBiky/Nc4TrUcBDEF
         IXd9LuTMjWc46wknIhuvht3ibOU/+ukWC6gwE/ZncgnG4UpSVO9UtqI0ARq6iQpN3/OD
         vMfTikKAzLvw/OtBPVHo1vkhMg6wAdqxX3lIrQRrRX7Noi9MeoWjE572TjDgsW8qIQQS
         5cVQ==
X-Gm-Message-State: AOAM530woFLZfaKTEavLcgTuHZ5sA3vhEUBkFlcLEJEWktHHPoyq65Ww
        BBdHtw+CdMQzW1eF0dMumIgwKOJNlUw=
X-Google-Smtp-Source: ABdhPJyWDkinSCUm9zft6cHkyKNdVmo/WGHllxiqqkh9fJ6kEY5CAqGNVJKdJuZO/r0qAdlIoVQflA==
X-Received: by 2002:a17:907:271c:: with SMTP id w28mr26749459ejk.140.1608030908404;
        Tue, 15 Dec 2020 03:15:08 -0800 (PST)
Received: from [192.168.1.240] (108.45.90.146.dyn.plus.net. [146.90.45.108])
        by smtp.gmail.com with ESMTPSA id c11sm18668681edx.38.2020.12.15.03.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:15:07 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/1] Hashed mailmap support
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <558dc3da-e0c4-2e7e-83b3-e8f8c431a696@gmail.com>
Date:   Tue, 15 Dec 2020 11:15:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff, Ævar, Brian

On 15/12/2020 01:48, Jeff King wrote:
> On Sun, Dec 13, 2020 at 01:05:38AM +0000, brian m. carlson wrote:
> 
>> Note that this is not perfect, because a user can simply look up all the
>> hashed values and find out the old values.  However, for projects which
>> wish to adopt the feature, it can be somewhat effective to hash all
>> existing mailmap entries and include some no-op entries from other
>> contributors as well, so as to make this process less convenient.
> 
> I remain unconvinced of the value of any noop entries. Ultimately it's
> easy to invert a one-way hash that comes from a small known set of
> inputs. And that's true whether there are extra noops or not.
> 
> The interesting argument IMHO is that somebody has to _bother_ to invert
> the hash. So it means that the old and new identities do not show up
> next to each other in a file indexed by search engines, etc. That drops
> the low-hanging fruit.
> 
> And from that argument, I think the obvious question becomes: is it
> worth using a real one-way function, as opposed to just obscuring the
> raw bytes (which Ævar went into in more detail). I don't have a strong
> opinion either way (the obvious one in favor is that it's less expensive
> to do so; and something like "git log" will have to either compute a lot
> of these hashes, or cache the hash computations internally).
> 
> I think somebody also mentioned that there's value in the social
> signaling here, and I agree with that. But that is true even for a
> reversible encoding, I think.

 From an obscurity point of view one possible advantage of using a 
one-way function as opposed to just obscuring the raw bytes with a 
reversible encoding is that looking up an old identity requires someone 
to have both the .mailmap and the repository, they cannot get the old 
identities by just downloading the .mailmap file. (I think this the same 
argument as Ævar makes in favor of a reversible encoding as the .mailmap 
file has other uses)

Best Wishes

Phillip

> -Peff
> 
