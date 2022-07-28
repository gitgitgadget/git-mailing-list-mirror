Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9EDC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 19:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiG1TtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG1TtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 15:49:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35831B7BE
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:49:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e15so3460964edj.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=wtb5cKEbk4enr3onXGm1wObrLOXs+BYJTYbISCQSkzc=;
        b=lUET6OLTbyjwJKc4XkGf1IwXKtQGlWRErT0BBn3a+x4XmmXwc36PpXnN1M4zDrC4fL
         qsjI4oasSzndn+fbtxYO4uMr3JbvoryeSgKgKWS7zDUfDCWztuADX6h+45CVhIQW1rXd
         a1YepQTkl/J6dtBa/I84NoGzluluZwnZHQU03d+1e6U3/ivW4XqcRBUgOB7mBfQAhvLx
         DkvQVcttq2+kwQHGG2D4wvLjTrh+FFmyD+izAe8tzEHSPw5SlpNbeoXusKdpaOOukze3
         lNu8RakB7c3Mr2Jf352s7xEWDKMP4H0Dgcn6wXezVIVjgOK2iQj5mmknEBMpBaYePi4O
         78/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=wtb5cKEbk4enr3onXGm1wObrLOXs+BYJTYbISCQSkzc=;
        b=ilnrMoxah+sPuLShjhT1xJJIr40cfDXTnKJdezIJcSGZs/mGKe/tOVoLGDyUXgKpU8
         YgMKPKmdbNqEEQB1qUGOiwJejv3wMoT0tXfz79R6dDQqcFV1urCcQZLVx5JVFhAPt512
         bB4Z2Hdu3uxV+urB8vpCfwVGUXs8WP00iOn0qd99Zix1lY/vLJfkVRdZJuG+JgJmqTNR
         4e7UDmf0dqUrtFgBpeTrcg3vS62IHqMZsz9NIVqq1g42VrGVl2SC8Mm31RbjusjjibOs
         7Clzg4By+TX4wvkGp32dTSqobMVlTwTcgvSTCUsHY1qyelniufmPwzlLdHQFFqN0S/w4
         0p6g==
X-Gm-Message-State: AJIora+R2CV1VBMZKZmnEzg1Fu4TjPnfZz/4C91PHUItq69oiwbfOBMy
        IRrb3uPn2tJAZgtzYAZfrE0=
X-Google-Smtp-Source: AGRyM1tvkXP+NN7inc6D02UBTlk+kdJY9BM+6HcYsP/vThZlIECzruRZZTAIbDr8nCp3B8bQI0LUkg==
X-Received: by 2002:a05:6402:1e8f:b0:43a:ddfc:5c4e with SMTP id f15-20020a0564021e8f00b0043addfc5c4emr516109edf.358.1659037744143;
        Thu, 28 Jul 2022 12:49:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906560b00b0072b2eab813fsm747977ejq.75.2022.07.28.12.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 12:49:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH9VG-007EPe-5M;
        Thu, 28 Jul 2022 21:49:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
Date:   Thu, 28 Jul 2022 21:46:49 +0200
References: <1196830250.20220726145447@yandex.ru>
 <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
 <xmqqo7x9ch7n.fsf_-_@gitster.g>
 <220728.86k07xjh11.gmgdl@evledraar.gmail.com> <xmqqwnbxb092.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqwnbxb092.fsf@gitster.g>
Message-ID: <220728.86fsilj9w1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> That algorithm section also says:
>>
>> 	The cost of an edge o--C is the size of C's diff, modified by a
>> 	fudge factor that should be smaller than 100%.
>>
>> Which I find quite confusing to follow, isn't that "fudge factor" the
>> <percent> (or <factor>) we're accepting with --creation-factor? Doesn't
>> that also need to be adjusted?
>>
>> I still find this documentation quicke lacking, if the default is 60 and
>> it's not 0..100 what is it then? Are values of 200 sensible in some
>> cases, 1k? 10k?
>
> I think 90% of your responses are better answered not by me.  Feel
> free to edit "to:" header field when that happens next time ;-)

It's a comment on your patch: If you're updating the <percent> early in
the doc, shouldn't the proposed update also update the wording later on
to refer to "factor?"

