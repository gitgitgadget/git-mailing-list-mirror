Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642F720248
	for <e@80x24.org>; Sat, 23 Feb 2019 22:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfBWWki (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 17:40:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42546 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfBWWki (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 17:40:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id j89so4644093edb.9
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mm7bknK140kq1DHMw4LdXUENHsnUqovvxOMxzmwQ6Ls=;
        b=m77kU5DywhxsgIUDW4jaduy2N83glHFfwrPXFJikdoSloXozvD7GUd92AupIUCg3uv
         GVLN/1Y/kFi/pXiHnteCkafjasil2hFbbjXjDCHsl3xO18jRV6fspCsaPzhe7s7p3tkW
         V7ClbjqV7/LaGqyQoIkizCS5ZGBVd3kNEnEaq/YSkUiBiGbUOprmdudORLMOV60lXPLw
         h4WpmWeEMTwdqwUisCGYzbepI6aqpS6LuUeivoVXK2+mVQeKqLXTu0pYwo5QEnmgmSH6
         lTG4Nt9AJi1x3zf3H9x236XXz7i3SZcSH80kwbuS3oYvga680aSzf7QGMgXEPSHa3DTr
         l0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mm7bknK140kq1DHMw4LdXUENHsnUqovvxOMxzmwQ6Ls=;
        b=bVg5T+F8Vf+wU6bmicxKPsSPxfGNvOsUQdBmj1zNj2xAmqEvXtTPeBhcY7koIJOEJN
         fL+fWFC77iz1Exqsnk0dta3uTdhX8LmQD+jfM2vc4331y/8+4vtylr87EXeorgZLRsxD
         hR5nbgKjMRNpR82xjgSG+eSVIev5h6Ro2vtQMxBdJGOCUTbL7soZivm9VDE+yVnWfEdJ
         SgogxDO9VIvFA0uiDCCMMwVBXAJ3YJo7PygPcV+6m9VWa4xr8wGqEFI8dF6YlE7Ocb19
         H+UoUvtRL77+MjggE4EDVtMJVTL6FSJFRrelmasn/voOQRd43pYN7THD8FwYt0S4uMij
         gSPA==
X-Gm-Message-State: AHQUAuY97XJceziu7rdYY76xzm0pdWR+ABXWtETt4zEs0EOlbw+C9+kN
        8xX92JuFoSZzqVx9exqsnE0=
X-Google-Smtp-Source: AHgI3IYQ6/Fk0sFLlF5bUCPxw1EfKtIH1m7efkQZQw2SmpCIoSQyEvHz7ZZJkUluadOAoNfdclA+ng==
X-Received: by 2002:aa7:d987:: with SMTP id u7mr8521635eds.194.1550961635810;
        Sat, 23 Feb 2019 14:40:35 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a51sm1469261edd.57.2019.02.23.14.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 14:40:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
References: <20190223190309.6728-1-matheus.bernardino@usp.br> <20190223190309.6728-4-matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190223190309.6728-4-matheus.bernardino@usp.br>
Date:   Sat, 23 Feb 2019 23:40:33 +0100
Message-ID: <87va1a3z8e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 23 2019, Matheus Tavares wrote:

> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API. This simplifies the code and avoid recursive calls to
> copy_or_link_directory.

Sounds good in principle.

> This process also brings some safe behaviour changes to
> copy_or_link_directory:

I ad-hoc tested some of these, and could spot behavior changes. We
should have tests for these.

>  - It will no longer follows symbolic links. This is not a problem,
>    since the function is only used to copy .git/objects directory, and
>    symbolic links are not expected there.

I don't think we should make that assumption, and I don't know of
anything else in git that does.

I've certainly symlinked individual objects or packs into a repo for
debugging / recovery, and it would be unexpected to clone that and miss
something.

So in the general case we should be strict in what we generate, but
permissive in what we accept. We don't want a "clone" of an existing
repo to fail, or "fsck" to fail after clone...

When trying to test this I made e.g. objects/c4 a symlink to /tmp/c4,
and a specific object in objects/4d/ a symlink to /tmp too.

Without this patch the individual object is still a symlink, but the
object under the directory gets resolved, and "un-symlinked", also with
--dissociate, which seems like an existing bug.

With your patch that symlink structure is copied as-is. That's more
faithful under --local, but a regression for --dissociate (which didn't
work fully to begin with...).

I was paranoid that "no longer follows symbolic links" could also mean
"will ignore those objects", but it seems to more faithfully copy things
as-is for *that* case.

But then I try with --no-hardlinks and stock git dereferences my symlink
structure, but with your patches fails completely:

    Cloning into bare repository 'repo2'...
    error: copy-fd: read returned: Is a directory
    fatal: failed to copy file to 'repo2/objects/c4': Is a directory
    fatal: the remote end hung up unexpectedly
    fatal: cannot change to 'repo2': No such file or directory

So there's at least one case in a few minutes of prodding this where we
can't clone a working repo now, however obscure the setup.

>  - Hidden directories won't be skipped anymore. In fact, it is odd that
>    the function currently skip hidden directories but not hidden files.
>    The reason for that could be unintentional: probably the intention
>    was to skip '.' and '..' only, but it ended up accidentally skipping
>    all directories starting with '.'. Again, it must not be a problem
>    not to skip hidden dirs since hidden dirs/files are not expected at
>    .git/objects.

I reproduce this with --local. A ".foo" isn't copied before, now it
is. Good, I guess. We'd have already copied a "foo".

>  - Now, copy_or_link_directory will call die() in case of an error on
>    openddir, readdir or lstat, inside dir_iterator_advance. That means
>    it will abort in case of an error trying to fetch any iteration
>    entry.

Good, but really IMNSHO this series is tweaking some critical core code
and desperately needs tests.

Unfortunately, in this as in so many edge case we have no existing
tests.

This would be much easier to review and would give reviewers more
confidence if the parts of this that changed behavior started with a
patch or patches that just manually objects/ dirs with various
combinations of symlinks, hardlinks etc., and asserted that the various
options did exactly what they're doing now, and made sure the
source/target repos were the same after/both passed "fsck".

Then followed by some version of this patch which changes the behavior,
and would be forced to tweak those tests. To make it clear e.g. that
some cases where we have a working "clone" are now a hard error.

Thanks for working on this!
