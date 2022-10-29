Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E6AC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 02:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJ2CYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 22:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2CYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 22:24:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2213F47
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 19:24:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so16925047ejb.13
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 19:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AMIn5zskXLrHz1h991Fro5vjImXiLcnLlTDw+hQ1VeQ=;
        b=iu8DypiOU4vAddEgdysntMnMGYqiaT2l9c31Nyxoo8btyD13eMIzGkfMudjHXlSiDG
         Xh4VM5dcAmgTJRfSz+XLcslLWKnajJA8cXXKQGQRmselF7xt4udEhYnQxgohpk9C+bGt
         YOeKT2znWCO1vPf2zzaaRxjqFU+vmobQCSqtIvxHQLuk3MhTjocz6oxwUXNhozHzGhcC
         Tn2SqbLF30CY7rBEUQqJ7vtD4fNPYgqL+IoTlY4kqOzlwknhbnrjRvObey3PVaEI19NX
         SvBJaZXk6mh/VmwURPBWal6du1Aj2qFF37faegTpINVbFU2aZbgb4BCOrKEXsxAC9S0E
         HUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMIn5zskXLrHz1h991Fro5vjImXiLcnLlTDw+hQ1VeQ=;
        b=BkAaFLy9I0fyTCKprBobRFx5s03mWhuNoJ1XkSj6DpobtnNzZksVuvi2JBChjku3no
         fB9kG34v7kF/VnISoj3MzyfO0tE1IuN9WY1XasRG1pMsfL0XPDC5bp3jq+/pMOYRPFXu
         U2iWu24KwcxR7pLFOM629flDiIEphFYUawQKT4aHoPqWC8sigZhJnmyg4qsrOflNFGxk
         ww7aUB7qQk5XITBKJeAf9b1AI+gkluKVBGqfF3kJwZG6BYCgQlSjwvxIW5rGl41O7Vpg
         qJOdU4jQIyVVBBQaiOPfQaaMmKkUpPn4sUEmUimSpqbGnj2yWei/Kzmk+1daNGHgcA3k
         sE4g==
X-Gm-Message-State: ACrzQf1nnJ4d7/czZ1sJjFjt5ziMIYT98iL4w42Niw+jMg/XVR0EyPyj
        FKRBRf1BH/2NhFM11uumiqU=
X-Google-Smtp-Source: AMsMyM64f851sxDOPCDu7SlOWKLz/VHSkyAdQfvBNOK/VSMsBYMuSqLwYsJVV0PkIpRs0YekvckmKg==
X-Received: by 2002:a17:907:31c3:b0:770:852b:71a2 with SMTP id xf3-20020a17090731c300b00770852b71a2mr2017055ejb.557.1667010278961;
        Fri, 28 Oct 2022 19:24:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x25-20020aa7d399000000b0045c010d0584sm147517edq.47.2022.10.28.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:24:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oobWW-00A5Ia-0v;
        Sat, 29 Oct 2022 04:24:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Date:   Sat, 29 Oct 2022 04:17:23 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <221028.86edusan0k.gmgdl@evledraar.gmail.com>
 <749f6adc-928a-0978-e3a1-2ede9f07def0@web.de>
 <221028.8635b87wo6.gmgdl@evledraar.gmail.com>
 <b200477c-f856-f107-b897-63721c805093@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <b200477c-f856-f107-b897-63721c805093@web.de>
Message-ID: <221029.86y1sz74ez.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.10.22 um 18:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Fri, Oct 28 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 27.10.22 um 23:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> - I wish C had a nicer syntax for not just declaring but squashing
>>>>   together compile_time bracketed lists (think set operations). But the
>>>>   below "CHILD_PROCESS_INIT_LIST" is a pretty good poor man's version.
>>>>
>>>>   I see gcc/clang nicely give us safety rails for that with
>>>>   "-Woverride-init", for this sort of "opts struct with internal stuff,
>>>>   but also user options" I think it works out very nicely.
>>>>
>>>
>>> That's a nice and simple macro.  I played with a gross variant =C3=A0 la
>>>
>>>   #define CHILD_PROCESS_INIT_EX(...) { .args =3D STRVEC_INIT, __VA_ARGS=
__ }
>>>
>>> which would allow e.g.
>>>
>>>   struct child_process cmd =3D CHILD_PROCESS_INIT_EX(.git_cmd =3D 1);
>>>
>>> Yours is better,
>>
>> I actually think yours is better, anyway...
>>
>>> but they share the downside of not actually saving any lines of code..
>>
>> To me it's not about saving code, but that it's immediately obvious when
>> reading the code that this set of options can be determined and set at
>> function or scope entry.
>>
>> We tend to otherwise have creep where the decl and option init drifts
>> apart over time, and with complex init's you might stare at it for 30s,
>> before realizing that between the decl and fully init ing it often 50
>> lines later nothing actually changed vis-a-vis the state, we could have
>> just done it earlier.
>
> Hmm, we could do that by collecting the flag setting parts at the top,
> without the need for a new macro.

You mean just to pinky promise to always try to set the flags right
after we declare variables. Yes, we can try to aim for that, but
sometimes you need to declare quite a few of them (e.g. that difftools
caller), so not having distance between the decl & setting can help.
>> I think that's worth it in general, whether it's worth the churn in this
>> case...
>>
>>>> - We have quite a few callers that want "on error, die", so maybe we
>>>>   should have something like that "on_error" sooner than later.
>>>
>>> We could add a die_on_error bit for that, or start_command_or_die() and
>>> run_command_or_die() variants (there I go again, multiplying APIs..).
>>> They could report the failed command, which a caller can't do because
>>> the internal strvec is already cleared once it learns of the failure.
>>
>> *nod*
>
> Wait a second: Does it even make sense to mention the command in a die()
> message after start_command() failed?  Unless .silent_exec_failure is
> set, start_command() already reports it.  E.g. archive-tar.c has:
>
> 	if (start_command(&filter) < 0)
> 		die_errno(_("unable to start '%s' filter"), cmd.buf);
>
> ... and the result looks like this upon failure:
>
>    $ git -c tar.tgz.command=3Dnonsense archive --format=3Dtgz HEAD
>    error: cannot run nonsense: No such file or directory
>    fatal: unable to start 'nonsense' filter: No such file or directory
>
> The second message is mostly redundant, but it mentions that the failed
> command was a filter.  Probably .silent_exec_failure should be set here,
> then the die() message is no longer redundant.  This requires args[0] to
> be stored outside of struct child_process, though, which is already done
> here, but may be a bit tedious in other cases.

Yes, maybe these messages aren't all that useful. But note that that
"error" is emittted by thy "#ifndef ...WINDOWS..." part of the code. See
also the recent 255a6f91ae4 (t1800: correct test to handle Cygwin,
2022-09-15).

But I suspect some of the "die" messaging is just boilerplate/legacy.

> So for start_command(), would it be a generally useful to support a
> scenario where upon failure
>
> - the program terminates,
> - but before that prints a single message,
> - which includes the command that could not be started

Isn't this just the "cannot spawn"/"cannot fork" etc. messaging from
start_command() now?

> - and some kind of hint why we tried to start it?
>
> For run_command() we'd need to distinguish between not being able to
> run the command and getting an error code from it after a successful
> start.

*nod*, it would be nice if that messaging was portable. Part of that
just seems to be that we need to do the same (or share) the whole "set
die message" part we do on *nix.

Some of the reasons a command fails aren't portable, but we should be
able to portably emit e.g. "can't execute this command because it
doesn't exist" etc.
