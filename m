Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40238C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiLBUvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 15:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiLBUuh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 15:50:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA24F2C48
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 12:49:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o13so14204250ejm.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 12:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=au0GpQNCJ3J7DbfplTxNML5eJ5ofrCHfk1kUufx2S04=;
        b=jbUkMeZSa3I4PONM+5ThyFWm6mxzDqX9Mi944QqkyLCX6uoxCJNHV68j4U1qXk6xjY
         k+u06YEq3mr9do6nzDk2uSk8myOWTTQW6jUIqiDKqKv9VUU3SVJ8DQ2kCs4jq6UhHzVO
         KD6BIZPcbLRG3QwxkOgNcv9/AaE+9ZCbkX/I7qeJDTKDlVl0Ny3k4IqD5YoJS5g+V1RL
         OH2NdJJu7ILPX6dkltbNLk5WmpVw/qWrbH0xy7/IdOi+8z8XENP4ZOJx5lKz7vhVqDE/
         dP+9VBFryWEplLJj/O8zV+Nm8lK9/tsakN/mzGM8YcaVDpgYNXVBZ1orIh/BAmsSkvBi
         ur1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=au0GpQNCJ3J7DbfplTxNML5eJ5ofrCHfk1kUufx2S04=;
        b=6zsvoNIn7v6Qn1+dkHMUtT+SdjYvHHPwjAYypG/taIGL5E52tvv2ISDZQFSFxjcXdC
         py2TNi1371QXcMOp/N6izQIUIsgUjXB0kWJe0iTcO2eDKW5XUxHNmAIyqIiuiVjWjb3z
         ft+N5j33Ot61j/tpPewapDpWzIYUATXAGEqBUiJsUUKN2azgUOtmEJFn/+3dqaQCTDNY
         i65eZjU2WvjJsbJs69gUnXvSxG3y/MQPvaQgS2iZTHAoyJVwJrkyw8Ual3VZi/uaceLT
         P1qagIM+jVyUGC70eSg32czClsrv9CldG3pBY34M3x2dQ5tvF25oPY1wlF9pzOuk4R8W
         /7kA==
X-Gm-Message-State: ANoB5pk0MHxwbsAO7BsUHJN6RWbMrtKlUWzAUyePrtb/J2477aRiokr3
        i8PK5seFusVyVnIuJ209Xv0=
X-Google-Smtp-Source: AA0mqf7ear9ZUuZ1ojaCzxi0of2KMduOZ0/ktWJ/5KLppotYco5fNXpn+tbZ2NwWjFxqgqFkLv1+tQ==
X-Received: by 2002:a17:907:3fa9:b0:7bf:5446:389d with SMTP id hr41-20020a1709073fa900b007bf5446389dmr23662634ejc.449.1670014145249;
        Fri, 02 Dec 2022 12:49:05 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u12-20020a056402064c00b0046b1d63cfc1sm3294572edx.88.2022.12.02.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 12:49:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1Cxz-002sH3-26;
        Fri, 02 Dec 2022 21:49:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Date:   Fri, 02 Dec 2022 21:34:56 +0100
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
        <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
        <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
        <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
        <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
Message-ID: <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Dec 02 2022, Jeff Hostetler wrote:
>>=20
>>> On 12/2/22 1:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> So, based on the ages of those two Apple releases, I'd like to think
>>> that we're fine just switching over and not having to ifdef-up the
>>> config.mak.uname.  (If it were a more recent change in the OS, then
>>> yeah the answer would be different.)
>>>
>>> Thoughts ???
>>=20
>> That seems reasonable to me, but it came out in 2001, and we'd be moving
>> the dependency to a 2007 version.
>>=20
>> Is that OK? No idea, I don't know how old of an OSX version people
>> reasonably run & want to compile Git on.
>
> I appreciate the diligence, but I don't think continuing this discussion
> will be productive use anyone's time.

It's quite useful in general to know the lower boundaries of what
versions of OS's are supported at all.

For example, we support non-GNU iconv implementations that have some
weird edge cases. As the config.mak.uname shows OLD_ICONV is required
for OSX 10.4 or later. If we know we'd like to draw a hard line at OSX
10.5 we can scratch it off the list of platforms we care about.

Anyway, that larger topic aside. All I'm suggesting here is that the
proposed patch seems to at least soft-deprecate versions of OSX we
supported before. Maybe that's fine, but the commit message didn't get
across whether that was considered, part of the plan etc.

> Apple doesn't seem to provide official end-of-life dates for their OS
> versions, but we can extrapolate from the list of obsolete hardware [1] t=
hat
> it likely doesn't support OS versions older than 2014; that's corroborated
> by their official set of release notes going only as far back as 10.14,
> released in 2018). In other words, I think it's safe to say that a version
> supplanted in 2009 is old enough to not warrant Git support.

I wish :)

It may happen to be true for OSX, and I suspect that OS has a relatively
aggressive timeline as OS's go, as opposed to AIX or something, which
people tend to run long past EOL.

But our support for OS versions has neither historically or currently
mirrored EOL dates.

A lot of those are *very* aggressive, e.g. FreeBSD's releases go EOL
around a year or so after release, and we certainly support building on
way older FreeBSD than that:
https://www.freebsd.org/security/unsupported/

For some other in-tree software we're >10 yrs past EOL:
https://lore.kernel.org/git/221124.865yf4plw1.gmgdl@evledraar.gmail.com/

In general I think OS EOL's are most useful as an indicator of what
versions of that OS you'd want to run in some Internet-connected
high-vulnerability scenario.

But git gets ported and backported to a long tail of systems way beyond
that. Eventually we do need to let got, but we've generally drawn the
line at some fuzzy notion of when users don't care anymore, along with
whether it's worth the effort to find out.
