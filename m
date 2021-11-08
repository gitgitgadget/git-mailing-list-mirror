Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B2C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 00:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAE261378
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 00:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhKHAPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 19:15:09 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46065 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhKHAPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 19:15:09 -0500
Received: by mail-ed1-f44.google.com with SMTP id f4so55324559edx.12
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 16:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndY9rO7Afsl0CaWYYm4US0/sqmZW/cX3gJxqm0KZnjA=;
        b=w51OPFZgT0UZHYUBdaR9r9AApavmm34N44C9jGxv4PxX4bSqFMPHdXxtQBKcjv0tVL
         oh1kTVQwukPVMvvAR6oFfQ6GioGAmVtu8eBJzSZRn5LXUtRAyh09UPKG8vJPD8StT5va
         N9DwbFCJWVXejJLbrG9FA/kJ0jKLtbEIRcTjiK8w57aKXwOnu0Bv3SYXkSY7QHHTZ8Dc
         nI50qrkW8bOjPWukRV36kyBZLURlw6bE40aESL5gP7/AEzemMuYStzNDxqqhUA1Q558+
         8nXDTA8RB/qmETUJEb489rp/hIP7mdXFoTb+caMJiMonRx+aHOe8l/O4IslCrxF3jsdV
         248w==
X-Gm-Message-State: AOAM532bapiqApM1hzDlsWPnJAsGhTx5D+d9pK2leJRKgyfXVLGRfpiS
        feWpvYXuz4uq0Mxtuvbj02yeS1Z0Ea7OwnIuINM=
X-Google-Smtp-Source: ABdhPJxRRiJ/e1uchPA3FOG+95JCnAgY49QhIqmCJ78AGa4Qgdsp69M/o1w9wO1WfoDP//PsjgP96BMgJqbl6sJ+z6M=
X-Received: by 2002:a05:6402:206c:: with SMTP id bd12mr1647573edb.283.1636330344972;
 Sun, 07 Nov 2021 16:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20211107225525.431138-1-sandals@crustytoothpaste.net> <20211107225525.431138-4-sandals@crustytoothpaste.net>
In-Reply-To: <20211107225525.431138-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Nov 2021 19:12:14 -0500
Message-ID: <CAPig+cRtOpaPd_HCQAW=33-vxhP4Knijo3g0dUA9HVb4_=JH4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gitfaq: add entry about syncing working trees
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 7, 2021 at 5:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Users very commonly want to sync their working tree with uncommitted
> changes across machines, often to carry across in-progress work or
> stashes.  Despite this not being a recommended approach, users want to
> do it and are not dissuaded by suggestions not to, so let's recommend a
> sensible technique.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> @@ -185,6 +185,49 @@ Then, you can adjust your push URL to use `git@example_author` or
> +[[sync-working-tree]]
> +How do I sync a working tree across systems?::
> +       First, decide whether you want to do this at all.  Git usually works better
> +       when you push or pull your work using the typical `git push` and `git fetch`
> +       commands and isn't designed to share a working tree across systems.  This is
> +       potentially risky and in some cases can cause repository corruption or data
> +       loss.

The phrase "usually works better" makes this statement feel weak, thus
it may not convey the potential severity of the issue. I wonder if
rewording it something like this would make the statement more
forceful:

    Git works best when you `git push` and `git pull` your work
    between machines; it is not designed to share a working tree
    across systems. [...]

> +Usually, doing so will cause `git status` to need to re-read every file in the
> +working tree.  Additionally, Git's security model does not permit sharing a
> +working tree across untrusted users, so it is only safe to sync a working tree
> +if it will only be used by a single user across all machines.
> ++
> +It is important not to use a cloud syncing service to sync any portion of a Git
> +repository, since this can cause corruption, such as missing objects, changed
> +or added files, broken refs, and a wide variety of other corruption.  These
> +services tend to sync file by file and don't understand the structure of a Git
> +repository.  This is especially bad if they sync the repository in the middle of
> +it being updated, since that is very likely to cause incomplete or partial
> +updates and therefore data loss.

Taking into consideration that people who are experiencing such
corruption will likely include the name of the syncing service in
their search query, would it make sense to mention some well-known
services here in order to make it more likely that people will
actually find this entry? Something like this, perhaps:

    It is important not to use a cloud syncing service (such as DropBox,
    FooBar, CowMoo, BuzzingBee, etc.) to sync any portion of a Git
    repository...

> +Therefore, it's better to push your work to either the other system or a central
> +server using the normal push and pull mechanism.  However, this doesn't always
> +preserve important data, like stashes, so some people prefer to share a working
> +tree across systems.
> ++
> +If you do this, the recommended approach is to use `rsync -a --delete-after`
> +(ideally with an encrypted connection such as with `ssh`) on the root of
> +repository.  You should ensure several things when you do this:
> ++
> +* There are no additional worktrees enabled for your repository.

I don't fully understand this restriction. Can you explain it (at
least here in the email discussion)?

> +* You are not using a separate Git directory outside of your repository root.

Same question about this restriction.

> +* You are comfortable with the destination directory being an exact copy of the
> +       source directory, _deleting any data that is already there_.
> +* The repository is in a quiescent state for the duration of the transfer (that
> +       is, no operations of any sort are taking place on it, including background
> +       operations like `git gc` and operations invoked by your editor).
> ++
> +Be aware that even with these recommendations, syncing in this way has some risk
> +since it bypasses Git's normal integrity checking for repositories, so having
> +backups is advised.  You may also with to do a `git fsck` to verify the
> +integrity of your data on the destination system after syncing.

s/with/wish/

In fact, as with "usually" above, "wish" may be too weak. Perhaps say
instead that it is "recommended" that you use `git fsck` to verify the
integrity.
