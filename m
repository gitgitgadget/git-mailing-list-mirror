Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80353C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E14206D9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJJl5U8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgKXM6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 07:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgKXM6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 07:58:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CBC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 04:58:34 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lv15so22477232ejb.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 04:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CBTIxMI6RAjZRoGBaTGKS9jGFN7mjuQRiQsHzaV3nFk=;
        b=DJJl5U8smiOuz7lTdPrsa6RlpgDutIvDuh1k/QLanvRIGi1n+cnaxQaxxslJs64F0H
         MTrRERnmp35TT0IVcSMQQr+chfcoip66IcknO8EVxriHNBEOmZ97FqfNmtS5W59tCkrY
         NCtx26Qsb0h/WIOXO2p3oFf2FDJwCkHBJq6qCw/h4DL4WeN5H9nb2GrNhJbv5ByXx7jZ
         51oYG1Zo4fHlTl4k7/BA57zQdAeQa17bWzYqbXgn3kheUi4LXsVkjLNXfi6lcJzfrVbv
         ec2RKC0gUIxCylxVjNlMpQE6u8FwH5uGyN0dgImbFMCMxP37j9xWFO63igVuTTR0vvyR
         aNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CBTIxMI6RAjZRoGBaTGKS9jGFN7mjuQRiQsHzaV3nFk=;
        b=qihhPx5Ej0KYun4fIaytHCb9i6sAhTGV4BnU/Arealw4/BOVTnWpN3uDBrgI34bGYi
         BoDT/9pMx3bKp1PVir7Z2mkKPN13TMlMrw0CkjrWNmdkq5mgfRSLzR1TeqfxPDFN/ueM
         zJgDOitUJvEQW3BJontxf0Tr67WB/4CTkFxoYWwyKzUxaYWsZ3IscVpMrQnGCLdRjX2h
         PXGadCLDiyBVD7ZKm8/CL6s9y2VJ2hUM4Pf93Hiw045ocbzDGdEF2X0x8L9imRaxQvXn
         zvSGWwsB4yOcIqHfbsMeH/qiwXzl0s+Ahk3BKbFHMvlghJP71By+4+iGIf64qh0bdDiz
         XntQ==
X-Gm-Message-State: AOAM530qEYFl2ETS95nZ0Q6PTY5m4aS4QfGQtWVFxgdfPUbRmhlPwYxf
        KqykvktOUg/TJJRoQPSkD+4=
X-Google-Smtp-Source: ABdhPJzhdBAq1ByITt/iQKcI9p6Lq6RVs9iEJ+8BN4qZ1raRec9uyLEZpDdM7hdRWp3hex+uxEmG7A==
X-Received: by 2002:a17:906:13d6:: with SMTP id g22mr4212329ejc.240.1606222712608;
        Tue, 24 Nov 2020 04:58:32 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id l7sm6811025ejc.5.2020.11.24.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 04:58:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
References: <20201115194359.67901-1-matheus.bernardino@usp.br> <87y2ixpvos.fsf@evledraar.gmail.com> <20201123233735.GB28189@dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201123233735.GB28189@dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com>
Date:   Tue, 24 Nov 2020 13:58:31 +0100
Message-ID: <878saqq5c8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 24 2020, Geert Jansen wrote:

> Hi =C3=86var,
>
> On Thu, Nov 19, 2020 at 10:01:07AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> > The major downside is that detecting the file system type is quite
>> > platform-dependent, so there is no simple and portable solution. (Also,
>> > I'm not sure if the optimal number of workers would be the same on
>> > different OSes). But we decided to give it a try, so this is a
>> > rough prototype that would work for Linux:
>> > https://github.com/matheustavares/git/commit/2e2c787e2a1742fed8c35dba1=
85b7cd208603de9
>>=20
>> I'm not intrinsically opposed to hardcoding some "nr_threads =3D is_nfs()
>> ? x : y" as a stopgap.
>>=20
>> I do think we should be thinking about a sustainable way of doing this
>> sort of thing, this method of testing once and hardcoding something
>> isn't a good approach.
>>=20
>> It doesn't anticipate all sorts of different setups, e.g. in this case
>> NFS is not a FS, but a protocol, there's probably going to be some
>> implementations where parallel is much worse due to a quirk of the
>> implementation.
>>=20
>> I think integrating an optimization run with the relatively new
>> git-maintenance is a better way forward.
>>=20
>> You'd configure e.g.:
>>=20
>>     maintenance.performanceTests.enabled=3Dtrue
>>     maintenance.performanceTests.writeConfig=3Dtrue
>>=20
>> Which would run e.g.:
>>=20
>>     git config --type bool core.untrackedCache $(git update-index --test=
-untracked-cache && echo true || echo false)
>>     git config checkout.workers $(git maintenance--helper auto-discover-=
config checkout.workers)
>>=20
>> Such an implementation can be really basic at first, or even just punt
>> on the test and use your current "is it NFS?" check.
>>=20
>> But I think we should be moving to some helper that does the actual test
>> locally when asked/configured by the user, so we're not making a bunch
>> of guesses in advance about the size/shape of the repository, OS/nfs/fs
>> etc.
>
> I like this idea as something that will give the best configuration for a=
 given
> repository. I also know from working with customers for a long time that =
most
> users will use the default settings for almost any application, and that
> default configurations therefore matter a lot.
>
> The ideal experience would be, in my view, that a clone or checkout would
> automatically benefit from parallel checkout, even if this is the first
> checkout into a new repository.
>
> Maybe both ideas could be combined? We could have some reasonable heurist=
ic
> based on file system type (and maybe number of CPUs) that gives most of t=
he
> benefits of paralell checkout, while still being a reasonable compromise =
that
> that works across different NFS servers and file systems. Power users tha=
t want
> more aggressive tuning could run the maintenance command that measures fi=
le
> system performance and comes up with an optimal value for checkout.worker=
s.

Yeah, I'm not opposed to it in the least. I just think as a practical
matter it may become a non-issue if we had something like
maintenance.performanceTests.*

Because we eventually run a "gc/maintenance", and there we detach from
the terminal, so we can run something like a find_optimal_nr_threads()
without keeping the user waiting.

If the only reason we had a
find_if_nfs_and_nr_cores_to_guess_nr_threads() was because the more
general find_optimal_nr_threads() took a tad too long when run
interactively then changing where/how it's run would make the
find_if_nfs_and_nr_cores_to_guess_nr_threads() codepath unnecessary.

The "on clone" case is something we have in general with other speedups
& sane defaults. E.g. in making the commit-graph.

I haven't kept up with the latest state of that, but there was
work/discussions on generating that there too in a smart way. E.g. you
clone & we either make it or fork to the background and generate it. So
in practice the user cloning a big repo has sane performance right away
or really soon.

But yeah, fully agreed on that we should ship sane defaults when
possible.

I do think (and I may be wrong here) that in particular with performance
options it's more acceptable to not try as hard by default. A lot of
them don't matter except for some really large repos, and users working
with those tend to be part of some established ecosystem, where e.g. you
clone chromium.git and a script could set up your custom config for you.

But maybe there's common cases I'm not aware of where that assumption
doesn't hold, e.g. (I'm just guessing here) people cloning arbitrary
repos on some VM on Amazon that happens to use NFS, and then wondering
why things are slow.
