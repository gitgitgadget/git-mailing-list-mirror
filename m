Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F41C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9D760234
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbhDMK1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhDMK1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 06:27:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12942C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 03:26:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so3149125wrx.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 03:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y6iTeXfvpdmjC/tnHr2VBO0YgAZ5fklQWYLM9VMIG/k=;
        b=vfuihRUWtZCbqJSz8SxvZWjbeOOsZJzy/4pyRmGAQMKW7+FPgXVYvKLR3HAtoLIxe2
         I34hYDW4jw6J/YAkinuSJ+aA+ZPdPDKNnW5tJEH1/qZUOUy7Iel1L15iKfdgATuYAxfO
         FFDpsPItQ2nLuGyCwdWtMKbaT29nJgiwpPKq7eHo+LHMWcXcl8eS7RvZVOD8ePBSQT0d
         ADHBFi/50/PMe0Ha8kkgPBN3b1sb8PJ4QH91BVmpqP86OQyEK/HXPXjL28WplBRXIqSy
         2kIoRqu4e08ruNdK0cTtU3YG6YpMGQtW3Ne3TG84+l41DZoWrCnjDsRS4RaInaWx7X+N
         Qriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y6iTeXfvpdmjC/tnHr2VBO0YgAZ5fklQWYLM9VMIG/k=;
        b=meuzL5Z7YYscO2FgKGgZM3iNudlr/pIkQmjqCAKphjyhzyUVAqkv1Q2hoo9Jaqx2a8
         qw93FYnEVrSViEWLKiXkch89D4ZQolxOxkPVnmE2wWeWK5mA5/f1H+7r5BF0W3W6mOy6
         jPTnYI6bAdTHhNdVzrDPv1e6jmsobBJ+zv4d/yxU9molqJXZvoD2dLIS69z6Ayxk8cGw
         K+mk49egpsYv3uxZdhWfgQ+dKk6gjuyxtsjO3+EGFMP/sKbCk6mK7ccWtJTARtwRmwMt
         DA0jWkgZz6DFqXljJnlO7SfBcnfacA9YQSQAHWdj67qokABFHnSkbrqZVZb1WHh8x6ql
         V3Sg==
X-Gm-Message-State: AOAM531xFIDTDzwoNvE2gaSICD1X2knXFevxUJ86F/Q28bzW/SLdkAsn
        qBaka/ryVkTSmzKNUZHlwgs=
X-Google-Smtp-Source: ABdhPJwqSUBEVF58o4rB4eW4otBxh3uHEbvjQZtlIGD8g4C9lY2L6Lmhnd7rdUrnbxPTMDMwwuucXg==
X-Received: by 2002:adf:f692:: with SMTP id v18mr25947908wrp.206.1618309610157;
        Tue, 13 Apr 2021 03:26:50 -0700 (PDT)
Received: from Inspiron (2a01cb04010c42009496933419a25328.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:9496:9334:19a2:5328])
        by smtp.gmail.com with ESMTPSA id q20sm2402179wmq.2.2021.04.13.03.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:26:49 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, shouryashukla.oo@gmail.com,
        periperidip@gmail.com
Subject: [GSoC] Proposal: Convert Git submodule to built-in
Date:   Tue, 13 Apr 2021 12:26:46 +0200
Message-ID: <87o8eih449.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone and potential mentors,

I'm Firmin, a master student who plan applying to GSoC this year. You can f=
ind
below my proposal "Convert Git submodule to built-in". Any thought or
feedback are welcomed.

I'm sorry to send my proposal this late, but I was overwhelmed these days.

I highly recommend to read the Google docs version of my proposal as the
textual version (converted through pandoc) missed all hyperlinks,
markups and heading levels.=20

    https://docs.google.com/document/d/1321TC1Nkn-MpjvKv0VigEHRzcMIyOHO6m8d=
Msw9SCb4/edit?usp=3Dsharing

Thanks,

Firmin

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Personal Details

Contact Information

-   Name: Firmin Martin

-   Blog: https://firminmartin.com

-   Current location: Paris, France (UTC+02:00)

-   Availability: fully available starting from mid-April

-   Emails: <<email1>>, <<email2>>

-   Github: firmart

-   StackExchange: firmin-martin

Technical Background

I am Firmin Martin, a master student in Theoretical Computer Science at
=C3=89cole Normale Sup=C3=A9rieure de Lyon. My interests include mathematic=
al
logic (proof theory), formal verification and human-based computation.

My first ever programming language was C and it remains my favorite so
far. As a matter of fact, I was involved years ago in a bioinformatics
project at Institut Curie in which my task consisted of, among others,
refactoring a large portion (2k+ loc.) of a C MPI codebase and porting a
sequential Java code into a parallel MPI version. I thus developed, in
the meantime, solid debugging skills using Valgrind and GDB.

I also write shell scripts on a regular basis to satisfy my daily needs.

Programming Environment

I=E2=80=99m on a dual-boot Ubuntu 20.04/Windows 10, but work primarily on
Ubuntu. I use Emacs as my main editor and Vim in the terminal. I use Git
on a daily-basis either through git itself, the CLI utility tig or the
Emacs package Magit.

Open Source Contributions

I=E2=80=99m also a partisan of free/libre and open-source softwares, and
contribute to them regularly. That being said, my contribution to FLOSS
projects is limited to sporadic bug reports and tiny patches/PRs towards
softwares I use everyday. I also open-sourced some Emacs packages I plan
to include in the package archive in the future. Here is a short list of
my contributions to depict my interests.

-   A tiny PR to translate-shell. translate-shell coding-style has
      strongly inspired me when I wrote a cheat-sheet maker (2k+ loc. of
      pure awk) as a (now archived) hobby project.

-   Emacs packages

    -   A fix from the maintainer of Emacs Org mode based on a bug I
          reported

    -   Some packages I wrote: org-glaux, notmuch-notify,
          org-desc-initial etc.

    -   Some packages I contributed to: vuiet, mpv.el, org-krita etc.

Learning Git=E2=80=99s Design & Development Process

Despite using Git for years, I reached its codebase for the first time
in mid-March 2021. I started to learn the organization of the source
code (built-in vs. non-built-in scripts, subcommands cmd_* and more),
the test infrastructure, the internals (through the Git Pro book), etc.
It also took me a while to learn the development process of Git: e.g.
the release cycle, and peculiarly to figure out how email-based workflow
works as I was used to Github=E2=80=99s PR model and prior this time frame,
though I subscribed to some mailing lists using this workflow (Org mode,
notmuch), I didn=E2=80=99t go further than reporting bugs and suggesting
workarounds. During this period, I also had the opportunity to learn how
to polish and build a patch through some commands/options I never used
before: git rebase -i, git add -p or git pull -r. Navigating through the
commits log was also very helpful to apprehend design decisions.

Contributions to Git

+----------------------------------------------------------------------+
| user-manual.txt: assign preface an id and a title                    |
|                                                                      |
| Status: next, also see What's cooking in git.git.                    |
|                                                                      |
| git/git: fc12b6fdde47cfb5                                            |
|                                                                      |
| firmart/git: doc/assign-preface-id-and-title                         |
|                                                                      |
| Mailing list: [PATCH v2 0/1][GSoC] user-manual.txt: assign preface   |
| an id and a title                                                    |
|                                                                      |
| Abstract:                                                            |
|                                                                      |
|   Fix two warnings causing visible issues in                         |
|   Documentation/{user-manual.texi, git.info}.                        |
+----------------------------------------------------------------------+

+----------------------------------------------------------------------+
| doc: (monospace) apply CodingGuidelines on a large-scale             |
|                                                                      |
| Status: WIP                                                          |
|                                                                      |
| firmart/git: doc/apply-coding-guidelines                             |
|                                                                      |
| Mailing list: [RFC PATCH v1 00/13][GSoC] doc: (monospace) apply      |
| CodingGuidelines on a large-scale                                    |
|                                                                      |
| Abstract:                                                            |
|                                                                      |
|   Make the documentation fully compliant regarding monospace font.   |
|   It involves around 6k lines of changes made through interactive    |
|   substitutions. It probably needs to be split off in even smaller   |
|   chunks to be digestible by reviewers.                              |
+----------------------------------------------------------------------+

Project proposal: Convert submodule to builtin

Introduction

Quoting from the Pro Git book:

  =E2=80=9CGit was initially a toolkit for a version control system rather =
than
  a full user-friendly VCS, it has a number of subcommands that do
  low-level work and were designed to be chained together UNIX-style or
  called from scripts. These commands are generally referred to as Git=E2=
=80=99s
  =E2=80=98plumbing=E2=80=99 commands, while the more user-friendly command=
s are called
  =E2=80=98porcelain=E2=80=99 commands.=E2=80=9D

A lot of Git=E2=80=99s =E2=80=9Cporcelain=E2=80=9D commands stem from this =
idea and were
consequently written as shell/Perl scripts composed by Git=E2=80=99s =E2=80=
=9Cplumbing=E2=80=9D
commands and other shell utilities. Over the time, different platforms
were targeted to be supported and projects using Git have grown in size.
Portability and performance became non-negligible topics.

For instance, Git for Windows relies on a modified version of Cygwin,
called MSYS2, to run those shell scripts. They tend to have
compatibility issues due to this requirement (see the next section).

Moreover, even though subshell overheads are relatively cheap, they can
grow fastly when involved in a loop or spawn in a nested fashion. The
situation is even worse when a high-level porcelain shell command calls
another one. Hopefully, since the very beginning, it was a common
practice to make mature shell commands built-in to avoid this concern.

To see the evolution of this process, one can easily make the following
table indicating the date and the commit of popular commands made
built-in thanks to git naming consistency. Though some of them are born
built-in, the majority was first implemented as shell/Perl or even Tcl
scripts[1].

Legend.

-   <date>: date of the command turning built-in.

-   builtin (<date>): the command is implemented directly as built-in in
      the given date.

-   ongoing (<patch>): there is an active process to turn the command
      built-in.

+----------+----------+----------+----------+----------+----------+
| Command  | Date     | Commit   | Command  | Date     | Commit   |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| add      | 20       | c6       | mai      | builtin  | 20       |
|          | 16-05-17 | 99f9b924 | ntenance |          | 57d75038 |
|          |          |          |          | (202     |          |
|          |          |          |          | 0-09-17) |          |
+----------+----------+----------+----------+----------+----------+
| am       | 20       | 78       | merge    | 20       | 1c       |
|          | 15-08-04 | 3d7e865e |          | 08-07-07 | 7b76be7d |
+----------+----------+----------+----------+----------+----------+
| archive  | builtin  | 4d       | mv       | 20       | 11       |
|          |          | f096a5ca |          | 06-06-26 | be42a476 |
|          | (200     |          |          |          |          |
|          | 6-09-07) |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| bisect   | ongoing  | N/A      | notes    | 20       | cd       |
|          |          |          |          | 10-02-13 | 067d3bf4 |
|          | (last    |          |          |          |          |
|          | patch)   |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| branch   | 20       | c3       | pull     | 20       | b1       |
|          | 06-10-23 | 1820c26b |          | 15-06-18 | 456605c2 |
+----------+----------+----------+----------+----------+----------+
| bundle   | builtin  | 2e       | push     | 20       | ec       |
|          |          | 0afafebd |          | 06-08-02 | 19a22b74 |
|          | (200     |          |          |          |          |
|          | 7-02-22) |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| checkout | 20       | 78       | ra       | builtin  | 34       |
|          | 08-02-07 | 2c2d65c2 | nge-diff |          | 8ae56cb2 |
|          |          |          |          | (202     |          |
|          |          |          |          | 0-09-17) |          |
+----------+----------+----------+----------+----------+----------+
| che      | 20       | 95       | rebase   | 20       | d0       |
| rry-pick | 07-03-01 | 09af686b |          | 19-03-18 | 3ebd411c |
+----------+----------+----------+----------+----------+----------+
| clean    | 20       | 11       | reset    | 20       | 0e       |
|          | 07-11-11 | 3f10f22f |          | 07-09-11 | 5a7faa3a |
+----------+----------+----------+----------+----------+----------+
| clone    | 20       | 84       | restore  | builtin  | 46       |
|          | 08-04-27 | 34c2f1af |          | (201     | e91b663b |
|          |          |          |          | 9-04-25) |          |
+----------+----------+----------+----------+----------+----------+
| commit   | 20       | f5       | revert   | 20       | 95       |
|          | 07-11-08 | bbc3225c |          | 07-03-01 | 09af686b |
+----------+----------+----------+----------+----------+----------+
| describe | 20       | 9a       | rm       | 20       | d9       |
|          | 07-01-10 | 0eaf83ea |          | 06-05-19 | b814cc97 |
+----------+----------+----------+----------+----------+----------+
| diff     | 20       | 8a       | shortlog | 20       | b8       |
|          | 06-05-01 | b99476ec |          | 06-11-19 | ec59234b |
+----------+----------+----------+----------+----------+----------+
| difftool | 20       | 01       | show     | 20       | ba       |
|          | 17-01-19 | 9678d6b1 |          | 06-04-15 | 1d45051e |
+----------+----------+----------+----------+----------+----------+
| fetch    | 20       | b8       | sparse-  | builtin  | 94       |
|          | 07-09-10 | 88d61c83 | checkout |          | c0956b60 |
|          |          |          |          | (201     |          |
|          |          |          |          | 9-11-21) |          |
+----------+----------+----------+----------+----------+----------+
| form     | 20       | 68       | stash    | 20       | 40       |
| at-patch | 06-05-21 | 5637381a |          | 19-02-25 | af146834 |
+----------+----------+----------+----------+----------+----------+
| gc       | 20       | 67       | status   | 20       | f5       |
|          | 07-03-13 | 57ada403 |          | 07-11-08 | bbc3225c |
+----------+----------+----------+----------+----------+----------+
| grep     | 20       | 63       | s        | ongoing  | N/A      |
|          | 06-05-16 | dffdf03d | ubmodule |          |          |
|          |          |          |          | (last    |          |
|          |          |          |          | patch)   |          |
+----------+----------+----------+----------+----------+----------+
| init     | builtin  | e8       | switch   | builtin  | d7       |
|          |          | 3c516331 |          |          | 87d311db |
|          | (200     |          |          | (201     |          |
|          | 5-04-07) |          |          | 9-03-29) |          |
+----------+----------+----------+----------+----------+----------+
| log      | 20       | e3       | tag      | 20       | 62       |
|          | 06-04-14 | a125a94d |          | 07-07-20 | e09ce998 |
+----------+----------+----------+----------+----------+----------+
|          | worktree | builtin  | df       |          |          |
|          |          |          | 0b6cfbda |          |          |
|          |          | (201     |          |          |          |
|          |          | 5-01-29) |          |          |          |
+----------+----------+----------+----------+----------+----------+

Additionally, per a mail from Johannes Schindelin, in which he stated
the current conversion process of remaining scripts, we can further note
the following scripts=E2=80=99 conversion status (with my personal adaptati=
on).

+----------------+----------------+----------------+----------------+
| Scripts        | Status         | Scripts        | Status         |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| git-difft      | Candidates for | git-fi         | Deprecated     |
| ool--helper.sh | being          | lter-branch.sh |                |
|                | converted      |                |                |
| git-mer        |                | gi             |                |
| getool--lib.sh |                | t-rebase--pres |                |
|                |                | erve-merges.sh |                |
| gi             |                |                |                |
| t-mergetool.sh |                |                |                |
|                |                |                |                |
| git-me         |                |                |                |
| rge-octopus.sh |                |                |                |
|                |                |                |                |
| git-mer        |                |                |                |
| ge-one-file.sh |                |                |                |
|                |                |                |                |
| git-me         |                |                |                |
| rge-resolve.sh |                |                |                |
+----------------+----------------+----------------+----------------+
| git-           | Support for    | g              | Too complex or |
| quiltimport.sh | legacy[3] SCMs | it-instaweb.sh |                |
|                |                |                | too many       |
| git-a          |                | git-r          | dependencies   |
| rchimport.perl |                | equest-pull.sh |                |
|                |                |                |                |
| git-cvsexp     |                | git-           |                |
| ortcommit.perl |                | web--browse.sh |                |
|                |                |                |                |
| git-           |                | git-s          |                |
| cvsimport.perl |                | end-email.perl |                |
|                |                |                |                |
| git-           |                | git-svn.perl   |                |
| cvsserver.perl |                |                |                |
|                |                | git-add--in    |                |
|                |                | teractive.perl |                |
+----------------+----------------+----------------+----------------+

 Summary

The goal of this GSoC project is to finish the ongoing conversion
(started in 2015) of the submodule=E2=80=99s commands from shell script int=
o C
and totally get rid of the file git-submodule.sh. The file
submodule--helper.c will henceforth be renamed to submodule.c. The
benefit to doing so is not only performance-wise, but also
compatibility-wise. A quote from Johannes Schindelin, the maintainer of
Git for Windows, could explain this well:

  =E2=80=9CSince git submodule is still implemented as a Unix shell script =
(and
  traditionally, there have been tons of issues with that due to the
  need to use a derivative of Cygwin to interpret such scripts) [...]=E2=80=
=9D

Previous Works

-   During 2015-2019, Stefan Beller has worked on the conversion of the
      update command, has finished the conversion of the init command
      and has ported multiple helper functions in C (module_list,
      resolve_relative_url, update-module-mode etc.). He has also
      written in C the absorbgitdirs command.

-   Prathamesh Chavan (GSoC 2017) has finished the conversion of the
      foreach, deinit, sync and status commands and has ported the
      helper function set_name_rev in C. He has also worked on an early
      version of the command add on which Shourya Shukla was based
      later.

-   Shourya Shukla (GSoC 2020) has finished the conversion of set-url
      and set-branch commands. He also continued and finished Chavan=E2=80=
=99s
      work on the summary (patch) command. His patch on the conversion
      of the add command is currently at version 3, but staled since
      then.

Conversion Status of Submodule=E2=80=99s Subcommands

Most of the submodule=E2=80=99s subcommands (set-branch, set-url, summary,
status, init, deinit, foreach and sync) have only the options left to
parse. As for absorbgitdirs, it was written fully in C by Stefan Beller
since the beginning.

Consequently, the remaining tasks are the conversion of the update and
add subcommands which have both 160 loc. involving essentially Git=E2=80=99s
plumbing, branching plus some basic filtering with sed and grep besides
the options left to parse. The conversion of the add subcommand has a
long-standing history (see previous works).

Correspondence Between Submodule=E2=80=99s Shell and C Code

To better understand how the conversion would work and how the converted
code would look, one should examine the components constituting a
submodule=E2=80=99s subcommand in shell and C respectively.

-   A submodule=E2=80=99s subcommand in shell corresponds simply to

    -   An entry point function cmd_<subcommand> (e.g. cmd_add) which
          handles options parsing, performs business logic with the
          assistance of helper functions and Git=E2=80=99s plumbing.

    -   Several helper functions such as sanitize_submodule_env which
          essentially unset all Git=E2=80=99s environment variables of a
          repository except GIT_CONFIG_PARAMETERS.

-   On the other hand, a submodule=E2=80=99s subcommand in C is more struct=
ural.
      It corresponds to

    -   A =E2=80=9Cprincipal=E2=80=9D function <subcommand>_submodule (e.g.
          init_submodule) which performs the essential business logic.
          It has at least three parameters: path, prefix and flags
          coming from the subcommand=E2=80=99s entry point (see below).

    -   A facultative callback function <subcommand>_submodule_cb (e.g.
          init_submodule_cb) serving as an argument of the higher-order
          function for_each_listed_submodule which applies the callback
          function on a list of submodules one by one. The callback
          functions are essentially wrappers of the subcommand=E2=80=99s
          =E2=80=9Cprincipal=E2=80=9D function except that they have a unif=
orm signature
          (precisely, the type each_submodule_fn).

    -   A facultative[4] callback structure <subcommand>_cb (e.g.
          init_cb), initialized by the macro <SUBCOMMAND>_CB_INIT (e.g.
          INIT_CB_INIT), storing option values and flags to serve as an
          argument of for_each_listed_submodule and the callback
          function. This structure is necessary to keep the uniform
          signature of the callback function: it packs together some
          arguments which feed the =E2=80=9Cprincipal=E2=80=9D function.

    -   An entry point function module_<subcommand>[5] (e.g.
          module_init) which parses options, handles flags and
          eventually calls for_each_listed_submodule along with the
          callback function and structure on a list of submodules.

    -   A registration of the subcommand in the structure commands and
          indication whether the subcommand supports --super-prefix.

    -   Several helper functions: either subcommand-specific (e.g.
          print_status is uniquely dedicated to the status subcommand)
          or with general purpose (e.g. revision name retrieval:
          compute_rev_name; URL computation: relative_url,
          chop_last_dir; string manipulation: starts_with_dot_dot_slash
          etc.)

Proposed Timeline

Present - 17 May: warm-up

While waiting for the announcement of the selected student, I would want
to be more involved in the Git=E2=80=99s development & submission process, =
as I
would be fully available starting from mid-April. This would start by
discussing in the mailing-list some RFCs I have in mind, not necessarily
directly related to submodules (as it is reserved to the selected
student), e.g.

-   Address the =E2=80=9CNEEDSWORK=E2=80=9D in path.c::normalize_path_copy_=
len. This can
      be proved useful in the next phase while dealing with the path
      normalization (multiple trailing slashes) occurred in cmd_add.
      This point was discussed in Shourya Shukla last patch's cover
      letter.

-   Improve git add -p user interface -- fix corrupt patch line number,
      paginate diff hunks, and change behaviour of SIGINT in the
      interactive process -- and trying to reproduce an issue I faced,
      namely =E2=80=9Cgit add -p restarts itself after selecting the last d=
iff
      hunk=E2=80=9D and figure out a solution.

-   See whether there is room for improvement regarding git format-patch
      --cover-letter which overwrites existing cover-letter having the
      same name. Could we just replace the diff statistics of the old
      cover letter, and keep its title and content ? Or alternatively,
      create a new cover letter whose filename is suffixed by =E2=80=9C~=E2=
=80=9D or =E2=80=9C_=E2=80=9D
      ? These are the questions that need to be answered.

-   Adding a =E2=80=9Csubcommand=E2=80=9D entry in Git=E2=80=99s glossary. =
E.g. submodule is a
      Git=E2=80=99s subcommand, add is a submodule=E2=80=99s subcommand.

-   Finish the work-in-progress patch series which aims to make the
      documentation fully compliant regarding monospaced font (see
      Contributions to Git).

May 17 - June 7: community bonding

I will use this three weeks time frame to familiarize myself with the
codebase and make a series of trivials yet useful patches (as depicted
below) to present a slightly polished version to the community in hope
to obtain feedback in an early stage and not miss out important
mistakes. In the end, it would help to have a better estimation of the
schedule with mentors. More concretely, that could be translated as
follows.

-   Study the last patch of Shourya Shukla and available routines in
      submodule.c and builtin/submodule--helper.c.

-   See if there is any portion of code in his patch which could be
      reused to

-   Port shell helper functions: especially sanitize_submodule_env which
      appears numerous times, but also its by-products is_tip_reachable
      and fetch_in_submodule.

-   Port the basic filtering using sane_grep and sed occurring in
      cmd_add (e.g. path normalization). As stated in the previous
      section, the function path.c::normalize_path_copy_len once fixed
      could be proved useful.

-   Find out present issues in his patch (e.g. potential memory leak in
      string manipulation) and incorporate feedback to the patch.

-   Study and update present tests to cover new code.

-   Port set-branch, set-url, summary, status, init, deinit, foreach and
      sync options parsing into builtin/submodule--helper.c so that they
      merely become wrapper of their C counterparts (i.e. exactly the
      current status of the absorbgitdirs command).

-   Submit the slightly improved version (RFC) of Shourya Shukla's patch
      incorporating above considerations (split off in multiple commits)
      along with a summary of the patch status. Having a first round of
      review in an early stage would help to detect important mistakes
      requiring to be taken into consideration.

-   Discuss with mentors to rearrange the schedule if necessary.

June 7 - July 12: porting the add subcommand & mid-term evaluation (5 weeks)

I would want to start tackling the add subcommand as I believe its
long-standing conversion was due to its low priority (it was in Chavan
proposal=E2=80=99s wishlist and in Shukla proposal=E2=80=99s last phase). A=
t this stage,
based on the previous phase=E2=80=99s investigation and first round of revi=
ew,
it would be clear what pieces are missing.

Also, as Prathamesh Chavan=E2=80=99s weekly summaries suggest (12th, 13th a=
nd
14th), he took more than two weeks to deal with failed tests as the
invocation of the subcommand add is widely present in the tests (137
instances[6] among 53 test files[7]). I would expect to spend a fair
amount of time dealing with them too.

July 12 - August 2: porting the update subcommand (3 weeks)

As Philippe Blain pointed out on Github, it would be better to start
converting the update command after having acquired enough insight
regarding git submodules. That is why I place it right after the port of
the add command. I allocate 3 weeks to deal with it as it is mainly
constituted of business logic involving built-in function calls. This
being said, I will be peculiarly cautious as bugs could emerge
unexpectedly.

August 2 - August 16: buffering phase

This period will serve as a buffering phase.

-   If everything goes well, the remaining part of git-submodule.sh will
      be converted at this phase.

-   This stage will also be the time for polishing, testing and
      debugging. Without being too optimistic and considering past years
      students' schedules, there would still be bugs lurking around at
      this phase.

-   If the submit process goes faster than expected, I will use the
      remaining time to tackle some of the numerous NEEDSWORK in
      submodule.c (three in total) and builtin/submodule--helper.c (five
      in total).

Weekly Blogpost=20

I commit myself to writing a blog post each week on my blog to allow
mentors and other contributors keep tracking of my progress. I felt that
Shukla=E2=80=99s blog has provided valuable insight at the moment of this
document being written, and according to Shukla=E2=80=99s words, Matheus
Tavares=E2=80=99 blog (GSoC 2019) has in turn somehow inspired him. I hope I
could do the same for future GSoC applicants and keep this great
tradition.

Regarding the Review Process

As pointed out by Junio C. Hamano, converting a subcommand in a single
patch makes the review process harder than it should be. I suggest
gradually converting portions of the shell script into multiple C
internal helping commands and commit them separately while keeping the
code functionality. Doing so, it would be easier to locate the removed
shell code and compare it to the converted C code. This is actually what
Stefan Beller has done when converting a part of the update command. In
the last patch of Shourya Shukla, once everything is satisfying enough
(e.g. no memory leak), the commits could be squashed and the helper
functions could be merged if needed.

I also plan to send a weekly summary in the mailing list to present the
ongoing progress and challenge. When things become mature enough, I will
also attach the whole patch series to the summary (exactly as Prathamesh
Chavan did from week 5).

Epilogue

I unfortunately started late and did not have the opportunity to
contribute to code-related patches being overwhelmed (see contributions
to Git). But, to be fair, the amount of things I learned during this
period through the mailing list, the commits log, the documentation or
the codebase is absolutely stunning.

As discussed at the beginning of this document, I have the habit of
contributing to open source softwares I=E2=80=99m using on a regular basis.=
 It
seems the bottleneck of contributing to Git was the lack of
understanding on the mail-based workflow, a thing that I happily
overcomed. From now on, I would be able to contribute to more
open-source projects I benefit from (e.g. Emacs, Org-mode, notmuch
etc.). And of course, the adventure with Git has just started!

References

Proposals

-   Johannes Schindelin's description of the project on Git for Windows=E2=
=80=99
      issue tracker

-   Shourya Shukla's GSoC 2020 proposal

-   Prathamesh Chavan's GSoC 2017 proposal

Final Reports

-   Prathamesh Chavan's final report

-   Shourya Shukla's final report

Last Patch Series

-   Stefan Beller's partial port of the subcommand update (including
      implementation of the helper function update_module_mode)

-   Stefan Beller's port of helper functions: module_list, module_name
      and module_clone

-   Prathamesh Chavan's port of the status subcommand and introduction
      of get_submodule_displaypath and for_each_listed_submodule

-   Prathamesh Chavan's port of the foreach subcommand

-   Prathamesh Chavan's port of the sync and deinit subcommand

-   Shourya Shukla's port of the set-branch subcommand

-   Shourya Shukla=E2=80=99s port of the set-url subcommand

-   Shourya Shukla's port on the summary subcommand

-   Shourya Shukla=E2=80=99s last patch on the port of the add subcommand

Documentations

-   Git Tools - Submodules from the Pro Git book

-   Git=E2=80=99s man pages: gitsubmodules, git-submodule and gitmodules

GSoC Weekly Summary

-   Shourya Shukla's Blog

-   Prathamesh Chavan's weekly summary and patch series

[1] See gitk-git/gitk and git-gui/git-gui.sh

[2] That being said, quilt last release was from 2019.

[3] That being said, quilt last release was from 2019.

[4] Relevant if a callback function is required by the subcommand.

[5] It does basically the same thing as cmd_<git-subcommand> functions
(e.g. cmd_commit) except that the prefix module_ is a convention
suggesting it=E2=80=99s a subcommand of a Git=E2=80=99s subcommand (i.e. in=
 our context
a submodule=E2=80=99s subcommand).

[6] grep -R 'git submodule add' | wc -l

[7] grep -Rl 'git submodule add' | sort | uniq | wc -l
