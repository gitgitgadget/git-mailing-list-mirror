Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A4C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGAVxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGAVxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:53:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC9A59269
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:53:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z41so4503993ede.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pvgn/yZhVbh3NE4Fpj0gyYvuVicUZeea3oOQ7a5KvKk=;
        b=F+v8smNliL/MdCHOQyqrRfWMR1z7KcTuzYCS1qejm51qPmBo1ipzW8W9Sytkq7G/GC
         /NHtxjS1gF46aBj6lTGgbZNH1yDgcj7RiCSl5KZAjcmiQk6sjnge7qfZodfRZXmWNeus
         FhwDZZ3EaoJjPahCsQsRq6q4pqrUs2GvtobmyfphcK2gwmiE+poM8mJBdM650+wkZmeU
         R3ELWcrFDeR6eJeFLjCs2DQCohl+iAFGctw22sJx3LI55aD8DYr128PNdETuQYMnHkew
         OPZsPqQFztG7B2aW8+UJNkDUKy1yKlBJS2G7alJS8qe448wMDDT3CO02+M6rjlbQVVt4
         KC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pvgn/yZhVbh3NE4Fpj0gyYvuVicUZeea3oOQ7a5KvKk=;
        b=dtlqTk6EJacn5AUsMaQnsJ1bFGKdFr7T/Gy/xgR4RouSV4QqGwBLTh8Xw5pVyGkAA+
         FQ0uMoTSzTkBUV4P67t9g1GqXeKs3jpdx9U5X2GzwXiTH0JP+9wvIHQlsDMcYbPOV6gL
         bP0rnDEUTPABlMuJ6ARAmbEUkfkCn8pwPq6Msj9xe284VE9qWFie1N2+0LMOi4eKOFqk
         FnZem38odATwH9vxV3rTARz883Bv6dgczIhbZ7o/x39e+Xk13D4W6qffdkjWVv1b/9/j
         imCkLG1+VDN/QeUN1q+bSLYG0WVYaELbX4FE7cIDDGIYGB17fJTQahyHxmozhbSzBswT
         2OUA==
X-Gm-Message-State: AJIora98Ma5LjEJnEypu6Nww/qgQaXsQscUQ5vGDX7ncP6u8F1deXFpR
        ARTDwFo/PeTQFtxoCKJJgkIUf0KqeD8w5Ior2W1M9CJvXJY=
X-Google-Smtp-Source: AGRyM1uFQz1mtfwSi6AVoynt2fvmmXL+PkTLdDv62UmS7n867TA6R+9GgqfiX8xfdLpOzoBfJ1FF4riclDE7Biha7mA=
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr20078744eda.75.1656712380010; Fri, 01
 Jul 2022 14:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com> <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
 <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com>
In-Reply-To: <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Jul 2022 14:52:48 -0700
Message-ID: <CABPp-BHgwaWNEJnSer0-jw8+53NDuRWLvtXp4U_JJ8T_t-bTpQ@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Dian Xu <dianxudev@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dian,

As a heads up, note that on this list we don't top-post.

On Fri, Jul 1, 2022 at 1:24 PM Dian Xu <dianxudev@gmail.com> wrote:
>
> Hi Victoria, Elijah, Derrick,
>
> Thanks a lot for the detailed insight.
>
> (Btw our company=E2=80=99s email mathworks.com is blocked by
> mailto:git@vger.kernel.org, hope someone can help take a look)

Konstantin: Is this something you know how to look into?  (Or do you
know who to ask?)

> 1. We use a no-cone version of sparse-checkout to control the 'shape'
> (set of scm files) of our source code. In this case, the local sandbox
> is not necessarily 'sparse' (2m files), but it's very convenient that
> we can use git to check out the exact amount (shape) of files. To
> Victoria's question, all these 2m files are "H".

How many are "H", how many are "S", and how many files in total?  I'd
like to try to construct a way to reproduce your issue, and knowing
how many of each will help.

> 2. Below is the detail steps to create the local repo (sparse-checkout
> was defined 'before' git checkout)
>       % git init
>       % git remote add origin <url>
>       % git config core.sparsecheckout true
>       % vi .git/info/sparse-checkout
>       % git fetch
>       % git checkout -b <SHA>
>     Do I still need to 'git sparse-checkout reapply' after checkout?
> (Thanks for pointing out to run reapply once .git/info/sparse-checkout
> changed)

Why didn't you list 'git sparse-checkout reapply' after editing
.git/info/sparse-checkout?  You mention it later, so I'm hoping you
ran it at that point.

You should only need to run the sparse-checkout reapply command after
manually editing the .git/info/sparse-checkout file.  There are
special cases where it might be useful after other commands, but it's
pretty rare.  Most git commands, and particularly checkout, will keep
the sparsity of the working tree up-to-date with the sparse-checkout
file -- assuming it was up-to-date beforehand.  Basically, feel free
to use the rule that you only need to reapply after manual edits of
the $GIT_DIR/info/sparse-checkout file.

Also, with newer git, you can replace all three of
   git config core.sparsecheckout true
   vi .git/info/sparse-checkout
   git sparse-checkout reapply
with
   git sparse-checkout set --no-cone <space-separated list of patterns
to insert into the .git/info/sparse-checkout file>

With older git, you can replace those three commands with two: `git
sparse-checkout init --no-cone && git sparse-checkout set <list of
patterns>`.  But that's sometimes not wanted since the init command
sparsifies everything away except files in the toplevel directory, and
then the second step restores all the files, and that two-step
approach is really slow as it deletes and then restores a huge number
of files from the working directory.

> 3. Unfortunately, after executing reapply (btw it is very slow on this
> 2m files * 16k patterns scenario: 30 mins), 'git add', and 'git add
> --sparse' still hangs.

'git add --sparse' is still slow?  That sounds like a bug I'd like to
investigate.

What's the particular timing you get for each of 'git add' and 'git
add --sparse'?  Are you giving it individual files (if so, how many?),
or directories (how many files under those directories?), or globs?
(This information will be helpful in my attempts to get a synthetic
setup aiming to be similar to yours.)

> 4. --cone is a big topic for us now, since 2.37.0 deprecates
> --no-cone. We do have our own challenges to move away from --no-cone
> (E.g. we use lots of file specifiers and/or exclusion patterns to
> define our source code shape), which will be a huge amount of work, if
> feasible. We've established a set of workflows based on --no-cone,
> because of its merit of being capable of defining a fine-grained scm
> shape.

To be fair, --no-cone is deprecated as in discouraged due to various
usability problems (including performance), but we currently have no
plans to remove it from Git.  I do heartily recommend migrating to
--cone since it solves so many problems, but we'll still support
--no-cone users as best we can.

> 5. Back to this case, what we've experimented on are:
>       - Remove all files/*/! patterns from our shape definition, which
> leave us with 14k directories (Obviously the scm shape no longe
> matches, but just to proof of concept here)
>       - 'git sparse-checkout set <14k directories>' finishes fast

Now I'm surprised.  You said in the previous email that you were using
git 2.34.2.  In that version, --no-cone is the default, so this would
still be using --no-cone mode.  That either suggests you switched to
v2.37 since your email and didn't include that detail here, or that
the performance issue is actually with certain specific patterns.
What version of git did you use here?  And did you have either an
explicit --cone or --no-cone when using the sparse-checkout set
command?

>       - 'git add' finishes fast

>     As Victoria mentioned, I hope this --no-cone 'git add' performance
> can be addressed because 'those performance gains can also be realized
> in cone mode', as we saw here.

Are we sure we saw that here?  Could you verify by reporting: (a) what
version of git were you using, and (b) does `git config --list | grep
-i sparse` show both core.sparsecheckout and core.sparsecheckoutcone
as being true after your do your sparse-checkout set?


Elijah
