Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE3EC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiEXVhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiEXVhc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:37:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A547C178
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:37:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f21so24280731ejh.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4E+eyEYo8tmF1Zx2K3/ZwdWs830Fh+MyH9Ii/+gk334=;
        b=cSEXgVFlDxVYxmrVcRwfdajyTQudRZm3HGXJV72vJHhlFFNevAS1Xf1ZbjbEQ5XUbN
         D+GI2nazj09Tn9vARmupObWq0+1I71Kr1I4djx5GKp+FNCSIx3NgU/6IlB8IIvgzNlKC
         NoGEj4bKVqdEmffwAqiEvWn/43Jh+sUXdtspvgViIfBd0SzBLUL4BZdnZTMwDEutZ59M
         X4cMxuH7inpdg+EAUZBb5u+NwSfAK+E8hZTi53sfd9Ql7VNqQqf09x3yeTonzkMrDs0D
         jvquREH4uag6vZ4YFjAB7oMpLCWgF3dOM6THp99krUMoLCXiu+zfu1mbMa22p5GwnEiI
         GHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4E+eyEYo8tmF1Zx2K3/ZwdWs830Fh+MyH9Ii/+gk334=;
        b=xQ8FFHOIQbfhKd0LhOqdgJh/kvGJYpeuqHeX1yc13y6dzjeE06pat4aT57GuwaHWGg
         Diz4Yc44eyGPn+wWwDf2NPxqpqRY4zJgMsGbwqt08UzbbQ8QeQV8u8uVUw9pmo4ywcS3
         /tAw7phADl3xOUzLbRxmSu8d3K81ZScY5FtCrqVgbaybk4HwePTkCy91RuoW7JZR7rf6
         C1lZ9t6tNcUedRBPnrp+YKeFLcI1Lct60vt/dVrStlMt65hMHZ4IlRZiMvb+Z9Zlh/4h
         a1MPqDIqy7mpmV7cbr3JEAMyItQZmch0O95rH4J+fwKctVBcsz68nfCFKgi6ypq8bkgV
         aB5Q==
X-Gm-Message-State: AOAM532iXQeNjeyGzTh0dmoSx1yMIN8xX3SKkN5eW0FD0AbfrSQGx6KD
        hsti1NnAi6KThw2cQ3/v//4=
X-Google-Smtp-Source: ABdhPJxYyELWPvM1mJMb4FIG2fg3N1iO/rQFcPzlGpBlcp8hpZR749SSE6va9ixjxvzhmugFEo0gyQ==
X-Received: by 2002:a17:907:7396:b0:6fe:9a92:6c2b with SMTP id er22-20020a170907739600b006fe9a926c2bmr24612256ejc.113.1653428250310;
        Tue, 24 May 2022 14:37:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm4543458ejc.105.2022.05.24.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:37:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntcDZ-003bYz-AV;
        Tue, 24 May 2022 23:37:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/4] nedmalloc: avoid new compile error
Date:   Tue, 24 May 2022 23:33:33 +0200
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <8963c6fa625bbaf5153990939ea06742304ddcd2.1653351786.git.gitgitgadget@gmail.com>
 <220524.86bkvnxsm5.gmgdl@evledraar.gmail.com>
 <972c3c82-0c10-ee95-9a7f-082de02a49c0@web.de>
 <nycvar.QRO.7.76.6.2205242239150.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205242239150.352@tvgsbejvaqbjf.bet>
Message-ID: <220524.86ee0ivch2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Johannes Schindelin wrote:

> Hi Ren=C3=A9,
>
> On Tue, 24 May 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 24.05.22 um 10:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> >
>> > This seems sensible, I thought "why not submit it to upstream",
>> > i.e. see:
>> > https://github.com/ned14/nedmalloc/blob/master/nedmalloc.c#L1298
>> >
>> > But that repository was last updated in 2014, I wonder if it's just
>> > because nobody's submitted a patch since then, or if it's inactive. Ha=
ve
>> > you tried making Njall Douglas (the nedmalloc author) aware of this
>> > issue?
>> >
>>
>> https://github.com/ned14/nedmalloc says at the top: "This repository has
>> been archived by the owner. It is now read-only.".
>
> Indeed, maintenance of nedmalloc has stopped a few years ago (see e.g.
> https://github.com/ned14/nedmalloc/issues/20#issuecomment-343432314).

The author says:

    nedmalloc is pretty much EOL. Happy to accept patches, but unwilling to=
 fix.

The "Happy to accept patches" seems to suggest that they're willing to
take a PR, just not willing to do spend time on it themselves.

Anyway, I see that we've accumulated quite a few patches on top, and
given...

> About five years ago I tried to upgrade us to the latest nedmalloc version
> but ran into a performance regression that I was unable to justify the
> time to investigate further.

...perhaps it's not worth it.

Maybe someone should get to updating the readme we carry from it to
change the first line from:

    nedalloc v1.05 15th June 2008:

To:

    Git's (perma-)fork & local hacks on top of nedalloc v1.05 15th June 200=
8:

Or something :)
