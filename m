Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C0FC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B104260F3A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhH3Vfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhH3Vfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2722C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso727274wmj.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iqNPTV9ojkFIkuXB4c8bqY7SaJWOXS1TRXZbUqZe6VU=;
        b=gs0tmDMdSXWwrFh0VPw33ILGsJTUU/M8w/shyFqkKIoNZ4qiKyVgmmmN1QpTv32JlM
         xS5dNSydmvgGCSd5ac6Gwd6CpcuPaX5WNBj8LWwMlo+soz2obVy6ZFXEUKy/C7dHm0xT
         9dl2pJkgepGjnObrXg/O7fr3GpKbjZwrHHE9DpxlR25SJHgn7v+YL6UMcYzID/3mmg3W
         n01J4O/ulZv82C65WKxQZhnwKWdQAobbFdgxV+jbXQVTSkzJyxt12SJLPbddy8XWuvAx
         GUPOBgMdrbZaCo/jQUHC9ND6OTzqvYDhH4m9tkP7ithwwtd91DDNDxE0642BzQBfmb7Y
         JLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iqNPTV9ojkFIkuXB4c8bqY7SaJWOXS1TRXZbUqZe6VU=;
        b=rEcFcyPyJE6EvjzoWSyzkFEDZIZowuVFyzYsGwzdgaLU4KjuJCRFsjx+FLNWClZLWU
         n3qFCOCOFgEITC0o0ihEldXi/NCrePFm/A7uUwTZ93+C5UiyJUYH9kFQIMWmORh5pOaj
         9uOFe7Mk15FBPkNGrFKxxEBpXXDGmZ9/u/j1qJS7frsnrzdevfVE8a0jJp7SoRGi8DWP
         qoEyHxlvf3zY6deILQQr0z1cOZfx9ejBVI4E8FLti8ZXEz7c/5QAYn/pD7LKTpfzwYBA
         ddyAHykiDLDHdy0LgSrbH80LJa0tKKvlSBaxs2lV8RBIgIAzZeRsfI3C46E+hJ2Dr8BD
         adCA==
X-Gm-Message-State: AOAM531oke1q6c4cIyUsHTN+VK+ZrM+crpkDCM7F7ch9ZTGgBm4EBRh4
        FniFmMubT7vtG2byCuKOgihsJbqEJSI=
X-Google-Smtp-Source: ABdhPJzdnH7nOPLeZxbEy4xVkNot0521EmAHFG15C4abKPFBu1AxFUCrSm3t+ELdcMu7j+Nfc18FTg==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr933347wmj.163.1630359291299;
        Mon, 30 Aug 2021 14:34:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21sm592165wmh.31.2021.08.30.14.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:51 -0700 (PDT)
Message-Id: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:35 +0000
Subject: [PATCH 00/15] [RFC] Upstreaming the Scalar command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr: This series contributes the Scalar command to the Git project. This
command provides an opinionated way to create and configure repositories
with a focus on very large repositories.


Background
==========

Years ago, Microsoft wanted to move the source code of the Windows operating
system to Git. The challenge there was to prove that Git could scale to
massive monorepos. The VFS for Git (formerly GVFS) project was born to take
up that challenge.

The final solution included a virtual filesystem (with both user-mode and
kernel components) and a customized fork of Git for Windows. This solution
contained several key concepts, such as only populating a portion of the
working directory, demand-fetching blobs, and performing periodic repo
maintenance in the background. However, the required kernel drivers made it
difficult to port the solution to other platforms.

But it was realized that many of these key concepts were independent of the
actual VFS and its projection of the working directory. The Scalar project
was created to make that separation, refine the key concepts, and then
extract those features into the new Scalar command.


The present
===========

The Scalar project provides a completely functional non-virtual experience
for monorepos. But why stop there. The Scalar project was designed to be a
self-destructing vehicle to allow those key concepts to be moved into core
Git itself for the benefit of all. For example, partial clone,
sparse-checkout, and background maintenance have already been upstreamed and
removed from Scalar proper. This patch series provides a C-based
implementation of the final remaining portions of the Scalar command. This
will make it easier for users to experiment with the Scalar command. It will
also make it substantially easier to experiment with moving functionality
from Scalar into core Git, while maintaining backwards-compatibility for
existing Scalar users.

The C-based Scalar has been shipped to Scalar users, and can be tested by
any interested reader:
https://github.com/microsoft/git/releases/tag/v2.33.0.vfs.0.0 (it offers a
Git for Windows installer, a macOS package and an Ubuntu package).


Opportunities
=============

Apart from providing the Scalar command, this contribution is intended to
serve as a basis for further mailing list discussions on moving (some of)
these key concepts into the main Git commands.

For example, we previously discussed the idea of a "git big-clone" that does
much of what "scalar clone" is doing. This patch series is a step to make
such functionality exist in the Git code base while we simmer on what such a
"git big-clone" command-line interface would look like.

This is one of many possible ways to do this. Creating a 'git big-clone'
could lock Git into backwards compatibility concerns so it is necessary to
approach such an endeavor with caution. As a discussion starter, the scalar
clone <url> command does roughly this:

 1. git clone --sparse --filter=blob:none /src
 2. git -C /src sparse-checkout init --cone
 3. git -C /src config (many times)
 4. git -C /src maintenance start

It is my hope inspire discussions about what parts of Scalar could go into
core Git, and where, and in which form. While we wish to maintain
backwards-compatibility of Scalar's command-line interface (because it is
already in use), by having the Scalar code in the same code base as Git's,
it will be much easier to move functionality without having to maintain
loose version coupling between independently-versioned Scalar and Git. The
tight version-coupling, along with having access to libgit.a also allows the
C-based implementation of Scalar to be much smaller than the original .NET
version.

For example, we might choose in the future to implement, say, git clone
--scale=partial,cone to initialize a partial clone with a cone-sparse
checkout, that would not only be totally doable, and not only would we
already have precedent and data to prove that this actually makes engineers
happy who have to work on ginormous repositories, but we could then also
implement it by moving parts of contrib/scalar/ to builtin/ (where
contrib/scalar/ would then call the built-ins accordingly rather than
hard-coding the defaults itself).

We now also have the opportunity to discuss the merits of Scalar's clone
caching, which is not actually part of this patch series because it is a bit
coupled with the GVFS parts of microsoft/git for the moment, where clones
automatically get registered with a populated alternate repository that is
identified by the URL, meaning: subsequent clones of the same repository are
vastly faster than the first one because they do not actually download the
already-received objects again, they access the cache instead.

Another thing that I could imagine to be discussed at length is the
distinction between enlistment and worktree (where the latter is the actual
Git worktree and usually lives in the src/ subdirectory of the former). This
encourages untracked and ignored files to be placed outside the worktree,
making Git's job much easier. This idea, too, might find its way in one way
or another into Git proper.

These are just a few concepts in Scalar that do not yet have equivalents in
Git. By putting this initial implementation into contrib/, we create a
foundation for future discussions of these concepts.

We plan on updating the recommended config settings in scalar register as
new Git features are available (such as builtin FSMonitor and sparse-index,
when ready). To facilitate upgrading existing Scalar enlistments, their
paths are automatically added to the [scalar] section of the global Git
config, and the scalar reconfigure --all command will process all of them.


Epilogue
========

Now, to address some questions that I imagine every reader has who made it
this far:

 * Why not put the Scalar functionality directly into a built-in? Creating a
   Git builtin requires scrutiny over every aspect of the feature, which is
   difficult to do while also maintaining the command-line interface
   contract and expected behavior of the Scalar command (there are existing
   users, after all). By having the Scalar command in contrib/, we present a
   simple option for users to have these features in the short term while
   the Git contributor community decides which bits to absorb into Git
   built-ins.
 * Why implement the Scalar command in the Git codebase? We ported Scalar to
   the microsoft/git fork for several reasons. First, we realized it was
   possible now that the core features exist inside Git itself. Second,
   compiling Scalar directly within a version of Git allows us to remove a
   version compatibility check from each config option that might or might
   not apply based on the installed Git version. Finally, this new location
   has greatly simplified our release process and the installation process
   for users. We now have ways to install Scalar with microsoft/git via
   winget, brew, and apt-get. This has been the case since we shipped
   v2.32.0 to our users, read: this setup has served us well already.
 * Why contribute Scalar to the Git project? We are biased, of course, yet
   we do have evidence that the Scalar command is a helpful tool that offers
   an simple way to handle huge repositories with ease. By contributing it
   to the core Git project, we are able to share it with more users,
   especially some users who do not want to install the microsoft/git fork.
   We intend to include Scalar as a component in git-for-windows/git, but
   are contributing it here first. Further, we think there is benefit to the
   Git developer community as this presents an example of how to set certain
   defaults that work for large repositories.
 * Does this integrate with the built-in FSMonitor yet? No, not yet. I do
   have a couple of add-on patch series lined up, one of them being the
   integration with the built-in FSMonitor, which obviously has to wait
   until the FSMonitor patch series advances further.

Derrick Stolee (4):
  scalar: 'register' sets recommended config and starts maintenance
  scalar: 'unregister' stops background maintenance
  scalar: implement 'scalar list'
  scalar: implement the `run` command

Johannes Schindelin (10):
  scalar: create a rudimentary executable
  scalar: start documenting the command
  scalar: create test infrastructure
  scalar: let 'unregister' handle a deleted enlistment directory
    gracefully
  scalar: implement the `clone` subcommand
  scalar: teach 'clone' to support the --single-branch option
  scalar: allow reconfiguring an existing enlistment
  scalar: teach 'reconfigure' to optionally handle all registered
    enlistments
  scalar: implement the `version` command
  scalar: accept -C and -c options before the subcommand

Matthew John Cheetham (1):
  scalar: implement the `delete` command

 Makefile                         |   8 +
 contrib/scalar/.gitignore        |   5 +
 contrib/scalar/Makefile          |  57 +++
 contrib/scalar/scalar.c          | 844 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        | 152 ++++++
 contrib/scalar/t/Makefile        |  78 +++
 contrib/scalar/t/t9099-scalar.sh |  88 ++++
 7 files changed, 1232 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1005
-- 
gitgitgadget
