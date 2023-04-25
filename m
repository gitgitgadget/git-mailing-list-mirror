Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0046AC7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 03:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjDYDDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 23:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDYDDI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 23:03:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAD1BFF
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 20:03:06 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b99dae893c0so1452505276.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 20:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682391785; x=1684983785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B3zFPILTq2m2vGrb61HOQkQx2hpZbrwC+hhJtqjrWw=;
        b=B5w2YYc/eNWcuNU7pQ7EYleV7moq/es1HrDnKlzal4IGG85tCEKcUfBqCKsPDV88qY
         zctMV/1yFqmk9tvEYRHPzeBXJ4rPxnFSWNx9Mnzmp7pvWs1IZhkBYKP+gAhuImvFYp08
         t0y6LRByINVUDIzjgpZPkEcT5jJOnxQO+3GZfDALkHL44RBXPw4tYPiYeU9on60cs1Rn
         QCaiDBCpZv2VR7Ww77/suT9J7Axdgv5fS9kw3sZXo1chJooBZuzWIn5LaLyYHKtf6Fpe
         rhrkBmVRfaaZqbB9g3IcgfNBD7NM5Ai9DhtWuDgOJ0/L7OG7UjPsbTrUTDI0pMOJ1gaf
         gd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682391785; x=1684983785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B3zFPILTq2m2vGrb61HOQkQx2hpZbrwC+hhJtqjrWw=;
        b=S6+x/eKn14XYa2P2Q+K+C1QiXwlnM1Am5FHp5YGMvhgZO7cneVDbX2NNpM4+6gT/Y+
         SLtaS9zZMqb7tAM0JWTe05mPG28Vybj3qysZeYH/F9pEURNsLZilLAnbe9hYPw03LUvm
         3JhTHGXuaHe4JX6KyXYlvQPVAIkzITLuFQ1zQLqe99S6ISNc/H3X5tHoAEkCABH9yhVR
         IwuA1Z6a8bOm4jlmEmRq8QQdT3BN26ss+FgQ68/2JNttMiHgqD6BBXElHAp3XvRUI0I2
         glSd+tvJwb7JDQVzRIZIPVip5WNRKeVs6Ubx42sd1eqRYiZivj0m8EiTRHd+0ZXvi6Eo
         etQw==
X-Gm-Message-State: AAQBX9dfFdL+Pf5bb9rPzqWxhxSIFlgm2NAt5CaHkBUD6PVfJ4AleIel
        wVJFgzzrcs7TJkKPXnwAFKJzlJDBKcyuiCH6yya75A==
X-Google-Smtp-Source: AKy350an+t6lvo1Oxg2T2BO/AgMHBJzTJKVD7uKIWASSAlKY15Xk3cLR0qBzBubLORZDbaeiT7Czq2zaMl8+Rfi17+4=
X-Received: by 2002:a25:b097:0:b0:b97:f46:a2b8 with SMTP id
 f23-20020a25b097000000b00b970f46a2b8mr10613132ybj.17.1682391785370; Mon, 24
 Apr 2023 20:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230424022318.80469-1-hanxin.hx@bytedance.com> <2bcaeba9-20bc-1ca8-849b-ac54342c71e3@github.com>
In-Reply-To: <2bcaeba9-20bc-1ca8-849b-ac54342c71e3@github.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Tue, 25 Apr 2023 11:02:54 +0800
Message-ID: <CAKgqsWUEnbmhLL3p9+_P4yH_=A+hz+bBPqmfb8FyRUeW-u7_gw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] negotiator/default.c: avoid stack overflow
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 10:44=E2=80=AFPM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> > This is the same case as [1].
> >
> > 1. https://lore.kernel.org/git/20221025232934.1504445-1-jonathantanmy@g=
oogle.com/
>
> Thanks for the link, though this could be replaced with
>
>   4654134976f (negotiator/skipping: avoid stack overflow, 2022-10-25)
>
> now that the change exists in the commit history.

make sense.

>
> One thing that is missing from that change is a test, and such a test
> could be generalized to apply to all negotiators. This could maybe
> help any potential future negotiator avoid this bug. Did you think
> about what such a test could look like? Perhaps test_commit_bulk
> could help, but we'd probably need to create so many commits that the
> test would need to be marked as expensive. That's probably a major
> reason to not include a test and rely on avoiding recursion when
> possible.

I first found this issue in a large repository with numerous merge commits.
To address it, I added a test case which fast-imports 10,000 commits and
runs them through run_with_limited_stack(). Although expensive, this
approach was successful in executing the test case without any issues.

>
> > -     if (commit !=3D NULL && !(commit->object.flags & COMMON)) {
> > +     struct prio_queue queue =3D { NULL };
> > +
> > +     prio_queue_put(&queue, commit);
>
> Should we check the conditions what were removed? The COMMON flag
> is likely only useful for the recursion, but prio_queue_put() is
> not careful about NULL values. However, no callers should be
> providing NULL commits here.
>
> Couldn't hurt to add
>
>         if (!commit)
>                 return;

make sense.

>
> before the prio_queue_put().
>
> > +     while ((commit =3D prio_queue_get(&queue))) {
> >               struct object *o =3D (struct object *)commit;
> >
> > +             if (commit =3D=3D NULL || (commit->object.flags & COMMON)=
)
> > +                     continue;
>
> The NULL condition is definitely unnecessary here as it is checked
> by the while condition. The "& COMMON" is helpful if the commit
> gained the COMMON flag after being inserted into the queue.
>
> >               if (!ancestors_only)
> >                       o->flags |=3D COMMON;
> >
>
>
> > @@ -70,15 +76,17 @@ static void mark_common(struct negotiation_state *n=
s, struct commit *commit,
> >                               ns->non_common_revs--;
> >                       if (!o->parsed && !dont_parse)
> >                               if (repo_parse_commit(the_repository, com=
mit))
> > -                                     return;
> > +                                     continue;
> >
> > +                     ancestors_only =3D 0;
>
> This caught me off guard, but this flag essentially says "should
> I mark the first commit as common or not?". It would probably be
> clearer if this was done before the loop, and then was ignored
> within the loop, setting the flag on each parent in this loop:
>
> >                       for (parents =3D commit->parents;
> >                                       parents;
> >                                       parents =3D parents->next)
> > -                             mark_common(ns, parents->item, 0,
> > -                                         dont_parse);
> > +                             prio_queue_put(&queue, parents->item);
>

I'll think about how to optimize this again.

ancestors_only is used multiple times in the original logic:
1.
              if (!ancestors_only)
                     o->flags |=3D COMMON;
2.
             if (!(o->flags & SEEN))
                     rev_list_push(ns, commit, SEEN);
             else {
                     struct commit_list *parents;

                     if (!ancestors_only && !(o->flags & POPPED))
                             ns->non_common_revs--;

Should we use this ?

             if (!ancestors_only) {
                    commit->object.flags |=3D COMMON;

                    if ((commit->object.flags & SEEN) &&
!(commit->object.flags & POPPED))
                             ns->non_common_revs--;
             }

and

                   for (parents =3D commit->parents;
                             parents;
                             parents =3D parents->next) {
                             if (parents->item->object.flags & COMMON)
                                      continue;

                            parents->item->object.flags |=3D COMMON;

                            if ((parents->item->object.flags & SEEN)
                                     && !(parents->item->object.flags & POP=
PED))
                                      ns->non_common_revs--;

                            prio_queue_put(&queue, parents->item);
                   }

> It would have an extra benefit: your walk may duplicate objects in the
> priority queue (there is no duplicate protection in prio_queue_put).
> But, we could use
>
>         if (!(parents->item->object.flags & COMMON)) {
>                 parents->item->object.flags |=3D COMMON;
>                 prio_queue_put(&queue, parents->item);
>         }
>
> as duplicate protection _and_ a clearer way to demonstrate what
> ancestors_only is doing. Without this protection, it is possible
> to have exponential growth in the priority queue using simple
> merge commits.
>
> You'd need this at the beginning:
>
>         if (!commit)
>                 return;
>
>         prio_queue_put(&queue, commit);
>         if (!ancestors_only)
>                 commit->object.flags |=3D COMMON;

Make sense.

> > diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> > index c7d6ab39bc..3d262b3533 100644
> > --- a/negotiator/skipping.c
> > +++ b/negotiator/skipping.c
> > @@ -108,6 +108,8 @@ static void mark_common(struct data *data, struct c=
ommit *seen_commit)
> >                               prio_queue_put(&queue, p->item);
> >               }
> >       }
> > +
> > +     clear_prio_queue(&queue);
>
> This memory leak cleanup in the skipping negotiator is good to
> do, but should be split into its own change.
>
> In addition, the mark_common() method there seems to have a few
> problems:
>
>  1. It does not do duplicate protection before prio_queue_put().
>     (The COMMON bit would work here, too.)
>  2. When it translated from recursive to iterative it kept "return"
>     statements that should probably be "continue" statements.
>  3. It does not attempt to parse commits, and instead returns
>     immediately when finding an unparsed commit. This is something
>     that it did in its original version, so maybe it is by design,
>     but it doesn't match the doc comment for the method.
>
> Consider fixing these issues while you are here.
>

Make sense.

Thanks.
-Han Xin
