Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F7C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 04:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiGUEfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 00:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGUEfV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 00:35:21 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91428B7E2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 21:35:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c24so521382qkm.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 21:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNDFAFKTT+pH7Wjs4xaRpAR1wm1TjnnKL57wXSrcSt8=;
        b=n6saYJwBJXFAFax/W4vju582+im+kjW6F2y3X/Jsj18bpdy1KvjUYWq45005YQ6+UY
         qFdPSl6uO9KrD/IaU0DCFzSkTG7Q5Ad1hS+B5fte4dLFYhK6Caho5l2Kq0L+RXo6fBJo
         b692+Fqr9yO+nQhc7/UJMhFMs4rU6/LJ3TlFm3Z3VtJiqRWZushNDGtP61l2Vuv/dD1n
         exuSBYTugsP8PHfKoiIOcI4u6Dr1cH4OweQnWjRdjxB+jbGvQFGv1qjBMzjUsPHP23y9
         Y3KmLEu5ulpbWayOBdGd20YlDkU9HzRxNQtmff+rmMJ8vpaauxAYEzfr5X961SfmloOG
         syYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNDFAFKTT+pH7Wjs4xaRpAR1wm1TjnnKL57wXSrcSt8=;
        b=WRnXMkIM/RlBHQr7Y6N4XGbIBLN5hGnwkkGbbJc2CBYTlxcVarxMdCbLWvO4JhN/5r
         98N8zLbCl5UCxI9zP7CoX4mkG18rz8uQx/ODkuQTtZgPjFIe8e5GE/IdG6AJa1u6JZhr
         3SCUyPWx32tDJJrArUOnzB6HLl9pfORkWbWSAbjtBRjILNYwn7wiocdSKrEoS1WbIdEf
         3TScbsQtawKyIy2f7C7dy36lFMwLAEIOZQY3dZHTmtZVdV9q6vAVYgD9TohZtg18ZMID
         koSaVdYdi+s85iH6PrhskegWdkbpwwKqQYNkxfD7lpIe9L2UcoZQRtvT5m+Hjzv/3ltW
         aNQw==
X-Gm-Message-State: AJIora8GVkcNOEtlOWz8OSIHqQObxVGfzI8CwylpZKxPCrSfEUl1BG1Y
        JtNs6eo7DJGG0Og4eYsAuJJc31L/bUXFrbl1SI82S5kpvII=
X-Google-Smtp-Source: AGRyM1u128HGOnkcQRpp+XcssHZBKF3WIxn/fEeoj0ZHSlqAgm+dUGIBg0iYcYjHYMY5dEz58MC8xT5UBOYvtT7QOW8=
X-Received: by 2002:ae9:eb08:0:b0:6b5:cc8a:a041 with SMTP id
 b8-20020ae9eb08000000b006b5cc8aa041mr20403159qkg.413.1658378119595; Wed, 20
 Jul 2022 21:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 21:35:08 -0700
Message-ID: <CABPp-BGKzcVatwoLhzXiJ3jkKXgWne+=5xNj+VmNO=pL5Kr1Og@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] rebase: update branches in multi-part topic
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 11:33 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on ds/branch-checked-out.
>
> This is a feature I've wanted for quite a while. When working on the sparse
> index topic, I created a long RFC that actually broke into three topics for
> full review upstream. These topics were sequential, so any feedback on an
> earlier one required updates to the later ones. I would work on the full
> feature and use interactive rebase to update the full list of commits.
> However, I would need to update the branches pointing to those sub-topics.
>
> This series adds a new --update-refs option to 'git rebase' (along with a
> rebase.updateRefs config option) that adds 'update-ref' commands into the
> TODO list. This is powered by the commit decoration machinery.
>
> As an example, here is my in-progress bundle URI RFC split into subtopics as
> they appear during the TODO list of a git rebase -i --update-refs:
>
> pick 2d966282ff3 docs: document bundle URI standard
> pick 31396e9171a remote-curl: add 'get' capability
> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
> pick 6adaf842684 fetch: add --bundle-uri option
> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
> update-ref refs/heads/bundle-redo/fetch
>
> pick 1e3f6546632 clone: add --bundle-uri option
> pick 9e4a6fe9b68 clone: --bundle-uri cannot be combined with --depth
> update-ref refs/heads/bundle-redo/clone
>
> pick 5451cb6599c bundle-uri: create bundle_list struct and helpers
> pick 3029c3aca15 bundle-uri: create base key-value pair parsing
> pick a8b2de79ce8 bundle-uri: create "key=value" line parsing
> pick 92625a47673 bundle-uri: unit test "key=value" parsing
> pick a8616af4dc2 bundle-uri: limit recursion depth for bundle lists
> pick 9d6809a8d53 bundle-uri: parse bundle list in config format
> pick 287a732b54c bundle-uri: fetch a list of bundles
> update-ref refs/heads/bundle-redo/list
>
> pick b09f8226185 protocol v2: add server-side "bundle-uri" skeleton
> pick 520204dcd1c bundle-uri client: add minimal NOOP client
> pick 62e8b457b48 bundle-uri client: add "git ls-remote-bundle-uri"
> pick 00eae925043 bundle-uri: serve URI advertisement from bundle.* config
> pick 4277440a250 bundle-uri client: add boolean transfer.bundleURI setting
> pick caf4599a81d bundle-uri: allow relative URLs in bundle lists
> pick df255000b7e bundle-uri: download bundles from an advertised list
> pick d71beabf199 clone: unbundle the advertised bundles
> pick c9578391976 t5601: basic bundle URI tests
> # Ref refs/heads/bundle-redo/rfc-3 checked out at '/home/stolee/_git/git-bundles'
>
> update-ref refs/heads/bundle-redo/advertise
>
>
> Here is an outline of the series:
>
>  * Patch 1 updates some tests for branch_checked_out() to use 'git bisect'
>    and 'git rebase' as black-boxes instead of manually editing files inside
>    $GIT_DIR. (Thanks, Junio!)
>  * Patch 2 updates some tests for branch_checked_out() for the 'apply'
>    backend.
>  * Patch 3 updates branch_checked_out() to parse the
>    rebase-merge/update-refs file to block concurrent ref updates and
>    checkouts on branches selected by --update-refs.
>  * Patch 4 updates the todo list documentation to remove some unnecessary
>    dots in the 'merge' command. This makes it consistent with the 'fixup'
>    command before we document the 'update-ref' command.
>  * Patch 5 updates the definition of todo_command_info to use enum values as
>    array indices.
>  * Patches 6-8 implement the --update-refs logic itself.
>  * Patch 9 specifically updates the update-refs file every time the user
>    edits the todo-list (Thanks Phillip!)
>  * Patch 10 adds the rebase.updateRefs config option similar to
>    rebase.autoSquash.
>  * Patch 11 ignores the HEAD ref when creating the todo list instead of
>    making a comment (Thanks Elijah!)
>  * Patch 12 adds messaging to the end of the rebase stating which refs were
>    updated (Thanks Elijah!)
>
> During review, we have identified some areas that would be good for
> #leftoverbits:
>
>  * Warn the user when they add an 'update-ref ' command but is checked out
>    in another worktree.
>  * The checks in patch 9 are quadratic. They could be sped up using
>    hashtables.
>  * Consider whether we should include an 'update-ref ' command for the HEAD
>    ref, so that all refs are updated in the same way. This might help
>    confused users.

Not necessarily so they are updated in the same way; the behind the
scenes mechanism could perhaps still be different.  Just so that if
the user looks for the "list of things being updated" they don't get
surprised that HEAD is missing.

>  * The error message for failed ref updates could include information on the
>    commit IDs that would have been used. This can help the user fix the
>    situation by updating the refs manually.
>  * Modify the --update-refs option from a boolean to an
>    optionally-string-parameter that specifies refspecs for the 'update-ref'
>    commands.

refspecs?  Is that the term you really mean here?


> Updates in v5
> =============
>
>  * Rename 'wt_dir' to 'wt_git_dir' for clarity.
>  * The documented behavior around 'fixup!' and 'squash!' commits was
>    incorrect, so update the commit message, documentation, and test to
>    demonstrate the actual behavior.
>  * Use CALLOC_ARRAY() to be more idiomatic.
>  * Be much more careful about propagating errors.
>  * Commit message typo: "We an" to "We can"
>  * Remove unnecessary null OID check when writing refs, since those would
>    already be removed by a previous step.

Thanks, I've read over the range-diff and these changes look good to
me.  One thing I'm curious about (sorry to bring this up so late):
"pick" commands come with the old commit hash.  Perhaps the update-ref
commands should too?  (e.g. "update-ref refs/heads/topic from
<OLDHASH>")
