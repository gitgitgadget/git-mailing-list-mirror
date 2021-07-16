Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0CAC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F151613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhGPQwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQwE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:52:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B15C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:49:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bu12so16189178ejb.0
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OZc6nxa0VO7wMCa8wMROhcZYd5jCgzll6SV7TzVaIY4=;
        b=mrA2MTXL9BFR+zaVCFYBpeh+t1rTNa7qKkN+FoS0KN5VIo0Z6fApp7qZLju76rXl8I
         2RCWWkZW6feMXSBGa6WsAnZGDYejkYmBhlESNfOhc9XZptJpPPqew6MoAj+WH4HzeYAq
         s7hFZcz+Fn+m7ZUlLTJw1yVhndoR+fcUxfnCCrcv/bVV971VFzFAz1URRv83auzSlvQB
         4l2OuL7p2yCOEPvuShv2655j1G7M6tTZgh0Uk71oigxP6+m5/bZHerIwSVqxyDcYaTiZ
         oJ5LsFUAbZtgOWu+1bq4Ebos6irdeF41Rn7DBXsETN/uqDM0B2GXizC6vofQOK78fwRL
         f/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OZc6nxa0VO7wMCa8wMROhcZYd5jCgzll6SV7TzVaIY4=;
        b=LXf0ZubFY+Qh5eEe56rEH7r8+954CJ5BP49ToUU5Hq1tRd/N2tRFq3XuONPyKk5U1t
         NDwoLdH9iQlFobkEcQZWCuyH4WiJ9Y2z4NF0ir6fKWDGZuKs0/2QIYj4MtYSQ+rV7if8
         VaeYsisxkcakkJds/6O1s/l9lFD/2etAMOLBs0wt33ZoDh7cFs/9rAqNzdYEzei/Geua
         ACpF3v2BSVKVTnxX0i6os2bhR57peFtBJR0bY6rzAJGR7jkUHGo4V6TWsqtwhcZv72kE
         QQ0FF+oQtUt3yhdjbmFzTKadFdUle4XhyoEzr3pEgST+yKxLaRV4jf4TvwMUhxkxCIyt
         +9lA==
X-Gm-Message-State: AOAM530+5Xa92WLTgSMlc9rCtu6i1bpUJsilxwGRjAUvqXYHhIypBQJe
        CC1YxVRwuWKC4reC4Gi7WSM=
X-Google-Smtp-Source: ABdhPJwkgazwmu1ql9UgYnjyaNd5HHwdaqDokFcheJ2TvZAZ8K2fLt09Djgmn6cHQjBvwMIqkBnyrw==
X-Received: by 2002:a17:906:5392:: with SMTP id g18mr12865994ejo.518.1626454146452;
        Fri, 16 Jul 2021 09:49:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l16sm3103438ejb.26.2021.07.16.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:49:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Wong <e@80x24.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
Date:   Fri, 16 Jul 2021 18:27:44 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
        <87k0m9bpmv.fsf@evledraar.gmail.com>
        <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
        <87mtqq2i3r.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
Message-ID: <874kcuxkz8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 13 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Tue, Jul 13 2021, Jeff Hostetler wrote:
>>
>> > On 7/1/21 7:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>> >>
>> >>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> >>>
>> >>> Teach the win32 backend to register a watch on the working tree
>> >>> root directory (recursively).  Also watch the <gitdir> if it is
>> >>> not inside the working tree.  And to collect path change notificatio=
ns
>> >>> into batches and publish.
>> >>>
>> >>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> >>> ---
>> >>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++=
++++
>> >> <bikeshed mode> Spying on the early history of this (looking for the
>> >> Linux backend) I saw that at some point we had just
>> >> compat/fsmonitor/linux.c, and presumably some of
>> >> compat/fsmonitor/{windows,win32,macos,darwin}.c.
>> >> At some point those filenames became much much longer.
>> >>
>> >
>> > Once upon a time having "foo/bar/win32.c" and "abc/def/win32.c"
>> > would cause confusion in the debugger (I've long since forgotten
>> > which).  Breaking at win32.c:30 was no longer unique.
>> >
>> > Also, if the Makefile sends all .o's to the root directory or a
>> > unified OBJS directory rather than to the subdir containing the .c,
>> > then we have another issue during linking...
>> >
>> > So, having been burned too many times, I prefer to make source
>> > filenames unique when possible.
>>
>> A much shorter name like compat/fsmonitor/fsmon-win32.c would achieve
>> that goal.
>>
>> >> I've noticed you tend to prefer really long file and function names,
>> >> e.g. your borrowed daemonize() became
>> >> spawn_background_fsmonitor_daemon(), I think aiming for shorter
>> >> filenames & function names helps, e.g. these long names widen diffsta=
ts,
>> >> and many people who hack on the code stick religiously to 80 character
>> >> width terminals.
>> >>
>> >
>> > I prefer self-documenting code.
>>
>> Sure, I'm not saying daemonize() is an ideal name, just suggesting that
>> you can both get uniqueness & self-documentation and not need to split
>> to multiple lines in some common cases to stay within the "We try to
>> keep to at most 80 characters per line" in CodingGuidelines in this
>> series.
>
> While you are entitled to have your taste, I have to point out that Jeff
> is just as entitled to their taste, and I don't think that you can claim
> that yours is better.
>
> So I wonder what the intended outcome of this review is? To make the patch
> better? Or to pit taste against taste?

Neither, to address a misunderstanding.

Sure, if a reviewer points out "maybe change X to Y" and the reply is "I
like X better than Y", fair enough.

My reading of Jeff H.'s upthread was that he'd misunderstood my
suggesting of that Y for a Z.

I.e. that shortening a name like fsmonitor-fs-listen-win32.c (X)
necessarily had to mean that we'd have a win32.c (Z), negatively
impacting some debugging workflows, as opposed to just a
shorter-but-unique name like fsmon-win32.c (Y).

Ditto for daemonize() (X/Z) and spawn_background_fsmonitor_daemon() (X).

I'm certain that with this reply we're thoroughly into the "respectfully
disagree" territory as opposed to having a misunderstanding.

I also take and agree your implied point that there's no point in having
a yes/no/yes/no/yes argument on-list, and I did not mean to engage in
such a thing, only to clear up the misunderstanding, if any.

I'll only say that I don't think that something like long variable/file
etc. names is *just* a matter of taste, seeing as we have a fairly
strict "keep to at most 80 characters per line" as the 2nd item in the C
coding style (after "use tabs, not spaces").

That matter of taste for one developer objectively makes it harder to
stay within the bounds of the coding style for furute maintenance.

We do have active contributors that I understand actually use terminals
of that size to work on this project (CC'd, but maybe I misrecall that
for one/both). I'm not one of those people, but I do find that
maintaining code with needlessly long identifiers in this codebase is
painful.

E.g. in a patch I just submitted I've been working on similarly long
identifiers in the refs code[1], and with say a long variable/type name
and using a long-named function you get to the point of needing to place
each individual argument of the function on its own line, or near enough
to that.

1. https://lore.kernel.org/git/patch-7.7-cb32b5c0526-20210716T142032Z-avara=
b@gmail.com/

