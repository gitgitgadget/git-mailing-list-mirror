Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F7AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbiCBTQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbiCBTQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:16:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91357B11
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:16:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y11so3114885eda.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FojvsKH+KOQBuxxBEpT3Y0JmOEYQMKRXANctBZPKNVw=;
        b=EGNTH0r8ytHKS26cducs1GnbcVC5nJlXFgLbZrLVZRoFnVAyR+u+03KIYX/i9hscl5
         79OeOw8rYXNiVc5ZwrMhxPcnnX3IdTSZATsaRCJLvPg7sy9p4O0OyUKtqZ8BCV4QQs7G
         vLpwH+rQW25+//QBCxgfQR9DLejHcux7KuRqX6Bttw8N52P7bqBI/OLHhfZFGGdxxjSV
         B0prJUW3oK9Uh0bMagyWRkpSANzNY09XuuEbIy8QEPUQb3FEXakHp/q+cLIy/g04msSa
         PUn7gKWAbIhv7Bwu270cdCeqy8kJbAQKcSyM2xu+JK0te8C+8kPYNi4lWIyrRBLm7IJj
         MeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FojvsKH+KOQBuxxBEpT3Y0JmOEYQMKRXANctBZPKNVw=;
        b=EdsJc45+DVfi3LOwIZob+Jb3s3Sc8xLvdn/nQ3IYDWigKUexlgETGbAQTJPPxaSou/
         uKpwN3xvWzdPS6fcG/Pa45RURu44FxjSSfM91iqKDacop8YDbdWZ0h4nldh6ulLqBBp5
         xWyWvgI30OVwLa5imfPBAhgX5qfNrMg1FFVJYkVmhygAgVwVsY3+Bg20s/T+ILkX4ZVT
         azkSgW47VC0/8zCRyOczOlQEGoJSZFElERTFJ2zgMHzazoGjemeYM45mYDThClTzAAIl
         s143uXxKWPaXEpLsDwiLmjP2qURTSitPX2/PJfDxtJTEQyASeFK26SJ3Yk3czbElY2Dl
         j9RQ==
X-Gm-Message-State: AOAM531V2SPz/ciBVXrq4B9En/wqux16Du3+wVXVb7PHkoU7x3XcxYKn
        plX2f0NaNKU67PI34Qs37iY=
X-Google-Smtp-Source: ABdhPJyvypXm26rvS8iMQ0jwVQ06dfwt1mzpWxpJjbrT+O+lQjCz+dm6JiWLFzC27OAFA16xdymqLg==
X-Received: by 2002:a05:6402:1912:b0:415:c50e:d3ce with SMTP id e18-20020a056402191200b00415c50ed3cemr3136635edz.413.1646248567007;
        Wed, 02 Mar 2022 11:16:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d6-20020a056402144600b00412a7d10c20sm8637243edx.60.2022.03.02.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:16:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPUSD-000JAv-Ie;
        Wed, 02 Mar 2022 20:16:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Date:   Wed, 02 Mar 2022 20:00:59 +0100
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
Message-ID: <220302.865yow6u8a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Taylor Blau wrote:

> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git remote' [-v | --verbose]
>  'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
> -'git remote rename' <old> <new>
> +'git remote' [-v | --verbose] 'rename' <old> <new>

I realize that you're just copying an existing pattern within
builtin/reflog.c here, but we should really call this "--no-progress",
not "-v" or "--verbose".

I did that in the last 3 patches here, which I was waiting on
re-submitting:
https://lore.kernel.org/git/cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com/

I.e. the whole reason we use --verbose here is entirely historical, it
used to (well, still is without those patches) very verbose line-by-line
output.

Whereas for other things we turn progress on by default, and --verbose
is something very different.

So please have this by "int progress = 1", and have a "PARSE_OPT_NONEG"
"no-progress" option instead, there's no reason we need to propagate the
existing UX mistake in "reflog expire".

[I reversed the order you wrote the following, due to the obvious
digression...] :)

> When renaming a remote, Git needs to rename all remote tracking
> references to the remote's new name (e.g., renaming
> "refs/remotes/old/foo" to "refs/remotes/new/foo" when renaming a remote
> from "old" to "new").
>
> This can be somewhat slow when there are many references to rename,
> since each rename is done in a separate call to rename_ref() as opposed
> to grouping all renames together into the same transaction. It would be
> nice to execute all renames as a single transaction, but there is a
> snag: the reference transaction backend doesn't support renames during a
> transaction (only individually, via rename_ref()).
>
> The reasons there are described in more detail in [1], but the main
> problem is that in order to preserve the existing reflog, it must be
> moved while holding both locks (i.e., on "oldname" and "newname"), and
> the ref transaction code doesn't support inserting arbitrary actions
> into the middle of a transaction like that.
>
> As an aside, adding support for this to the ref transaction code is
> less straightforward than inserting both a ref_update() and ref_delete()
> call into the same transaction. rename_ref()'s special handling to
> detect D/F conflicts would need to be rewritten for the transaction code
> if we wanted to proactively catch D/F conflicts when renaming a
> reference during a transaction. The reftable backend could support this
> much more readily because of its lack of D/F conflicts.

As an aside I think the reftable code "emulates" the D/F conflicts of
the files backend, but I'm not sure (this is from vague memory).

And I've run into the same limitations you're describing here with the
ref transactions code. I tried to transaction-ize the "branch rename"
the other day, there we copy an existing reflog in its entirety.

It would be really nice if you could plug things into the
transaction. It would have to be things that could support the same
do-stuff/abort-stuff semantics, e.g. being able to create a file with
arbitrary contents, then unlink() it if we're rolling back.

But in any case, all of that is a much larger change than is really
required here, so I (also) digress :)

As an even further aside: If we had a slight "twist" on the ref backend
where we were able to store the reflogs next to the actual ref files,
e.g.:

    .git/refs/heads/master
    .git/refs/heads/.master.reflog

Which would work since that '.master.reflog' name isn't a valid refname
(it contains "."), couldn't we safely do this whole operation on a POSIX
FS with a simple:

    mv .git/refs/remotes/origin .git/refs/remotes/newname

I.e. even if you had concurrent *.lock files in play from other
transactions having those would mean that we had a file descriptor open
to file in question, and a file being renamed underneath you doesn't
change your ability to write to that open file.

Although I guess we rename() them into place, and if that target
moves..., so we'd need to pre-open them.

Hrm.

Anyway, that's an even larger digression & can of worms, but something I
wondered about when I saw this take a LOOOONG time in the past, "why
doesn't it just rename the folders?".

