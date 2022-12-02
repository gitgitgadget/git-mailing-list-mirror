Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37498C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiLBTLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiLBTLw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 14:11:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A1ED692
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 11:11:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l11so7712760edb.4
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7y4Bpw/JKU52oLKgcxHJ+L8X+b1FseOi2gquV/kbMCo=;
        b=GXJ6z0N7fkdnxV96mOF3fl9qaFqXJ+ZreNmifa4pUXG21EZ+5eCOYEG35QEgNTV31A
         tS+ZVX0JKyN3SHoe9O9qwwsUx4OYloZTou7Wab2MV3XKAc77GGUD7nY6qNb/SVyexYKw
         dHVyCV1OCppJbRj8Ezbi79bfsE13PEspxRRWMIpPdKPAsCRKbkF14+AP5lPqr7bGDJwl
         MwWOIqY/dMKRtUtkMsVvzw3hzPA+lt77dEES4zCZbuBDuW1dhkWyAaRIjWvTQDfTyg5n
         i0jg4jXaXesHMboz/UY3FnefNK4aBvJ5vkA7V2A5865XRD/hL6DALRNDE/0/YE5ZDlQv
         x0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7y4Bpw/JKU52oLKgcxHJ+L8X+b1FseOi2gquV/kbMCo=;
        b=o20KXFNVK7+Mi4wncxWrng09SiRVgc+U3Pz0wdv4Tx/U3IghrwCDRHZHY3Zkpr99jv
         Nw7EV/EN9Bb8TWphEC9xJ8lUXo40cHxc4XJhsunQMXxdCN8IZwsfqSAa3eDp2WXUVtXu
         f3WIaY/Hb2L4tT9j1GqEHbce5zyfDsDh40vD4y3cLTib+attz4F7axyhwoy7IyfmyK9n
         p5Jd2FbrQjbt+fxKefvNw43IET/2DLTuUoexP8DJtcQ1mBZjfxmf595RGXKQ6u7i6/HS
         wReGxi+D/cjMaPlO9CV/7sNppPbD/1Y4Al3q6MBFxZy2uqVCqjagXMmHTEGg1XLQeYWx
         GYuw==
X-Gm-Message-State: ANoB5plgRIICCG+iRjjXdT0VA1EufgVGctM6f8WeEVkr93+tXF5DM0lG
        IynmyuSwsg3NDBEl/xK/+qM=
X-Google-Smtp-Source: AA0mqf5mRSYyuyMVGDIk2mx/Xiyyh4pV8eawADs/h1F1IhaT7tF7GMRLZgF6OOJeC6gzZQquD9HweQ==
X-Received: by 2002:a05:6402:34d2:b0:468:37d5:9c6e with SMTP id w18-20020a05640234d200b0046837d59c6emr89990edc.344.1670008309796;
        Fri, 02 Dec 2022 11:11:49 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906310a00b0078ba492db81sm3326008ejx.9.2022.12.02.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:11:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1BRs-002pgE-2P;
        Fri, 02 Dec 2022 20:11:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Date:   Fri, 02 Dec 2022 20:08:37 +0100
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
 <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
Message-ID: <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Jeff Hostetler wrote:

> On 12/2/22 1:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Dec 02 2022, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhostetler@github.com>
>>>
>>> Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
>>> the suggested `FSEventStreamSetDispatchQueue()` function.
>>>
>>> The MacOS version of the builtin FSMonitor feature uses the
>>> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
>>> and process FSEvents from the system.  This routine has now been
>>> deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
>>> generates a warning when compiling calls to this function.  In
>>> DEVELOPER=3D1 mode, this now causes a compile error.
>>>
>>> The `FSEventStreamSetDispatchQueue()` function is conceptually similar
>>> and is the suggested replacement.  However, there are some subtle
>>> thread-related differences.
>>>
>>> Previously, the event stream would be processed by the
>>> `fsm_listen__loop()` thread while it was in the `CFRunLoopRun()`
>>> method.  (Conceptually, this was a blocking call on the lifetime of
>>> the event stream where our thread drove the event loop and individual
>>> events were handled by the `fsevent_callback()`.)
>>>
>>> With the change, a "dispatch queue" is created and FSEvents will be
>>> processed by a hidden queue-related thread (that calls the
>>> `fsevent_callback()` on our behalf).  Our `fsm_listen__loop()` thread
>>> maintains the original blocking model by waiting on a mutex/condition
>>> variable pair while the hidden thread does all of the work.
>> I just skimmed the code change and didn't see anything out of place,
>> but
>> one thing that's missing about this explanation is:
>> Ok, it's deprecated, but when was it introduced? I.e. we now
>> presumably
>> have a hard dependency on a newer API released with a newer version of
>> OSX?
>> Is it OK that we're going to throw compilation errors on older
>> versions
>> that don't have it? What version is that? Is that older or newer than
>> our oldest supported OSX version in general, or is the plan to support
>> older OSX, but those users would need to compile without fsmonitor?
>> Depending on the answers to the above (hopefully in a re-rolled
>> commit
>> message): Should we patch the bit in config.mak.uname where we do the
>> OSX version detection? I.e. if we're deprecating an older version anyone
>> still on it would be much better off with a straight-up "$(error)" from
>> the Makefile, rather than running into a compilation error, only to find
>> that we've stopped supporting that older version.
>
> Lots of questions here.  Let me take a quick stab at answering them.
> From [1] the old routine was introduced in 10.5 and marked deprecated
> in 10.13.  From [2] the new routine was introduced in 10.6.
>
> 10.5 (Leopard) was released October 2007.
> 10.6 (Snow Leopard) was released August 2009.
>
> So the only people that would be affected by this must be running
> exactly 10.5, right?  (Those with 10.4 and before don't have either
> API and are already broken regardless.)
>
> So, based on the ages of those two Apple releases, I'd like to think
> that we're fine just switching over and not having to ifdef-up the
> config.mak.uname.  (If it were a more recent change in the OS, then
> yeah the answer would be different.)
>
> Thoughts ???

That seems reasonable to me, but it came out in 2001, and we'd be moving
the dependency to a 2007 version.

Is that OK? No idea, I don't know how old of an OSX version people
reasonably run & want to compile Git on.

But in 842c9edec64 (fsmonitor: enable fsmonitor for Linux, 2022-11-23)
which is new in this upcoming release we seem to have set that
dependency at 10.4.

Now, you can unset FSMONITOR_DAEMON_BACKEND and FSMONITOR_OS_SETTINGS in
your config.mak.uname, but that's probably something that should be
noted more prominently.

Eric? [CC'd]
