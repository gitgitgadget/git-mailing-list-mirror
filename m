Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6720C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiAKUih (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAKUig (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:38:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DDC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:38:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so1085187edj.7
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EWQoQJPl5ck9V0V3oroKEmP5RP+dWmzZfRc7JOr7na4=;
        b=j6SvU5Ja+Q5oEt7MPvTB1WfwwVh5XRTCV0oepBVYwL08XAeuMWfxAoDEZI1NGzd0kI
         HEuqrxjUVHtyyMmvcx90vio8QIFdSdC47609NSvxAdA3115Se0u3ZHmfCla4QMju7o+e
         ZMoO1Fkno0oLyGUwhwCp1fK/s8502tEUeeFIlIT+A3HFCAaSFGsz9jhJb7ph4mlDcpiV
         dUzcdVgIMqWw9uHc0F5sx/JaMOHvOeYTnneVsGbQQd8pu5a2Ch6uFzIPrxClfWiF37Cq
         pLPUjKTEWnOTxdSPpGMFovBHagFv8IkENmwchiifLov60E/hTZv8rmjcsMZJ3m/xRaea
         TgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EWQoQJPl5ck9V0V3oroKEmP5RP+dWmzZfRc7JOr7na4=;
        b=VBZMGu80rLxpv7XxAJBwy59veJ2Ncs1husmGUMssJfbO/dZN9r0Indnwjw2Q6KnXAd
         h6bRH2LGHXSVtoDHJ6j9t4UNhRF/boe5RHfvDXt1pVXTWjWxXEdJu57qKwBwKvfQR2YD
         YYJ/IZBAGrJf6t18egn+59b7YhRhhKRWhIQ9v5bJnfG6nzd3Lhi5bFBO5gK5E86wKC9l
         gDZlGoA950HvjQsYAVuW8MVeEDP9ai/+IYakMtcZv175bLEmn7+11P8FrIsgmGvDklYv
         jnPLYTmG82mCybrVztjWvOKuEV7ldqxM1Gp8ls77jV7kkWiMzxdf8XHbNOyXgwYLcsDt
         RJPA==
X-Gm-Message-State: AOAM532+rYgK5My3XNfH6QFV7zY2VFkkuUPv07a6VM2r3QfxkKQ1z2eK
        rQuFlQoOYuYh6H8kp07Xh/s=
X-Google-Smtp-Source: ABdhPJznBjArTWb8swsU44/Q7zXY7jJWQmrcNloWpdsvZDcEoDEw1kKz0xn/PAv9s+907xT/Peavww==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr5932175edd.242.1641933514918;
        Tue, 11 Jan 2022 12:38:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cd6sm103350ejb.91.2022.01.11.12.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:38:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7Nub-000hYD-ST;
        Tue, 11 Jan 2022 21:38:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
Date:   Tue, 11 Jan 2022 18:00:51 +0100
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
 <xmqq8rvn1nkw.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
Message-ID: <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 11 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Mon, 10 Jan 2022, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > I am against a new command for what essentially serves the original
>> > purpose of `merge-tree`.
>> >
>> > The fact that `merge-tree` has not seen any work in almost 12 years is
>> > testament not only to how hard it was to disentangle the work-tree
>> > requirement from the recursive merge (it is one of my favorite
>> > counterexamples when anybody claims that you can easily prototype code in
>> > a script and then convert it to C), but the fact that there is no user
>> > within Git itself (apart from t/t4300-merge-tree.sh, which does not count)
>> > speaks volumes about the design of that `merge-tree` tool.
>> >
>> > So it's only fair to breathe life into it by letting it do what it was
>> > meant to do all along.
>>
>> My "Yup" would not weigh as much as one that Linus (whose original
>> merge-tree survived this long without seeing much enhancements)
>> might give us, but he is busy elsewhere so you guys have to live
>> with mine ;-)
>>
>> As to its output, I do agree that "we give a tree when it is already
>> usable to record in a new commit" is a valuable option to have.  The
>> original behaviour should be made available somehow, for those who
>> built their workflow (including scripts) around it, though.
>
> No, I don't think it is a good idea to keep the original behavior around
> indefinitely, when it is totally unclear whether there actually _is_ any
> user of this feature out there.

For what it's worth I've used it for some automation at an ex-employer
at least once. Grepping through my #*git* IRC logs there's a few
mentions of it, and likewise for StackOverflow.

I'm not opposed to replacing it, and I think that probably in-the-wild
users of it are almost certainly just grepping for the conflict markers
to see if there's conflicts, or parsing which files have them etc.

So if we can provide a better interface that they can use (or even make
git merge-tree a thin wrapper...).

> We intentionally broke any existing users of `git-parse-remote.sh` by
> removing it, when that feature was much more likely to be used in scripts
> than `git merge-tree`. We cannot say on the one hand that we will get rid
> of some useful script just because we don't want the maintenance burden
> when on the other hand trying to keep support for an operation that is
> unlikely to have any users. That does not compute.  (And don't get hung up
> on the specific example of `git-parse-remote.sh`[...]

The specific example or case really matters. We don't have some generic
flowchart for deprecating things that applies in all cases.

I removed git-parse-remote.sh in a89a2fbfccd (parse-remote: remove this
now-unused library, 2020-11-14) and had the opposite impression you're
expressing here.

I.e. searching around for in-the-wild uses via search engines, stack
overflow etc. either found nothing interesting, or just a reflection of
ourselves (i.e. generated manpages etc.).

That along with its history, i.e. it wasn't *really* meant for
out-of-tree exposure if you look at the history of how it came about, it
was just made at a time when similar libraries had similar manpages
etc. added as a template.

Maybe that was the right thing to do, maybe not, but it went out with
v2.30.0 and the lack of complaints since then would seem to suggest that
I was right that removing it wouldn't be a big deal.

Of course it may have broken someone's script somewhere.

But an important distinction is that they can get it working again by
just copy/pasting that ~100 line shell library into their own script, or
calling the underlying commands it was invoking themselves.

Which doesn't apply to "git merge-tree" unless we come up with a
replacement, and even then a 1=1 port of some in-the-wild code might be
much harder, i.e. if it's deeply coupled to parsing the specific output
it emits now.

So I'd personally be much more hesitant to remove or change that, but of
course we might still come up with good reasons for why it's worth it,
especially with some advertised deprecation period.

And isn't any doubt around that even more reason to just go with
Elijah's plan of introducing new plumbing? I.e. is it really costing us
to just leave these "legacy merge" plumbing built-ins and
merge-recursive.c etc. in place?
