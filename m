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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FACCC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774036069E
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350173AbhICRzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350155AbhICRzv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F8C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v10so9297575wrd.4
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gXezc2629+ho8RHqHq46InoL4gRn8pinz6CpdFiZeIw=;
        b=k7wW3cZhJfPtG6MzGD1NKfDQqqA3G95XTy8SyD+6NMjhmMDkyhKxzLkkbwDsgTmzkI
         rQL0EMH/DeXA4tiQpUXmw3hSuqmorVzaRLg3r3UtB+cXhpxIegVVV0jP7iMHfc1BL/ka
         AGIiPIULkEhf1uWHgP2MVBGEREgXz6VKI0Eu+EF+OxSq6zv8ZntbTwCsafPUkRiIm195
         FMkAKApcBmji+G0VSuXSHbeV0KE8ZaX0trEzXLs1adp/zRlqwUgaZ13GShTJwWi1Undu
         k7Uo+frED8P0q37As5guyxmgNkklLcjmrm1lSuW+y8wk3BQrXt8kDZmnjKRhYgENTfy6
         jtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gXezc2629+ho8RHqHq46InoL4gRn8pinz6CpdFiZeIw=;
        b=irosxZsyIHzVGsr5GGa16Zcx6qxuE25hiHqpmHtAZ93N5pE+Sgrye17FVB9UJS9ovS
         g3/N/S+lbAf4OkvEUILjLDRuSSd5OmqrYbzDe20/v2FUR+90KHfubHOiWGxZ+5lk3eoa
         8z1ransPiYdFf+Qbvhv0Tua2is+PMAfW3PAwxLcZ//UT5Sfr9HnHgNYYslPRn2QL1RBR
         Lrl9x/th5nwQPR+BoLbfwcb9s3SXSLnyucKCBAQahWava+Ek3LlEfRgqKQMosoRhK9Mm
         v0J0pgoXYp6bQyxP7OBtpsidIMaM1TL4D8oNLICYO6/s+DOrz8v8DEteZE9vMvNOhZVT
         KqRg==
X-Gm-Message-State: AOAM530daawX0NiQYPlZ8Jwi5PMeT0qM1aSuEghj81oQcCo5cHyPBPRB
        UzEBy1GtvnOtbi9VPq0b4ZUzjqAjeBM=
X-Google-Smtp-Source: ABdhPJx8X+Vb0UkTLo6pDby1ZcGE4GPS6jdmFww33j3rK4Wkds1Call6jIpANGuvYRkxC/aDOUeyhw==
X-Received: by 2002:adf:c3c9:: with SMTP id d9mr277851wrg.339.1630691689375;
        Fri, 03 Sep 2021 10:54:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm5581186wrh.66.2021.09.03.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:48 -0700 (PDT)
Message-Id: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:32 +0000
Subject: [PATCH v2 00/15] [RFC] Upstreaming the Scalar command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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

Changes since v1:

 * A couple typos were fixed
 * The code parsing the output of ls-remote was made more readable
 * The indentation used in scalar.txt now consistently uses tabs
 * We no longer hard-code core.bare = false when registering with Scalar

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
 contrib/scalar/scalar.txt        | 156 ++++++
 contrib/scalar/t/Makefile        |  78 +++
 contrib/scalar/t/t9099-scalar.sh |  88 ++++
 7 files changed, 1236 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1005

Range-diff vs v1:

  1:  b8c7d3f8450 =  1:  b8c7d3f8450 scalar: create a rudimentary executable
  2:  4f886575dcf =  2:  4f886575dcf scalar: start documenting the command
  3:  bcfde9bc765 =  3:  bcfde9bc765 scalar: create test infrastructure
  4:  3786f4c597f !  4:  ee3e26a0c4e scalar: 'register' sets recommended config and starts maintenance
     @@ contrib/scalar/scalar.c
      +		 */
      +		{ "core.untrackedCache", "false" },
      +#endif
     -+		{ "core.bare", "false" },
      +		{ "core.logAllRefUpdates", "true" },
      +		{ "credential.https://dev.azure.com.useHttpPath", "true" },
      +		{ "credential.validate", "false" }, /* GCM4W-only */
     @@ contrib/scalar/scalar.txt: will be identical to the worktree.
      +~~~~~~~~
      +
      +register [<enlistment>]::
     -+    Adds the enlistment's repository to the list of registered repositories
     -+    and starts background maintenance. If `<enlistment>` is not provided,
     -+    then the enlistment associated with the current working directory is
     -+    registered.
     ++	Adds the enlistment's repository to the list of registered repositories
     ++	and starts background maintenance. If `<enlistment>` is not provided,
     ++	then the enlistment associated with the current working directory is
     ++	registered.
     +++
     ++Note: when this subcommand is called in a worktree that is called `src/`, its
     ++parent directory is considered to be the Scalar enlistment. If the worktree is
     ++_not_ called `src/`, it itself will be considered to be the Scalar enlistment.
      +
       SEE ALSO
       --------
  5:  2a6ac170e6b !  5:  6142f75875b scalar: 'unregister' stops background maintenance
     @@ contrib/scalar/scalar.txt: SYNOPSIS
       
       DESCRIPTION
       -----------
     -@@ contrib/scalar/scalar.txt: register [<enlistment>]::
     -     then the enlistment associated with the current working directory is
     -     registered.
     +@@ contrib/scalar/scalar.txt: Note: when this subcommand is called in a worktree that is called `src/`, its
     + parent directory is considered to be the Scalar enlistment. If the worktree is
     + _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
       
      +Unregister
      +~~~~~~~~~~
      +
      +unregister [<enlistment>]::
     -+    Remove the specified repository from the list of repositories
     -+    registered with Scalar and stop the scheduled background maintenance.
     ++	Remove the specified repository from the list of repositories
     ++	registered with Scalar and stop the scheduled background maintenance.
      +
       SEE ALSO
       --------
  6:  087fc9be194 =  6:  82dd253154f scalar: let 'unregister' handle a deleted enlistment directory gracefully
  7:  c272ff4069d !  7:  fb7c931ddb3 scalar: implement 'scalar list'
     @@ contrib/scalar/scalar.txt: an existing Git worktree with Scalar whose name is no
      +~~~~
      +
      +list::
     -+    To see which repositories are currently registered by the service, run
     -+    `scalar list`. This subcommand does not need to be run inside a Scalar
     -+    enlistment.
     ++	To see which repositories are currently registered by the service, run
     ++	`scalar list`. This subcommand does not need to be run inside a Scalar
     ++	enlistment.
      +
       Register
       ~~~~~~~~
  8:  2cbf0b61113 !  8:  f3223c10788 scalar: implement the `clone` subcommand
     @@ Commit message
          experience and experiments of the Microsoft Windows and the Microsoft
          Office development teams.
      
     -    Note: We intentionally use a slightly wasteful `set_config()` function
     -    (which does not reuse a single `strbuf`, for example, though performance
     -    _really_ does not matter here) for convenience and readability.
     -
     -    Also note: since the `scalar clone` command is by far the most commonly
     +    Note: since the `scalar clone` command is by far the most commonly
          called `scalar` subcommand, we document it at the top of the manual
          page.
      
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      +
      +	cp.git_cmd = 1;
      +	strvec_pushl(&cp.args, "ls-remote", "--symref", url, "HEAD", NULL);
     -+	strbuf_addstr(&out, "-\n");
      +	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
     -+		char *ref = out.buf;
     -+
     -+		while ((ref = strstr(ref + 1, "\nref: "))) {
     -+			const char *p;
     -+			char *head, *branch;
     ++		const char *line = out.buf;
      +
     -+			ref += strlen("\nref: ");
     -+			head = strstr(ref, "\tHEAD");
     ++		while (*line) {
     ++			const char *eol = strchrnul(line, '\n'), *p;
     ++			size_t len = eol - line;
     ++			char *branch;
      +
     -+			if (!head || memchr(ref, '\n', head - ref))
     ++			if (!skip_prefix(line, "ref: ", &p) ||
     ++			    !strip_suffix_mem(line, &len, "\tHEAD")) {
     ++				line = eol + (*eol == '\n');
      +				continue;
     ++			}
      +
     -+			if (skip_prefix(ref, "refs/heads/", &p)) {
     -+				branch = xstrndup(p, head - p);
     ++			eol = line + len;
     ++			if (skip_prefix(p, "refs/heads/", &p)) {
     ++				branch = xstrndup(p, eol - p);
      +				strbuf_release(&out);
      +				return branch;
      +			}
      +
      +			error(_("remote HEAD is not a branch: '%.*s'"),
     -+			      (int)(head - ref), ref);
     ++			      (int)(eol - p), p);
      +			strbuf_release(&out);
      +			return NULL;
      +		}
     @@ contrib/scalar/scalar.txt: an existing Git worktree with Scalar whose name is no
      +~~~~~
      +
      +clone [<options>] <url> [<enlistment>]::
     -+    Clones the specified repository, similar to linkgit:git-clone[1]. By
     -+    default, only commit and tree objects are cloned. Once finished, the
     -+    worktree is located at `<enlistment>/src`.
     ++	Clones the specified repository, similar to linkgit:git-clone[1]. By
     ++	default, only commit and tree objects are cloned. Once finished, the
     ++	worktree is located at `<enlistment>/src`.
      ++
      +The sparse-checkout feature is enabled (except when run with `--full-clone`)
      +and the only files present are those in the top-level directory. Use
     @@ contrib/scalar/scalar.txt: an existing Git worktree with Scalar whose name is no
      +
      +-b <name>::
      +--branch <name>::
     -+    Instead of checking out the branch pointed to by the cloned repository's
     -+    HEAD, check out the `<name>` branch instead.
     ++	Instead of checking out the branch pointed to by the cloned
     ++	repository's HEAD, check out the `<name>` branch instead.
      +
      +--[no-]full-clone::
     -+    A sparse-checkout is initialized by default. This behavior can be turned
     -+    off via `--full-clone`.
     ++	A sparse-checkout is initialized by default. This behavior can be
     ++	turned off via `--full-clone`.
      +
       List
       ~~~~
       
       list::
     -     To see which repositories are currently registered by the service, run
     --    `scalar list`. This subcommand does not need to be run inside a Scalar
     --    enlistment.
     -+    `scalar list`. This subcommand, like `clone`, does not need to be run
     -+    inside a Scalar enlistment.
     + 	To see which repositories are currently registered by the service, run
     +-	`scalar list`. This subcommand does not need to be run inside a Scalar
     +-	enlistment.
     ++	`scalar list`. This subcommand, like `clone`, does not need to be run
     ++	inside a Scalar enlistment.
       
       Register
       ~~~~~~~~
  9:  9af1c37c2ea !  9:  b3c4b3dccc6 scalar: teach 'clone' to support the --single-branch option
     @@ contrib/scalar/scalar.txt: scalar - an opinionated repository management tool
       scalar register [<enlistment>]
       scalar unregister [<enlistment>]
      @@ contrib/scalar/scalar.txt: subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
     -     Instead of checking out the branch pointed to by the cloned repository's
     -     HEAD, check out the `<name>` branch instead.
     + 	Instead of checking out the branch pointed to by the cloned
     + 	repository's HEAD, check out the `<name>` branch instead.
       
      +--[no-]single-branch::
     -+    Clone only the history leading to the tip of a single branch,
     -+    either specified by the `--branch` option or the primary
     -+    branch remote's `HEAD` points at.
     ++	Clone only the history leading to the tip of a single branch, either
     ++	specified by the `--branch` option or the primary branch remote's
     ++	`HEAD` points at.
      ++
      +Further fetches into the resulting repository will only update the
      +remote-tracking branch for the branch this option was used for the initial
     @@ contrib/scalar/scalar.txt: subdirectories outside your sparse-checkout by using
      +`--single-branch` clone was made, no remote-tracking branch is created.
      +
       --[no-]full-clone::
     -     A sparse-checkout is initialized by default. This behavior can be turned
     -     off via `--full-clone`.
     + 	A sparse-checkout is initialized by default. This behavior can be
     + 	turned off via `--full-clone`.
      
       ## contrib/scalar/t/t9099-scalar.sh ##
      @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success 'set up repository to clone' '
 10:  c3f16bccd02 ! 10:  b7fc2dc29c8 scalar: implement the `run` command
     @@ contrib/scalar/scalar.txt: scalar clone [--single-branch] [--branch <main-branch
       DESCRIPTION
       -----------
      @@ contrib/scalar/scalar.txt: unregister [<enlistment>]::
     -     Remove the specified repository from the list of repositories
     -     registered with Scalar and stop the scheduled background maintenance.
     + 	Remove the specified repository from the list of repositories
     + 	registered with Scalar and stop the scheduled background maintenance.
       
      +Run
      +~~~
      +
      +scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]::
     -+    Run the given maintenance task (or all tasks, if `all` was specified).
     -+    Except for `all` and `config`, this subcommand simply hands off to
     -+    linkgit:git-maintenance[1] (mapping `fetch` to `prefetch` and
     -+    `pack-files` to `incremental-repack`).
     ++	Run the given maintenance task (or all tasks, if `all` was specified).
     ++	Except for `all` and `config`, this subcommand simply hands off to
     ++	linkgit:git-maintenance[1] (mapping `fetch` to `prefetch` and
     ++	`pack-files` to `incremental-repack`).
      ++
      +These tasks are run automatically as part of the scheduled maintenance,
      +as soon as the repository is registered with Scalar. It should therefore
 11:  13056f02018 ! 11:  9a834c23d08 scalar: allow reconfiguring an existing enlistment
     @@ contrib/scalar/scalar.c: static int set_recommended_config(void)
      -		{ "core.untrackedCache", "false" },
      +		{ "core.untrackedCache", "false", 1 },
       #endif
     --		{ "core.bare", "false" },
      -		{ "core.logAllRefUpdates", "true" },
      -		{ "credential.https://dev.azure.com.useHttpPath", "true" },
      -		{ "credential.validate", "false" }, /* GCM4W-only */
     @@ contrib/scalar/scalar.c: static int set_recommended_config(void)
      -		{ "feature.experimental", "false" },
      -		{ "fetch.unpackLimit", "1" },
      -		{ "fetch.writeCommitGraph", "false" },
     -+		{ "core.bare", "false", 1 },
      +		{ "core.logAllRefUpdates", "true", 1 },
      +		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
      +		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 12:  732a28c22fc ! 12:  79e9f5d203a scalar: teach 'reconfigure' to optionally handle all registered enlistments
     @@ contrib/scalar/scalar.txt: After a Scalar upgrade, or when the configuration of
       reconfigure the enlistment.
       
      +With the `--all` option, all enlistments currently registered with Scalar
     -+will be reconfigured. This option is meant to to be run every time Scalar
     -+was upgraded.
     ++will be reconfigured. This option is meant to to be run every time after
     ++Scalar is upgraded.
      +
       SEE ALSO
       --------
 13:  13afbd68812 ! 13:  94a21982652 scalar: implement the `delete` command
     @@ contrib/scalar/scalar.txt: scalar register [<enlistment>]
       DESCRIPTION
       -----------
      @@ contrib/scalar/scalar.txt: With the `--all` option, all enlistments currently registered with Scalar
     - will be reconfigured. This option is meant to to be run every time Scalar
     - was upgraded.
     + will be reconfigured. This option is meant to to be run every time after
     + Scalar is upgraded.
       
      +Delete
      +~~~~~~
      +
      +delete <enlistment>::
     -+    This subcommand lets you delete an existing Scalar enlistment from your
     -+    local file system, unregistering the repository.
     ++	This subcommand lets you delete an existing Scalar enlistment from your
     ++	local file system, unregistering the repository.
      +
       SEE ALSO
       --------
 14:  73d08c0c894 ! 14:  707d8e19683 scalar: implement the `version` command
     @@ Commit message
      
          Since Scalar is now tightly coupled with Git, it does not make sense for
          them to show different versions. Therefore, it shows the same output as
     -    `git versions`. For backwards-compatibility with the .NET version,
     +    `git version`. For backwards-compatibility with the .NET version,
          `scalar version` prints to `stderr`, though (`git version` prints to
          `stdout` instead).
      
 15:  6455b18f1b6 ! 15:  26e23b5c5e5 scalar: accept -C and -c options before the subcommand
     @@ contrib/scalar/scalar.txt: The `scalar` command implements various subcommands,
      +The following options can be specified _before_ the subcommand:
      +
      +-C <directory>::
     -+    Before running the subcommand, change the working directory. This
     -+    option imitates the same option of linkgit:git[1].
     ++	Before running the subcommand, change the working directory. This
     ++	option imitates the same option of linkgit:git[1].
      +
      +-c <key>=<value>::
     -+    For the duration of running the specified subcommand, configure this
     -+    setting. This option imitates the same option of linkgit:git[1].
     ++	For the duration of running the specified subcommand, configure this
     ++	setting. This option imitates the same option of linkgit:git[1].
      +
       COMMANDS
       --------

-- 
gitgitgadget
