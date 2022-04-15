Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B2C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 12:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351470AbiDOMpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241937AbiDOMpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 08:45:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9522C31D7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:43:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ks6so15236644ejb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xZiKJC1kXHfIcy82s1DvymHB4r76Dy0Q6AYJS8vN0b8=;
        b=bTsc52l2z1G8i92d4y29sLsFby6ad+4V1a0t9dQyv2eJgyvjcFLBy46hiSDvlwyY2B
         TEy4P6ybzfCi6IAnaQzN19obaqm09YYfrm38QCurL4EPcBEri7gOAOrX808B//ChVZNm
         mbJ2JuUPAgIIjeYCwO0eSXG7VIQ2ftRtLcADEByBX6XWvbM2nFY3NuhyWJEAvpwGN3ZF
         zqq5JA1Pzf/3HsQDbPdXOZbx3JjSzF9foroNnVK3jruYQDKl5lknn/mcNkG0CPXl9O4e
         r6Lp6UL5THw27qOIdb4NNwWyCqvyHImml57EPDVhkuRyaBKZLDsNVfMMWsiWZh1DHRTT
         Mc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xZiKJC1kXHfIcy82s1DvymHB4r76Dy0Q6AYJS8vN0b8=;
        b=TRCqieGle22LxOqbdPmIlDbz4pUhnfzMBvWmzg1RCa1yvE0gMOzbshIkglZr3jeR0e
         Ft2sYt7F64tkGqZ6ohxg1ul1cuBJScNXSoXUt3w5D0B5HeXsgwFXCkQ+25FNmvKriuao
         LDnywlYPVFLXLuzzFYsteXG/Jkyd4oXWwJRoT+k8oejYU3g9SPpfLdPdhphjM+HlMY7N
         HUMU77IkGw37UCuyjrI9EDiqrxUpTNEBZzgxjqv/f4dSY+LtJe4s2LrEsFZLwXxLOGav
         VAOBiePa/pCQ8cCoq0c8JzcYw0yNxdKcVzK1xPc2OZuZPCH5j3AdvHo5PnG2H2vTWcMH
         1NaQ==
X-Gm-Message-State: AOAM533LRIYLSjHYxq7ShaKVkZKHkV071y6JPPPiJhrokvkqpBZJ5IEd
        kdlRUm2ZUyy+Pxp0l2JAJkRFlCvHTAVxTA==
X-Google-Smtp-Source: ABdhPJwrS2GskosNJk30WxE3RF4Rqjr9FUFsRbz8MBlx7ofubAISAIPOG+TAGTtncO+9TWUxgAryHA==
X-Received: by 2002:a17:907:2cc7:b0:6df:b76d:940d with SMTP id hg7-20020a1709072cc700b006dfb76d940dmr6100784ejc.742.1650026595127;
        Fri, 15 Apr 2022 05:43:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm1670926ejo.191.2022.04.15.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:43:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfLIA-005dTL-3D;
        Fri, 15 Apr 2022 14:43:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Pathological performance with git remote rename and many
 tracking refs
Date:   Fri, 15 Apr 2022 14:26:16 +0200
References: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
 <220414.8635igdtfn.gmgdl@evledraar.gmail.com>
 <YljFnJk55WYLKd6Y@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YljFnJk55WYLKd6Y@camp.crustytoothpaste.net>
Message-ID: <220415.868rs6cyal.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-04-14 at 07:12:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Aside from how we'd do renames with transactions, do you know about
>> clone.defaultRemoteName and --origin?
>
> Yes, I do know about that.  However, in my case, the repository is
> cloned before I even get a chance to touch it, so these options have no
> effect.  My dotfiles aren't even on the machine at that point.

*nod*

>> There was a (small) thread as a follow-up to that "rename --progress"
>> patch at the time, did you spot/read that?:
>> https://lore.kernel.org/git/220302.865yow6u8a.gmgdl@evledraar.gmail.com/
>
> Yeah, I remember reading it at the time.
>
>> More generally, probably:
>>=20
>>  1. Teach transactions about N operations on the same refname, which
>>     they'll currently die on, renames are one case.
>>=20
>>  2. Be able to "hook in" to them, updating reflogs is one special-case,
>>     but we have the same inherent issue with updating config in lockstep
>>     with transactions.
>
> Yeah, that's one of the reasons I was thinking of implementing
> --no-reflogs: because in that case, the operation really is a
> create/delete operation and it doesn't require any additional logic in
> the transaction.
>
> My goal here is specifically not to rearchitect ref transactions and to
> implement a relatively simple solution.  Your response is indicating to
> me that updating reflogs is going to be the former and not the latter.

Yes, I think it would be nicer to solve the general problem, because
we'd otherwise end up with no-reflogs and have-reflogs paths through
these functions.

I'd also think you'd be stuck trying to instrument transactions in some
new way anyway, because wouldn't this thing be racy if reflogs for one
of the remotes appeared after you started you'd need to abort or deal
with them?

Or was the plan to:

 1. Create lock files for them all
 2. No reflogs?
 3. Rename..

Maybe that was what we did in any case, I'm rather rusty on the exact
procedure at the moment. I.e. did we do the mass-lock first?

Anyway.

I actually wonder if this wouldn't be that hard, because if we have any
reflogs we could simply "replay" them by turning (again, I'm a bit rusty
on the exact lock dance);

    lock(refs/remotes/origin/master);
    lock(refs/remotes/def/master);
    create(refs/remotes/def/master, refs/remotes/origin/master^{});
    delete(refs/remotes/origin/master);
    unlock(refs/remotes/origin/master);
    unlock(refs/remotes/def/master);

Into instead doing:

    lock(refs/remotes/origin/master);
    lock(refs/remotes/def/master);
    for from, to, msg ref_update(refs/remotes/origin/master):
    update(refs/remotes/def/master, from, to, msg);
    delete(refs/remotes/origin/master);
    unlock(refs/remotes/origin/master);
    unlock(refs/remotes/def/master);

I.e. simply replay each individual item in the reflog, basically using
the code in your builtin/stash.c series.

I didn't think of that before, and just thought of some
extra-transactional way to copy the reflog over as-is.

I think that multi-copy approach would run into
ref_update_reject_duplicates(), i.e. you can't have multiple updates
now, but that's a sanity assertion to make sure the transaction is
internally consistent.

In this case the N update() calls are semnatically the same as a
create() call in terms of aborting the transaction, i.e. we'd "fold"
them away, i.e. turn the sanity check into pretending N such updates
were the same as a single create(), so we'd delete on rollback.

Maybe that would work? Hrm...

Anyway, depending on the answer to if your --no-reflogs plan would have
any lock issues etc, perhaps an alternate plan would be:

    git remote rename --unsafe

Where we'd just "mv" the 1-2 relevant refs/remotes/X and
log/refs/remotes/X folders, followed by updating refs...
