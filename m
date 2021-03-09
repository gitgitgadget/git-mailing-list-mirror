Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E1BC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D066528C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhCIAK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCIAKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:51 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:51 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id h22so11112830otr.6
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WWYT445Ys209uEBYAmknVOJgRSGil8VA/DxmTwUnBBA=;
        b=MPlyj7utXdcoZxlXLm3AAKaRyeiLDfCtF54wh86liYCtzZtIdLOFaPNgJRIl90ELR/
         7qEU5npo4j6Fr6u6Daatau19VlDvv6rcRKHHtrOGfLHBV6Ds2ER31E1UpQgpnm2OMdW9
         STFMqXoqtEAWhkPCrFSl2ml3THKHAn49yOQx5EQO5wTsfqm4AeUznU5bEQes7g6MI75d
         MfaANiOmX/6kawM/2RtkPeuENNb/teYX2/uucaVpW/MRp1dKlpLdP6MoKpuHI6QxjhmC
         0AVN9KPlZaf37V/wEL1EwkQ+InATWmJWEjrfS3ZhJPhVkM1+DD9pCXUBKY+4abxNC5dS
         xx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WWYT445Ys209uEBYAmknVOJgRSGil8VA/DxmTwUnBBA=;
        b=tQBeZjOw7gme2hjZ7Rsyo9RpVULcztxdVy+SKyvDte8kO4ck0fdmjRWOg3mKCwM8dp
         JanHSNMEF9v7KEzmBe/7BmXxSCIh//Gy3KDU3f8WmmMLnyPr4ZYX6khkZv190bqPRgY7
         sqYr37L2XGWMdngdlRn6+u06W/fCmtrzftXk18N7DyJ1TAKNmTFzkFjNoEuXFR0Zzkfr
         K/CiPkdkw+kFelxoWgFngilauy779jCF/pljc5JyBltlHbcJ/fUBJI4yF2RuKfn2RASA
         kx8B4F035Ojfz1KNuJAmjwBsXphVIFae0ggs9fCxOpSPByNp6XSUAjraxdrGvSFg2v8t
         oOWA==
X-Gm-Message-State: AOAM5300uIayDTLGFuNO3FnVO08aNEym3mEv+O2yF2/H7voFe+cMGJQ6
        VB95dxisYvIwoP1l9mmwfFRQs4k3kamxLtTNMhxYGZtubUz70Q==
X-Google-Smtp-Source: ABdhPJw55B2b7tKVCoZ3+5LBS56HnYkypAis4Ft9w7Bi9S1agWKgxRGth4Br8lEogr9loGnneiHbg82PsRsCLj1ogxw=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr3221624otf.162.1615248650963;
 Mon, 08 Mar 2021 16:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-1-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 16:10:40 -0800
Message-ID: <CABPp-BHPR7SZHtuyROBc=c_g2nGyV_RA3xv9vmNXJw3v9KJurQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] tree-walk: mostly "mode" to "enum object_type"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> This large series goes on top of my 6 patch series for
> read_tree_recursive() as this one further refactors that function. See
> https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/
> for that series.
>
> I noticed that since 2014 or so we haven't been doing the fsck checks
> for bad file modes in trees. This series fixes that. I plan to add
> tests etc. for that in another follow-up series.
>
> I wanted to get this out for review sooner than later, particularly
> since the fsck testing will probably get me down another refactoring
> path (fsck testing in general in this area is pretty bad...).
>
> As noted in 30/30 it would have been way easier to simply do an
> isolated fix for that bug by introducing some fsck-specific API for
> raw tree reading.
>
> But I thought the bug was symptomatic of a wider problem in our
> codebase. Namely that we pass around the tree's mode *a lot*.
>
> But almost everything that then deals with the mode doesn't per-se
> care about the mode bits in the tree, but using them to map that mode
> to a tree entry for one of of OBJ_{BLOB,TREE,COMMIT}.
>
> So this is a large refactoring of all users of the widely used
> tree-walk.h API to "enum obj2ect_type", finally in 29/30 I rename the
> field to a scary "raw_mode".
>
> At that point we have just ~30-50 grep hits left for "raw_mode" in the
> codebase (depending on whether we count names in function parameters).
>
> Hopefully being in that state alleviates e.g. Elijah's concerns
> expressed in
> https://lore.kernel.org/git/CABPp-BEdu1PqV5W=3DFuL0f08iFhGzvzV8oSUybNj4eF=
0aAwTnAw@mail.gmail.com/
> I agree that doing the equivalent of 30/30 on top of master would be
> way too scary, but once we're at 29/30 I think it's sane.
>
> I tested this in combination with his on-list series to add more
> merge-ort testing:
> https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gmai=
l.com/
>
> I found a regression I'd caused in the merge-ort.c code with those
> tests, fixed here. See the comment in merge-ort.c in 30/30.

I'll start reading through this series, but two quick early notes:
  - I was worried about touching the tree-walk code message up
performance.  Since collect_rename_info() in merge-ort.c takes the
most time (and it's mostly a tree-walk), I was worried this would
regress performance for me.  A couple runs of my mega-renames big
rebase testcase suggests performance is not that different, so my
fears look unfounded.  (Note: I tested in combination with all my
performance improvements, because otherwise tree-walking would just be
in the noise of overall runtime.)
  - There's a textual conflict with this series and my sets of patch
series that finish off the ort implementation[1], but it's just two
lines that are pretty easy to resolve.

[1] https://github.com/gitgitgadget/git/pulls?q=3Dis%3Aopen+is%3Apr+author%=
3Anewren+Optimization+batch


> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (30):
>   diff.c: remove redundant canon_mode() call
>   notes & match-trees: use name_entry's "pathlen" member
>   cache.h: add a comment to object_type()
>   tree-walk.h: add object_type member to name_entry
>   tree-walk.c: migrate to using new "object_type" field when possible
>   cache.h: have base_name_compare() take "is tree?", not "mode"
>   tree-walk.h users: switch object_type(...) to new .object_type
>   tree.h: format argument lists of read_tree_recursive() users
>   tree.h users: format argument lists in archive.c
>   archive: get rid of 'stage' parameter
>   tree.h API: make read_tree_fn_t take an "enum object_type"
>   tree-walk.h users: migrate "p->mode &&" pattern
>   tree-walk.h users: refactor chained "mode" if/else into switch
>   tree-walk.h users: migrate miscellaneous "mode" to "object_type"
>   merge-tree tests: test for the mode comparison in same_entry()
>   merge-ort: correct reference to test in 62fdec17a11
>   fsck.c: switch on "object_type" in fsck_walk_tree()
>   tree-walk.h users: use temporary variable(s) for "mode"
>   tree-walk.h API: formatting changes for subsequent commit
>   tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
>   tree-walk.h API users: use "tmp" for mode in shift_tree_by()
>   tree-walk.h API: Add get_tree_entry_type()
>   tree-walk.h API: add a get_tree_entry_path() function
>   tree-walk.h API: document and format tree_entry_extract()
>   tree-entry.h API: rename tree_entry_extract() to
>     tree_entry_extract_mode()
>   tree-walk.h API: add a tree_entry_extract_all() function
>   tree-walk.h API: add a tree_entry_extract_type() function
>   tree-walk.h API users: rename "struct name_entry"'s "mode" to
>     "raw_mode"
>   tree.h API users: rename read_tree_fn_t's "mode" to "raw_mode"
>   tree-walk.h API: move canon_mode() back out of decode_tree_entry()
>
>  archive.c              | 51 +++++++++++++-----------
>  blame.c                |  9 +++--
>  builtin/checkout.c     |  7 +++-
>  builtin/fast-import.c  |  8 ++--
>  builtin/grep.c         |  6 +--
>  builtin/log.c          |  7 ++--
>  builtin/ls-files.c     | 13 +++---
>  builtin/ls-tree.c      | 18 ++++-----
>  builtin/merge-tree.c   | 32 +++++++++------
>  builtin/mktree.c       |  4 +-
>  builtin/pack-objects.c |  6 +--
>  builtin/reflog.c       |  3 +-
>  builtin/rm.c           |  2 +-
>  builtin/update-index.c |  7 +++-
>  cache-tree.c           |  2 +-
>  cache.h                | 11 ++++--
>  combine-diff.c         |  8 ++--
>  delta-islands.c        |  2 +-
>  diff.c                 |  2 +-
>  fsck.c                 | 23 +++++------
>  http-push.c            |  6 ++-
>  line-log.c             |  2 +-
>  list-objects.c         | 20 +++++++---
>  match-trees.c          | 52 ++++++++++++------------
>  merge-ort.c            | 34 ++++++++++------
>  merge-recursive.c      | 33 ++++++++--------
>  notes.c                | 15 +++----
>  object-name.c          |  7 ++--
>  pack-bitmap-write.c    |  8 ++--
>  read-cache.c           | 16 ++++----
>  revision.c             | 12 ++++--
>  t/t4300-merge-tree.sh  | 44 +++++++++++++++++++++
>  tree-diff.c            | 44 ++++++++++++---------
>  tree-walk.c            | 89 +++++++++++++++++++++++++++++++-----------
>  tree-walk.h            | 67 ++++++++++++++++++++++++++-----
>  tree.c                 | 19 +++++----
>  tree.h                 |  5 ++-
>  unpack-trees.c         | 30 ++++++++------
>  walker.c               | 22 ++++++-----
>  39 files changed, 482 insertions(+), 264 deletions(-)
>
> --
> 2.31.0.rc0.126.g04f22c5b82
>
