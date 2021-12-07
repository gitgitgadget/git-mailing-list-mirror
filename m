Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3157C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 05:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhLGFdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 00:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhLGFdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 00:33:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDCCC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 21:30:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o20so52238790eds.10
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 21:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oUbATNe0QezOxZvmSNzYAnP8pp3LdA39wVHWWQQOZAU=;
        b=KVTeuf+Tcxu8ili+yyrONnt9JwrfyU8wYVmzb6DuOsyLduUGJsGPBVq+2Br4CGW0vf
         0zthjwZecu7B/NZQZ04/msQ+MmLOZRn7AVGFWeiPIfNzw8x/RKRQU2cyFaEPIXPXfA7S
         e8HnSJsRBRaoVUG0iFrz50y1ktdlVbVkk12UJMLtbhSVDpsFHKqrSDSwOhbLja+NmPf3
         SsciGMgjz4qc27gxuSNcXlz1r3itemigcYFIhYRYl79SHi/6yV085Jgl+vVR6HCkI4uu
         SNNYUnTfIOzRH661iG/naCTGp0fXhj0OWnmRgeMnFfsEdEIKIAO3Z9Tut6fDrQijPucj
         48pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oUbATNe0QezOxZvmSNzYAnP8pp3LdA39wVHWWQQOZAU=;
        b=LlekNeg/yiVnEFNKICggZmSjSOagMEv7D83Cs7RWUMtM4VzMSP3yGj+qnPgAHCgZ9G
         YAJuuxEiMiAQe0qbJkBSPFyIWY7RmyxC5/zz18tH74tpbObCpEe/JPmWmfM8v6Xyoxev
         OA6g/fng/epERFQChsnjv0JRrjT+n+F8b9BncAWbzcfBAxzXUmBZU5r+PULJs0f5Vv6y
         6JEO/FnV0FqUA8xiwac3spVuE7QUJRRbJi/fosly9wlW52X69YvTKbVL7DyJDP4bQfcb
         aSLCzIDaPDizQ2JfHEY8X7TEu3SY14szqmF8EC/TXcJN8uXt8sHmpoAFio5II4PbyZF6
         K38g==
X-Gm-Message-State: AOAM530jgZb293Epb3rkJuP07Xl6JpDrjcOmeE0uVG9ISzyDIaEBW5aa
        8kKYR/OUC6cXgfjTtYkSl8pzJJFgIHlLhynhb7rUe2/JXzI=
X-Google-Smtp-Source: ABdhPJz4Hn9XMwHathcS6624bJMRZ0HRvpVud/CfBY0GkS6bihmYwXACXgXmugF40Q2vzgsL8jnAjh9YPKO/jfsSno4=
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr8955943ejc.443.1638855014599;
 Mon, 06 Dec 2021 21:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20211206121639.o4a4tdzlijnhnjqz@pengutronix.de>
In-Reply-To: <20211206121639.o4a4tdzlijnhnjqz@pengutronix.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Dec 2021 21:29:59 -0800
Message-ID: <CABPp-BEEpboXxs6dghCagj2oXkXKX9aNQGLmUmQRa5m3jj2--w@mail.gmail.com>
Subject: Re: Regression in 8d92fb292706 ("dir: replace exponential algorithm
 with a linear one")
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 6, 2021 at 4:16 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> I admit this is somewhat of a corner case, still it happens in the
> reality of our admin team ...
> Initially this was noticed after upgrading the OS from Debian buster
> (with git 2.20.1) to Debian bullseye (with git 2.30.2).
>
> (wgit is just a wrapper for git to call it from my ~/src/git.)
>
> This is the good ("old") case:
>
>         uwe@taurus:~/tmp/8d92fb29270$ wgit version
>         git version 2.25.2.7.g0bbd0e8b5233
>
>         uwe@taurus:~/tmp/8d92fb292706$ wgit init
>         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/.g=
it/
>
>         uwe@taurus:~/tmp/8d92fb292706$ mkdir subdir
>         uwe@taurus:~/tmp/8d92fb292706$ cd subdir/
>         uwe@taurus:~/tmp/8d92fb292706/subdir$ wgit init
>         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/su=
bdir/.git/
>         uwe@taurus:~/tmp/8d92fb292706/subdir$ cd ..
>
>         uwe@taurus:~/tmp/8d92fb292706$ echo content > subdir/somefile
>         uwe@taurus:~/tmp/8d92fb292706$ wgit add subdir/somefile
>         uwe@taurus:~/tmp/8d92fb292706$ wgit status
>         On branch master
>
>         No commits yet
>
>         Changes to be committed:
>           (use "git rm --cached <file>..." to unstage)
>                 new file:   subdir/somefile

Eek, that's bad.  I think there's a number of dragons going down that route=
.

> with 8d92fb292706, the following happens:
>
>         uwe@taurus:~/tmp/8d92fb292706$ wgit version
>         git version 2.25.2.8.g8d92fb292706
>         uwe@taurus:~/tmp/8d92fb292706$ wgit init
>         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/.g=
it/
>         uwe@taurus:~/tmp/8d92fb292706$ mkdir subdir
>         uwe@taurus:~/tmp/8d92fb292706$ cd subdir/
>         uwe@taurus:~/tmp/8d92fb292706/subdir$ wgit init
>         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/su=
bdir/.git/
>         uwe@taurus:~/tmp/8d92fb292706/subdir$ cd ..
>         uwe@taurus:~/tmp/8d92fb292706$ echo content > subdir/somefile
>         uwe@taurus:~/tmp/8d92fb292706$ wgit add subdir/somefile

Not optimal; more on this below.

>         uwe@taurus:~/tmp/8d92fb292706$ wgit status
>         On branch master
>
>         No commits yet
>
>         Untracked files:
>           (use "git add <file>..." to include in what will be committed)
>                 subdir/
>
>         nothing added to commit but untracked files present (use "git add=
" to track)

This part looks good to me.

> So git after 8d92fb292706 doesn't add files from a subdirectory if
> said subdirectory is tracked in git, too.
>
> While I'm not sure which of the two behaviours is the bogus one, this is
> a change in behaviour that I guess wasn't intended in 8d92fb292706.

I put some effort separate from that commit into avoiding accidentally
recursing into nested git dirs; see e.g. commit 09487f2cba ("clean:
avoid removing untracked files in a nested git repository",
2019-09-17).  So, I was slightly surprised that some other commit
hadn't fixed this.

However, it's not all that surprising to me that 8d92fb292706 affected
this.  Prior to that commit, we visited untracked paths which were n
directories deep a ridiculous 2^n times.  But what made it even more
fun was that the status returned for any given path (tracked, ignored,
not interesting to the traversal, etc.) was not always the same; later
traversals might return something different than earlier traversals.
That confusion made it real "fun" trying to ensure no regressions when
reducing the number of visits to any given path from 2^n down to 1.
The fact that side effects of the traversals (the population of the
dir.entries and dir.ignored) could have essentially functioned to
override a later traversal's return status certainly didn't help; it
was such a mess.

But, interestingly, the fixed behavior here also depends pretty
strongly on commit b9670c1f5e ("dir: fix checks on common prefix
directory", 2019-12-19) which came months earlier.  This is
particularly important in combination with the following comment from
dir.h:
    /**
     * If set, recurse into a directory that looks like a Git directory.
     * Otherwise it is shown as a directory.
     */
    DIR_NO_GITLINKS =3D 1<<3,
which suggests that cmd_add() (which didn't set this flag) should have
never been recursing into a Git-tracked directory.  In other words,
this was a bug all along.

> Is this something that needs fixing?

I agree with brian elsewhere in this thread that not adding the file
is correct.  However, two points:

* I would prefer to see a warning/error from git add when it doesn't
add a path  (Any takers?  #leftoverbits maybe?)

* It is possible that one might want to be able to force the addition
of files to an outer repository despite existing within a directory
tracked by an inner git repository, perhaps with a double `--force`
being passed to git-add (much like git-clean allows).  If so, that
could be implemented via the addition of
    dir.flags |=3D DIR_NO_GITLINKS;
to cmd_add() when the double force is detected.


Hope that helps,
Elijah
