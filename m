Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B06C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924E964FC3
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCIVsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhCIVsR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:48:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71EC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:48:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id bd6so23414872edb.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=u/4rphnINogKBKfpCLbPPb2OI4Ez/zmdeq6SNqOAkmE=;
        b=vSgBykudc8b+BNygHUcr9fy6DmkLGNRaiZI5dWphDnNss7436fYPfh/AWa6/Ow52/k
         R6RmNuYA3uyse+A17q1+3QK8BTji6ulxzoDfz5auGgckmv1Dg35tR/duUAhx6TemaOIa
         3OD+yrUAtL8j6hC4u5Hb181yHG+m9zMwUWV0ciOrtBh14l1GoRZgU61d3J81FWnpUse0
         +v3vpaxkbqq70DJGVLQLg5Jq8hhVpn6hdvX/ut55ft50TyPfeIGPbnO5ZeKqabtAhUmQ
         xrXt6d5n2fZxdEVq/bmBODdlqeO2gWswoXYykP1vwoiSFeFEi03slmY3LxK2C0FjKg1O
         a4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=u/4rphnINogKBKfpCLbPPb2OI4Ez/zmdeq6SNqOAkmE=;
        b=g+rHcV4TM3vLfKf6UuKiYULZLJfHpHfPIftNuMJVfxBdjZnZ2gKI2FnRXnLncEJOpy
         AeonJuUUtsaNZ32TbLjZXDZCDgRqW2B5TkOkojBdGEeb1yfDWj4PvA0QQ5Lnid1WJ4uJ
         5cZongXgFrISh2qlcbSC8lGhN3zXzWgni4B2oFK/r7bZj+bv7NXC8DI7epAvSE6Jl5pa
         YJyMrs82MqbPi/w/JCmy0heWlzRTrJPRWSUClWD3RejZp5yynKo2EgttiNJlP9N5odvU
         ++NvX7TfAkH2jmPC4inacg/zJKZ/cyjgrIZndoZEtfsEgvvq0TdI55MZu4YZ98o+L9Qp
         fnxQ==
X-Gm-Message-State: AOAM531HZhdBlZ1H0JYUMFnOq1brQnAnmx9nXV7U9UDiIXHwdotlgEFc
        iOczaxMT/2FZfrZ3MFYo3bEbrH5CMXVzxg==
X-Google-Smtp-Source: ABdhPJz8uWxuXveyBAquTTBuwqHTAEPai1y4bDJA2ldWKRtBUCAGo+Qro6UbIv27FOP8nUHRloXgnQ==
X-Received: by 2002:a50:e702:: with SMTP id a2mr6605629edn.3.1615326489578;
        Tue, 09 Mar 2021 13:48:09 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i10sm8925860ejv.106.2021.03.09.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:48:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/30] tree-walk: mostly "mode" to "enum object_type"
References: <20210308022138.28166-1-avarab@gmail.com>
 <20210308150650.18626-1-avarab@gmail.com>
 <CABPp-BGqcG7Hpz1=Kf5wNMsTTdxVccGyRVmq5ShYOMG0phcqDg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BGqcG7Hpz1=Kf5wNMsTTdxVccGyRVmq5ShYOMG0phcqDg@mail.gmail.com>
Date:   Tue, 09 Mar 2021 22:48:08 +0100
Message-ID: <87blbshucn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 09 2021, Elijah Newren wrote:

> On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> This large series goes on top of my 6 patch series for
>> read_tree_recursive() as this one further refactors that function. See
>> https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/
>> for that series.
>>
>> I noticed that since 2014 or so we haven't been doing the fsck checks
>> for bad file modes in trees. This series fixes that. I plan to add
>> tests etc. for that in another follow-up series.
>>
>> I wanted to get this out for review sooner than later, particularly
>> since the fsck testing will probably get me down another refactoring
>> path (fsck testing in general in this area is pretty bad...).
>>
>> As noted in 30/30 it would have been way easier to simply do an
>> isolated fix for that bug by introducing some fsck-specific API for
>> raw tree reading.
>>
>> But I thought the bug was symptomatic of a wider problem in our
>> codebase. Namely that we pass around the tree's mode *a lot*.
>>
>> But almost everything that then deals with the mode doesn't per-se
>> care about the mode bits in the tree, but using them to map that mode
>> to a tree entry for one of of OBJ_{BLOB,TREE,COMMIT}.
>>
>> So this is a large refactoring of all users of the widely used
>> tree-walk.h API to "enum obj2ect_type", finally in 29/30 I rename the
>> field to a scary "raw_mode".
>>
>> At that point we have just ~30-50 grep hits left for "raw_mode" in the
>> codebase (depending on whether we count names in function parameters).
>>
>> Hopefully being in that state alleviates e.g. Elijah's concerns
>> expressed in
>> https://lore.kernel.org/git/CABPp-BEdu1PqV5W=3DFuL0f08iFhGzvzV8oSUybNj4e=
F0aAwTnAw@mail.gmail.com/
>> I agree that doing the equivalent of 30/30 on top of master would be
>> way too scary, but once we're at 29/30 I think it's sane.
>
> It's partially less scary (good cleanups that help make things
> clearer, your comment about the code having been in a similar state
> once upon a time in patch 30), but in some ways even more scary (after
> reading through 30/30 and readily noticing a few missing areas and
> starting to dig and finding several more).

Thanks a lot for your reviews. I'm going to let this sit for a fair bit
longer before any re-roll, especially with the rc period, other eyeballs
on this most welcome though :)

>>
>> I tested this in combination with his on-list series to add more
>> merge-ort testing:
>> https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gma=
il.com/
>>
>> I found a regression I'd caused in the merge-ort.c code with those
>> tests, fixed here. See the comment in merge-ort.c in 30/30.
>
> I've read through the whole series now.  It is nicely structured, and
> has lots of good cleanups.  Unfortunately, there are also some clear
> regressions noted in my comments on both patches 6 and 30.
>
> I'm particularly worried with patch 30's basic plan; I think it'd be
> far safer to have the tree-walking default to returning canonicalized
> modes but allowing callers to request it be off.  I think each caller
> is going to need someone to audit the particular path for whether it
> can be safely switched over to using raw modes on a case-by-case basis
> and with the introduction of new tests.  Some callers probably aren't
> worth the effort (e.g. merge-recursive).  Others might be, but require
> a fair amount of work or other trade-offs.  I'm split about whether
> merge-ort should consider it.  Using raw_modes might allow me to fix
> one funny corner case issue in merge-ort that to my knowledge no user
> has ever hit in practice, but I'm not sure fixing that testcase is
> worth it.  To fix it, we'd also have to allow writing tree objects
> with non-canonicalized modes to the object store (for a "temporary"
> tree defining the virtual merge-base); that means new objects with
> "broken"/"non-canonicalized" modes being written that users can
> access.

To add a bit to your worries, I think your "[...]does lower my worry
some[...]" in 30/30 is unfortunately based on some unintentional lying
on my part.

I.e. my "yes our test coverage sucks, but[...]" was based on some
misreading of the history. Here's a correction:

7146e66f086 didn't break the fsck check in mid-2014, it had been broken
for much longer. See Jeff King's late-2014 E-mail about it here (which
I've just now discovered):
https://lore.kernel.org/git/20140923154751.GA19319@peff.net/#t

Basically, decode_tree_entry() didn't sanitize the mode, but we did that
in the tree_entry_extract() function, which is what fsck.c was using all
along, so it was always getting pre-sanitized modes.

But I think I was mostly right, somewhat by accident, AFAICT this was
the state of things back then:
=20=20=20=20
    $ git grep '\b(init_tree_desc|fill_tree_descriptor|update_tree_entry|up=
date_tree_entry|tree_entry)\(' -- '*.c' | wc -l
    78
    $ git grep '\b(get_tree_entry|tree_entry_extract)\(' -- '*.c' | wc -l
    25

Those were the API functions that gave you the un-canonical and
canonical mode, respectively.

But yes, I agree that it's probably a bit too scary.

Where I was mainly trying to get to with 30/30 was that for any future
code we'd more carefully review this whole "raw_mode" thing just because
of its name.

So what do you think about a version of 30/30 where existing API users
immediately call canon_mode() upon calling the current API functions?

It would be ugly and verbose now, but the benefit would be that we'd eye
any future change that deals with this "raw_mode" with more suspicion,
and likely convert it to use the object_type instead.

Or I could just back out of this whole 29-30 step and just add a "bare"
API for fsck in particular.

I'm partial to renaming it to *something* just to make it more grep-able
though, we have a "mode" in all sorts of structs all over the place...

>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (30):
>>   diff.c: remove redundant canon_mode() call
>>   notes & match-trees: use name_entry's "pathlen" member
>>   cache.h: add a comment to object_type()
>>   tree-walk.h: add object_type member to name_entry
>>   tree-walk.c: migrate to using new "object_type" field when possible
>>   cache.h: have base_name_compare() take "is tree?", not "mode"
>>   tree-walk.h users: switch object_type(...) to new .object_type
>>   tree.h: format argument lists of read_tree_recursive() users
>>   tree.h users: format argument lists in archive.c
>>   archive: get rid of 'stage' parameter
>>   tree.h API: make read_tree_fn_t take an "enum object_type"
>>   tree-walk.h users: migrate "p->mode &&" pattern
>>   tree-walk.h users: refactor chained "mode" if/else into switch
>>   tree-walk.h users: migrate miscellaneous "mode" to "object_type"
>>   merge-tree tests: test for the mode comparison in same_entry()
>>   merge-ort: correct reference to test in 62fdec17a11
>>   fsck.c: switch on "object_type" in fsck_walk_tree()
>>   tree-walk.h users: use temporary variable(s) for "mode"
>>   tree-walk.h API: formatting changes for subsequent commit
>>   tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
>>   tree-walk.h API users: use "tmp" for mode in shift_tree_by()
>>   tree-walk.h API: Add get_tree_entry_type()
>>   tree-walk.h API: add a get_tree_entry_path() function
>>   tree-walk.h API: document and format tree_entry_extract()
>>   tree-entry.h API: rename tree_entry_extract() to
>>     tree_entry_extract_mode()
>>   tree-walk.h API: add a tree_entry_extract_all() function
>>   tree-walk.h API: add a tree_entry_extract_type() function
>>   tree-walk.h API users: rename "struct name_entry"'s "mode" to
>>     "raw_mode"
>>   tree.h API users: rename read_tree_fn_t's "mode" to "raw_mode"
>>   tree-walk.h API: move canon_mode() back out of decode_tree_entry()
>>
>>  archive.c              | 51 +++++++++++++-----------
>>  blame.c                |  9 +++--
>>  builtin/checkout.c     |  7 +++-
>>  builtin/fast-import.c  |  8 ++--
>>  builtin/grep.c         |  6 +--
>>  builtin/log.c          |  7 ++--
>>  builtin/ls-files.c     | 13 +++---
>>  builtin/ls-tree.c      | 18 ++++-----
>>  builtin/merge-tree.c   | 32 +++++++++------
>>  builtin/mktree.c       |  4 +-
>>  builtin/pack-objects.c |  6 +--
>>  builtin/reflog.c       |  3 +-
>>  builtin/rm.c           |  2 +-
>>  builtin/update-index.c |  7 +++-
>>  cache-tree.c           |  2 +-
>>  cache.h                | 11 ++++--
>>  combine-diff.c         |  8 ++--
>>  delta-islands.c        |  2 +-
>>  diff.c                 |  2 +-
>>  fsck.c                 | 23 +++++------
>>  http-push.c            |  6 ++-
>>  line-log.c             |  2 +-
>>  list-objects.c         | 20 +++++++---
>>  match-trees.c          | 52 ++++++++++++------------
>>  merge-ort.c            | 34 ++++++++++------
>>  merge-recursive.c      | 33 ++++++++--------
>>  notes.c                | 15 +++----
>>  object-name.c          |  7 ++--
>>  pack-bitmap-write.c    |  8 ++--
>>  read-cache.c           | 16 ++++----
>>  revision.c             | 12 ++++--
>>  t/t4300-merge-tree.sh  | 44 +++++++++++++++++++++
>>  tree-diff.c            | 44 ++++++++++++---------
>>  tree-walk.c            | 89 +++++++++++++++++++++++++++++++-----------
>>  tree-walk.h            | 67 ++++++++++++++++++++++++++-----
>>  tree.c                 | 19 +++++----
>>  tree.h                 |  5 ++-
>>  unpack-trees.c         | 30 ++++++++------
>>  walker.c               | 22 ++++++-----
>>  39 files changed, 482 insertions(+), 264 deletions(-)
>>
>> --
>> 2.31.0.rc0.126.g04f22c5b82
>>

