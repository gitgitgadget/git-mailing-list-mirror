Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91B2C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbiEZTP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiEZTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:15:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49256DFF46
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:15:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v15so496178edl.9
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=urHg7alqDGVuc0oPvbeKNdyKFWBS5IHe5dlVgEEcPco=;
        b=MH4GP2Jw8WuWYiJ9UtJXw2E5m7ai99RM11WgoRHS3BImPcNuXsFC2AgS8TlVLB7q+6
         8DM0OIf8UrfgV4BPjwmRbXW6BOGJBySOXgE4wcozmeSfjw2EBWYCMjYZFdJtn52DZ+Dw
         EbSMwbHZITfod7O4DEzA2gYeLTttwvTREYzD6CapERt7ea/Lv0ZtoVorufaat4BojqPL
         z3J5FBPnpkv12tmR3TZw6LnHvu1jPgY0dkOxjnjg8uvLFYIO47PH3intXDCZ6PLoGIMK
         30MIXJfMakmTThe0WKR5nXOp/VTlu5ttyrEdLbNt7UuCjkW+UlKRvT2zBglNhW3YeoeL
         ow8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=urHg7alqDGVuc0oPvbeKNdyKFWBS5IHe5dlVgEEcPco=;
        b=djySo5IHXcWKJEo7fQ+qIB5S24mZskLynUg7dLgD42G37dG2dTSFcT+xNnzDN3xj7+
         50AHGX2Qc4lHU4Q52E3xkYNfnlRVODnvx85O/HkjKnPJtrRXHhPmT4ct5hebq9PZQLD6
         6n3faZQ8KJwjYnd7p7Zb0C2Xv0W74UDbeR3FWcdliD5OQ5vCm4SElOhH+gFC2g9EA33W
         C6G2Qccp9prv5/nYTk/7k6OLX1zwEnX4HLa68hU0po4EQ/A2vWZ6NiKrDUPrjeXXaH0S
         0V/Rof30JSyx8gKPIOZyoR1HLOGPbyvSL5i5IAv9m/vrXEcGnxM6zjgczM3a1G6F466G
         9Eig==
X-Gm-Message-State: AOAM533OfRO80kUQHqkILu6YZClmcFxJGDWggfCUMbWlW0LJfh7dveMs
        2ry0soMBRqiGOQqeFbr2ZQ0ByvMMDHE8eA==
X-Google-Smtp-Source: ABdhPJxdb0iugvzXyAzNxJ5AxYXzWmiPKda/FZ18v+JypCwp41TK5GBRS5ns6PgHXFN+xehMwD+JBw==
X-Received: by 2002:a50:d48b:0:b0:42b:da11:4827 with SMTP id s11-20020a50d48b000000b0042bda114827mr4980541edi.216.1653592552783;
        Thu, 26 May 2022 12:15:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y8-20020a056402358800b0042617ba63b3sm1198224edc.61.2022.05.26.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:15:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIxb-000Gb0-9L;
        Thu, 26 May 2022 21:15:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
Date:   Thu, 26 May 2022 21:13:50 +0200
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
 <xmqqbkvl8s88.fsf@gitster.g> <xmqqczg13xpy.fsf@gitster.g>
 <220526.86pmk060xa.gmgdl@evledraar.gmail.com> <xmqqpmk01caj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqpmk01caj.fsf@gitster.g>
Message-ID: <220526.86ee0g3y1k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> The current proposal is large by line count, but it's relatively easy to
>> skim it and assure oneself that a new parameter is being passed in, and
>> that all the proposed behavior change applies only to the one caller
>> that passes in that new parameter.
>>
>> Whereas switching to a new non-callback based API will require carefully
>> going over the parallel API line-by-line, assuring oneself that the
>> non-callback version is really doing the same thing etc.
>
> I was worried about something like that when I wrote (admittedly
> unfairly, in a somewhat frustrated state) that the series was
> designed to be hard to revert.  The reverting itself was reasonably
> easy if the "did we invoke the hook, really?" topic is discarded at
> the same time, but if was done with too much rearchitecting, it is
> understandable to become cumbersome to review X-<.
>
> I wonder if rebuilding from scratch is easier to review, then?  The
> first three patches of such a series would be
>
>  - Revert cb3b3974 (Merge branch 'ab/racy-hooks', 2022-03-30)
>  - Revert 7431379a (Merge branch 'ab/racy-hooks', 2022-03-16)
>  - Revert c70bc338 (Merge branch 'ab/config-based-hooks-2', 2022-02-09)
>
> and then the rest would rebuild what used to be in the original
> series on top.  There will be a lot of duplicate patches between
> that "the rest" and the patches in the original series (e.g. I would
> imagine that the resulting hook.h would look more or less
> identical), but "git range-diff" may be able to trim it down by
> comparing between "the rest" and "c70bc338^..c70bc338^2" (aka
> ab/config-based-hooks-2).  I dunno.

I'm still happy to and planning to send a re-roll of this to try to
address outstanding comments/concerns, but am holding off for now
because it's not clear to me if you're already planning to discard any
such re-roll in favor of a revert.

Or do you mean to create a point release with such revert(s) and have
master free to move forward with a fix for the outstanding issue, but
not to use that for a point release?



