Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E05DC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E72564E7D
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhBHIGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBHIFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 03:05:14 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD51C06174A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 00:04:15 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id i3so3862753oif.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 00:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lOAYUMkbMKacEixJvAI5M1ieiYKjawUJt5b/OY2avCs=;
        b=Vj6tCjU3Okzrum1lum9cM9/91YPStWkPipdQcQTF9pMZwE4F5y0I3UymiVR8kKbpKs
         QfSnrvV9z1iVcDatrrrlqYMV7vrxzUAwrszVG9B+rXmD/DdNqDxTQbNg0kePYlh+FpI6
         9kxrNkJcG7ikwk5U04Izabsr6MNtcxAtjWVVOw0VysnsL602al2BaSbFA4bppg8bIHTA
         bo3nK/TodqK8kVuwsB8haVYJaZFKQo8TsvkLzqgOEKx9jxj19h3Uhm0naql5U7g3LbWE
         9gev4DZ/EvM6hg6gXp5Jy5pdCSIJhkad0dS5D197cGG6bu8agBcrIPbLz2I+ZfPSnHA/
         NbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lOAYUMkbMKacEixJvAI5M1ieiYKjawUJt5b/OY2avCs=;
        b=ALucJajmo+jV8Y9B8mjcGtT7JTDesJDGtlozBS3bqa5Ndr0hcHyqF7aHs77LMTDTS7
         DB5trYVnMhXV4nIhqv7LKz1KSij07h+qF3XGR81mRqvyZ8r/zvC2fTehA5XQZbNzf65V
         5TgQrC/VcwQpkXrf7OtT8O7tOYg9JKJVF4CiTCFCXOVVwsrMlME+sX4371FBWx/AG0AM
         Ar0KHlJ1CHtNJnaayYvA6ZgKW/mQldtixxGqnSAFa4BwZR9x/URTvzaQvtacFKTSLIAo
         jQ5dFxqgUxE89pT6/nPzEt2uGIpC0P7tA7XU4Gt1hFDlnfeAufLQabV22ktWvSq5LWwF
         9Ohg==
X-Gm-Message-State: AOAM533694tj+yygTi4MnfVeCtosaynpg9EAkXWtzE0/BPrPsurU3cr5
        iaqTAf2hciyNCzD+JhvdG21680sN0sRjNqGnxQ4=
X-Google-Smtp-Source: ABdhPJw1XDw+/HU4k2bVwWYHZAzNuvq/I8/+8cQPZ9rF3ACyxfCOLubdVeHVv6hcE0aEpO/hTCc7wy0JVdT5oJRaOiQ=
X-Received: by 2002:aca:5b46:: with SMTP id p67mr10597026oib.179.1612771454805;
 Mon, 08 Feb 2021 00:04:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com> <xmqq8s7z8zsg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s7z8zsg.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Mon, 8 Feb 2021 16:06:20 +0800
Message-ID: <CAOLTT8TnkzU397Bnx1NdpJY-P4fYpTPzjtuzwPzLEpE_Si4Fjw@mail.gmail.com>
Subject: Re: [PATCH] git-difftool-helper.sh: learn a new way skip to save point
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=883:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Sorry, but a not-yet-written reply went out by accident; please
> discard it.
>

Never mind. I have synchronized different signatures of git, gmail,
github.

> > `git difftool` only allow us to select file to view In turn.
>
> Funny capitalization "In"?
>
> > If there is a commit with many files and we exit in search,
> > We will have to traverse list again to get the file diff which
> > we want to see.Therefore,here is a new method:every time before
>
> It makes it hard to lack SP after punctuation like '.', ',', and
> ':'.
>
> > we view the file diff,the current coordinates will be stored in
> > `GIT_DIR/difftool_skip_to`,this file will be deleted after
> > successful traversing.But if an unexpected exit occurred midway,
> > git will view the coordinates in the save point,ask user if they
> > want continue from the last saved point.This will improve the
> > user experience.
>
> I think the idea sounds good.  Admittedly I do not use difftool
> myself, so I do not even know if and how the current end user
> experience is so bad to require a patch like this (e.g. I do not
> know how "unexpected exit" is "unexpected"---isn't it the end user
> initiated action to "quit", or does the tool crash or something?).
>

Generally speaking, It is the user of git manually use [Ctrl+c].
However, if the program itself fails and causes the exit, I think
this "save point" can also be well recorded, because it will be
stored before view the diff.

> So I won't be the best qualified person to judge if the solution
> presented is the best one for the problem.
>
>     $ git shortlog --no-merges git-diff-helper.sh
>
> might be a good way to find whom to ask for review and help.
>

Thanks for reminding, I will -cc these authors.

> Having said that, I do have one opinion on the "skip-to" filename.
> I do not think it is wise to call it after the purpose you want to
> use it for (i.e. "I want to use it to skip to the recorded
> position").  Instead, if the file records "the last visited
> position", it is better to name it after that
> (e.g. "difftool-last-position".  If it records "the next file to be
> visited", then "difftool-next-file" may be a good name).
>

Indeed, "last-position" can better express this patch function.
I will modify it according to your suggestions.

> The reason is because your first design may be to visit the file the
> user was visiting before the "crash" happened, but you may later
> want to revise the design to allow the user to say "start at one
> file before the file I was visiting" etc.  The location recorded in
> the file may still be used to decide where the code skips to when
> restarting, but no longer exactly where the code "skips to".  If you
> name it after what it is, not what it is (currently) used for, the
> design would become clearer.
>

You are right,But I think based on this patch, the function of "skip to"
may can be added later.

>
> > diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> > index 46af3e60b718..56ec1d38a7a1 100755
> > --- a/git-difftool--helper.sh
> > +++ b/git-difftool--helper.sh
> > @@ -6,6 +6,7 @@
> >  # Copyright (c) 2009, 2010 David Aguilar
> >
> >  TOOL_MODE=3Ddiff
> > +GIT_DIFFTOOL_SKIP_TO_FILE=3D"$GIT_DIR/difftool-skip-to"
> >  . git-mergetool--lib
> >
> >  # difftool.prompt controls the default prompt/no-prompt behavior
> > @@ -40,6 +41,31 @@ launch_merge_tool () {
> >       # the user with the real $MERGED name before launching $merge_too=
l.
> >       if should_prompt
> >       then
> > +             if test -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
> > +             then
> > +                     SAVE_POINT_NUM=3D$(cat "$GIT_DIFFTOOL_SKIP_TO_FIL=
E")
>
> You can avoid the TOCTTOU race by
>
>                 if SAVE_POINT=3D$(cat 2>/dev/null "$GIT_DIFFTOOL_SKIP_TO_=
FILE")
>                 then
>
> but that wouldn't probably matter in this application.
>
> > +                     if test $SAVE_POINT_NUM -le $GIT_DIFF_PATH_TOTAL =
&&
> > +                             test $SAVE_POINT_NUM -gt $GIT_DIFF_PATH_C=
OUNTER
>
> Think what happens if the file is corrupt and SAVE_POINT_NUM has (1)
> an empty string, (2) garbage that has $IFS whitespace, (3) non
> number, in it.  At least, quoting the variable inside double-quotes,
> i.e. "$SAVE_POINT_NUM", would help an error condition reported
> correctly at the runtime.

Understand now.A variable with '""'can show correct error usage when
these error conditions occur.

>
> > +                     then
> > +                             # choice skip or not skip when check firs=
t file.
>
> A bit funny language.  Isn't the code clear enough without this comment?
>
> > +                             if test $GIT_DIFF_PATH_COUNTER -eq "1"
>
> No need to quote the constant "1"; quoting the variable side may be
> a good practice, even though I think in this codepath we know
> GIT_DIFF_PATH_COUNTER is a well-formatted number.

Truly. I will use "DIFFTOOL_FIRST_NUM" instread of "1".

>
> > +                             then
> > +                                     printf "do you want to skip to la=
st time difftool save point($SAVE_POINT_NUM) [Y/n]?"
>
> "Skip" is probably an implementation detail that the user does not
> have to know.  "Do you want to start from the last file you were
> viewing?", perhaps?

Yeah. Because users may choice another totally different diff,
I will use "Do you want to start from the possible last file you
were viewing?".

>
> > +                                     read skip_ans || return
> > +                                     if test "$skip_ans" =3D y
> > +                                     then
> > +                                             return
> > +                                     fi
> > +                             else
> > +                                     return
> > +                             fi
> > +                     fi
> > +             fi
> > +             # write the current coordinates to .git/difftool-skip-to
> > +             if test !$SAVE_POINT_NUM || $SAVE_POINT_NUM -ne $GIT_DIFF=
_PATH_COUNTER
>
> Have this code been tested?  I think "test" is missing after the
> "||", and I am not quite sure what you are trying to check with
> "test !$SAVE_POINT_NUM", either.  The "test" utility, when given a
> non-operator string (like "!23" this one is checking when the last
> visited path was the 23rd one), returns true if the string is not an
> empty string, and by definition a string made by appending anything
> after "!" would not be empty, so the entire "|| $SAVE_POINT_NUM ..."
> have been skipped in your test, I think.
>

Is indeed a mistake of mine, `test -z "$SAVE_POINT_NUM"` will be fine.
Shell script syntax I will pay more attention.

> Is writing the current position to the file unconditionally good
> enough?  After all, we are about to go interactive with the user, so
> the body of this "if" statement won't be performance critical in any
> sense, no?  Or is there something more subtle going on and
> correctness of the code depends on this condition?  I cannot quite
> tell.
>
> > +             then
> > +                     echo $GIT_DIFF_PATH_COUNTER > $GIT_DIFFTOOL_SKIP_=
TO_FILE
>
>                 echo "$GIT_DIFF_PATH_COUNTER" >"$GIT_DIFFTOOL_SKIP_TO_FIL=
E"
>
> cf. Documentation/CodingGuidelines
>
>  - Redirection operators should be written with space before, but no
>    space after them.  In other words, write 'echo test >"$file"'
>    instead of 'echo test> $file' or 'echo test > $file'.  Note that
>    even though it is not required by POSIX to double-quote the
>    redirection target in a variable (as shown above), our code does so
>    because some versions of bash issue a warning without the quotes.
>
>         (incorrect)
>         cat hello > world < universe
>         echo hello >$world
>
>         (correct)
>         cat hello >world <universe
>         echo hello >"$world"
>
>
>
>

OK, I will read Documentation/CodingGuidelines more times.

> > +             fi
> >               printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTE=
R" \
> >                       "$GIT_DIFF_PATH_TOTAL" "$MERGED"
> >               if use_ext_cmd
> > @@ -102,4 +128,10 @@ else
> >       done
> >  fi
> >
> > +if test -f $GIT_DIFFTOOL_SKIP_TO_FILE &&
> > +     test $GIT_DIFF_PATH_COUNTER -eq $GIT_DIFF_PATH_TOTAL
> > +then
> > +     rm $GIT_DIFFTOOL_SKIP_TO_FILE
> > +
> > +fi
> >  exit 0
>
> Wouldn't it be simpler to clear when we have reached at the end, i.e.
>
>         if test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL"
>         then
>                 rm -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
>         fi
>
> Thanks.

Thanks for the advice and correct, Junio.
