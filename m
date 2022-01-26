Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F0C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiAZIsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiAZIsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:48:16 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5065C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:48:16 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id r65so65671757ybc.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LXRpIfzEq0kGT4RZbuZJ91YSnpmTDlFcpR71jfdo3bY=;
        b=kxTmITzriH3rCLJMod1moYhZKvkE7IrtTCpMpRY1ralbbmzsPvF08whwQr5c0hZCVA
         6asWjV0YxvMTYQuz21mablOIDP40u57HnsmHog+8Bu4LShsKsxjPHLrL/o7/vO7+vC0p
         /ENQMIM+2Ej2Xfy9KtR95taL6dLXK01eGaPBaaSkJa/RNgitQac0SecQX1zmJ8kmHWzN
         RAJ1IMxFL0YtGnUjB/6CKxcLLpXW9lyd8G8S+a9WYErqa3gOwM6QHvQ5PE96/ni/EhI4
         8M3txeWCxjVzOiLNY/9cSjFGrof5fjhhaVvpW/CBODzNuQVM86f6PYurFT+a5ZXpJkg6
         Ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LXRpIfzEq0kGT4RZbuZJ91YSnpmTDlFcpR71jfdo3bY=;
        b=Ou7Gv7SCROWaKYPkoMpBvXN5f5plwAfXOpwlNlDhChFBQGDEDK5yPEv8tkToN6FmDe
         kPqty6DB7eqkbRtMeBnfwyDhYSNklecAoAVjBbg94bN/AC4BQYdTHW7bXeQZ0tsOSZVP
         CrG3tdE9Gyhv5pZddqVWsNoDp7AawGfvO3IBx/BcAggbAKkxRCYTMbm+JoMhZMpZkRv4
         cqZItQc/0rcO4AjZYCL+arTCgkpoDUE2J9/fm1kwYO47SJ4VdnmCoqOE1FJY30KlGQmW
         jhFetfo6j3wNZJ30cdw3Z7SPTfrY4WoepZUwe06GISM8QrIfCNbUmiUVbCCqEwSNMxCs
         0YVQ==
X-Gm-Message-State: AOAM532fka0eP3vJO3uV/uvgopewZwDn3A9UTFHBolRu4FzCyToxmFr0
        Oz4y9e7VFs+vlni1zZ4MsB0G8kDJpZQRLIOxYPY=
X-Google-Smtp-Source: ABdhPJyXLjfuothx/Bd4zKTYSDaHxl0xjKADZFupqT/Vj82B8pu1lCibk0AC3VvC0WK0FCbWgUarcbzpxvHYw5P8B9M=
X-Received: by 2002:a25:dac1:: with SMTP id n184mr33977021ybf.649.1643186895753;
 Wed, 26 Jan 2022 00:48:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jan 2022 09:48:04 +0100
Message-ID: <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> Updates since v2 (thanks to Christian, Dscho, Ramsay, and Ren=C3=A9 for
> suggestions and comments on v2):
>
>  * Significant changes to output format:
>    * Flags no longer take a filename for additional output; they write to
>      stdout instead.
>    * More information included by default when there are conflicts (no ne=
ed
>      to request it with additional flags, instead flags can be used to
>      suppress it).
>    * Provide (mode, oid, stage, file) tuples -- i.e. ls-files -u style of
>      information -- when there are conflicts. Add a flag to only list
>      conflicted files if that's preferred.

The above changes seem good to me.

>  * Much more thorough manual for git-merge-tree.txt
>  * Renamed option from --real to --write-tree
>  * Accept an optional --trivial-merge option to get old style merge-tree
>    behavior
>  * Allow both --write-tree and --trivial-merge to be omitted since we can
>    deduce which from number of arguments

I still think that it might be simpler and cleaner to leave 'git
merge-tree' alone for now, and just add a new command named for
example 'git write-merge-tree'. Later we can always add flags to 'git
merge-tree' or add 'git trivial-merge-tree' as an alias for 'git
merge-tree', and eventually slowly switch 'git merge-tree' to mean
only 'git write-merge-tree' if that's where we want to go.

>  * Document exit code when the merge cannot be run (so we can distinguish
>    other error cases from conflicts)
>  * testcase cleanups: test_tick, early skip of test when using recursive
>    backend, variable renames, etc.
>  * various minor code cleanups
>  * Add a new --allow-unrelated-histories option (with same meaning as the
>    one used in git merge)

The above changes seem good to me too.

> Stuff intentionally NOT included, but which others seemed to feel strongl=
y
> about; they'd need to convince me more on these:
>
>  * Any form of diff output[1]

It's not a big issue for me to not include them right now as long as
it's possible to add cli options later that add them. The reason is
that I think in many cases when there are conflicts, the conflicts
will be small and the user will want to see them. So it would be
simpler to just have an option to show any conflict right away, rather
than have the user launch another command (a diff-tree against which
tree and with which options?).

Thanks for working on this anyway!
