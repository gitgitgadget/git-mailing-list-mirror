Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F074C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiBOWQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:16:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiBOWQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:16:33 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5527CCE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:16:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id l125so410714ybl.4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3Ulag4Whur/Z+aMvvAHMjihm+aDedVCVXL3uRhZ6iA=;
        b=W6RAVSShrzGvW+fMa6weg3hKTS1501qWURSHH+AOyQGrFNbKwAMIwsXug8Jhz6zCaa
         QOFeXeDnmCyL+qvhHS5DbmqyuBWaemOUa3oavveayPPBba4mL0eZfVK/F+g7Z1bRy3yK
         I/7G2nrKVM8T8ztWf8d6Xtj7melyXw4b/6KsvpdflH9ch9e4EdhrEt1BvvsVwbjYQzOr
         W3J4/OiRMHK67JTupbV+fDvo/WrSdtswuMJDIr6FomSKHr0cfJzFTFGj+vUXnFsDeyZ8
         So5LgNJYbHnGZV+mAN0qNxhsyoWAaLDXV+NL22peL9lSiaD813pb51JpBotQAbEOM+0W
         YLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3Ulag4Whur/Z+aMvvAHMjihm+aDedVCVXL3uRhZ6iA=;
        b=tSd5reNOtICQf6eXDdXOHrUQNSGVw8BMhmshIN3UhbUqLbLXzpAUTxyuPTXba4lOO4
         WK/y55in57Hg5bG2zY6nJMROP/8XvKVnXT9NiQ+/5+SA4W7OG/2+CdcF4jgO9Iu4KNO9
         USR4Y5PQ1gASjhvgwGfuoy3/Urbx1nJJvzEYDXZQK0Y2RrRbQQ0Lu0NNhOqYXzEQMm53
         5JQ5jpIczoyVsigXxDdkk8nKHzjmfrYI0XIhAk6+fAuQFTCDRTBBkmnc2EK2UZU3UNWo
         CMBPEGGNj/NE498xmGHYkARPuUTJQxH9rQoEhEdQuGikHDq4EP2uAqtO9DtOYRcEKa6A
         8Xxw==
X-Gm-Message-State: AOAM533vEPzj1oHTIaxK+tR/qAvwglZAseqRQ4riiBcsoin1lZCe+ovf
        sipAcMOULVYK+9DJPd8OA8aLjGKTH9dQ2JUJ31l5ORMW/cA=
X-Google-Smtp-Source: ABdhPJy0eRbe17Ex0af0DGNPydXhPZF4V481jDk/Lkvbhyu5han3rQxH7RinHHXjX1EtnhzdsRVLnvqzG3NUBzcdjec=
X-Received: by 2002:a81:ef08:: with SMTP id o8mr1006340ywm.425.1644963380600;
 Tue, 15 Feb 2022 14:16:20 -0800 (PST)
MIME-Version: 1.0
References: <CAKQMxzSQRL-Q5daxETF+gYhVScmq_n=r2LJAeEuxpM7=jPajZQ@mail.gmail.com>
 <CABPp-BE2q5_LVVUw=2Wfys0AF350tTMMr43ZLpfsjE4ecb1Tpw@mail.gmail.com>
In-Reply-To: <CABPp-BE2q5_LVVUw=2Wfys0AF350tTMMr43ZLpfsjE4ecb1Tpw@mail.gmail.com>
From:   Patrick Marlier <patrick.marlier@gmail.com>
Date:   Tue, 15 Feb 2022 23:16:09 +0100
Message-ID: <CAKQMxzRsq5uHme03a8DqMg1-Tku+0teDv0mDnsbJERfORtTB_w@mail.gmail.com>
Subject: Re: Optimization for "git clean -ffdx"
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Thanks for this nice and very detailed email!

On Sun, Feb 13, 2022 at 4:25 AM Elijah Newren <newren@gmail.com> wrote:
> There are two steps -- collect the list of things that are removable,
> and then a separate step to remove the things that are removable.  It
> can be the case that we recurse into the same directory twice, once
> for each step.  For the first step, see the fill_directory() call.  If
> you left off "-x" or only had one "-f", or your directories had some
> tracked files, then fill_directory()'s job is finding out which things
> are removable and it'd likely only be a subset of those directories.
> For the second step, some of those removable things may be entire
> directories.  So when it hits one of those and later calls
> remove_dirs() to remove it, it has to recurse again.

I am not sure I understand perfectly why there are 2 steps but this is detail.

The observation I had in the second step for removal, it is this type
of patterns using strace:
getcwd("/tmp/repo", 129) = 46
newfstatat(AT_FDCWD, "/tmp/repo/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/tmp/repo/a/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/tmp/repo/a/a/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/tmp/repo/a/a/a/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
rmdir("a/a/a/a")                        = 0
newfstatat(AT_FDCWD, "a/a/a/b", {st_mode=S_IFDIR|0700, st_size=4096,
...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, "a/a/a/b", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 6
newfstatat(6, "", {st_mode=S_IFDIR|0700, st_size=4096, ...}, AT_EMPTY_PATH) = 0
getdents64(6, 0x55b718d8d650 /* 2 entries */, 32768) = 48
getdents64(6, 0x55b718d8d650 /* 0 entries */, 32768) = 0
close(6)                                = 0
getcwd("/tmp/repo", 129) = 46
newfstatat(AT_FDCWD, "/tmp/repo/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/tmp/repo/a/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/tmp/repo/a/a/a", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/tmp/repo/a/a/a/b", {st_mode=S_IFDIR|0700,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
rmdir("a/a/a/b")                        = 0

Here I have a repository with quite some nested and untracked directories.
We can see that many "newfstatat" are repeated for the same path. Also
"getcwd" is repeated many times.
I guess here "strbuf_realpath" would benefit from some caching.


> > Using "-ff" should not check for nested .git and no need to recurse if
> > the directory is already untracked.
>
> Not quite; the -x and lack of -e options is critical here, otherwise
> we cannot just nuke the whole directory.  (Also, -d is important, but
> that just kind of goes without saying.)

Indeed, you are right.


> Further, setting this flag is only solving part of the performance
> problem.  We'll still recurse into the directories to look for ignored
> files, which should be avoided since we don't need to differentiate.
> That basically means that we need to avoid all the code in the current
>
>    if (remove_directories && !ignored_only)
>
> block, whenever (remove_directories && ignored && !exclude_list.nr &&
> force > 1).

Good point!


> > Another thfing to note is that it shows "Removing XXX" but it shows it
> > when the directory is already gone. So we could change to "Removed
> > XXX" or display the "Removing XXX" before starting to remove the
> > directory.
>
> I commented on Bagas' patch, but I think this is minutiae that won't
> be relevant to the end user, and would rather either ignore it or just
> move the print statement earlier rather than increasing work for
> translators.  That is, unless we tend to use past tense elsewhere in
> the UI and we want to make a concerted effort to convert to using past
> tense.

If we want to be correct, then we should then move the "Removing"
printing before but then it makes the "gone" flag a bit useless.
I will defer to you if this is something we want to fix.


> Anyway, I'll be happy to review your patch(es) and
> will take whichever parts you don't want to tackle.

If you don't mind, I will let you adjust the documentation.
Following the patch series for the 2 other changes.

Thanks a lot Elijah. Very appreciated!
--
Patrick Marlier
