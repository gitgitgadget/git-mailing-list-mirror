Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27049C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIGMgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIGMgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 08:36:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52EBB2862
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 05:36:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b35so1467748edf.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=AEf1Ca7OW0cAUrjkN5SgTcujx/HGQiViaXfzRF2KGJ4=;
        b=ELrX6+ukLRsd0rMWFHfgZn5ptbiNXwDT3Oe24CVRxaeTVocW2aPEHGd64C3XR0UyDb
         2Y4teEYlEfF26hY3z8X33wXk3CaNYIEJGJDm9helW+enRdy+STl8TvV2T/ZAnfmFn3qw
         micJAyTGbnfYPRXbtGTuaDMOP1/vWdJEL2ikeoSWq9WoJXUto258nOftq7ASAPb3fiT+
         /in57xnvryDoQ7TOVHIuSe/EYqrZbadzRLWUNDcGkBe1xWHLRQQpdJwXdsG3xWOaQzkU
         uMU1E1yFvOx9cJGT9ssv41EBHaRcZCbeoFt9FO997jHgUJWA0pM5eRZx/Ms1VftMGwXi
         ZG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=AEf1Ca7OW0cAUrjkN5SgTcujx/HGQiViaXfzRF2KGJ4=;
        b=KRGzlDtQX7DGYT8gB4dm4wHdv2/le33tm3xXoZSK2fjy/ObsbBB4+PrgMkgKteNnqQ
         oEDXT97yIwzEjm/ZeJ576J0OBz8621iZ6QIKGJcy9IWhwAR1CnQcS592lmCMg/5d630i
         Gxk6Idv6jZyo7lDXlZZazY54eix0L5Mzez6ACpHQ0g4a1j8CngjMw0/5ORMD9/8ifDn3
         cBvxob/sSampTCPC5etMzi1C5LcNYuPXs9DMVueLqVQGrVwuTxZoq0BEMpLM5JDdRmfh
         907S7dqN3wqCtzKw+NClHgIOc4RmosyfwKp3lSW3Ig8FAKuXgNTMWFbiYP/OM2z8EorW
         6Bog==
X-Gm-Message-State: ACgBeo1V+nFY3YKZ9vXwxdY4sBze3T2UTq5Ou0OgYrtDHIxWqLhzgrbY
        bs3gPO91pMhmDbS8Kq54abo=
X-Google-Smtp-Source: AA6agR5LrpqqEZ9CgJKZsQeIs69ysooXnoY8aj76vWe0b1QrUHOA0V4u5WyXfEZ9uEJcyjn0gxYhzw==
X-Received: by 2002:a05:6402:1b0c:b0:44e:8ae1:8016 with SMTP id by12-20020a0564021b0c00b0044e8ae18016mr2991679edb.342.1662554159054;
        Wed, 07 Sep 2022 05:35:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b0073d732e440asm8200230ejg.84.2022.09.07.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:35:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oVuHd-000lzA-20;
        Wed, 07 Sep 2022 14:35:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] diff --no-index: unleak paths[] elements
Date:   Wed, 07 Sep 2022 14:31:25 +0200
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <01pn98p2-qppn-260p-8o80-n5483p41859o@tzk.qr>
 <220905.86zgfekrqq.gmgdl@evledraar.gmail.com>
 <36q9s463-rno9-9rs1-7qsq-5oqq23o30o0r@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <36q9s463-rno9-9rs1-7qsq-5oqq23o30o0r@tzk.qr>
Message-ID: <220907.86mtbbl5ua.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 07 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 5 Sep 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Sep 05 2022, Johannes Schindelin wrote:
>>
>> [...]
>> > +	string_list_clear(&to_release, 1);
>> [...]
>>
>>  * The free_util=3D1 in your code isn't needed/is a bug, we make no use =
of
>>    "util" here, so it should be free_util=3D0
>
> Calling it a bug is a bit strong[...]

Yes, FWIW I meant that in the sense of "the author probably didn't mean
this" or "it was copy/pasted", but it has no effect currently, as we'll
always have NULL "util" members.

> , and misses the reason why I did it: future-proofing.

I didn't think it was intentional, but obviously you know better about
the intent.

"Future proofing" seems like a bad reason for that API use however. If
you look at the various "util" users some of them want to free() it, and
some don't. If you forget to free() the worst you'll have is a memory
leak, but if you have some boilerplate free() there you'll probably get
a segfault.

Without knowing what the future code looks like we don't know whether it
would make any sense to free() that util use.

> In any case, Ren=C3=A9 took up Junio's ask and provided a new iteration t=
hat
> side-steps this concern altogether, therefore the point is now moot.

Indeed, that patch LGTM.
