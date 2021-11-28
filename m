Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825BEC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhK2W1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhK2WZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:25:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09AC0C084A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:41:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so77218211edd.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KrfhMH0P/6pZC9Hfn+88gEH76xSiI4nWXMIJ8WoB2W0=;
        b=L94icezZrTdewwziMD9wtOKONenAbvwM/EbT697ZNiAKCYhh7jN1HLpgL14MnD9AoO
         wdKxdXgu5VfIRXRZsavd+3heem5M+DgfucJEmNqhJ9HeNo9IlePY5pLJE5AOXq8sQyDP
         BtPiPmF8r/CTDFzFrkglMMNcO6sh7EAmtO+T4qqMjWdmh0bstFzVB1GZbb7W9sxuQSEJ
         O3ACcYV/QnXWX7oCxHbpsDAH4joX28CDtSoBHOU1tQjX95KoEuQ0Bj1V0H7MOKYwZNKt
         ws2/qIuk7qbn4qZOs0qUsGcgf6vUvkQRZFku+M6tZ+ppurV6hJTev59+AOMevfGjoLcM
         +6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KrfhMH0P/6pZC9Hfn+88gEH76xSiI4nWXMIJ8WoB2W0=;
        b=ra1P9vZT5Xm8zbpbu7FDqm1hznKzy1DNYYFv5Y6CnQ++VdE27Py6dzZNUkEI9CMIYv
         IOd+Gkj1u+0H/9V4I0COKUmD+USFvri6tHnE8tzu3CnMw7bg3H3fYk1skMQp93KKS3c4
         4lApujTFpAulD1jc8ZX3M1qXPvSFsMrd9RpwKZdTdj1OVc0rtlasKs6AT4jFGIuKKrWU
         rG4oO2KOgfNidE20MnxJ54eySukYUZDUsyeGTr1VLWxhaDlj++3DCB81hF85sI7IGBrJ
         issArzV/exFTD31Z9gP+i8O7vh50zW0eBxdkTd0Ij8gL8PTYuDML0zF8i6bpLR9QQmww
         5OMg==
X-Gm-Message-State: AOAM531xz/01e2A5UYbXM1hOpnKpaZcdrgqiwkkwZbrVKx6Lo7V7Np9R
        bSVAQ0x6zgXdkzNbjBdiOu0Ta6hYzqHuJg==
X-Google-Smtp-Source: ABdhPJz8R9so3t5+bEDhZkNoxnMYiIlnycN4H93mDkBejK23/vsavPbPauNAQNkrJDPpDyzWR+Nanw==
X-Received: by 2002:aa7:dd56:: with SMTP id o22mr77383385edw.73.1638218505135;
        Mon, 29 Nov 2021 12:41:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ig1sm7809661ejc.77.2021.11.29.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:41:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrnT5-000rOK-Qg;
        Mon, 29 Nov 2021 21:41:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
Date:   Sun, 28 Nov 2021 19:04:25 +0100
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
        <211127.86v90dhf5g.gmgdl@evledraar.gmail.com>
        <CABPp-BFuKBht2yZ+tYkG+C4Rpek6dLT0gx6pZNH4rXqv0UFf3Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BFuKBht2yZ+tYkG+C4Rpek6dLT0gx6pZNH4rXqv0UFf3Q@mail.gmail.com>
Message-ID: <211129.868rx6g0e0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 27 2021, Elijah Newren wrote:

> On Sat, Nov 27, 2021 at 6:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:
>>
>> [Just some more "I haven't really looked at this in all that much
>> detail" commentary, so maybe it's stupid, sorry]
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > Removing the current working directory causes all subsequent git
>> > commands run from that directory to get confused and fail with a messa=
ge
>> > about being unable to read the current working directory:
>> >
>> >     $ git status
>> >     fatal: Unable to read current working directory: No such file or d=
irectory
>> >
>> > Non-git commands likely have similar warnings or even errors, e.g.
>> >
>> >     $ bash -c 'echo hello'
>> >     shell-init: error retrieving current directory: getcwd: cannot acc=
ess parent directories: No such file or directory
>> >     hello
>>
>> Is that really realistic?
>
> I have 321 shell scripts (or symlinks thereto) in /usr/bin/ on my
> Fedora laptop, and 951 shell scripts in /usr/bin/ on my Ubuntu
> workstation at $DAYJOB.  That's not even considering stuff in other
> directories.  Note that I didn't place any of those scripts in
> /usr/bin/; they came from the distribution and/or corporate packages
> from others.  Any invocation of bash will see the above "error"
> message.  Granted, bash calls it an 'error' but continues anyway, but
> I thought it showed that there were clearly programs besides git where
> users could run into problems.
>
>> Any "normal" command would use "pwd" or look
>> at $PWD, both of which "work", this error is only because we're starting
>> a new shell.
>
> <grin>
>
> Yeah, good point.  Who would use an unusual program like git?  Or a
> shell script?  Or a java program?  Or emacs?  Or other programs like
> them?  Besides, git, bash, java, and emacs are all relatively young
> commands with small development teams.  Maybe we should just rely on
> users only using commands that get the pwd/$PWD detail right; perhaps
> limiting to commands that are more mature and have bigger development
> teams than those four.
>
> Silly users.
>
> ;-)
>
> Sorry, couldn't resist a little friendly teasing.
>
>
> However, for "pwd"...by "work", do you mean "doesn't necessarily
> work"?  On my machine:
>
> $ mkdir gone
> $ cd gone
> $ rmdir ../gone
> $ pwd -P
> pwd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> $ pwd
> pwd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> $ echo $PWD
> /home/newren/floss/git/gone
>
> If I do not run `pwd -P` first then a plain `pwd` works.  But your
> advice to use `pwd` seems misguided for programs, since they'll hit
> this problem if users have run a previous `pwd -P`.  (The $PWD trick
> would have worked, as shown above)
>
>> I wonder if it was just because you ran into our bin-wrappers edge case,
>> but that should be really obscure for any real users.

For some reason I was under the misimpression that the "#!/bin/bash"
part of the bin-wrappers and other scripts somehow immunized them from
the $PWD/"pwd" reset, and it was only the programs they invoked (like
git in the bin-wrappers) that didn't get the values passed along.

But that's clearly incorrect as you demonstrate above, so the only thing
that'll work OK (seemingly) is running "pwd" (but not "pwd -P"), or
looking at $PWD in your terminal shell itself.

Invoking non-POSIX shell programs "works" in that they can use the same
trick, after the dance of "mkdir x && cd x && rm -rf ..x" e.g. Perl
says:
=20=20=20=20
    $ perl -MCwd=3Dgetcwd -wE 'say $ENV{PWD}; say getcwd'
    /home/avar/g/git/x
    Use of uninitialized value in say at -e line 1

This "pwd -P" behavior isn't just something weird in your shell & mine,
it semse to be mandated by POSIX:
https://pubs.opengroup.org/onlinepubs/007904875/utilities/pwd.html

All of which is to say I'm much more sympathetic to this approach
now. I.e. it seemed like purely a way to work around fixable breakages
in our own and other programs. Well, I guess "don't use shellscript if
you care about this edge case" is a "fix", but not a trivial one.

I do still think a better starting point would be fixing the setup.c
dying in our own code, and see where that leaves us, but up to you
etc. I'm not going to work on it any time soon.

> Yes, I agree our bin-wrappers is a really obscure edge case not worth
> considering.  I don't see how you jump from there to painting all
> shell scripts combined with the same brush, though.

*nod*

>> > This confuses end users, particularly since the command they get the
>> > error from is not the one that caused the problem; the problem came fr=
om
>> > the side-effect of some previous command.
>> >
>> > We would like to avoid removing the current working directory of our
>> > parent process; towards this end, introduce a new variable,
>> > startup_info->original_cwd, that tracks the current working directory
>> > that we inherited from our parent process.  For convenience of later
>> > comparisons, we prefer that this new variable store a path relative to
>> > the toplevel working directory (thus much like 'prefix'), except witho=
ut
>> > the trailing slash.
>>
>> I'm still not clear at all on why we need a "original_cwd" at all then
>> as opposed to just using "prefix" (or adding "the_prefix" if passing it
>> down is painful). I.e. we discover our relative path, we resolve the
>> relative path to the root, can't we use that as the "don't remove our
>> CWD" guard?
>>
>> Does our prefix change at some point, then maybe "orig_prefix" would
>> make more sense?
>
> No; see the code comment in the same patch:
>
> +       /*
> +        * startup_info->original_cwd points to the current working
> +        * directory we inherited from our parent process, which is a
> +        * directory we want to avoid removing.
> +        *
> +        * For convience, we would like to have the path relative to the
> +        * worktree instead of an absolute path.
> +        *
> +        * Yes, startup_info->original_cwd is usually the same as 'prefix=
',
> +        * but differs in two ways:
> +        *   - prefix has a trailing '/'
> +        *   - if the user passes '-C' to git, that modifies the prefix b=
ut
> +        *     not startup_info->original_cwd.
> +        */
>
> It's never equal to prefix, even though it's usually semantically
> referring to the same directory.  However, even if it weren't for the
> trailing slash issue, the -C case means it is not appropriate to think
> of it as "orig_prefix" either.

Ah, with -C of e.g. t/helper we'll first chdir(t/helper), and then run
the usual setup.c dance to find that we need to chdir() again to the
(equivalent of) "../../". But our prefix stays at "t/helper".

I'm a bit confused about the trailing slash case, isn't the prefix
always going to point to a directory? Why would t/helper v.s. t/helper/
matter?

I think it won't matter for rmdir(2) et al, but maybe I'm wrong.

What got me confused about the "prefix" v.s. "original_cwd" is that I
was assuming they'd be the same. The commentary on setup_git_directory()
says as much, i.e.:

    Returns the "prefix", a path to the current working directory
    relative to the work tree root, or NULL,

But of course we know that's a white lie, it's not the $PWD/getcwd(). So
you're only trying to save the user in cases of e.g. (in t/helper):

    git rm ../helper

If they actually run it while in t/helper, but would like to explicitly
omit the case of (at the top-level):

    git -C t/helper rm ../helper

That's fair enough I guess. I'd just assumed those cases would be
treated the same way.

Even in that case, I can't think of a case where this "original_cwd"
wouldn't be made redundant by some boolean flag to accompany "prefix" to
indicate that we've chdir'd out of the prefix (or not).
