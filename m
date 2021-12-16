Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F37C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhLPXmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhLPXmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:42:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C20C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:42:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so1442258edv.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wrDBbj1AFqz6z6WgF65Y68WalYcx/5jXrbYIRrQN2S4=;
        b=XKdSTMpL0Zzw4RCC4q4Vt8xRSBf2ghlpEuHh9XJPkBYewQiihG8/hzTCdx0OhgUB1X
         67B0TvUmqU/mVzFNnGPXKO6gx7jlHXw72RiVS+0CelghpeTtFKLtlR7G3mwRNuwjtmj+
         vb9bDcSVbghH/qbm++/dSsQSTnRYG3xsYB78rLomBPaW++EPK+M96P2GBzCktMK7NZjG
         97XOPTOghqfqILgPWx0lP762LLz4HeQpp7mSMzZFJu2fCr43CyccseulYp71N6dZam7M
         t7K1tHd1ffMQD0p73ju0a1HWSWcHjosqGRJ+NSmguO1DJvs14x027iM383HGWCN7r5al
         rcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wrDBbj1AFqz6z6WgF65Y68WalYcx/5jXrbYIRrQN2S4=;
        b=HbtnwIS073IHdvNiH8z04yWoODcqyEnIRHl/kuV/plBtAmTpj6nNgZ7+ByOc4h64D1
         0w/McnZtmOM5iGZIA5Dl9XAQfl9j90s3Rg+xj2nIoP8Q2iA4iLShp17he0hHb4P3t4iu
         bIMh/Is6fhbFIXT23bb+8f1pXSF0amOPMahDQ567MNanE5lClFiNRvKnU5hMHccQgaPI
         FrPUTyWQUq6+JEVT0zAPFY+cIgzBOgnBdSE93h7j9nHA607JAh32u54uBfIpkVNyeowL
         yNC25ke52loK7TDLEqu54pk/igx9di7jOnE0OQZQH/Bg2DRiZbhWR7PZKKilbB5m3zxD
         Acow==
X-Gm-Message-State: AOAM530DO8GMlxq0VElDpgl9nHL3jFeI9dHWTYUD2I5bDz1eMhIccxen
        y6pjcqOdhAPMdQFyMlxLbxzVO56Q0Dy/JQ==
X-Google-Smtp-Source: ABdhPJzn5Nw5nFo0WRKIFOxJtEoYqNtrWAg1Z+UhSDQT+21to/YXB8O+p9SPShd4dHdQMM5BuADCDg==
X-Received: by 2002:a17:906:3a03:: with SMTP id z3mr356165eje.326.1639698124220;
        Thu, 16 Dec 2021 15:42:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w7sm2904958ede.66.2021.12.16.15.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:42:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1my0Nt-000cq9-JX;
        Fri, 17 Dec 2021 00:42:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/9] reftable prep: have builtin/reflog.c handle
 "--verbose"
Date:   Fri, 17 Dec 2021 00:31:10 +0100
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
 <xmqq35ms89u2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq35ms89u2.fsf@gitster.g>
Message-ID: <211217.86ilvo9kxi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This series refactors various small bits of builtin/reflog.c
>> (e.g. using a "struct string_list" now), and finally makes it handle
>> the "--verbose" output, instead of telling the files backend to emit
>> that same verbose output.
>
> I was quite confused even after spending quite some time until I
> realized that you are primarily talking about the "-v" option of
> "git reflog expire" (and "delete", perhaps) and not about "git
> reflog -v" having different output from the same command without
> "-v" option.

Will try to clear that up in an eventual re-roll, but considering this a
"look at only if re-rolling for other reasons" for now.

> I'll refrain from commenting on, or picking up, the series until
> Han-Wen has a chance to take a look and give his input as it is
> unclear if it helps or crashes with his plan.

He hasn't reviewed this series.

But I think I/he have looked at it sufficiently that you might want to
consider picking it up, particularly since he doesn't work on Friday's &
with the holidays etc. it might be a while.

He commented on this helping with his plans recently here:

    https://lore.kernel.org/git/CAFQ2z_PSS9zOzR6nGYZ8DBK+6oOQzkJsEy_7y+Nprw=
J1OHNs7w@mail.gmail.com/

The snippet he's referring to can (last seen on-list, AFAICT) be seen
here:

    https://lore.kernel.org/git/3d57f7c443082fd2a7f01aee003a9cd3ca2dd910.16=
29207607.git.gitgitgadget@gmail.com/

Which from my reading of the code (I haven't actually tried to combine
this with reftable/* for real) would Just Work when combined with this
series.

I.e. he had "dry_run" implemented, but not "verbose". Now he'll get
"verbose" for free. The "XXX" comment there about dry_run appears to be
a TODO about not doing needless work within the reflog backend.
