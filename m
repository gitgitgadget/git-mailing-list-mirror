Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D64C56202
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 11:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44AE22272
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 11:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhJYsFAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKTLgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKTLgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 06:36:19 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C0C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 03:36:19 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f23so12439471ejk.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6Ml/PuJckBfvD44h3CidA0GYr+H4XP/1gNT77btC8iY=;
        b=ZhJYsFAHqo3rDFi7kekEcMmic8txjAlsUe+PWPmCVFHWaQAvt0MbBB+aLj5MtiuOmA
         MPYtSPJAe8mgd22XoMStPUvzqX+gcAQ7O0Fz4D7BgVMHud7GcVbLYXAcmfrB0ebYm5H2
         bKC0edvIYLgWOfnkSjDfRwGpa1BaT3Dr3HowqG7DWaRmxUx+9Kz8fwwMrE3oGtCtr2aF
         wPPXw/A1ntayuZQvzzTrsaQ7GI0buZlssJBHOMqe7TQEtPCKWjqhTrhdpK5G9fPXxCfx
         Lqe2rMN5HGz6o9b+paisowHQBwZH9tj+Gf8FkqjMPWde+QQ5yhmPslHwVlFTkt7le2Vc
         kkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6Ml/PuJckBfvD44h3CidA0GYr+H4XP/1gNT77btC8iY=;
        b=G+3OqaEQOXAg5V7BEm0M70b4z1Qkw8spMxY7YdrhPxtQQMrsotKfOrKDeX8YAcfcrX
         6Sr3tEJsqLOZ2M8/t41tOWyPvh2qXbeO7jOOPCxwGOxxkJqyExMXTnKs/w/QlLGgdDFl
         g00h7xldgvKQtvB0oVWyB+Upl1Pi0UkIHrdDqB7KzV9eGlR6xkqMqPpTHc9OzLMg3pRp
         bPuTgeUXZctASoIQQd00Fb/N+T4UOpWXeptFd8w/CmzvtqhoVaIUBwyDpQaZTtleafTu
         1PgtmxWjDbOGW6fXJhvHe3qW0uUM5tGcpm+gGiIm0yDsmiHBoPgOh0XZr7sPV2BalQ0m
         kaSQ==
X-Gm-Message-State: AOAM533xQ93Pdh7KvbWW7dPtft01jq43LvjFiw0hT22a2uJp0Y9IGq3L
        M1aSRw/LzIQ8zEjfHApLlnM=
X-Google-Smtp-Source: ABdhPJxjow/4KdoGVBi2lbaOy+2RKHnuZuGhZEy9uBfgCGhmwDLAtLcZFw3dpwygB1WXn1V7lPb7MQ==
X-Received: by 2002:a17:906:3641:: with SMTP id r1mr31167030ejb.405.1605872177736;
        Fri, 20 Nov 2020 03:36:17 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u17sm1032453eje.11.2020.11.20.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:36:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default branch (sort of)
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet> <87ima2rdsm.fsf@evledraar.gmail.com> <CAMP44s2Uf4tkBdHWFV6e3K3VqCksJxwz52kgWzTBN_SAHnof-w@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <CAMP44s2Uf4tkBdHWFV6e3K3VqCksJxwz52kgWzTBN_SAHnof-w@mail.gmail.com>
Date:   Fri, 20 Nov 2020 12:36:15 +0100
Message-ID: <87pn48p8eo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 18 2020, Felipe Contreras wrote:

> On Wed, Nov 18, 2020 at 7:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> I do 100% agree that the s/master/main/g change of the default should be
>> made in one form or another. In my mind that doesn't even require a
>> consideration of the political motivations at this point as far as
>> git.git is concerned, just:
>
> Others disagree.

Sure, and I might end up disagreeing with myself once we have the
proposed patches & more people inevitably chime in with some useful data
about the trade-offs, edge cases we haven't considered etc.

> While the political motivation shouldn't be a central concern, I
> suspect the vast majority of users have no idea this change is coming,
> and when they see the warning they will likely complain... Strongly.
> The fact that this change is extremely politically charged will become
> a factor.
>
>>  1. Major Git hosting providers already made the change

[... addressed below ...]

> That's their decision. The Git project shouldn't be held hostage to
> third party decisions.
>
>>  2. Realistically a lot/majority of git's user base interact with that
>>     in a major way.
>>
>>  3. A discrepancy in any default between /usr/bin/git and those
>>     providers is more confusing than not.
>
> That's a problem for GitHub et al. Fortunately they can tell their
> users to set init.defaultbranch to whatever they want.

I think this and what you mention in another thread[1] about GitHub's
instructions for creating a repository takes a narrow view of our
responsibility for creating a sane UI for users.

For example, right after the instructions you note there GitHub's
current instructions are:

    git remote add origin $url
    git branch -M main
    git push -u origin main

Now, put yourself in the shoes of a novice user who's just been
introduced to this "git" thing for a job they started 2 days ago. We
don't take the s/master/main/g change in git.git, GitHub keeps
theirs.

You followed some tutorial or read the manpage to create a local
repository and made a few commits, then to upload it to GitHub or
another provider that uses "main" by default you copy/pasted the above
commands. Now the thing changing from "master" to "main" is one more
thing you're confused by.

That's my motivation for supporting this change. I think most git users
by number are (hopefully) in the future, yes, as you note we'll have
version transitions where that's more confusing than not, but the same
can be said about the dashed command transition.

Whatever mistakes we made in that transition and should learn from a
typical git user in 2020 has never used a dashed builtin, just like a
new user in 2030 probably won't know or have to care about their local
default being different than a $BIG_HOSTING_PROVIDER default.

That *is* our problem, not just a problem for GitHub et al. To claim
otherwise is to just bury our head in the sand.

Are we on balance going to not make the change because e.g. we don't
want various paper books and tutorials to be confusing? Maybe, maybe
not. But just dismissing those concerns by saying e.g. "that's
O'Reilly's problem" would be as nonsensical as us pretending that
perpetuating an (admittedly rather minor) UI difference in perpetuity by
our inaction is purely GitHub's responsibility.

>>  4. #3 doesn't mean they say "jump" we say "how high" whatever the
>>     change is.
>>
>>     But in this case the default is an entirely arbitrary default. Not
>>     e.g. that they decided to add some ill-thought out header to the
>>     object format or whatever.
>
> I don't agree it is arbitrary, otherwise you could set the default to
> "loremipsum". Moreover, even if was arbitrary, it was arbitrary in
> 2005, not 2020 where "master" is already widely used in basically
> *all* the documentation everywhere. Some people have been using this
> name for 15 years, they won't give it up just like that.

Yes, that was badly phrased and I take that back. I meant to say
something closer to "a common convention" or whatever. E.g. if GitHub et
al for whatever reason switched all use of "origin" as the default
remote to "source" I'd think that at some point we'd be improving things
overall if we made that switch as well.

> People will complain, especially if they don't see a good reason for
> the change.


1. https://lore.kernel.org/git/CAMP44s1515GOwTOYv-wz4qMC9Qb6d8cSVSb_CNVwun0=
+Yj3VxQ@mail.gmail.com/
