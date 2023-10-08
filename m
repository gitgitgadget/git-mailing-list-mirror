Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D9E95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 07:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbjJHHCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHCp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 03:02:45 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E4D6
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 00:02:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-503f39d3236so4261575e87.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696748561; x=1697353361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcEohYxcjQAh6Akjt6AujQqymxgjNPnuwgTRLQ+d0E4=;
        b=lvXvZ3lKHz401B/t8cfLUf9n+SgcqSgdZAQNNEOXekS1uy05n1i1/CvdDuIShjF3WW
         vXF7jSBfwaTukWVRUIwQb2sk/PnEdDnnxM/6f2IqmNuX4X9WrzUqfb+k8OvTSfgmzbat
         4tkkbnv/7Vva8zg9YgxhwWIW8RFYbm1LpIuA9nMYln7HDn9hDs8R8k61UYA/FhoxBrZj
         839QtLdJILjM5DdmP2ZyZh0N5+722W4ZdCYhwVd134pgrSdO0UB0vfHYGrW62CRfhc1/
         dDQjlPAtNigbtSZuTQwHbFbOjTFLEfKOj2tS8+CWsSTjdCCgMudlrwiqorTNFKx6408M
         TqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696748561; x=1697353361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcEohYxcjQAh6Akjt6AujQqymxgjNPnuwgTRLQ+d0E4=;
        b=vpuyDW5iZP2L2qgU2T530RRq9fYunqYRkiHPOzV/cr2Tdrst3LdNe8Qk61qPdRJyF6
         eSCoRpR5Vwe1Fo/BslYOglDzW4hc51Ao1Kan2MX4IQmSBPxKzDz/gGMqCYd0OWmO2RdD
         4YAKbWbBqgvCUd1TpfmlST82QHs1hSjeLLFpBhgoQ9Q/+9OAfQkoZgMARltgndzjxm32
         9HY9Qr6FFo3eVqBYkrM2SGLvZtSstpHrabRJufSnJCzOOd88PMn5rON2fR0FHx7ttlqs
         gW0B5w4MLuZJXFrVxfcK7gNUCyvcEfwaGPJrSDT3cek6oHpR6QpQAq1C8ppRjOWmH0U1
         /PNw==
X-Gm-Message-State: AOJu0YyRZV6D2EgB5k8kwgdNNhmXLFY6iR26loLl8TgI2jTyKzRashGl
        DOjYHtbV89W1tr066XWXBys+6R/y4PdRqDChB2w=
X-Google-Smtp-Source: AGHT+IEaEA6cyWqUsbwQLwqBYsFYKcdZuqnTbKHcoKz+cEEj6AfIQzO8e7FPBf/IuFsXvuuaO/u46ayMpCf3RVQGrxU=
X-Received: by 2002:a05:6512:130b:b0:502:ffdf:b098 with SMTP id
 x11-20020a056512130b00b00502ffdfb098mr13523207lfu.6.1696748560387; Sun, 08
 Oct 2023 00:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696629697.git.me@ttaylorr.com> <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g> <ZSCR7e6KKqFv8mZk@nand.local>
In-Reply-To: <ZSCR7e6KKqFv8mZk@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 8 Oct 2023 00:02:27 -0700
Message-ID: <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for `--write-pack`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2023 at 4:02=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Oct 06, 2023 at 03:35:25PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > When using merge-tree often within a repository[^1], it is possible t=
o
> > > generate a relatively large number of loose objects, which can result=
 in
> > > degraded performance, and inode exhaustion in extreme cases.
> >
> > Well, be it "git merge-tree" or "git merge", new loose objects tend
> > to accumulate until "gc" kicks in, so it is not a new problem for
> > mere mortals, is it?
>
> Yeah, I would definitely suspect that this is more of an issue for
> forges than individual Git users.

It may still be nice to also do this optimization for plain "git
merge" as well.  I had it in my list of ideas somewhere to do a
"fast-import-like" thing to avoid writing loose objects, as I
suspected that'd actually be a performance impediment.

> > As one "interesting" use case of "merge-tree" is for a Git hosting
> > site with bare repositories to offer trial merges, without which
> > majority of the object their repositories acquire would have been in
> > packs pushed by their users, "Gee, loose objects consume many inodes
> > in exchange for easier selective pruning" becomes an issue, right?
>
> Right.
>
> > Just like it hurts performance to have too many loose object files,
> > presumably it would also hurt performance to keep too many packs,
> > each came from such a trial merge.  Do we have a "gc" story offered
> > for these packs created by the new feature?  E.g., "once merge-tree
> > is done creating a trial merge, we can discard the objects created
> > in the pack, because we never expose new objects in the pack to the
> > outside, processes running simultaneously, so instead closing the
> > new packfile by calling flush_bulk_checkin_packfile(), we can safely
> > unlink the temporary pack.  We do not even need to spend cycles to
> > run a gc that requires cycles to enumerate what is still reachable",
> > or something like that?
>
> I know Johannes worked on something like this recently. IIRC, it
> effectively does something like:
>
>     struct tmp_objdir *tmp_objdir =3D tmp_objdir_create(...);
>     tmp_objdir_replace_primary_odb(tmp_objdir, 1);
>
> at the beginning of a merge operation, and:
>
>     tmp_objdir_discard_objects(tmp_objdir);
>
> at the end. I haven't followed that work off-list very closely, but it
> is only possible for GitHub to discard certain niche kinds of
> merges/rebases, since in general we make the objects created during test
> merges available via refs/pull/N/{merge,rebase}.

Oh, at the contributor summit, Johannes said he only needed pass/fail,
not the actual commits, which is why I suggested this route.  If you
need to keep the actual commits, then this won't help.

I was interested in the same question as Junio, but from a different
angle.  fast-import documentation points out that the packs it creates
are suboptimal with poorer delta choices.  Are the packs created by
bulk-checkin prone to the same issues?  When I was thinking in terms
of having "git merge" use fast-import for pack creation instead of
writing loose objects (an idea I never investigated very far), I was
wondering if I'd need to mark those packs as "less optimal" and do
something to make sure they were more likely to be repacked.

I believe geometric repacking didn't exist back when I was thinking
about this, and perhaps geometric repacking automatically handles
things nicely for us.  Does it, or are we risking retaining
sub-optimal deltas from the bulk-checkin code?

(I've never really cracked open the pack code, so I have absolutely no
idea; I'm just curious.)

> I think that like anything, this is a trade-off. Having lots of packs
> can be a performance hindrance just like having lots of loose objects.
> But since we can represent more objects with fewer inodes when packed,
> storing those objects together in a pack is preferable when (a) you're
> doing lots of test-merges, and (b) you want to keep those objects
> around, e.g., because they are reachable.

A couple of the comments earlier in the series suggested this was
about streaming blobs to a pack in the bulk checkin code.  Are tree
and commit objects also put in the pack, or will those continue to be
written loosely?
