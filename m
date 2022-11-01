Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8F7C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 18:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKAScx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAScw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 14:32:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46D1AF14
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 11:32:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so39343697ejd.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oyq1Zx74XN3cC6I2A33yPdwQmQnGJilmF0WKXYKhboI=;
        b=a4222JjCkdRavUzcgs1XAKbfiZxe/WFmfPmpM9UWsULQfdf74Ea6gS/O+iOU8QPp/o
         SczSoqb2KPn/Rn+UwYdDzGprSQRToz8Y85uVPKa+wRwsTKzHc0BkvqJNXw9X+vB3M52G
         iPxfn6rw7K1DJrcFs+ieXC5cEHA07yzHBjb7bHWm4AOZ3wTnaN30TAl+UhLQ0S7/Li5r
         OnV/vqSWnOMxd+OOwUUg0PRZI8HQ4xrVywsqWBBHpdcl4be2wbD6+kYPpysUw5zsyeXP
         bNJ6xo9vhn6Yo8ep9VPdXxPk8b1nGoLwqUF98nKjo9hhnXJ2v2gYiqB61ZNlXUkn32RR
         rJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oyq1Zx74XN3cC6I2A33yPdwQmQnGJilmF0WKXYKhboI=;
        b=a7Wwuj4QK5ERzAcKbf2+iNjI1+6eau5xGVaXxvTOJ09hTPVmZlbyR4XMboQiUbnsA6
         tKuP0NoYHJtg7VSkyuxORb+/RhqxJCENRyh1GDn3V9CS1rV0tsh1e5qa6JuSgB+TLnqs
         vjuLBDXDuNKRJs8kyte4PJMu8fR1pCqCNacinUmT4HUxl3CCIlIH7LBvAldkXGh9yYDg
         QAiPPGjzBcScoyH+kblvYt+oYfjLnOQUfGYptHZxpSfySCREGOd0fGMQD8VtWgONiLJT
         +2mm2svoRcGoP/DlHrYwoutxqDjmsHy0Iirta7NyPFPmgAPTb+4gntw+Ho5mLCo8b9uh
         fXfA==
X-Gm-Message-State: ACrzQf0wJEUINPXzjFtm26OodKi4I9pI9TC8n2gx0+msrCOxbCsuuqd0
        bsIIbC06HoIfz+uEK908fIk=
X-Google-Smtp-Source: AMsMyM6eChFcAmVkvn0uRLeJ5hh8Rdm8INQj62ZGV4OwLbJ76Rc92vvYpOxIpsHM9z3IpuwH93TyDw==
X-Received: by 2002:a17:907:7f07:b0:779:7f94:d259 with SMTP id qf7-20020a1709077f0700b007797f94d259mr20082951ejc.525.1667327569121;
        Tue, 01 Nov 2022 11:32:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id qc9-20020a170906d8a900b0078b1ff41f05sm4375361ejb.43.2022.11.01.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:32:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opw48-00BTcA-0m;
        Tue, 01 Nov 2022 19:32:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mark Hills <mark@xwax.org>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: Consist timestamps within a checkout/clone
Date:   Tue, 01 Nov 2022 18:46:29 +0100
References: <2210311614160.25661@stax.localdomain>
 <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
 <a87ebafd-c83-7a1d-d8d2-953bc9a93184@xwax.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <a87ebafd-c83-7a1d-d8d2-953bc9a93184@xwax.org>
Message-ID: <221101.86bkpq4jan.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Mark Hills wrote:

> On Mon, 31 Oct 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>=20
>> On Mon, Oct 31 2022, Mark Hills wrote:
>>=20
>> > Our use case: we commit some compiled objects to the repo, where compi=
ling=20
>> > is either slow or requires software which is not always available.
>> >
>> > Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS upgra=
de)=20
>> > we are noticing a change in build behaviour.
>> >
>> > Now, after a "git clone" we find the Makefile intermittently attemptin=
g=20
>> > (and failing) some builds that are not intended.
>> >
>> > Indeed, Make is acting reasonably as the source file is sometimes=20
>> > marginally newer than the destination (both checked out by Git), examp=
le=20
>> > below.
>> >
>> > I've never had to consider consistency timestamps within a Git checkou=
t=20
>> > until now.
>> >
>> > It's entirely possible there's _never_ a guarantee of consistency here.
>> >
>> > But then something has certainly changed in practice, as this fault ha=
s=20
>> > gone from never happening to now every couple of days.
>> >
>> > Imaginging I can't be the first person to encounter this, I searched f=
or=20
>> > existing threads or docs, but overwhemingly the results were question =
of=20
>> > Git tracking the timestamps (as part of the commit) which this is not;=
=20
>> > it's consistency within one checkout.
>> >
>> > $ git clone --depth 1 file:///path/to/repo.git
>> >
>> > $ stat winner.jpeg
>> >   File: winner.jpeg
>> >   Size: 258243          Blocks: 520        IO Block: 4096   regular fi=
le
>> > Device: fd07h/64775d    Inode: 33696       Links: 1
>> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthie=
r)
>> > Access: 2022-10-31 16:05:17.756858496 +0000
>> > Modify: 2022-10-31 16:05:17.756858496 +0000
>> > Change: 2022-10-31 16:05:17.756858496 +0000
>> >  Birth: -
>> >
>> > $ stat winner.svg
>> >   File: winner.svg
>> >   Size: 52685           Blocks: 112        IO Block: 4096   regular fi=
le
>> > Device: fd07h/64775d    Inode: 33697       Links: 1
>> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthie=
r)
>> > Access: 2022-10-31 16:05:17.766859030 +0000
>> > Modify: 2022-10-31 16:05:17.766859030 +0000
>> > Change: 2022-10-31 16:05:17.766859030 +0000
>> >  Birth: -
>> >
>> > Elsewhere in the repository, it's clear the timestamps are not consist=
ent:
>> >
>> > $ stat Makefile
>> >   File: Makefile
>> >   Size: 8369            Blocks: 24         IO Block: 4096   regular fi=
le
>> > Device: fd07h/64775d    Inode: 33655       Links: 1
>> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthie=
r)
>> > Access: 2022-10-31 16:05:51.628660212 +0000
>> > Modify: 2022-10-31 16:05:17.746857963 +0000
>> > Change: 2022-10-31 16:05:17.746857963 +0000
>> >  Birth: -
>>=20
>> I think you're almost certainly running into the parallel checkout,
>> which is new in that revision range. Try tweaking checkout.workers and
>> checkout.thresholdForParallelism (see "man git-config").
>
> Thanks, it will be interesting to try this and I'll report back.

FWIW I was under the impression that we'd made it the default, so unless
you opted-in it's probably not that.

>> I can't say without looking at the code/Makefile (and even then, I don't
>> have time to dig here:), but if I had to bet I'd say that your
>> dependencies have probably always been broken with these checked-in
>> files, but they happend to work out if they were checked out in sorted
>> order.
>>
>> And now with the parallel checkout they're not guaranteed to do that, as
>> some workers will "race ahead" and finish in an unpredictable order.
>
> These are very simple Makefile rules, I don't think these dependencies ar=
e=20
> broken; but your theory is in good alignment with the observed behaviour.
>
> For example, the rule from the recent case above is:
>
>   %.jpeg:         %.png
>                   convert $< $(IMFLAGS) $@
>
>   %.png:          %.svg
>                   inkscape --export-type=3Dpng --export-filename=3D$@ $<

Grom a glance those don't seem broken to me, but I don't know how it
interacts with your built assets.

So e.g. if you are checking in your *.jpeg files those will be more
recent than either the *.png or source *.svn, so they won't be built.

This is fast getting out of scope of Git-specific advice, but you should
run "make --debug" (there's also sub-debug flags) to see if make's idea
of the dependency graph matches yours.
