Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01599C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 12:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiATMEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiATMEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 07:04:09 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C258C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 04:04:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l5so10628608edv.3
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=a6JssZaP0+N2cVrvZYTzUAbZpjMETpEfQTCZIz7S+Sw=;
        b=aV3esALaQ8B+rNXKxtMUp4qFP0zimEKRrzGSXTgpdhZW/SPBpugD+55lsT3ATTSwBD
         OO5efk+2CVT5FYh4ZRVnMyRfHGqGPouLi47pF4ZLpWWumVDmpFQt25yjs9RdpnSqWkso
         T4fgIcbQsSxJqnJPT3AnDnqe0zPKez3XYWPUotQtVnerjqlzY6NvkTvgzWKIZ9UmukRn
         VUoBaMU2NGq0DrDLRF4edH6flvq5oeElBOpUklgMNSjJnOeSz0+R6VOXFgFzIkcrANa4
         8wLbIPeGbvm7E/SuBIRQ54/ShJstoZNMYQXqg3U7RTgjz3lsflqkkZg1HKmWzG61Maaf
         QjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=a6JssZaP0+N2cVrvZYTzUAbZpjMETpEfQTCZIz7S+Sw=;
        b=NWYQ2oJ1vi4fbgUoOAchg0qkekHfS57WorvjQvBKp/w3lkJYyeloVWvsnloO1vCjgf
         Twl22rRK7nPMQJBt3ilQPPuEtMJ4GjjW/q7vBHelyBEwXbYKlrEE8guQEAJJlKqBUiZR
         LhtTmGu+zey0SXKLic2eiy4cBRD3AVyUTXul99mGjOS1nxr2ZcG3VIgLw0zPkHfSHUhP
         EaAmVZQsO3ewVugEe7qiO/vDdlFkwNPBW4Au9iqGF0iM/JzRkkGPFTgHMJS35fPL7KCh
         mZpgNhAmzaAUXOgiob3fxUbC3yb3XFj6qn5HsEuTsPPNh0/PxWDFyTsvHbaSjX74TsPs
         FuHQ==
X-Gm-Message-State: AOAM531UydqO+JKKmobRuWSHlrOzci3b1siN8Dl9jt2S5m+lfc90e99f
        a4nJl9j4D1yu5lfAllJyO27bIcoWEaV7Qg==
X-Google-Smtp-Source: ABdhPJzAFHCrf+VGSCEAZN/8W6OT1J3iRD+s8qNAVZfj1mxCaCtqstEsuCP14FXHcNnGE3uwm+zuUg==
X-Received: by 2002:a17:906:1790:: with SMTP id t16mr6660959eje.396.1642680247849;
        Thu, 20 Jan 2022 04:04:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k4sm766745edo.55.2022.01.20.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:04:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAWAg-001xmq-Gd;
        Thu, 20 Jan 2022 13:04:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        chooglen@google.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: incorrect 'git (checkout|branch) -h' output with new --track
 modes (was: [PATCH v8 2/3] branch: add flags and config to inherit
 tracking)
Date:   Thu, 20 Jan 2022 13:00:22 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
 <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
 <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <55d5327a-9c6c-7fd8-b540-e710259c0694@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <55d5327a-9c6c-7fd8-b540-e710259c0694@web.de>
Message-ID: <220120.864k5ymx55.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 19 2022, Ren=C3=A9 Scharfe wrote:

> Am 11.01.22 um 02:57 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Dec 20 2021, Josh Steadmon wrote:
>>
>>> Since we've added an argument to "--track", also add "--track=3Ddirect"=
 as
>>> another way to explicitly get the original "--track" behavior ("--track"
>>> without an argument still works as well).
>>> [...]
>>> -'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
>>> +'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname>=
 [<start-point>]
>>
>> The usage info here is correct...
>
> Actually it isn't, because optional arguments need the equal sign.  I.e.
> this works as expected:
>
>    git branch --track=3Ddirect branch
>
> But this here interprets "direct" as a branch name (and branch as a
> start point):
>
>    git branch --track direct branch
>
> The usage string could start with:
>
>   'git branch' [--track | --track=3Ddirect | --track=3Dinherit | --no-tra=
ck]
>
> ... or the less repetitive:
>
>   'git branch' [--track[=3D(direct|inherit)] | --no-track]
>
> Options with required arguments accept either whitespace or an equal
> sign between option name and arg.  With PARSE_OPT_OPTARG we cannot
> accept whitespace because we cannot decide whether the next thing after
> the option name is an argument or the next parameter.

Well spotted. Your downthread patch LGTM (with the small nit I noted
that having an optbug() check for this would be even better).

>>
>>> ---track::
>>> +--track [inherit|direct]::
>>
>> ...as is this...
>
> Same here:
>
>    --track[=3D(direct|inherit)]
>
>>
>>> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git=
-pull(1))"),
>>> -			BRANCH_TRACK_EXPLICIT),
>>> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
>>> +			N_("set branch tracking configuration"),
>>> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>>> +			parse_opt_tracking_mode),
>> ....
>>
>>>  	struct option options[] =3D {
>>>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at name=
d commit")),
>>> -		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for n=
ew branch"),
>>> -			BRANCH_TRACK_EXPLICIT),
>>> +		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
>>
>> ... but these are not. I.e. we'll emit:
>>
>>     -t, --track[=3Ddirect|inherit]
>>                           set branch tracking configuration
>>
>> I.e. implying that the valid uses are --track, --track=3Ddirect, and
>> --trackinherit.
>
> Well spotted.  It should be specified as "(direct|inherit)" (i.e. with
> parens).

*nod*

>> It looks like the problem is (ab)use of PARSE_OPT_OPTARG, i.e. it was
>> never meant for an enumeration of possible values, but for something
>> like N_("mode"). It could be made to support that, but it would require
>> some light patching of the releant bits of parse-options.c.
>
> Could you please elaborate that point?  AFAIU PARSE_OPT_OPTARG just
> requires arguments to be attached with equal signs and there is no
> limitation regarding the number of possible argument values.

I'd skimmed the code & -h generation, but see on a second reading that I
was just wrong about this.

I.e. I thought it would always misformat alternate args, but as your
downthread patch shows where we'll now for "git am -h" emit e.g.:

    --show-current-patch[=3D(diff|raw)]

The output is now correct (and was before, we were just giving the flag
rudendantly).

>> The PARSE_OPT_LITERAL_ARGHELP should also be dropped if it's fixed to
>> use a string like "mode".
>
> That's true.  And it's also enabled automatically if the argument help
> string contains any of the following characters: ()<>[]|.  So basically
> it's never needed explicitly..
