Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F0C433EF
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 18:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhK0Sht (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 13:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhK0Sfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 13:35:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C6C061758
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 10:32:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so52646348eds.10
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 10:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/+KMGY/PLilb7/PH5aaxFPhgG99rMKPCYJmjTy+N8+o=;
        b=VAHUCwc3VxOCDZbdpRX0FkJcDSiUtl8A60CvlkDNZG4fc0TGIkgu/WmD4jPrppYZFg
         MgXzBGnnRl/qyZSS4sxqHixMtTL5OqbupAEE400njNqSsprO1Gb9mXTgTffte6BsjvCB
         uKzlhrGh5/edn3bXeE89VHMFwXpmcl8NxiMxkjI3dRSZx0beNPDGAOrqPUmInyLby2Mb
         PDEMge4urQFujC2Uwb/xL58Oytrwoxyrv/5VslqAxPyryWvizOq3eFHV4o8E7M76JEwF
         A2pUrKD/p3R85HDWST2/SkIiQbLsRZkpAuWrItlqbksNQTQ3nI1sqcKlN4eGaiKHUVYe
         LAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/+KMGY/PLilb7/PH5aaxFPhgG99rMKPCYJmjTy+N8+o=;
        b=vsJVys46lxGFB3ByNUmEhzIyOfARjxDSV9+vXfAcbQCItIeIcKeSj8Vrtbg8BxwVOm
         whv3rllfTutWqGIT5AJvw3e/yjpE9yuJauf1+Px35NsNcx7lt1PUI5HcdZdnLOd19HHn
         U4p7chqXtAhvy+PhTUDBaOdKkgod0b4Fep3Mz72KlaAaAZY1deF0rD8HDUFm5lW7D4QL
         cR5834Bw0DMmgG4Cu0rvo3BQh39NbJ8lizafwYXHEUyYQSHSPYxxsIY2yqBdrZgeOUxd
         dQzzaYpBVotSv1HvNo62TM8GpkGc2GS5e60cfV4tw3g53KevYLx9UJBTOVrGQ3kWZ7z7
         Fp8A==
X-Gm-Message-State: AOAM531XtMB38LYPxMnXHMY1n8iXDzBd8uUQdRsC4kPe+ngUFWrNC+A3
        hpi/KDYsFd1+5MQlhOAMWoHywNziAXixzboUZMU=
X-Google-Smtp-Source: ABdhPJwwsA0XZ9QwBuJ7ybXHkkHlt+lI/JbNaURVbtd8XvQIRDVl5vi2qRM8FbpxO2MBKflCNg2O0QYVBbrhhlXsOKM=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr46653913eja.172.1638037922091;
 Sat, 27 Nov 2021 10:32:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
 <211127.86v90dhf5g.gmgdl@evledraar.gmail.com>
In-Reply-To: <211127.86v90dhf5g.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 27 Nov 2021 10:31:50 -0800
Message-ID: <CABPp-BFuKBht2yZ+tYkG+C4Rpek6dLT0gx6pZNH4rXqv0UFf3Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 27, 2021 at 6:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:
>
> [Just some more "I haven't really looked at this in all that much
> detail" commentary, so maybe it's stupid, sorry]
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Removing the current working directory causes all subsequent git
> > commands run from that directory to get confused and fail with a messag=
e
> > about being unable to read the current working directory:
> >
> >     $ git status
> >     fatal: Unable to read current working directory: No such file or di=
rectory
> >
> > Non-git commands likely have similar warnings or even errors, e.g.
> >
> >     $ bash -c 'echo hello'
> >     shell-init: error retrieving current directory: getcwd: cannot acce=
ss parent directories: No such file or directory
> >     hello
>
> Is that really realistic?

I have 321 shell scripts (or symlinks thereto) in /usr/bin/ on my
Fedora laptop, and 951 shell scripts in /usr/bin/ on my Ubuntu
workstation at $DAYJOB.  That's not even considering stuff in other
directories.  Note that I didn't place any of those scripts in
/usr/bin/; they came from the distribution and/or corporate packages
from others.  Any invocation of bash will see the above "error"
message.  Granted, bash calls it an 'error' but continues anyway, but
I thought it showed that there were clearly programs besides git where
users could run into problems.

> Any "normal" command would use "pwd" or look
> at $PWD, both of which "work", this error is only because we're starting
> a new shell.

<grin>

Yeah, good point.  Who would use an unusual program like git?  Or a
shell script?  Or a java program?  Or emacs?  Or other programs like
them?  Besides, git, bash, java, and emacs are all relatively young
commands with small development teams.  Maybe we should just rely on
users only using commands that get the pwd/$PWD detail right; perhaps
limiting to commands that are more mature and have bigger development
teams than those four.

Silly users.

;-)

Sorry, couldn't resist a little friendly teasing.


However, for "pwd"...by "work", do you mean "doesn't necessarily
work"?  On my machine:

$ mkdir gone
$ cd gone
$ rmdir ../gone
$ pwd -P
pwd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
$ pwd
pwd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
$ echo $PWD
/home/newren/floss/git/gone

If I do not run `pwd -P` first then a plain `pwd` works.  But your
advice to use `pwd` seems misguided for programs, since they'll hit
this problem if users have run a previous `pwd -P`.  (The $PWD trick
would have worked, as shown above)

> I wonder if it was just because you ran into our bin-wrappers edge case,
> but that should be really obscure for any real users.

Yes, I agree our bin-wrappers is a really obscure edge case not worth
considering.  I don't see how you jump from there to painting all
shell scripts combined with the same brush, though.

> > This confuses end users, particularly since the command they get the
> > error from is not the one that caused the problem; the problem came fro=
m
> > the side-effect of some previous command.
> >
> > We would like to avoid removing the current working directory of our
> > parent process; towards this end, introduce a new variable,
> > startup_info->original_cwd, that tracks the current working directory
> > that we inherited from our parent process.  For convenience of later
> > comparisons, we prefer that this new variable store a path relative to
> > the toplevel working directory (thus much like 'prefix'), except withou=
t
> > the trailing slash.
>
> I'm still not clear at all on why we need a "original_cwd" at all then
> as opposed to just using "prefix" (or adding "the_prefix" if passing it
> down is painful). I.e. we discover our relative path, we resolve the
> relative path to the root, can't we use that as the "don't remove our
> CWD" guard?
>
> Does our prefix change at some point, then maybe "orig_prefix" would
> make more sense?

No; see the code comment in the same patch:

+       /*
+        * startup_info->original_cwd points to the current working
+        * directory we inherited from our parent process, which is a
+        * directory we want to avoid removing.
+        *
+        * For convience, we would like to have the path relative to the
+        * worktree instead of an absolute path.
+        *
+        * Yes, startup_info->original_cwd is usually the same as 'prefix',
+        * but differs in two ways:
+        *   - prefix has a trailing '/'
+        *   - if the user passes '-C' to git, that modifies the prefix but
+        *     not startup_info->original_cwd.
+        */

It's never equal to prefix, even though it's usually semantically
referring to the same directory.  However, even if it weren't for the
trailing slash issue, the -C case means it is not appropriate to think
of it as "orig_prefix" either.
