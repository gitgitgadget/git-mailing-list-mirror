Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD5E1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFSSB7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 14:01:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42592 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 14:01:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so540819edq.9
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uYpY0SbzhtJMIHLipf+4SayWMp1eJIMKgTtPqVxJB1I=;
        b=Ofd9BqZDPRM3ybt888MobWOLuYf1HxpnglMzq2hCYheC5zwsZT626JpZxW9ywxlfKH
         hmDi+wcIUQeurWsM9O3p5cNRUX5l4R70MVgP344zDBA5xDXcapwKlAXuVRZGfdkSxAb0
         yx6CNs9LZqfjKhHAwZ81znnruVrLrYesFhlE6ndo/ZHOXQRmkV90c99L+5Z/biuxLqWn
         fMIjqH8eLc3+nqOOOmBCz2CrpRWhD5DW4eCswCJorLTrDsmCcyUV9ZbMaacMh4vsW5dX
         GAlEuUt1DCUWtz/a1bBPdJbGRVJksB4uvX+r1JIPijA11kb0i+iUAB9DLYXqTGPW2hgS
         VruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uYpY0SbzhtJMIHLipf+4SayWMp1eJIMKgTtPqVxJB1I=;
        b=YbEvKUleG8rib6ojF6JmioVPsXCbl85eFlc+2MCG2hhYlPmbG1CZvjI0DALYoYDT3Z
         ePj0TUtCaU9tZ6JXiDfTwojVx9iexwc+EtraMMjPGGWElJpUiORAM+kNwJ5c3avk0dxQ
         hJec8l5bKXrCBlwaC6qKLdSK8XPfVm6c4P4n4rRpzqgqOev357KMZbY2g8v6uABa1UaN
         D8g0KKHxtOHslLpbX+WfAv2d4E+jobb9u3x1ACbHqyg3skspLAi5rD0bOhSCK07Xjoug
         JRaJb8INBuiNMd2aiuSDAPiQpS1Hx+rPrS9pynU7kEyWPe+eEPdrF+s/YMBmM1k/hHXg
         9ViQ==
X-Gm-Message-State: APjAAAUkPY+wHeQ8T3MBSAwX712m9nu6Rvw12w9D84tNbUxqZXT7BF6e
        n6FwkZIdZfP69mQY9OHfjRs=
X-Google-Smtp-Source: APXvYqzfaG2Fjw4DSpM0s64NJYT+iYD2/EW8FGmdjidPeRtbDP6aWI/rqfMMSLxXM2n3jykdFfk7FQ==
X-Received: by 2002:a17:906:838a:: with SMTP id p10mr15373147ejx.237.1560967317542;
        Wed, 19 Jun 2019 11:01:57 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id l50sm6110593edb.77.2019.06.19.11.01.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 11:01:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
References: <20190619094630.32557-1-pclouds@gmail.com> <20190619102601.24913-1-avarab@gmail.com> <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
Date:   Wed, 19 Jun 2019 20:01:55 +0200
Message-ID: <87k1dh8ne4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 19 2019, Duy Nguyen wrote:

> On Wed, Jun 19, 2019 at 5:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> This patch is part of a WIP branch I have that's a bit of a mess. It's
>> more-gc-detach-under-lock on github.com/avar/git.git. It doesn't apply
>> on master because it relies on some previous test work, but for RFC
>> purposes I figured it was better to send it stand-alone.
>>
>> But I think this sort of approach is better than Duy's proposed patch,
>> because...
>>
>> On Wed, Jun 19 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> > So let's try to avoid that. We should only need one 'gc' run after all
>> > objects and references are added anyway. Add a new option --no-auto-gc
>> > that will be used by those n-1 processes. 'gc --auto' will always run =
on
>> > the main fetch process (*).
>> >
>> > (*) even if we fetch remotes in parallel at some point in future, this
>> >     should still be fine because we should "join" all those processes
>> >     before this step.
>>
>> This is what I'm trying to fix in my version of this patch. This is
>> only true for yours if you assume that the user is going to be
>> invoking "fetch" in a single terminal window, IOW that we have an
>> implicit global mutex of one top-level git command at a time.
>>
>> Wheras mine fixes e.g. the same issue for:
>>
>>     parallel 'git fetch {}' ::: $(git remote)
>>
>> Ditto for you running a "git" command and your editor running a
>> "fetch" at the same time.
>
> You could sort of avoid the problem here too with
>
> parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
> git gc --auto
>
> It's definitely simpler, but of course we have to manually add
> --no-auto-gc in everywhere we need, so not quite as elegant.
>
> Actually you could already do that with 'git -c gc.auto=3Dfalse fetch', I=
 guess.

The point of the 'parallel' example is to show disconnected git
commands, think trying to run 'git' in a terminal while your editor
asynchronously runs a polling 'fetch', or a server with multiple
concurrent clients running 'gc --auto'.

That's the question my RFC patch raises. As far as I can tell the
approach in your patch is only needed because our locking for gc is
buggy, rather than introduce the caveat that an fetch(N) operation won't
do "gc" until it's finished (we may have hundreds, thousands of remotes,
I use that for some more obscure use-cases) shouldn't we just fix the
locking?
