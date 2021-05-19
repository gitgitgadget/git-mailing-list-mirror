Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B72C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355C4611AE
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbhESJVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344889AbhESJVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:21:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C09DC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:20:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i7so1102936ejc.5
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ys6BluY7/aPsWg6Z7kuYa0kkNKF4gVcKWLSZfBrMbyQ=;
        b=hRYNf0jMLN7aFqtW7s7py8oajSUdI1qvEVr4oz3tBVsEg7zwymifJckgDpQQ5M9DH5
         JDL07X6j6+Im3yDHraEYmU7jJbmJBsCujeOZcUsEUycm71No7Nrd2/e6ybT7C+w2aRWB
         Yfruoz6VF2gbWbKcCTmMWF72MYDLOzo12i/LV0xaSeixrgfSwUaftr8WegcB7Fi+vXg3
         iY/uiwC/uExtdU52UC7BWmheGTD86X2WvuCoFRSW6hnJCnG6oajwxppA4Z8l/NBctGe5
         dC4Bdpri62NsW4tCkErijU/sMpLY8Q9ZqPykHlHu/V9su2oLu49g0IAXjDnDPUjf0kg6
         ZDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ys6BluY7/aPsWg6Z7kuYa0kkNKF4gVcKWLSZfBrMbyQ=;
        b=MxTHFs8AndcH0LiopMUgTiFLxpPC6+iytqVDn9wRNV2c9c1i9TJLz5oT8RcHopsnUj
         Y8W5KvV6K5ySEzqrt0IpOqIrq6obtXO4b5r5+LfjwLvC/eZvMK7pevlcJx2mz7mSkpBM
         OMG7xa5TEdAAvKhJAb1hMRKDPxAURHBIWCpLEWuOTFYUrxe+hsMQNr2iv3HayH3SsSG4
         8/xhKGUsy8qXFfgH+A6Bi5tSVniE+TcHKF4vBLqpe35ih3GoqWg25YBBt7gwoTxN8uIe
         Fgtk7HPQlQypKAx1mRQ+b35eqsccMa0rPwPg+HWMTambzldFwqIiO2QiQkO+b5uI/tiv
         do/w==
X-Gm-Message-State: AOAM530x6/qjfbhBqhEEPh2Wnp7utyvJxI4SpNUYlOV5WtoizkZ+L//a
        TNqk1mYSjVNAPGyHECvh/c0=
X-Google-Smtp-Source: ABdhPJzkS7uSvELu9GOpPVpdYuvpqaEX3wWqT3aRWTZAMN3xXy4s6/p7uxvRn0hf0266HcPdmawuuw==
X-Received: by 2002:a17:907:7654:: with SMTP id kj20mr11672626ejc.439.1621416020324;
        Wed, 19 May 2021 02:20:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m16sm2336869edq.56.2021.05.19.02.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 02:20:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Subject: Re: [PATCH] help: colorize man pages
Date:   Wed, 19 May 2021 10:41:44 +0200
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
        <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
        <60a332fd22dad_14c8d4208ed@natae.notmuch>
        <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
        <xmqqfsyj1qe1.fsf@gitster.g>
        <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
        <xmqq1ra3z23n.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq1ra3z23n.fsf@gitster.g>
Message-ID: <87lf8bqdv0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 19 2021, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2021-05-19 at 01:08:54, Junio C Hamano wrote:
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>> 
>>> > In general, this is made worse because Git doesn't honor the unofficial
>>> > but widely supported NO_COLOR[0], so reading the documentation is
>>> > obligatory.
>>> 
>>> I vaguely recall that we were contacted by NO_COLOR folks to be
>>> an early supporter of their cause to break the chicken-and-egg
>>> problem they were hagving, and (unhelpfully) answered with "sure,
>>> when we see enough people support it---otherwise we'd end up having
>>> to keep essentially a dead code that supports a convention that is
>>> not all that useful".
>>
>> Yeah, I seem to recall you were somewhat negative on it at the time, but
>> I do personally find it useful, and someone on Twitter reminded me of
>> it just today.
>>
>>> I wonderr if it is just a matter of hooking into want_color(), like this?
>>> 
>>>  color.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>> 
>>> diff --git c/color.c w/color.c
>>> index 64f52a4f93..2516ef7275 100644
>>> --- c/color.c
>>> +++ w/color.c
>>> @@ -373,12 +373,17 @@ int want_color_fd(int fd, int var)
>>>  	 * we always write the same value, but it's still wrong. This function
>>>  	 * is listed in .tsan-suppressions for the time being.
>>>  	 */
>>> -
>>> +	static int no_color = -1;
>>>  	static int want_auto[3] = { -1, -1, -1 };
>>>  
>>>  	if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
>>>  		BUG("file descriptor out of range: %d", fd);
>>>  
>>> +	if (no_color < 0)
>>> +		no_color = !!getenv("NO_COLOR");
>>> +	if (no_color)
>>> +		return 0;
>>> +
>>>  	if (var < 0)
>>>  		var = git_use_color_default;
>>>  
>>
>> Yeah, that will probably do it.  I hadn't looked at it, but I assumed it
>> would be pretty easy, and it looks like it is.
>
> Actually I doubt it satisfies the FAQ #2 of no-color.org; we
> probably would need to go one level lower, like the original
> proposal from 2018 did:
>
> cf. https://lore.kernel.org/git/87efl3emlm.fsf@vuxu.org/

[CC'd the author of that proposal]

It also doesn't seem to me to satisfy their FAQ point #1, i.e. users who
actually want no color at all can just set TERM=dumb, and we support
that. The proposed patch is the same as having TERM=dumb set.

This NO_COLOR=1 actually means something like "I do support colors, so
show them if it's important, but don't color things willy-nilly".

I'm not sure if it matters for git, the FAQ point isn't really clear on
what the distinction is exactly. Users who want to use color for say CLI
emacs/vim/screen/tmux "status" bars, but don't want any "normal" CLI
program to emit them?

But if we gained such a "status" bar feature the proposed 2018 patch
would be actively going against what NO_COLOR users want, since it's our
equivalent of TERM=dumb, not whatever NO_COLOR=1 is supposed to mean. Or
maybe we already have that, I would think that "git add -i"'s UI would
count.

It seems like it really should have been named MOSTLY_NOT_COLOR=1 or
ONLY_COLOR_NCURSES_LIKE_UIS=1 if I'm understanding that FAQ item
correctly.

So it would be incorrect to map it to either color.ui=never or
color.ui=always (as "auto" will implicitly do). We'd need a new knob to
control the granularity of coloring, something like
color.ui=conservative.

I wasn't against NO_COLOR before, but after writing the above I think I
am. I initially assumed that it was some redundant and more "friendly"
way of setting TERM=dumb, but rather it's some entirely subjective way
for every program to decide if their UI elements are "text-editor"-like
or "status bar"-like enough to warrant coloring.

That's "against" in the sense that if git supported it I wouldn't care
much, and wouldn't oppose a patch to implement it.

But it seems to me to just introduce even more confusion to the *nix
coloring landscape. For what it's apparently trying to accomplish I
think it would be a much better thing to:

 1. Have terminals/startup rc'd etc. set a TERM_ACTUAL=<old value>
    before setting TERM=dumb. This is something POSIX et al could
    eventually standardize, i.e. "TERM=dumb" for now, but actually I
    support "TERM=xyz".

 2. Have some "color_this" shell function/alias/wrapper to start things
    like your editor, which would just be a one-line wrapper to start
    that program with TERM=$TERM_ACTUAL, or those programs would learn
    to look at TERM_ACTUAL.

The user would thus get color almost nowhere in "normal" programs like
"git status" or "ls", but would get them in emacs, vim, screet, tmux,
htop or whatever other "big" terminal UI they run.

I.e. the whole point seems to be to support the use-case of wanting
color almost nowhere except a very small whitelist of programs, but
trying to accomplish it with NO_COLOR means that hundreds/thousands of
programs need to support it, as opposed to the much smaller list of
editors/terminal multiplexers etc.

Each of those programs then need to subjectively decide if their UI
elements are "such as [...] a status bar". If they get it wrong the user
is back to inovking them with TERM=dumb anyway.
