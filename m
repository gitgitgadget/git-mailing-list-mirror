Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4FDC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiBVCJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:09:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiBVCJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:09:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984713DCF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:09:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm8so23621584edb.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4NJi+sfYpadnvdDdBWZ8zQ78cigU7eGQcTrksrCWqaY=;
        b=VuzMi7gCWjQfZi/DIR+svd8usyH2HfCHhsJF1KvD7jAxNf8jBLpg0j85nfrwHGLY6z
         NjO4U3fMHUBiri8zZOK3Y0s4uEcxoHU+0xJcRLpE0eS6VE4Xm5TY8krbXaG2FmvAM7Zt
         8nabJq53El87AzJDl+E7UzA/VHmsAv8VXPrRkrS16SGl0q7HhkSdvQWVREbVn/UvmTfy
         c23YoiaQNpH0QHho5TLcVF+p1o+COhqFOqSvGXP+VnZ0MYVhgmlBFn0HKR34Z3339iQp
         tqpcNIbMvxjN1SwGrTGGT4nWWz6a2hn/KS/2Ew3hecZsvnhsuQiQp3tmZ/qxn8SCauVb
         cAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4NJi+sfYpadnvdDdBWZ8zQ78cigU7eGQcTrksrCWqaY=;
        b=n2WDLDVJYqN2ro4QcdkReg/Q91W+BNAWHe9n4z4SK3g4ub8VhuhFsrUMfzRJMt7YUs
         szvOXRcZ3pLaiM+H/XlixvV+FA1QpBIbYBbM2CmorWS9v4Ndsf9SrZC3IzvVHJ06sVOd
         EHaGKVi6lmJzt+YLkxflmZkCtPEUnH3hFePxUJd6AIKBNZQk139l9hzhRB9JFc/CT1iI
         khpuSoATXyJ8ev2Qr5NCx9zCEl77GJT6489Jgnq+xYVyfMwL+W2Ve0HZrfxxOF2LpjWP
         yG4Y2Pv1oTe5bdR9HwVhnjtyB673WyJa31F9ffbcIMWDOemb+2PZcvFEXOPHEm9E2+un
         lE5w==
X-Gm-Message-State: AOAM5314XhyjtJDY4z4B86v1z8OEM71FI+Uz7aZFU72R9VScysS2KYTn
        k68LRbs17f1bGdmCa/yKnOqYMoWgVdUy8weeBJo=
X-Google-Smtp-Source: ABdhPJwkUUOMnPZK9Ei8MT1eu6BiItoByp5BcpAZ9QkTOkTGhKC+SN8M3xxdGE+qe3cV3GyO28kfa0YDZ5SO155064g=
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id
 k14-20020aa7c04e000000b004004dafbab1mr24138029edo.101.1645495741559; Mon, 21
 Feb 2022 18:09:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
 <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com> <220220.86k0dpd8c8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220220.86k0dpd8c8.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 18:08:50 -0800
Message-ID: <CABPp-BF0LtkDPxBY7ECbS4110-38sa=YXBkUkjw6mNFH4PEebQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] In-core git merge-tree ("Server side merges")
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 4:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sun, Feb 20 2022, Elijah Newren via GitGitGadget wrote:
>
> > =3D=3D Updates Log =3D=3D
> >
> > Many thanks to the many reviewers who provided good feedback on the mos=
t
> > recent round -- Junio, =C3=86var, Josh, Emily, and perhaps some others =
I've
> > forgotten from review club.
> >
> > Updates since v4:
> >
> >  * Fixed double "is" in documentation.
> >  * Fixed a few small items with testcases
> >
> > Updates since v3 (or v5, if you include the rounds at
> > https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadge=
t@gmail.com/):
> >
> >  * Dropped previous patches 5, 6, and 8 of the old series; they weren't
> >    being used and opened a can of worms[1]
> >  * [Patch 3] Restructured argument checking, including using an enum
> >  * [Patch 4] Restored the extended paragraph about the deprecated form =
of
> >    git-merge-tree, mentioned write-tree in plumbing commands, and a few
> >    other small fixups to the documentation
> >  * [Patch 4] Also provide an example of a clean merge rather than just =
a
> >    conflicted one
> >  * [Patch 6] Fix the incompatible arguments check and add some tests fo=
r it
> >  * [Patch 6] Introduce an anonymize_hash() shell function to make tests
> >    easier to read (less repeated sed)
> >  * [Patch 9] Rename --exclude-modes-oids-stages to --name-only; no shor=
t
> >    option for now
> >  * [Patch 10] When -z passed, the tree in the first section should have=
 a
> >    trailing NUL rather than trailing newline [1]
> >    https://lore.kernel.org/git/CABPp-BEKuXHELVx4=3D5JJTj5HVOKZ=3DY-4G4B=
K47BCZYYRSrkFsQ@mail.gmail.com/
> >
> > Stuff NOT included that reviewers brought up in earlier rounds:
> >
> >  * Very generic (mode, oid, stage, filename) printing formatting[2]
> >  * Always printing 3 stages for each filename with conflicts[3]
> >  * Attempting to group conflict stages by logical conflict rather than =
by
> >    affected target filepath[4]
> >  * Providing similar functionality for doing cherry-picks/rebases/rever=
ts,
> >    i.e. a scheme for three-way merges with a specified merge-base[5]. T=
hat's
> >    being deferred to a future series. [2]
> >    https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-=
0it3z7TPn_w@mail.gmail.com/
> >    [3]
> >    https://lore.kernel.org/git/CABPp-BG2rMEYBLuBW=3D0wtpJe4aUFGCFa8D0NT=
SKz9Sm+CkXPxw@mail.gmail.com/
> >    [4]
> >    https://lore.kernel.org/git/CABPp-BGCL0onSmpgKuO1k2spYCkx=3Dv27ed9TS=
SxFib=3DOdDcLbw@mail.gmail.com/
> >    [5]
> >    https://lore.kernel.org/git/CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbH=
A8+iGjxsYSA@mail.gmail.com/
>
> I've looked through this, I think it all looks good overall & that the
> things that needed to be addressed (as opposed to my --format rambling)
> have been.
>
> I think all the code should be ready for "next".
>
> I suggested (I think around getopts discussion) in an earlier that the
> code would have been easier with a new built-in, but if we're
> deprecating the existing "mode" I think using the name is probably
> better in the end.
>
> I find the resulting documentation to be really hard to grok though
> because we're effectively describing two different commands. The current
> docs are small: https://git-scm.com/docs/git-merge-tree
>
> I built the tip of this series and read the manpage, and found myself
> needing to carefully squint to see what referred to what mode in the
> docs.
>
> E.g. by the time it's discussing "-z" and other options the reader needs
> to be astute really aware of the context, and infer from the lack of
> "<options>" on the "--trivial-merge" that these options refer to the
> "--write-tree" only.
>
> The same goes for the rest of "--trivial-merge". I.e. I found myself
> needing to read the whole docs word-by-word (no skimming!) to see if
> OUTPUT etc. was going to describe its output, or just the "new" mode.
>
> It is my NSHO that man pages should be structured for the impatient
> reader :)
>
> Then when you say "git-merge-tree was written to be[...]" I thought "ah
> ha! surely this will discuss the since-2005 implemented mode", but "was
> written to be" is referring to code new in this series.
>
> The below patch-on-top addresses all those concerns. Basically I just
> added a line to the top of the DESCRIPTION saying that you should read a
> "DEPRECATED DESCRIPTION" section at the end for "--trivial-merge", and
> that all of the rest is talking about the "--write-tree" mode.
>
> I then edited various prose to do away with the now-unnecessary "the
> first form" etc.
>
> This diff is better against "master" in that you'll see that the current
> merge-tree DESCRIPTION section isn't touched at all (it's now just under
> a new heading), but this diff is against the tip of your series.
>
> There's various other small fixes while I was it it here, e.g. all your
> cross-section links were using some pseudo-not-quite-ASCIIDOC syntax
> that doesn't work. Now it uses the right syntax. Ditto link-ifying
> references to "mktag" etc.
>
> I don't know if you'd consider this for a v6, or if I should just submit
> this on top myself, but in any case here it is. I'll leave it to you how
> you'd like to proceed with it:

Overall the diff below looks good; thanks!  I'll include it in a v6.
Two exceptions, listed below:

> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 306149fa0e2..723b1995426 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -9,17 +9,24 @@ git-merge-tree - Perform merge without touching index o=
r working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
> -'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (depr=
ecated)
> +'git merge-tree' --write-tree [<options>] <branch1> <branch2>
> +'git merge-tree' --trivial-merge <base-tree> <branch1> <branch2>

I dislike all three changes to the synopsis; I'll discard these.

> +[[NEWMERGE]]
>  DESCRIPTION
>  -----------
>
> -Performs a merge, but does not make any new commits and does not read
> -from or write to either the working tree or index.
> +This command has a modern `--write-tree` mode and a deprecated
> +`--trivial-merge` mode. The rest of this documentation describes
> +modern `--write-tree` mode unless otherwise specified. see
> +<<DEPMERGE,DEPRECATED DESCRIPTION>> below for a summary of the
> +`--trivial-merge` mode.
>
> -The first form will merge the two branches, doing a real merge.  A real
> -merge is distinguished from a trivial merge in that it includes:
> +Performs a "real" merge, but does not make any new commits and does
> +not read from or write to either the working tree or index.
> +
> +The performed merge will use the same feature as the "real"
> +linkgit:git-merge[1], including:
>
>    * three way content merges of individual files
>    * rename detection
> @@ -28,24 +35,8 @@ merge is distinguished from a trivial merge in that it=
 includes:
>      merge base, creating a virtual merge base by merging the merge bases=
)
>    * etc.
>
> -After the merge completes, the first form will create a new toplevel
> -tree object.  See `OUTPUT` below for details.
> -
> -The second form is deprecated; it is kept for backward compatibility
> -reasons but may be deleted in the future.  Other than the optional
> -`--trivial-merge`, it accepts no options.  It can only do a trivial
> -merge.  It reads three tree-ish, and outputs trivial merge results and
> -conflicting stages to the standard output in a semi-diff format.
> -Since this was designed for higher level scripts to consume and merge
> -the results back into the index, it omits entries that match
> -<branch1>.  The result of this second form is similar to what
> -three-way 'git read-tree -m' does, but instead of storing the results
> -in the index, the command outputs the entries to the standard output.
> -This form not only has limited applicability, the output format is
> -also difficult to work with, and it will generally be less performant
> -than the first form even on successful merges (especially if working
> -in large repositories).  The remainder of this manual will only
> -discuss the first form.
> +After the merge completes, a newtoplevel tree object is created.  See
> +`OUTPUT` below for details.
>
>  OPTIONS
>  -------
> @@ -54,7 +45,7 @@ OPTIONS
>         Do not quote filenames in the <Conflicted file info> section,
>         and end each filename with a NUL character rather than
>         newline.  Also begin the messages section with a NUL character
> -       instead of a newline.  See OUTPUT below for more information.
> +       instead of a newline.  See <<OUTPUT>> below for more information.
>
>  --name-only::
>         In the Conflicted file info section, instead of writing a list
> @@ -74,11 +65,12 @@ OPTIONS
>         share no common history.  This flag can be given to override that
>         check and make the merge proceed anyway.
>
> +[[OUTPUT]]
>  OUTPUT
>  ------
>
> -By default, for a successful merge, the output from git-merge-tree is
> -simply one line:
> +For a successful merge, the output from git-merge-tree is simply one
> +line:
>
>         <OID of toplevel tree>
>
> @@ -90,6 +82,7 @@ Whereas for a conflicted merge, the output is by defaul=
t of the form:
>
>  These are discussed individually below.
>
> +[[OIDTLT]]
>  OID of toplevel tree
>  ~~~~~~~~~~~~~~~~~~~~
>
> @@ -98,6 +91,7 @@ working tree at the end of `git merge`.  If there were =
conflicts, then
>  files within this tree may have embedded conflict markers.  This section
>  is always followed by a newline (or NUL if `-z` is passed).
>
> +[[CFI]]
>  Conflicted file info
>  ~~~~~~~~~~~~~~~~~~~~
>
> @@ -111,6 +105,7 @@ the `--name-only` option is passed, the mode, object,=
 and stage will
>  be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
>  character instead of a newline character.
>
> +[[IM]]
>  Informational messages
>  ~~~~~~~~~~~~~~~~~~~~~~
>
> @@ -138,72 +133,94 @@ something other than 0 or 1 (and the output is unsp=
ecified).
>  USAGE NOTES
>  -----------
>
> -git-merge-tree was written to be low-level plumbing, similar to
> -hash-object, mktree, commit-tree, write-tree, update-ref, and mktag.
> -Thus, it could be used as a part of a series of steps such as
> +This command is intended as low-level plumbing, similar to
> +linkgit:git-hash-object[1], linkgit:git-mktree[1],
> +linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
> +linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
> +used as a part of a series of steps such as:
>
>         NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>         test $? -eq 0 || die "There were conflicts..."
>         NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
>         git update-ref $BRANCH1 $NEWCOMMIT
>
> -Note that when the exit status is non-zero, NEWTREE in this sequence
> +Note that when the exit status is non-zero, `NEWTREE` in this sequence
>  will contain a lot more output than just a tree.
>
> -git-merge-tree was written to provide users with the same information
> -that they'd have access to if using `git merge`:
> -  * what would be written to the working tree (the <OID of toplevel tree=
>)
> +The output will include the same information that you'd get with
> +linkgit:git-merge[1]:
> +
> +  * what would be written to the working tree (the <<OIDTLT,OID of tople=
vel tree>>)
>    * the higher order stages that would be written to the index (the
> -    <Conflicted file info>)
> -  * any messages that would have been printed to stdout (the <Informatio=
nal
> -    messages>)
> +    <<CFI,Conflicted file info>>)
> +  * any messages that would have been printed to stdout (the <<IM,Inform=
ational
> +    messages>>)
>
>  MISTAKES TO AVOID
>  -----------------
>
>  Do NOT look through the resulting toplevel tree to try to find which
> -files conflict; parse the <Conflicted file info> section instead.  Not
> +files conflict; parse the <<CFI,Conflicted file info>> section instead. =
 Not
>  only would parsing an entire tree be horrendously slow in large
>  repositories, there are numerous types of conflicts not representable by
>  conflict markers (modify/delete, mode conflict, binary file changed on
>  both sides, file/directory conflicts, various rename conflict
>  permutations, etc.)
>
> -Do NOT interpret an empty <Conflicted file info> list as a clean merge;
> +Do NOT interpret an empty <<CFI,Conflicted file info>> list as a clean m=
erge;
>  check the exit status.  A merge can have conflicts without having
>  individual files conflict (there are a few types of directory rename
>  conflicts that fall into this category, and others might also be added
>  in the future).
>
>  Do NOT attempt to guess or make the user guess the conflict types from
> -the <Conflicted file info> list.  The information there is insufficient
> +the <<CFI,Conflicted file info>> list.  The information there is insuffi=
cient
>  to do so.  For example: Rename/rename(1to2) conflicts (both sides
>  renamed the same file differently) will result in three different file
>  having higher order stages (but each only has one higher order stage),
> -with no way (short of the <Informational messages> section) to determine
> +with no way (short of the <<IM,Informational messages>> section) to dete=
rmine
>  which three files are related.  File/directory conflicts also result in
>  a file with exactly one higher order stage.
>  Possibly-involved-in-directory-rename conflicts (when
>  "merge.directoryRenames" is unset or set to "conflicts") also result in
>  a file with exactly one higher order stage.  In all cases, the
> -<Informational messages> section has the necessary info, though it is
> +<<IM,Informational messages>> section has the necessary info, though it =
is
>  not designed to be machine parseable.
>
> -Do NOT assume all filenames listed in the <Informational messages>
> +Do NOT assume all filenames listed in the <<IM,Informational messages>>
>  section had conflicts.  Messages can be included for files that have no
>  conflicts, such as "Auto-merging <file>".
>
> -AVOID taking the OIDS from the <Conflicted file info> and re-merging
> +AVOID taking the OIDS from the <<CFI,Conflicted file info>> and re-mergi=
ng
>  them to present the conflicts to the user.  This will lose information.
> -Instead, look up the version of the file found within the <OID of
> -toplevel tree> and show that instead.  In particular, the latter will
> +Instead, look up the version of the file found within the <<OIDTLT,OID o=
f
> +toplevel tree>> and show that instead.  In particular, the latter will
>  have conflict markers annotated with the original branch/commit being
>  merged and, if renames were involved, the original filename.  While you
>  could include the original branch/commit in the conflict marker
>  annotations when re-merging, the original filename is not available from
> -the <Conflicted file info> and thus you would be losing information that
> +the <<CFI,Conflicted file info>> and thus you would be losing informatio=
n that
>  might help the user resolve the conflict.
>
> +[[DEPMERGE]]
> +DEPRECATED DESCRIPTION
> +----------------------
> +
> +Per the <<NEWMERGE,DESCRIPTION>> and unlike the rest of this
> +documentation this section describes describes the deprecated
> +`--trivial-merge` mode.
> +
> +Reads three tree-ish, and output trivial merge results and
> +conflicting stages to the standard output.  This is similar to
> +what three-way 'git read-tree -m' does, but instead of storing the
> +results in the index, the command outputs the entries to the
> +standard output.
> +
> +This is meant to be used by higher level scripts to compute
> +merge results outside of the index, and stuff the results back into the
> +index.  For this reason, the output from the command omits
> +entries that match the <branch1> tree.

What you have in the new section is fine, but what you've deleted
should probably be included here.  In particular, the brief
explanation about why this mode is deprecated.


> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
>
