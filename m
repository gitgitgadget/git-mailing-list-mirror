Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2213DC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 00:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiGNAcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGNAcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 20:32:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF222724
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 17:32:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g1so407866edb.12
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PJqYTKCFudzx2AAMv7mNIdrbl1nZ15lg57At9ylXBp8=;
        b=LjXYLAKLE76TXM5Vldu+pzr78m1ECsrunkjAqcANfqWs/TtLFE72iaJW4z4T6GXElW
         0jqp6FIiRLCuk7MhkUUYWFQAQ4PUNUl0IJR57RDpzQ8tr63QLAVsWZeFXdbc0cmvoSm+
         S1uCvVQMIHfnaZ+2jNjs7D8/iRopOR8MEvm+WNZTG457n4DCsc+GgVdnr8MRoFJZLnCo
         qly/AV9MDMmIh143YKH/HrWGJKmxazc+5+3oJRjWUkmqvM+Rs0EKFYb5cvAopCYUP8QG
         XY1+dL7yEjxwIzsQe/N1w3fVAAP+gH7918s+f1lkig9ENer2N813KoSxX4v1PCicp1Aa
         uzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PJqYTKCFudzx2AAMv7mNIdrbl1nZ15lg57At9ylXBp8=;
        b=usFQKitjZ/T7x0O1WMFTfA7G6ra6wT15NKMXBIvzlv3r6tNW5i4PnC1heCRei17vYk
         NVhkg7Mvc2iIde5zZhtbP75w+f+B9smUkWNNfmezgwm3uz0PxLUjW05URgsbuOlhqBHF
         R8ArVtKbV5R9XGy7WCZ0sSwQc0ROWlpdlO9JVO6dOwGTFgk41XRSpJKiwrxh/C4p+FXS
         KdsDS1dkFPZiJspf0tZAB6UjiIMqxrEIBDkJqerdp4eLUohAYe6FF+/FiadKDJweFr+/
         P98uVLGJ2Z/raxzZYS+t4rEEcYTBt3cn8dqZ5NvPuC1sp/+phTCYhTqbcz2Gnfx+0W7E
         SC2g==
X-Gm-Message-State: AJIora+Tm377/b7BWrQuY6duwaOYsg62jc/40vJseYNKbgPrCDMUBnYd
        Je2tUFDdQS42JT2Hlbdzy+E=
X-Google-Smtp-Source: AGRyM1uNnxjw48l7iVj/Qednmei0mP0v+VrbJeW1OU70UIO7QVyG4eIlGpvf8FUqWGKsCte85NAYgQ==
X-Received: by 2002:a05:6402:2786:b0:43a:dc4e:ea63 with SMTP id b6-20020a056402278600b0043adc4eea63mr8888539ede.175.1657758724345;
        Wed, 13 Jul 2022 17:32:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kj18-20020a170907765200b00722e603c39asm39666ejc.31.2022.07.13.17.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:32:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBmlu-0023Pj-Ru;
        Thu, 14 Jul 2022 02:32:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11)
Date:   Thu, 14 Jul 2022 02:22:13 +0200
References: <xmqqo7xufee7.fsf@gitster.g>
 <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
 <220713.865yk1456z.gmgdl@evledraar.gmail.com> <xmqqtu7ldmrz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqtu7ldmrz.fsf@gitster.g>
Message-ID: <220714.86fsj4356l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'm not claiming that we always use 129 when we're fed bad options etc.,
>> but rather that that's what parse_options() does, so at this point most
>> commands do that consistently.
>>=20=09
>> 	./git --blah >/dev/null 2>&1; echo $?
>> 	129
>> 	./git status --blah >/dev/null 2>&1; echo $?
>> 	129
>>
>> But yes, you can find exceptions still, e.g. try that with "git log" and
>> it'll return 128.
>
> Yup, that was my understanding as well.  We may have existing
> breakage that we shouldn't be actively imitating when we do not have
> to.
>
>> Which, I'm not saying should hold this series up, but just that having
>> reviewed it for a few iterations I'm not comfortable saying we haven't
>> missed something else, and given the nature of the past whack-a-mole
>> fixes it looks like you haven't really looked it either.
>
> "We haven't missed" is not something we can comfortably say, ever,
> aobut a series with any meaningful size.  I am not so worried about
> it, if it is your only worries.  Would it make it less likely to
> have introduced unintended bugs if we find a way to keep using
> parse-options?

I started writing something here, but found myself rewriting the last 3
paragraphs of [1] seen in the context below, so I'll just refer to that.

FWIW ejecting 11-14/16, i.e. these patches:

	- Turn `git bisect` into a full built-in
	- bisect: move even the command-line parsing to `bisect--helper`
	- bisect: teach the `bisect--helper` command to show the correct usage str=
ings
	- bisect--helper: return only correct exit codes in `cmd_*()`

Yields a result that I've got no concerns about whatsoever, and reduces
the diffstat from:

    7 files changed, 110 insertions(+), 207 deletions(-)

To just:

    4 files changed, 71 insertions(+), 67 deletions(-)

Which I think might be worth considering, similar to how the submodule
migration is happening in multi-step fashion. I.e. advancing the parts
that don't migrate it away from parse_options(), since I showed a way to
keep using it in [1] (while changing less code).

Or just merge it down, up to you :)

>> I'm referring to e.g. the thread ending at [3], where I pointed out that
>> "git <subcommand> -h" was broken, you apparently tested one of the
>> subcommands and concluded it wasn't broken, but clearly not all of them.
>>
>> Which, I'd be less concerned about if as pointed out in [1] we don't
>> have entirte bisect sub-commands that don't have any test coverage at
>> all, so whatever coverage we have probably has major gaps.
>>
>> 1. https://lore.kernel.org/git/220627.86mtdxhnwk.gmgdl@evledraar.gmail.c=
om/
>> 2. https://lore.kernel.org/git/220523.865ylwzgji.gmgdl@evledraar.gmail.c=
om/
>> 3. https://lore.kernel.org/git/220225.86ilt27uln.gmgdl@evledraar.gmail.c=
om/

