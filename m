Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10853C07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0C361468
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGIB2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGIB2n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 21:28:43 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71039C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 18:26:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso7778245otu.10
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 18:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvbddtiQHm1KbcLrgxzagExBjmXzDlD7kT8yE3nfdX8=;
        b=o1K52XuKsg8qjiLd/uwqM8Ty1+iN9oUr+iUkFEVZMNaIb0+jSBWVKsr/WCnJxVTczQ
         ELwt7SI/+v6Wu6iKkn83FR5HTpwI62CK0oUoAGxUgnuuYoHzJguxuby5C3jJLAYnzYqB
         zoQ7USjnYDn4yRsyI+8B7zmo7/7TE3J2TiMDvQLUsTHiVakZjWyWOrwKgtZI4Wi+W/gc
         n+gxitrtmsRLHJRdVjDx/fXk8NZxk6oixxq0jblKwv5JCOV2EEKV2gOUA91BwuJZ4CJI
         aF+vYyG7KQ96T6ybo7uXxm9M6uqyAHhc71rWpbfALbG3GV/6x/gOG6eCLzTT1E9cOHl4
         kKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvbddtiQHm1KbcLrgxzagExBjmXzDlD7kT8yE3nfdX8=;
        b=ArXILqJ/jn35zVKOqWCq0qg3zO85m/oeHmMTmVAyuVg3bwXt47Sf0OezvtMIw5Y5l/
         mvs5FcR5FZqonBURwSrLtR5pfCh8CEOCOMSQc7TSUHNjrpMJETlUDczdjfdTbt/mPK8M
         meTUv50lFGDt+qM4e7KiJpi+gngr9zeSzIW+FmUVUZY39iKf1B0ivIPuEg3eE9hjJrjg
         uSjr26NmgXs3R//QDbAVxGHgfe+b76CnW0L16QZWqRrIlgDi6GI3bmmo9OX0DYIO+fey
         K08c3Jg19UxXBlqGuHFoP5F+HtZRX0EvK8Yt4Ofom1v7WUHdXlM+8D95XuiVDBMac4/a
         HCLQ==
X-Gm-Message-State: AOAM532iJ4SitLC2WMTaT3hnG+UPUb2dkoX9fUK+ew8+LPBWnqoyd9Lr
        XqCIHxuU7ku7XFaOzKJddTULjwtSV9PSxIPMOEw=
X-Google-Smtp-Source: ABdhPJzY0F6kpHR8HRTJYlul5147B/w28uEC15pEYrci0zvB1tuDgZX8z4gQZLILdnM2pqRCkKq0FMKJhHQiu/GGs6U=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr26356595otn.345.1625793959462;
 Thu, 08 Jul 2021 18:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8s2ga19f.fsf@gitster.g>
In-Reply-To: <xmqq8s2ga19f.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Jul 2021 18:25:48 -0700
Message-ID: <CABPp-BFZmY4jwXLHMgikvgXP7RtPhS=abGyVACsKn+BXWyCybg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #02; Thu, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 8, 2021 at 3:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/ort-perf-batch-14 (2021-07-01) 7 commits
>  - merge-ort: restart merge with cached renames to reduce process entry cost
>  - merge-ort: avoid recursing into directories when we don't need to
>  - merge-ort: defer recursing into directories when merge base is matched
>  - merge-ort: add a handle_deferred_entries() helper function
>  - merge-ort: add data structures for allowable trivial directory resolves
>  - merge-ort: add some more explanations in collect_merge_info_callback()
>  - merge-ort: resolve paths early when we have sufficient information
>
>  Further optimization on "merge -sort" backend.
>
>  Reviews?

Go ahead and mark this as expecting a re-roll.  While no reviews have
come in yet, I was writing up a blog post about it and discovered one
small issue I'd like to correct.

> * ds/commit-and-checkout-with-sparse-index (2021-06-28) 5 commits
>  - checkout: stop expanding sparse indexes
>  - sparse-index: recompute cache-tree
>  - commit: integrate with sparse-index
>  - p2000: compress repo names
>  - p2000: add 'git checkout -' test and decrease depth
>  (this branch uses ds/status-with-sparse-index.)
>
>  "git checkout" and "git commit" learn to work without unnecessarily
>  expanding sparse indexes.
>
>  Comments?

Will review soon, now that I've finished reviewing the latest round of
the dependent series.

> * ds/status-with-sparse-index (2021-06-28) 16 commits
>  - fsmonitor: integrate with sparse index
>  - wt-status: expand added sparse directory entries
>  - status: use sparse-index throughout
>  - status: skip sparse-checkout percentage with sparse-index
>  - diff-lib: handle index diffs with sparse dirs
>  - dir.c: accept a directory as part of cone-mode patterns
>  - unpack-trees: handle dir/file conflict of sparse entries
>  - unpack-trees: unpack sparse directory entries
>  - unpack-trees: rename unpack_nondirectories()
>  - unpack-trees: compare sparse directories correctly
>  - unpack-trees: preserve cache_bottom
>  - t1092: add tests for status/add and sparse files
>  - t1092: expand repository data shape
>  - t1092: replace incorrect 'echo' with 'cat'
>  - sparse-index: include EXTENDED flag when expanding
>  - sparse-index: skip indexes with unmerged entries
>  (this branch is used by ds/commit-and-checkout-with-sparse-index.)
>
>  "git status" codepath learned to work with sparsely populated index
>  without hydrating it fully.
>
>  Will merge to 'next'?

Not quite yet.  The series is starting to look really good, but I did
find some issues in my review here:
https://lore.kernel.org/git/CABPp-BF2BLQm6864m+esquJ7og3fWHvTZeX_R-y4pnx9ApZ6XA@mail.gmail.com/
