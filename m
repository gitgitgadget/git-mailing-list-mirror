Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B34C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FE4206D4
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHhhWLsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgJ3D6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgJ3D6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:58:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E9C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:58:13 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j7so5375632oie.12
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CE/Lf8wmjQYfwCyeleLoQtEGwcTfX455/quQJPpRZGs=;
        b=IHhhWLsQcZITRDd5S9GUjKcKNNQ4T9vLMt7PXRbNdPu+5xlp6OTlzlmCDqCxCK9/xs
         y64/2So3qomanklZkpIU3o3B3fsysdINKzdtxVyCh0cyqtRxx9V6bSIXULvy4o9s86vs
         Jan3HMXXVYcAqLQBypFvVeXy4ghwOVW2ulgP81aRqKWr0uSVNAe3++8GAe5yw06Sq2nP
         a2KROnATDgIKd1fzqvv+gPT8TgggZ6yavm9q17zUKipQQwiozSZ6CIBrRP7AFGUMNwpz
         zUekc3olwwEyBeKPsgTX+7cWW58BZUKp4z2Wgu2RUO2bPkkBd4GUHNEW5AUjHhdUeq9b
         5CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CE/Lf8wmjQYfwCyeleLoQtEGwcTfX455/quQJPpRZGs=;
        b=BNrSmPvmUzCowOncjxwsL51L0duy7pi/qoxYI8mutuCdRayLCaWkOSK8GRuR1QUyfv
         2lo7fXycc22dcFfphjv9N14GkdaJO5IoEcb+Z2dO9123BQwoS3MYV0i3HpBOnVoXhtAR
         iUWejmIY1lAZT5ti5crb0NMX4CPUFz8n7rkPA5I6iBEIZTJZ29q1g1vIsSeiSsRuLtkN
         KXnjniuX+HhiJEtXNUrWhytVoHj80Q18q0724HeZNPF/cJzGcQG8jTD/+s14n0JUiHq+
         CBUoh34oWzOvCvZdBeoVg5AdmyvBM5loaSJ0l0z5kR4QfaFJydsgurbPJfNIS3bi6d0o
         6TpA==
X-Gm-Message-State: AOAM533Z5sDhC2Sdy0k3MUMGFSID8+PqtvOLcsQb1Zc7YzUL3V5V9zU1
        lfXnATAPaNx/vbwezf0fE+a406eV8u4xnY3NsB8OPM3RDt6LXw==
X-Google-Smtp-Source: ABdhPJwEf1cPgFLTUQUgBKyS25u7gW4Ec/4QaaipcyQ3v7K7OVBsB19BMMcOCpps0ltlO23jXnkEfq1pbR/mc/yp2VQ=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr287616oic.31.1604030292461;
 Thu, 29 Oct 2020 20:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201030034131.1479968-1-newren@gmail.com>
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Oct 2020 20:58:01 -0700
Message-ID: <CABPp-BHKGkx04neULtYUyfiU+z-X7_rxQqriSEjxZjU1oXokOA@mail.gmail.com>
Subject: Re: [PATCH 00/20] fundamentals of merge-ort implementation
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 8:41 PM Elijah Newren <newren@gmail.com> wrote:
>
> ...
> The goal of this series is to show the new design and structure behind
> merge-ort, particularly the bits that are completely different to how
> merge-recursive operates....
>
> At a high level, merge-ort avoids unpack_trees() and the index, instead
> using traverse_trees() and its own data structure.  After it is done
> processing each path, it writes a tree.  Only after it has created a new
> tree will it touch the working copy or the index.  It does so by using a
> simple checkout-like step to switch from head to the newly created tree.
> If there are unmerged entries, it touches up the index after the
> checkout-like step to record those higher order stages.

While I didn't think anyone needed to be cc'ed on the whole series,
but I made some promises at Git Merge 2020 to give some heads up:

* Brian: Patches 13-15 create tree objects, joining other places in
the code such as fast-import, mktree, cache-tree, and notes that write
tree objects.  You mentioned something about consolidating these for
sha256 handling.
* Edward: You wanted a heads up when I started submitting the ort
merge backend.  Here it is.  It doesn't change any on-disk data
structures now or later, though, so I'm not sure libgit2 really is
affected.
* Peff: This isn't a Git Merge 2020 thing, but here's a series that
starts depending on strmap.  I'm happy to update and rebase if needed,
but opinions on strmap to prevent us from any API poisoning and such
would be great.  :-)

Elijah

> In the series:
>   * Patch 1 adds some basic data structures.
>   * Patch 2 documents the high-level steps.
>   * Patches 3-5 are some simple setup.
>   * Patches 6-10 collect data from the traverse_trees() operation.
>   * Patches 11-15 process the individual paths and create a tree.
>   * Patches 16-19 handle checkout-and-then-write-higher-order-stages.
>   * Patch 20 frees data from the merge_options_internal data structure
>
> Elijah Newren (20):
>   merge-ort: setup basic internal data structures
>   merge-ort: add some high-level algorithm structure
>   merge-ort: port merge_start() from merge-recursive
>   merge-ort: use histogram diff
>   merge-ort: add an err() function similar to one from merge-recursive
>   merge-ort: implement a very basic collect_merge_info()
>   merge-ort: avoid repeating fill_tree_descriptor() on the same tree
>   merge-ort: compute a few more useful fields for collect_merge_info
>   merge-ort: record stage and auxiliary info for every path
>   merge-ort: avoid recursing into identical trees
>   merge-ort: add a preliminary simple process_entries() implementation
>   merge-ort: have process_entries operate in a defined order
>   merge-ort: step 1 of tree writing -- record basenames, modes, and oids
>   merge-ort: step 2 of tree writing -- function to create tree object
>   merge-ort: step 3 of tree writing -- handling subdirectories as we go
>   merge-ort: basic outline for merge_switch_to_result()
>   merge-ort: add implementation of checkout()
>   tree: enable cmp_cache_name_compare() to be used elsewhere
>   merge-ort: add implementation of record_unmerged_index_entries()
>   merge-ort: free data structures in merge_finalize()
>
>  merge-ort.c | 922 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  tree.c      |   2 +-
>  tree.h      |   2 +
>  3 files changed, 922 insertions(+), 4 deletions(-)
>
> --
> 2.29.1.56.ga287c268e6.dirty
