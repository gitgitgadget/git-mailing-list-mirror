Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E6C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 12:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiBTMf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 07:35:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243783AbiBTMfw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 07:35:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9953B79
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:35:24 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s24so17480695edr.5
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MQsTJ6iOPKDtnUnayL3UFxwCmL4rl6lEFmkosPrSMR4=;
        b=juKMLFrfrrWx+BwVXgFdl7hbN1lhPMG9eWHRbyk+9Q2SmwWnpEuSFO13bpCdjz24yv
         QHEmE0p7miegm3OUKPhog8PdPMruPrHGX6mcUE94q6hX5PMmGyr/MrHtuZ0M35HlDQZu
         8xGnhNR2xCRx51EjUDa2eHzoffEMX7YC8m5PK8BY4OWLKXCxnY9fOx3nxh1VajXQDOj9
         unMINFB6pWyyC79FMoTHXWIEpDMqxIwOgFXW5+aTPqT+vhUKXj+Fb+8M6mnGRvsTzdeS
         OHCZzSL3J4HjyrFnlOzTf7aHovq5wDK/rGrpn/Vc8ZNvOHJdKQ2LR2LQWnEPpY2Rbysk
         DPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MQsTJ6iOPKDtnUnayL3UFxwCmL4rl6lEFmkosPrSMR4=;
        b=0/Cxg0qkkAyJU8wpK5MxPbG1o8efkilLUgfVGLm7eC05qFtDMRm4xAlNUSXUztzQ4j
         n10Qml25u+0zvX3Mo6EShzJymniDTkNsVKJAeT0YJSP3RO13z7VRhwPKPnj2FwpnXaHl
         6AC+UzNX8T9uodf5/RR41nJO8AyEmqo3ZcXdJvLP0ygh+L+WideFyeHpU3rnuSeUR5yK
         RqcCZonpTlM5tMISH/mS+TCP8hFxVpa+3sdegkYLblgSS7FoGOqB3epJhj8qf+iTujc0
         8gdl7YgQGJSfaWFNcnP5A90S1MW2CqJmamPFy3+esJeDg8e4wTkNpAVcWlr5vRUwjzmz
         r1uA==
X-Gm-Message-State: AOAM533OOwMsKjJEjX4+SHJirW9DSoFunawPtGAxBKYUtVWRksGM+CXH
        dR0mkp0FhDVNHf/QrsRyXLCpuOtRW3evQg==
X-Google-Smtp-Source: ABdhPJyl/qtIWKTPOj7itzsT1uD4xuGBjReVjxP9MGpnvTFZ3+69JXMfBeaFKFFn9m5UZmxZpdDs1w==
X-Received: by 2002:a05:6402:2805:b0:405:f6a8:f74 with SMTP id h5-20020a056402280500b00405f6a80f74mr16373310ede.241.1645360522438;
        Sun, 20 Feb 2022 04:35:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z4sm4095344ejd.39.2022.02.20.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 04:35:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLlQu-005LpF-2J;
        Sun, 20 Feb 2022 13:35:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 00/12] In-core git merge-tree ("Server side merges")
Date:   Sun, 20 Feb 2022 11:23:41 +0100
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
 <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
Message-ID: <220220.86k0dpd8c8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 20 2022, Elijah Newren via GitGitGadget wrote:

> =3D=3D Updates Log =3D=3D
>
> Many thanks to the many reviewers who provided good feedback on the most
> recent round -- Junio, =C3=86var, Josh, Emily, and perhaps some others I'=
ve
> forgotten from review club.
>
> Updates since v4:
>
>  * Fixed double "is" in documentation.
>  * Fixed a few small items with testcases
>
> Updates since v3 (or v5, if you include the rounds at
> https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@=
gmail.com/):
>
>  * Dropped previous patches 5, 6, and 8 of the old series; they weren't
>    being used and opened a can of worms[1]
>  * [Patch 3] Restructured argument checking, including using an enum
>  * [Patch 4] Restored the extended paragraph about the deprecated form of
>    git-merge-tree, mentioned write-tree in plumbing commands, and a few
>    other small fixups to the documentation
>  * [Patch 4] Also provide an example of a clean merge rather than just a
>    conflicted one
>  * [Patch 6] Fix the incompatible arguments check and add some tests for =
it
>  * [Patch 6] Introduce an anonymize_hash() shell function to make tests
>    easier to read (less repeated sed)
>  * [Patch 9] Rename --exclude-modes-oids-stages to --name-only; no short
>    option for now
>  * [Patch 10] When -z passed, the tree in the first section should have a
>    trailing NUL rather than trailing newline [1]
>    https://lore.kernel.org/git/CABPp-BEKuXHELVx4=3D5JJTj5HVOKZ=3DY-4G4BK4=
7BCZYYRSrkFsQ@mail.gmail.com/
>
> Stuff NOT included that reviewers brought up in earlier rounds:
>
>  * Very generic (mode, oid, stage, filename) printing formatting[2]
>  * Always printing 3 stages for each filename with conflicts[3]
>  * Attempting to group conflict stages by logical conflict rather than by
>    affected target filepath[4]
>  * Providing similar functionality for doing cherry-picks/rebases/reverts,
>    i.e. a scheme for three-way merges with a specified merge-base[5]. Tha=
t's
>    being deferred to a future series. [2]
>    https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0i=
t3z7TPn_w@mail.gmail.com/
>    [3]
>    https://lore.kernel.org/git/CABPp-BG2rMEYBLuBW=3D0wtpJe4aUFGCFa8D0NTSK=
z9Sm+CkXPxw@mail.gmail.com/
>    [4]
>    https://lore.kernel.org/git/CABPp-BGCL0onSmpgKuO1k2spYCkx=3Dv27ed9TSSx=
Fib=3DOdDcLbw@mail.gmail.com/
>    [5]
>    https://lore.kernel.org/git/CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8=
+iGjxsYSA@mail.gmail.com/

I've looked through this, I think it all looks good overall & that the
things that needed to be addressed (as opposed to my --format rambling)
have been.

I think all the code should be ready for "next".

I suggested (I think around getopts discussion) in an earlier that the
code would have been easier with a new built-in, but if we're
deprecating the existing "mode" I think using the name is probably
better in the end.

I find the resulting documentation to be really hard to grok though
because we're effectively describing two different commands. The current
docs are small: https://git-scm.com/docs/git-merge-tree

I built the tip of this series and read the manpage, and found myself
needing to carefully squint to see what referred to what mode in the
docs.

E.g. by the time it's discussing "-z" and other options the reader needs
to be astute really aware of the context, and infer from the lack of
"<options>" on the "--trivial-merge" that these options refer to the
"--write-tree" only.

The same goes for the rest of "--trivial-merge". I.e. I found myself
needing to read the whole docs word-by-word (no skimming!) to see if
OUTPUT etc. was going to describe its output, or just the "new" mode.

It is my NSHO that man pages should be structured for the impatient
reader :)

Then when you say "git-merge-tree was written to be[...]" I thought "ah
ha! surely this will discuss the since-2005 implemented mode", but "was
written to be" is referring to code new in this series.

The below patch-on-top addresses all those concerns. Basically I just
added a line to the top of the DESCRIPTION saying that you should read a
"DEPRECATED DESCRIPTION" section at the end for "--trivial-merge", and
that all of the rest is talking about the "--write-tree" mode.

I then edited various prose to do away with the now-unnecessary "the
first form" etc.

This diff is better against "master" in that you'll see that the current
merge-tree DESCRIPTION section isn't touched at all (it's now just under
a new heading), but this diff is against the tip of your series.

There's various other small fixes while I was it it here, e.g. all your
cross-section links were using some pseudo-not-quite-ASCIIDOC syntax
that doesn't work. Now it uses the right syntax. Ditto link-ifying
references to "mktag" etc.

I don't know if you'd consider this for a v6, or if I should just submit
this on top myself, but in any case here it is. I'll leave it to you how
you'd like to proceed with it:

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tre=
e.txt
index 306149fa0e2..723b1995426 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,17 +9,24 @@ git-merge-tree - Perform merge without touching index or =
working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
-'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprec=
ated)
+'git merge-tree' --write-tree [<options>] <branch1> <branch2>
+'git merge-tree' --trivial-merge <base-tree> <branch1> <branch2>
=20
+[[NEWMERGE]]
 DESCRIPTION
 -----------
=20
-Performs a merge, but does not make any new commits and does not read
-from or write to either the working tree or index.
+This command has a modern `--write-tree` mode and a deprecated
+`--trivial-merge` mode. The rest of this documentation describes
+modern `--write-tree` mode unless otherwise specified. see
+<<DEPMERGE,DEPRECATED DESCRIPTION>> below for a summary of the
+`--trivial-merge` mode.
=20
-The first form will merge the two branches, doing a real merge.  A real
-merge is distinguished from a trivial merge in that it includes:
+Performs a "real" merge, but does not make any new commits and does
+not read from or write to either the working tree or index.
+
+The performed merge will use the same feature as the "real"
+linkgit:git-merge[1], including:
=20
   * three way content merges of individual files
   * rename detection
@@ -28,24 +35,8 @@ merge is distinguished from a trivial merge in that it i=
ncludes:
     merge base, creating a virtual merge base by merging the merge bases)
   * etc.
=20
-After the merge completes, the first form will create a new toplevel
-tree object.  See `OUTPUT` below for details.
-
-The second form is deprecated; it is kept for backward compatibility
-reasons but may be deleted in the future.  Other than the optional
-`--trivial-merge`, it accepts no options.  It can only do a trivial
-merge.  It reads three tree-ish, and outputs trivial merge results and
-conflicting stages to the standard output in a semi-diff format.
-Since this was designed for higher level scripts to consume and merge
-the results back into the index, it omits entries that match
-<branch1>.  The result of this second form is similar to what
-three-way 'git read-tree -m' does, but instead of storing the results
-in the index, the command outputs the entries to the standard output.
-This form not only has limited applicability, the output format is
-also difficult to work with, and it will generally be less performant
-than the first form even on successful merges (especially if working
-in large repositories).  The remainder of this manual will only
-discuss the first form.
+After the merge completes, a newtoplevel tree object is created.  See
+`OUTPUT` below for details.
=20
 OPTIONS
 -------
@@ -54,7 +45,7 @@ OPTIONS
 	Do not quote filenames in the <Conflicted file info> section,
 	and end each filename with a NUL character rather than
 	newline.  Also begin the messages section with a NUL character
-	instead of a newline.  See OUTPUT below for more information.
+	instead of a newline.  See <<OUTPUT>> below for more information.
=20
 --name-only::
 	In the Conflicted file info section, instead of writing a list
@@ -74,11 +65,12 @@ OPTIONS
 	share no common history.  This flag can be given to override that
 	check and make the merge proceed anyway.
=20
+[[OUTPUT]]
 OUTPUT
 ------
=20
-By default, for a successful merge, the output from git-merge-tree is
-simply one line:
+For a successful merge, the output from git-merge-tree is simply one
+line:
=20
 	<OID of toplevel tree>
=20
@@ -90,6 +82,7 @@ Whereas for a conflicted merge, the output is by default =
of the form:
=20
 These are discussed individually below.
=20
+[[OIDTLT]]
 OID of toplevel tree
 ~~~~~~~~~~~~~~~~~~~~
=20
@@ -98,6 +91,7 @@ working tree at the end of `git merge`.  If there were co=
nflicts, then
 files within this tree may have embedded conflict markers.  This section
 is always followed by a newline (or NUL if `-z` is passed).
=20
+[[CFI]]
 Conflicted file info
 ~~~~~~~~~~~~~~~~~~~~
=20
@@ -111,6 +105,7 @@ the `--name-only` option is passed, the mode, object, a=
nd stage will
 be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
 character instead of a newline character.
=20
+[[IM]]
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
=20
@@ -138,72 +133,94 @@ something other than 0 or 1 (and the output is unspec=
ified).
 USAGE NOTES
 -----------
=20
-git-merge-tree was written to be low-level plumbing, similar to
-hash-object, mktree, commit-tree, write-tree, update-ref, and mktag.
-Thus, it could be used as a part of a series of steps such as
+This command is intended as low-level plumbing, similar to
+linkgit:git-hash-object[1], linkgit:git-mktree[1],
+linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
+linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
+used as a part of a series of steps such as:
=20
        NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
        test $? -eq 0 || die "There were conflicts..."
        NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
=20
-Note that when the exit status is non-zero, NEWTREE in this sequence
+Note that when the exit status is non-zero, `NEWTREE` in this sequence
 will contain a lot more output than just a tree.
=20
-git-merge-tree was written to provide users with the same information
-that they'd have access to if using `git merge`:
-  * what would be written to the working tree (the <OID of toplevel tree>)
+The output will include the same information that you'd get with
+linkgit:git-merge[1]:
+
+  * what would be written to the working tree (the <<OIDTLT,OID of topleve=
l tree>>)
   * the higher order stages that would be written to the index (the
-    <Conflicted file info>)
-  * any messages that would have been printed to stdout (the <Informational
-    messages>)
+    <<CFI,Conflicted file info>>)
+  * any messages that would have been printed to stdout (the <<IM,Informat=
ional
+    messages>>)
=20
 MISTAKES TO AVOID
 -----------------
=20
 Do NOT look through the resulting toplevel tree to try to find which
-files conflict; parse the <Conflicted file info> section instead.  Not
+files conflict; parse the <<CFI,Conflicted file info>> section instead.  N=
ot
 only would parsing an entire tree be horrendously slow in large
 repositories, there are numerous types of conflicts not representable by
 conflict markers (modify/delete, mode conflict, binary file changed on
 both sides, file/directory conflicts, various rename conflict
 permutations, etc.)
=20
-Do NOT interpret an empty <Conflicted file info> list as a clean merge;
+Do NOT interpret an empty <<CFI,Conflicted file info>> list as a clean mer=
ge;
 check the exit status.  A merge can have conflicts without having
 individual files conflict (there are a few types of directory rename
 conflicts that fall into this category, and others might also be added
 in the future).
=20
 Do NOT attempt to guess or make the user guess the conflict types from
-the <Conflicted file info> list.  The information there is insufficient
+the <<CFI,Conflicted file info>> list.  The information there is insuffici=
ent
 to do so.  For example: Rename/rename(1to2) conflicts (both sides
 renamed the same file differently) will result in three different file
 having higher order stages (but each only has one higher order stage),
-with no way (short of the <Informational messages> section) to determine
+with no way (short of the <<IM,Informational messages>> section) to determ=
ine
 which three files are related.  File/directory conflicts also result in
 a file with exactly one higher order stage.
 Possibly-involved-in-directory-rename conflicts (when
 "merge.directoryRenames" is unset or set to "conflicts") also result in
 a file with exactly one higher order stage.  In all cases, the
-<Informational messages> section has the necessary info, though it is
+<<IM,Informational messages>> section has the necessary info, though it is
 not designed to be machine parseable.
=20
-Do NOT assume all filenames listed in the <Informational messages>
+Do NOT assume all filenames listed in the <<IM,Informational messages>>
 section had conflicts.  Messages can be included for files that have no
 conflicts, such as "Auto-merging <file>".
=20
-AVOID taking the OIDS from the <Conflicted file info> and re-merging
+AVOID taking the OIDS from the <<CFI,Conflicted file info>> and re-merging
 them to present the conflicts to the user.  This will lose information.
-Instead, look up the version of the file found within the <OID of
-toplevel tree> and show that instead.  In particular, the latter will
+Instead, look up the version of the file found within the <<OIDTLT,OID of
+toplevel tree>> and show that instead.  In particular, the latter will
 have conflict markers annotated with the original branch/commit being
 merged and, if renames were involved, the original filename.  While you
 could include the original branch/commit in the conflict marker
 annotations when re-merging, the original filename is not available from
-the <Conflicted file info> and thus you would be losing information that
+the <<CFI,Conflicted file info>> and thus you would be losing information =
that
 might help the user resolve the conflict.
=20
+[[DEPMERGE]]
+DEPRECATED DESCRIPTION
+----------------------
+
+Per the <<NEWMERGE,DESCRIPTION>> and unlike the rest of this
+documentation this section describes describes the deprecated
+`--trivial-merge` mode.
+
+Reads three tree-ish, and output trivial merge results and
+conflicting stages to the standard output.  This is similar to
+what three-way 'git read-tree -m' does, but instead of storing the
+results in the index, the command outputs the entries to the
+standard output.
+
+This is meant to be used by higher level scripts to compute
+merge results outside of the index, and stuff the results back into the
+index.  For this reason, the output from the command omits
+entries that match the <branch1> tree.
+
 GIT
 ---
 Part of the linkgit:git[1] suite

