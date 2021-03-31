Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCC7C433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA7F6101E
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhCaTCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhCaTBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:01:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7CC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:01:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so31657678ejr.5
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RkUl5lf6PUNyUoD/OGqSgjfhHi+36TBTCxGwGVWEcMY=;
        b=qM37zaY+9DOthMJabpU8NmUV7ACRcwrnsjJ6+/j8piCcywE1kl0IxkQaSAuC+jM0lF
         QDb8pqBQ9JesVG2BEaeDtY73bX+xI+ILiQ7k96CsipXp5th0UaMvN/h+jZywoA7/nrlE
         vv11eIqlCLiDfWJfXrblm63wap05tWHNImoPZ11+B22+XYplRbfaNaLYOwg3tO6jhAWI
         TU+qC5jL5z1PeK1q6fqT/mhZITOC2XQHU5SyDGY75u500SJeqaRkqNfRVyBDGpZTxTE8
         w9Z8lXXvuqyen3qzm/roQdNEwf25onGmU1GvXTPb4EYEDHwvGVEOZrHJvoenLhsfLhJE
         kDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RkUl5lf6PUNyUoD/OGqSgjfhHi+36TBTCxGwGVWEcMY=;
        b=LmFD1GjmJ+/0lY+fPWWj2YcogoDjx3dDVaKkV3mSwie65yRlhLdctF0eFa5OO1VXFs
         BFZpfvtbW2enTzLlRNS9QCQjnFtfZS0lXUjFpSPu0ztvpAom8cAdIwPKJMTJTSzNayj1
         fK/ax3vwekTD+2lMk4GOwuBkQoJNqISm+qX9IxBD7wZZdmrqhe1s0V2ciKW28yo47dT9
         CMl5n76r+fVOBJ44RxziX5neuuVl91Oi6vCKas1wyboa7KgF0YkvcPDSMoFoXO40Bbgd
         oLDfZuJNpCROCb81odDq5k2m67djEccxMtvKJgNHbKDsQmjeRp9aRK3yOVrheM/YSTVm
         /ZeQ==
X-Gm-Message-State: AOAM5311oowPugOEiDOAlnBoN+s2BGtG4oVClCulp/RwBhcJP9xLStFP
        ZLIo8wOSQb3hfqfLjJw7r9w=
X-Google-Smtp-Source: ABdhPJzjhv5f584Lj1Z+5BZphMjlh0YYPhIUA2RsgINa2G1NcnY0TfTYbzB7rD1xy3R7nYh+CM+Lmg==
X-Received: by 2002:a17:907:248b:: with SMTP id zg11mr5089964ejb.364.1617217294771;
        Wed, 31 Mar 2021 12:01:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u24sm1693358ejn.5.2021.03.31.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:01:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Makefile: add a INSTALL_FALLBACK_LN_CP mode
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-6.7-9ada8979890-20210329T162327Z-avarab@gmail.com>
        <xmqqeefxh8rl.fsf@gitster.g> <87v997l8sl.fsf@evledraar.gmail.com>
        <xmqqr1jv6u2u.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqr1jv6u2u.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 21:01:33 +0200
Message-ID: <87h7krkv02.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 31 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> So I would understand if there are two orthogonal knobs
>>>
>>>  - the order of preference (e.g. hardlink > symlink > copy)
>>>  - which ones are allowed (e.g. "no symlinks please")
>>>
>>> but I cannot quite imagine how a system without any fallback would
>>> be useful.
>>
>> Because with explicit knobs I'd like to tell it what to do and not have
>> it auto-guess.
>
> So how would I explicitly tell "I want hardlinks for everything
> else, but use cp when going between /usr/bin and /usr/libexec"
> (because /usr/bin and /usr/libexec is not on the same filesystem
> on this particular box---I'll tell you to use hardlink everywhere
> on another box of mine where they reside on the same filesystem)?

Just as you would now:

    make NO_CROSS_DIRECTORY_HARDLINKS=3DY install

That'll get you hardlinks within bin/ and libexec, but copies between
them, and no symlinks.

The behavior change in this series is if your "ln" errors out we'll no
longer silently plow ahead and e.g. not hardlink *within* bin and
libexec in that case.

> Your argument or analogy with openssl does not make much sense to me
> in this case.

The point is the Makefile shouldn't be second-guessing explicit
requests. That's what defaults are for.
