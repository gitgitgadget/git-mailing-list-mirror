Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042BEC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C5823A62
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgLRGzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgLRGzE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:55:04 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD00C0617B0
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:54:24 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id x23so332567oop.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6Yoqsh+t+cOHpiX0j0K//gCTYMs2lFwrGTmV9Z4u28=;
        b=IEqpl1mLbSOM7JiE/yL1YtIcoALqpjR6PKUuruBMgSPfrXdgVwtO6YCdlt9Ug/b7oW
         hGh+wBbxmBkAWZrIb1ORFi+Bbpjb5ItaWJuKn3YSOv+gV+272jCtPK+4TI/EzUFpFEFQ
         m1pCQzS8JU9/2RA7z8LtrtReYLW0xKNpncymNdRaXdgINhpS+0g4mipN8nw+AbghQBxd
         HUT5Ws69IG7omXOcrInarpT2UQXeju1mnIO2ekL1FZGfPEUsYzrbYQ5XCq08QPuG4MmB
         7CDC9SdephH1GjNxmBYiLAw++wkIa1y1LLa7yrotylSn+iXE0X/41iOxR+KMOWjc/jwd
         YkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6Yoqsh+t+cOHpiX0j0K//gCTYMs2lFwrGTmV9Z4u28=;
        b=RyH6N9sufg0TniBT127k9M7MwxbYSH2PinQ1I3jEC4mKG+duEvd4AHQAxnLn5Sznbv
         8pT057IvP0NE2iSvb7htR3Otwi2ovDSphsvF+4/ti1mU7mq3zt79tk6GjeNiIKeJjCuU
         M+8AosO45e+ha5oPd87faGL9dPa1etIbxSDX153zOUrPgMSpEV5KaI3uIh4gbekeIACD
         gagph5yM99Zub1oHQXYx4dUGNv9oxynNAmDDZ2kHTaz85lUFml90sKEqjAJhI9pyH/LG
         iAc1ltlKxcUeOfGsplryhSUiglKFAfWZ9WiOCTrip0mF2xt5XztXgJHjNvk+ySsZEbbd
         e26Q==
X-Gm-Message-State: AOAM531EsRdXe2qAR/Hg3EJXTetrvudSQRQkbiLHJt5Z48BPYwX+MR4R
        5Qm9VM59vewfkZLxGsBLOQK37uYGI9zzyLbEjDw=
X-Google-Smtp-Source: ABdhPJw61l0hq96eWsvMgB89d2aGqPOhuVKGuAvBoPzRqiGfWesw5rOi6baijQJMZlXrcCYlgP7OkyjU8UeXy++toXs=
X-Received: by 2002:a4a:adc5:: with SMTP id t5mr1321408oon.45.1608274463769;
 Thu, 17 Dec 2020 22:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 22:54:12 -0800
Message-ID: <CABPp-BH_p50rNgpirpvPSK4ZnPTm4c62iothOF1Qa_7E1_EfFQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> These patch series implement new set of options governing diff output
> of merge commits, all under the umbrella of single
> --diff-merges=<mode> option.

With this round, I was hoping to get a range-diff (using the
--range-diff option to format-patch), so I could more easily see what
was new.  Since I've been updating frequently enough, I was able to
generate this locally using Junio's published so/log-diff-merge topic,
but it'd be helpful if you could include it in any future rounds.

With your previous patch series, I scanned most the patches somewhat
briefly but looked at the final patches more closely (the series is
kind of long, and I noticed Junio had started reviewing the early part
of the series, so I figured it might be most helpful to jump in and
cover the end in case he didn't get that far).  With this round, I
read through the range-diff, and then looked at all the new patches
and have left a number of comments.  I think Junio reviewed the first
8 or so patches of an earlier round, so patches 9-21 probably could
benefit from someone reviewing more closely.

Overall, I like the direction of the series.  I think it'll make it
easier to add --remerge-diff later since it simplifies getting the
interaction between it and -m/-c/--cc/--first-parent right.  It also
adds some new capabilities you want (--diff-merges=first-parent, to
show merges as diff against first parent without only traversing first
parents), and that Junio wants (--diff-merges=dense-combined, to only
show merges for diffs without showing diffs for non-merge commits).

> Unlike original -c/--cc options, these new options do not imply -p,
> thus allowing for getting diffs for merge commits without provoking of
> diff output for regular, non-merge commits. E.g.:
>
>   git log --diff-merges=cc
>
> will output diffs (in dense-combined format) only for merge commits,
> whereas:
>
>   git log --cc
>
> enables diffs for all the commits being output, either merges or
> simple ones.
>
> There is also another additional functionality provided, allowing to
> get the format of "-p --first-parent" without change in history
> traversal that --first-parent option causes, like this:
>
>   git log --diff-merges=first-parent
>
> The net result of these series are the following new options:
>
> --diff-merges=    |  rough original equivalent
> ------------------+----------------
> 1|first-parent    | --first-parent (only diff format implications)
> m|separate        | -m and enable diff for merges
> c|combined        | -c and enable diff for merges, but not for regulars
> cc|dense-combined | --cc and enable diff for merges, but not for
>                   |      regulars
>
> The series also cleanup logic of handling of diff merges options and
> fix an issue found in the original implementation where logically
> mutually exclusive options -m/-c/--cc failed to actually override each
> other. Neither semantics of these old options nor their interactions
> with other options, such as --first-parent and -p, is supposed to be
> changed.
>
> The series start with the set of pure refactoring commits that are expected
> to introduce no functional changes. These are all commits up to and
> including:
>
> "diff-merges: revise revs->diff flag handling"
>
> The aim of these commits is to isolate options handling for diff merges so
> that it could be easily understood and tweaked to ease introduction of the
> new options.
>
> Then the fix of -m/-c/-cc overriding issue follows, starting with a failing
> test and followed by the fix.
>
> Then follows a little bit of additional refactoring in order to
> prepare for introduction of the new options, and finally the series
> are finished by the implementation, documentation updates, and
> some testing for the new options.
>
> Updates in v2:
>
>   * Move logic of "-c/--cc imply -p" to this module and do not imply
>     -p by new --diff-merges options. Instead enable corresponding diff
>     output without affecting non-merge commits. This is the most
>     significant change with respect to v1 and it starts at 24/33.
>
>   * Add support for old mnemonics: --diff-merges=(m|c|cc) to help
>     those who are used to them, and add --diff-merges=1 to cover all
>     variants with short mnemonics.
>
>   * Fixed functions definitions style to have open curly brace on its
>     own line, pointed to by Junio C Hamano.
>
>   * Tweak --diff-merges=first-parent description, requested by Elijah
>     Newren.
>
>   * Fixed git-show documentation not to include description chunk
>     relevant to git-log only, noticed by Elijah Newren.
>
>   * Fixed documentation mistake claiming that -p is needed for
>     diff-merges options to take effect, noticed by Elijah Newren.
>
>   * Fixed a case where a change was put into wrong commit. The change
>     moved to 11/27 form 10/27. Didn't affect end-result in any way.
>
>   * Added short module description to diff-merges.h, as suggested by
>     Junio C Hamano.
>
>   * Fixed not returning "argcount" from diff_merges_parse_opts(),
>     noticed by Junio C Hamano.
>
> Updates in v1:
>
>   * Added documentation fix for git-show to include --diff-merges.
>
>   * Fixed typos in commit messages noticed by Philip Oakley.
>
> Sergey Organov (33):
>   revision: factor out parsing of diff-merge related options
>   revision: factor out setup of diff-merge related settings
>   revision: factor out initialization of diff-merge related settings
>   revision: provide implementation for diff merges tweaks
>   revision: move diff merges functions to its own diff-merges.c
>   diff-merges: rename all functions to have common prefix
>   diff-merges: move checks for first_parent_only out of the module
>   diff-merges: rename diff_merges_default_to_enable() to match semantics
>   diff-merges: re-arrange functions to match the order they are called
>     in
>   diff-merges: new function diff_merges_suppress()
>   diff-merges: new function diff_merges_set_dense_combined_if_unset()
>   diff-merges: introduce revs->first_parent_merges flag
>   diff-merges: revise revs->diff flag handling
>   t4013: support test_expect_failure through ':failure' magic
>   t4013: add tests for -m failing to override -c/--cc
>   diff-merges: fix -m to properly override -c/--cc
>   diff-merges: split 'ignore_merges' field
>   diff-merges: group diff-merge flags next to each other inside
>     'rev_info'
>   diff-merges: get rid of now empty diff_merges_init_revs()
>   diff-merges: refactor opt settings into separate functions
>   diff-merges: make -m/-c/--cc explicitly mutually exclusive
>   diff-merges: implement new values for --diff-merges
>   diff-merges: fix style of functions definitions
>   diff-merges: handle imply -p on -c/--cc logic for log.c
>   diff-merges: do not imply -p for new options
>   diff-merges: let new options enable diff without -p
>   diff-merges: add old mnemonic counterparts to --diff-merges
>   diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
>   doc/git-log: describe new --diff-merges options
>   doc/diff-generate-patch: mention new --diff-merges option
>   doc/rev-list-options: document --first-parent changes merges format
>   doc/git-show: include --diff-merges description
>   t4013: add tests for --diff-merges=first-parent
>
>  Documentation/diff-generate-patch.txt         |   6 +-
>  Documentation/diff-options.txt                |  53 +++++
>  Documentation/git-log.txt                     |  46 +---
>  Documentation/git-show.txt                    |   7 +-
>  Documentation/rev-list-options.txt            |   5 +
>  Makefile                                      |   1 +
>  builtin/diff-files.c                          |   5 +-
>  builtin/diff.c                                |   9 +-
>  builtin/log.c                                 |  22 +-
>  builtin/merge.c                               |   3 +-
>  diff-merges.c                                 | 151 +++++++++++++
>  diff-merges.h                                 |  24 +++
>  fmt-merge-msg.c                               |   3 +-
>  log-tree.c                                    |  30 +--
>  revision.c                                    |  38 +---
>  revision.h                                    |   9 +-
>  t/t4013-diff-various.sh                       |  11 +-
>  t/t4013/diff.log_--cc_-m_-p_master            | 200 ++++++++++++++++++
>  ...diff.log_--diff-merges=first-parent_master |  56 +++++
>  t/t4013/diff.log_-c_-m_-p_master              | 200 ++++++++++++++++++
>  ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++
>  21 files changed, 900 insertions(+), 116 deletions(-)
>  create mode 100644 diff-merges.c
>  create mode 100644 diff-merges.h
>  create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
>  create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_master
>  create mode 100644 t/t4013/diff.log_-c_-m_-p_master
>  create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master
>
> --
> 2.25.1
>
