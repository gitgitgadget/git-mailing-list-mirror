Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD8EEB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 08:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFVIj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVIjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 04:39:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677410F4
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 01:39:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b477e9d396so63303131fa.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687423162; x=1690015162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZPh9DQZxWtXG4+us7iu3NOPLdU7SEqICJoH8Y6cI4w=;
        b=GZnqS24Hm7635+URtvtAN2ryaa+kpzSyT6QkoKMMB8dQotCoUFpMr1hWWpuklgPDYH
         QeZpp0ZqRYsj5VZyFOSL00Q7m8mZtLv8rWtr61JuOLeD+4dBJ8fuamqg8TdsI8ZBN5RD
         vtNTyGHPYt/Rn2LqFWTqVIUatRK2Ac02zBVIHPdKYKF/3hDKg9hkJXfyowQL7FciPifO
         s6FqkF+E5L+LTnl6UqXk6yeqb5Gt/ANMt0K9H42JJZJLAB4a+ddmEqoKx7qtHVsMYjFt
         tiS6miFEy7GC/4WHn/b8cnHb+lVT7BRaB7+B7rr65vu7CYGbTREpbfyzU67BtrYt3E88
         bdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423162; x=1690015162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZPh9DQZxWtXG4+us7iu3NOPLdU7SEqICJoH8Y6cI4w=;
        b=HGWQbe6UakQh3rjg+GRP1oT67qf7y751lK2tudnoYsrw94H4D7Jtc8wQwPLYmc4jDf
         x5GfteLMu/MYeKsJHRYqWoXsGYmes4hdormPCUz9Rr8Dx47QtUB95T/i54p9SYg6Pn/I
         5CyCFnPO6je/LAT8tA1df0irJmUXJOTEzwrcUX54UtYkX6C8JGqL/0j4D8mG5HhLdyZv
         mTcvHk6swgzFFD3RbNp5r6MQth0TfjCsA2cUY0/qcEeP/GbclsuP2rza8RQ7bzSfWvNG
         t7YzUkMqfNQ/jtM5YpyOrtG9oVF6axG3e41/EOVMsnAb81aSrBK7Xp8O1QVZRONq10Z7
         qzIg==
X-Gm-Message-State: AC+VfDyGN7sdjDAm5w1PMeN1jHuYO4iRZpP/T2WIU/Bjj9buKFpeaRQp
        83bGBRldGlrVZlQU6jSK8uy7UebuELIrFKuu2A0=
X-Google-Smtp-Source: ACHHUZ5P898RbjNIMc3jugc8VXuh6nqPb72zq9lnfzEBeaBjC2PBFuHmDNgqP74RH6bSMstXwmBXUSnWmXtaWqUpbkg=
X-Received: by 2002:a2e:9d4a:0:b0:2b4:65ef:3af5 with SMTP id
 y10-20020a2e9d4a000000b002b465ef3af5mr10359639ljj.30.1687423162080; Thu, 22
 Jun 2023 01:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com> <xmqqmt10s0cw.fsf@gitster.g>
 <CAP8UFD3864uUjb0vR+B7xETJTFJoWdEqA5Gdyr42Lg3t8Auk=Q@mail.gmail.com> <xmqqy1kchi3l.fsf@gitster.g>
In-Reply-To: <xmqqy1kchi3l.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jun 2023 10:39:09 +0200
Message-ID: <CAP8UFD30Kx_vYfdV4ipPPXNVr76pKshjTUQGcJfkUvG_+KD3zQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 6:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It might indicate that we prefer to be safe, do things in different
> > steps and not provide an easy way for users to shoot their own foot.
> > For example it seems pretty safe to do things like this:
> >
> >   1) put all the objects we think should be on the promisor remote in
> > a separate packfile
> >   2) start checking that each object in that packfile is available on
> > the promisor remote
> >   3) if an object in that packfile isn't on the promisor remote, try
> > to send it there
> >   4) if we couldn't send the object, error out
> >   5) if we haven't errored out after checking all the objects in the
> > packfile, it means all these objects are now available from the
> > promisor remote and we can safely delete the packfile
>
> I may be missing something, but to me, the above sound more like a
> tail wagging the dog.
>
> Instead of saying "while repacking, we'll create the new pack with
> the objects that we suspect that we cannot re-fetch from the
> promisor (allowing false positives for safety), and store the rest
> in a backup pack (that can immediately be discarded)",

This might be a good idea, but what if users prefer to send to a
promisor remote the objects that should be on that promisor remote as
soon as possible, instead of keeping them on the local machine where
they take up possibly valuable space for no good reason?

My point is that there are a lot of different strategies that people
operating with a promisor remote could adopt, so it's better to
iteratively give them building blocks that can help them instead of
trying to find and implement right away the best solution for a
special use case or for every use case.

> the above
> says "while repacking, we'll create the new pack with objects that
> match the filter, and store the rest to another pack".  But because
> the object selection criteria used in the latter is not something
> with practical/useful meaning, in other words, it does not exactly
> match what we want,

"What we want" depends on the strategy chosen to manage objects on
promisor remotes and I am not sure that the strategy you mention is
always better than the example strategy I talked about. For some users
it might be better for others it might not.

> we fill the gaps between what we want (i.e. sift
> the objects into "refetchable" and "other" bins) and what we
> happened to have implemented (i.e. sift the objects into "match
> filter" and "other" bints) by sending the objects that we _should_
> have included in the new pack (i.e. "not refetchable") to the
> promisor to make them refetchable.
>
> I do not know what to think about that.  I do not think there is
> even a way to guarantee that the push done for 3) will always be
> taken and still leave the resulting promisor usable (e.g.  we can
> make them connected by coming up with a random new ref to point
> these "we are sending these only because we failed to include them
> in the set of objects we should consider local" objects, but then
> how would we avoid bloating the refs at the promisor remote side
> (which now has become a "dumping ground", rather than holding the
> objects needed for histories that project participants care about).

There are some configurations where users never want to delete any git
object. In those cases it doesn't matter if the promisor remote is a
"dumping ground". Users might just want a promisor remote to keep all
the large files that have ever been pushed into the repo, to save more
precious space on the machine hosting the regular repo.

There are configurations where users can have garanties that the push
done for 3) will work with a very high probability so that the example
strategy I talked about can work reliably enough.

The example strategy I talked about is just one example where having
repack --filter work like it does in this patch series can be useful
and safe. I don't pretend that it is always the best strategy and that
some users might not prefer another better strategy for them. If
that's the case perhaps they can implement another different option
that just checks that filtered out objects are indeed available from a
promisor remote and then just omit these objects from the resulting
pack. In fact I would have nothing against such an option, and I might
even implement it myself one day (no promise though).

Right now they have nearly no helpful command (except perhaps using
pack-objects directly), so even if this is not the best possible help
in all use cases, I am just saying that this can be useful in _some_
cases.

> As an argument to salvage this series as (one of the possible
> ingredients to) a solution to "slim down a bloated lazy clone"
> problem, it sounds a bit weak.

I don't quite agree, but anyway I will use this argument less in
version 2 of this patch series, and I will talk more about the
argument that `repack --filter=3D...` allows users to put packfiles
containing some kinds of objects (like large blobs or all the blobs)
on cheaper disks (when not using a promisor remote).

Thanks.
