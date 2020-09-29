Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A33FC4727E
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E0E20BED
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5Rdn2GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgI2Dg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgI2Dg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:36:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7974C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:36:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so3628110wrn.10
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X7vlJKyA/zQ6mlVfnCoQbfLZbskVM51hVA18r/sUvY0=;
        b=e5Rdn2GNQH0Mpvxv8u+w5HV9bAjQ4I3McXHwk1saXeWiF7ZiRzo8TnlvBSm8CMPPZk
         yqJg3wvrQeSi8RZ0LmeW4KeiZHnTsMPCytpsakd/4afcsZ6yxKD01BtpmBQ/BllizuuB
         WhzWDXKyAiR7igCHlgu/t+gCuUOHUKmm/QRd+lgwV4uphfrmz8CEpFkPgqWz1KnYmRoL
         RCN3dZDcKQJJQ8sUoxBCR1w7wOOaE/ntrmnU8A20YGwbdXMY2y4FMaXpzsHjnea+jJS1
         Q8kATeHGpPhXQ8mnqSNMiXGHl2RojpsEYDtvzTR6ZsOlYHMO8iGeVh6iiC9P4aP+z8sg
         usfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X7vlJKyA/zQ6mlVfnCoQbfLZbskVM51hVA18r/sUvY0=;
        b=ewVxGEwaxCYjIsAAzpb0p31h3IfFXAqYkyAT+r4nmaYAd51ZS3ROp0pqyxxELY00yC
         6k7ntiZfkOb+Vm04RJoZaqpdJp02SG1g+sU2Ap0FU9fGEnUlmpN48P44wJyXKnJxRU+O
         EvW6B4Q4dR6yM1JkW/+81zXRO3Uw/PS0FI/2YZ8st3PMejCXDJUsyW7JSfeHG0JghcHi
         5v3QY7k1aqJFa5oEj5vs0geSCqHC8Iw59J0ItJOTFeXrljNrXQVmWVbg5qwnO060xSA1
         Cw5clQhwmf14JMtL1NXnE8JGPvkN6xOmFhAQ/1Wavy0EQTkIupvyZBYKq8eHctgk2rt9
         WOFw==
X-Gm-Message-State: AOAM533Rqygqk56OODMjZN9ct3GwAAAzw7ko+oBG75TiK0BxXIrXctCI
        D4yTKyZFWRigVsenEwgtQr/g7Ky7az4=
X-Google-Smtp-Source: ABdhPJzyY3isl6iNAcN5AQm19Ttenp6qX0UqfDXC50s7e4NWvh5iP9ZjABIGmBFyM7eSxLcHTUfbCg==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr1581370wru.163.1601350616776;
        Mon, 28 Sep 2020 20:36:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm3818950wru.65.2020.09.28.20.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:36:56 -0700 (PDT)
Message-Id: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:48 +0000
Subject: [PATCH v2 0/7] clone: allow configurable default for -o/--origin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 (changes since v1):

 * Convert Thanks-to trailer to Helped-by
 * Rewrite several commit titles and messages
 * Unify error reporting between clone.c and remote.c
 * Add tests for git remote add and git remote rename with invalid remote
   names
 * Prevent leak of old remote_name

v1: Took another pass at supporting a configurable default for-o/--origin,
this time following Junio's suggestions from a previous approach as much as
possible [1]. Unfortunately, Johannes mentioned that --template can write
new config values that aren't automatically merged without re-calling 
git_config. There doesn't appear to be a way around this without rewriting
significant amounts of init and config logic across the codebase.

While this could have been v2 of the original patchset, it's diverged so
drastically from the original that it likely warrants its own root thread.
If that's not appropriate though, I'd be happy to restructure!

Thanks for all the advice Junio and Johannes! This feels significantly
better than my first attempt.

[1] 
https://lore.kernel.org/git/pull.710.git.1598456751674.gitgitgadget@gmail.com/
[2] https://github.com/gitgitgadget/git/pull/727#issuecomment-689740195

Sean Barag (7):
  clone: add tests for --template and some disallowed option pairs
  clone: use more conventional config/option layering
  remote: add tests for add and rename with invalid names
  refs: consolidate remote name validation
  clone: validate --origin option before use
  clone: read new remote name from remote_name instead of option_origin
  clone: allow configurable default for `-o`/`--origin`

 Documentation/config.txt       |  2 +
 Documentation/config/clone.txt |  5 +++
 Documentation/git-clone.txt    |  5 ++-
 builtin/clone.c                | 70 ++++++++++++++++++++++++++--------
 builtin/remote.c               |  7 +---
 refspec.c                      | 10 +++++
 refspec.h                      |  1 +
 t/t5505-remote.sh              | 13 +++++++
 t/t5606-clone-options.sh       | 68 ++++++++++++++++++++++++++++++++-
 9 files changed, 158 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/config/clone.txt


base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-727%2Fsjbarag%2Fclone_add-configurable-default-for--o-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-727/sjbarag/clone_add-configurable-default-for--o-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/727

Range-diff vs v1:

 1:  4cdcedff31 ! 1:  29ab418b1b clone: add tests for --template and some disallowed option pairs
     @@ Commit message
          errors.  Similarly, `git clone --template` didn't appear to have any
          tests.
      
     +    Helped-by: Jeff King <peff@peff.net>
     +    Helped-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Sean Barag <sean@barag.org>
      
       ## t/t5606-clone-options.sh ##
     -@@ t/t5606-clone-options.sh: test_expect_success 'clone -o' '
     - 
     - '
     +@@ t/t5606-clone-options.sh: test_expect_success 'setup' '
     + test_expect_success 'clone -o' '
       
     + 	git clone -o foo parent clone-o &&
     +-	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
     ++	git -C clone-o rev-parse --verify refs/remotes/foo/master
     ++
     ++'
     ++
      +test_expect_success 'disallows --bare with --origin' '
      +
     -+	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
     ++	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
      +	test_debug "cat err" &&
     -+	test_i18ngrep "\-\-bare and --origin foo options are incompatible" err
     ++	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
      +
      +'
      +
      +test_expect_success 'disallows --bare with --separate-git-dir' '
      +
     -+	test_expect_code 128 git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
     ++	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
      +	test_debug "cat err" &&
     -+	test_i18ngrep "\-\-bare and --separate-git-dir are incompatible" err
     ++	test_i18ngrep -e "--bare and --separate-git-dir are incompatible" err
      +
      +'
      +
      +test_expect_success 'uses "origin" for default remote name' '
      +
      +	git clone parent clone-default-origin &&
     -+	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
     ++	git -C clone-default-origin rev-parse --verify refs/remotes/origin/master
      +
      +'
      +
     @@ t/t5606-clone-options.sh: test_expect_success 'clone -o' '
      +	git config --file "$template/config" foo.bar from_template &&
      +	test_config_global foo.bar from_global &&
      +	git clone "--template=$template" parent clone-template-config &&
     -+	(cd clone-template-config && test "$(git config --local foo.bar)" = "from_template")
     ++	test "$(git -C clone-template-config config --local foo.bar)" = "from_template"
      +
      +'
      +
     @@ t/t5606-clone-options.sh: test_expect_success 'clone -o' '
      +	mkdir "$template" &&
      +	git config --file "$template/config" foo.bar from_template &&
      +	git clone "--template=$template" -c foo.bar=inline parent clone-template-inline-config &&
     -+	(cd clone-template-inline-config && test "$(git config --local foo.bar)" = "inline")
     -+
     -+'
     -+
     - test_expect_success 'redirected clone does not show progress' '
     ++	test "$(git -C clone-template-inline-config config --local foo.bar)" = "inline"
     + 
     + '
       
     - 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
 2:  51ef776f85 ! 2:  e3479e7b35 clone: call git_config before parse_options
     @@ Metadata
      Author: Sean Barag <sean@barag.org>
      
       ## Commit message ##
     -    clone: call git_config before parse_options
     +    clone: use more conventional config/option layering
      
     -    While Junio's request [1] was to avoids the unusual  "write config then
     -    immediately read it" pattern that exists in `cmd_clone`, Johannes
     -    mentioned that --template can write new config values that aren't
     -    automatically included in the environment [2]. This requires a config
     -    re-read after `init_db` is called.
     -
     -    Moving the initial config up does allow settings from config to be
     -    overwritten by ones provided via CLI options in a more natural way
     -    though, so that part of Junio's suggestion remains.
     -
     -    [1] https://lore.kernel.org/git/pull.710.git.1598456751674.gitgitgadget@gmail.com/
     -    [2] https://github.com/gitgitgadget/git/pull/727#issuecomment-689740195
     +    Parsing command-line options before reading from config required careful
     +    handling to ensure CLI options were treated with higher priority.  Read
     +    config first to let parsed CLI naively overwrite matching config values.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Sean Barag <sean@barag.org>
     -    Thanks-to: Junio C Hamano <gitster@pobox.com>
     -    Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: static int checkout(int submodule_progress)
     @@ builtin/clone.c: static int checkout(int submodule_progress)
       static int write_one_config(const char *key, const char *value, void *data)
       {
      +	/*
     -+	 * give git_config_default a chance to write config values back to the environment, since
     -+	 * git_config_set_multivar_gently only deals with config-file writes
     ++	 * give git_clone_config a chance to write config values back to the
     ++	 * environment, since git_config_set_multivar_gently only deals with
     ++	 * config-file writes
      +	 */
     -+	int apply_failed = git_default_config(key, value, data);
     ++	int apply_failed = git_clone_config(key, value, data);
      +	if (apply_failed)
      +		return apply_failed;
      +
 -:  ---------- > 3:  85be780b8e remote: add tests for add and rename with invalid names
 -:  ---------- > 4:  42dc18601a refs: consolidate remote name validation
 -:  ---------- > 5:  fdc9d3b369 clone: validate --origin option before use
 4:  5c519376c2 ! 6:  99f4d765b4 clone: allow configurable default for `-o`/`--origin`
     @@ Metadata
      Author: Sean Barag <sean@barag.org>
      
       ## Commit message ##
     -    clone: allow configurable default for `-o`/`--origin`
     +    clone: read new remote name from remote_name instead of option_origin
      
     -    While the default remote name of "origin" can be changed at clone-time
     -    with `git clone`'s `--origin` option, it was previously not possible
     -    to specify a default value for the name of that remote.  This commit
     -    adds support for a new `clone.defaultRemoteName` config.
     -
     -    It's resolved in the expected priority order:
     -
     -    1. (Highest priority) A remote name passed directly to `git clone -o`
     -    2. A `clone.defaultRemoteName=new_name` in config `git clone -c`
     -    3. A `clone.defaultRemoteName` value set in `/path/to/template/config`,
     -       where `--template=/path/to/template` is provided
     -    3. A `clone.defaultRemoteName` value set in a non-template config file
     -    4. The default value of `origin`
     +    In a future patch, the name of the remote created by `git clone` may
     +    come from multiple sources.  To avoid confusion, convert most uses of
     +    option_origin to remote_name, leaving option_origin to exclusively
     +    represent the -o/--origin option.
      
     +    Helped-by: Derrick Stolee <stolee@gmail.com>
          Signed-off-by: Sean Barag <sean@barag.org>
     -    Thanks-to: Junio C Hamano <gitster@pobox.com>
     -    Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
     -
     - ## Documentation/config.txt ##
     -@@ Documentation/config.txt: include::config/checkout.txt[]
     - 
     - include::config/clean.txt[]
     - 
     -+include::config/clone.txt[]
     -+
     - include::config/color.txt[]
     - 
     - include::config/column.txt[]
     -
     - ## Documentation/config/clone.txt (new) ##
     -@@
     -+clone.defaultRemoteName::
     -+	The name of the remote to create when cloning a repository.  Defaults to
     -+	`origin`, and can be overridden by passing the `--origin` command-line
     -+	option to linkgit:git-clone[1].
     -+
     -
     - ## Documentation/git-clone.txt ##
     -@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     - 
     - -o <name>::
     - --origin <name>::
     --	Instead of using the remote name `origin` to keep track
     --	of the upstream repository, use `<name>`.
     -+	Instead of using the remote name `origin` to keep track of the upstream
     -+	repository, use `<name>`.  Overrides `clone.defaultRemoteName` from the
     -+	config.
     - 
     - -b <name>::
     - --branch <name>::
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: static int option_shallow_submodules;
     @@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref
       		}
       	} else if (our) {
       		struct commit *c = lookup_commit_reference(the_repository,
     -@@ builtin/clone.c: static int checkout(int submodule_progress)
     - 
     - static int git_clone_config(const char *k, const char *v, void *cb)
     - {
     -+	if (!strcmp(k, "clone.defaultremotename") && !option_origin)
     -+		remote_name = xstrdup(v);
     - 	return git_default_config(k, v, cb);
     - }
     - 
     - static int write_one_config(const char *key, const char *value, void *data)
     - {
     - 	/*
     --	 * give git_config_default a chance to write config values back to the environment, since
     -+	 * give git_clone_config a chance to write config values back to the environment, since
     - 	 * git_config_set_multivar_gently only deals with config-file writes
     - 	 */
     --	int apply_failed = git_default_config(key, value, data);
     -+	int apply_failed = git_clone_config(key, value, data);
     - 	if (apply_failed)
     - 		return apply_failed;
     - 
      @@ builtin/clone.c: static void write_refspec_config(const char *src_ref_prefix,
       		}
       		/* Configure the remote */
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      +	if (option_origin)
      +		remote_name = option_origin;
       
     --	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
     -+	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", remote_name);
     - 	if (!valid_fetch_refspec(resolved_refspec.buf))
     --		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
     --		die(_("'%s' is not a valid origin name"), option_origin);
     -+		/*
     -+		 * TRANSLATORS: %s will be the user-provided --origin / -o option, or the value
     -+		 * of clone.defaultremotename from the config.
     -+		 */
     -+		die(_("'%s' is not a valid origin name"), remote_name);
     - 	strbuf_release(&resolved_refspec);
     - 
     - 	repo_name = argv[0];
     + 	if (!valid_remote_name(remote_name))
     + 		die(_("'%s' is not a valid remote name"), remote_name);
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       		git_config_set("core.bare", "true");
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      -	remote = remote_get(option_origin);
      +	remote = remote_get(remote_name);
       
     - 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
     - 		    branch_top.buf);
     + 	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
     + 			branch_top.buf);
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       			if (!our_head_points_at)
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       	if (is_local)
       		clone_local(path, git_dir);
     -
     - ## t/t5606-clone-options.sh ##
     -@@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-git-dir' '
     - 
     - '
     - 
     --test_expect_success 'uses "origin" for default remote name' '
     --
     --	git clone parent clone-default-origin &&
     --	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
     --
     --'
     --
     - test_expect_success 'prefers --template config over normal config' '
     - 
     - 	template="$TRASH_DIRECTORY/template-with-config" &&
     -@@ t/t5606-clone-options.sh: test_expect_success 'prefers -c config over --template config' '
     - 
     - '
     - 
     -+test_expect_success 'uses "origin" for default remote name' '
     -+
     -+	git clone parent clone-default-origin &&
     -+	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
     -+
     -+'
     -+
     -+test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
     -+
     -+	test_config_global clone.defaultRemoteName from_config &&
     -+	git clone parent clone-config-origin &&
     -+	(cd clone-config-origin && git rev-parse --verify refs/remotes/from_config/master)
     -+
     -+'
     -+
     -+test_expect_success 'prefers --origin over -c config' '
     -+
     -+	git clone -c clone.defaultRemoteName=inline --origin from_option parent clone-o-and-inline-config &&
     -+	(cd clone-o-and-inline-config && git rev-parse --verify refs/remotes/from_option/master)
     -+
     -+'
     -+
     - test_expect_success 'redirected clone does not show progress' '
     - 
     - 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
 3:  0dff8cd669 ! 7:  737f91c624 clone: validate --origin option before use
     @@ Metadata
      Author: Sean Barag <sean@barag.org>
      
       ## Commit message ##
     -    clone: validate --origin option before use
     -
     -    Providing a bad origin name to `git clone` currently reports an
     -    'invalid refspec' error instead of a more explicit message explaining
     -    that the `--origin` option was malformed.  Per Junio, it's been this way
     -    since 8434c2f1 (Build in clone, 2008-04-27).  This patch reintroduces
     -    validation for the provided `--origin` option, but notably _doesn't_
     -    include a multi-level check (e.g. "foo/bar") that was present in the
     -    original `git-clone.sh`.  It seems `git remote` allows multi-level
     -    remote names, so applying that same validation in `git clone` seems
     -    reasonable.
     +    clone: allow configurable default for `-o`/`--origin`
      
     +    While the default remote name of "origin" can be changed at clone-time
     +    with `git clone`'s `--origin` option, it was previously not possible
     +    to specify a default value for the name of that remote.  Add support for
     +    a new `clone.defaultRemoteName` config, with the newly-created remote
     +    name resolved in priority order:
     +
     +    1. (Highest priority) A remote name passed directly to `git clone -o`
     +    2. A `clone.defaultRemoteName=new_name` in config `git clone -c`
     +    3. A `clone.defaultRemoteName` value set in `/path/to/template/config`,
     +       where `--template=/path/to/template` is provided
     +    4. A `clone.defaultRemoteName` value set in a non-template config file
     +    5. The default value of `origin`
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Helped-by: Derrick Stolee <stolee@gmail.com>
     +    Helped-by: Andrei Rybak <rybak.a.v@gmail.com>
          Signed-off-by: Sean Barag <sean@barag.org>
     -    Thanks-to: Junio C Hamano <gitster@pobox.com>
     +
     + ## Documentation/config.txt ##
     +@@ Documentation/config.txt: include::config/checkout.txt[]
     + 
     + include::config/clean.txt[]
     + 
     ++include::config/clone.txt[]
     ++
     + include::config/color.txt[]
     + 
     + include::config/column.txt[]
     +
     + ## Documentation/config/clone.txt (new) ##
     +@@
     ++clone.defaultRemoteName::
     ++	The name of the remote to create when cloning a repository.  Defaults to
     ++	`origin`, and can be overridden by passing the `--origin` command-line
     ++	option to linkgit:git-clone[1].
     ++
     +
     + ## Documentation/git-clone.txt ##
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + 
     + -o <name>::
     + --origin <name>::
     +-	Instead of using the remote name `origin` to keep track
     +-	of the upstream repository, use `<name>`.
     ++	Instead of using the remote name `origin` to keep track of the upstream
     ++	repository, use `<name>`.  Overrides `clone.defaultRemoteName` from the
     ++	config.
     + 
     + -b <name>::
     + --branch <name>::
      
       ## builtin/clone.c ##
     +@@ builtin/clone.c: static int option_shallow_submodules;
     + static int deepen;
     + static char *option_template, *option_depth, *option_since;
     + static char *option_origin = NULL;
     +-static char *remote_name = "origin";
     ++static char *default_remote_name = "origin";
     ++static char *remote_name = NULL;
     + static char *option_branch = NULL;
     + static struct string_list option_not = STRING_LIST_INIT_NODUP;
     + static const char *real_git_dir;
     +@@ builtin/clone.c: static int checkout(int submodule_progress)
     + 
     + static int git_clone_config(const char *k, const char *v, void *cb)
     + {
     ++	if (!strcmp(k, "clone.defaultremotename")) {
     ++		if (remote_name != default_remote_name)
     ++			free(remote_name);
     ++		remote_name = xstrdup(v);
     ++	}
     + 	return git_default_config(k, v, cb);
     + }
     + 
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	const struct ref *ref;
     - 	struct strbuf key = STRBUF_INIT;
     - 	struct strbuf default_refspec = STRBUF_INIT;
     -+	struct strbuf resolved_refspec = STRBUF_INIT;
     - 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
     - 	struct transport *transport = NULL;
     - 	const char *src_ref_prefix = "refs/heads/";
     + 	int submodule_progress;
     + 
     + 	struct strvec ref_prefixes = STRVEC_INIT;
     ++	remote_name = default_remote_name;
     + 
     + 	packet_trace_identity("clone");
     + 
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	if (!option_origin)
     - 		option_origin = "origin";
     + 		option_no_checkout = 1;
     + 	}
       
     -+	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
     -+	if (!valid_fetch_refspec(resolved_refspec.buf))
     -+		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
     -+		die(_("'%s' is not a valid origin name"), option_origin);
     -+	strbuf_release(&resolved_refspec);
     -+
     +-	if (option_origin)
     +-		remote_name = option_origin;
     +-
     +-	if (!valid_remote_name(remote_name))
     +-		die(_("'%s' is not a valid remote name"), remote_name);
     +-
       	repo_name = argv[0];
       
       	path = get_repo_path(repo_name, &is_bundle);
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 
     + 	/*
     + 	 * re-read config after init_db and write_config to pick up any config
     +-	 * injected by --template and --config, respectively
     ++	 * injected by --template and --config, respectively.
     + 	 */
     + 	git_config(git_clone_config, NULL);
     + 
     ++	/*
     ++	 * apply the remote name provided by --origin only after this second
     ++	 * call to git_config, to ensure it overrides all config-based values.
     ++	 */
     ++	if (option_origin)
     ++		remote_name = option_origin;
     ++
     ++	if (!valid_remote_name(remote_name))
     ++		die(_("'%s' is not a valid remote name"), remote_name);
     ++
     + 	if (option_bare) {
     + 		if (option_mirror)
     + 			src_ref_prefix = "refs/";
      
       ## t/t5606-clone-options.sh ##
      @@ t/t5606-clone-options.sh: test_expect_success 'clone -o' '
     @@ t/t5606-clone-options.sh: test_expect_success 'clone -o' '
       
      +test_expect_success 'rejects invalid -o/--origin' '
      +
     -+	test_expect_code 128 git clone -o "bad...name" parent clone-bad-name 2>err &&
     -+	test_debug "cat err" &&
     -+	test_i18ngrep "'\''bad...name'\'' is not a valid origin name" err
     ++	test_must_fail git clone -o "bad...name" parent clone-bad-name 2>err &&
     ++	test_i18ngrep "'\''bad...name'\'' is not a valid remote name" err
      +
      +'
      +
       test_expect_success 'disallows --bare with --origin' '
       
     - 	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
     + 	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
     +@@ t/t5606-clone-options.sh: test_expect_success 'prefers -c config over --template config' '
     + 
     + '
     + 
     ++test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
     ++
     ++	test_config_global clone.defaultRemoteName from_config &&
     ++	git clone parent clone-config-origin &&
     ++	git -C clone-config-origin rev-parse --verify refs/remotes/from_config/master
     ++
     ++'
     ++
     ++test_expect_success 'prefers --origin over -c config' '
     ++
     ++	git clone -c clone.defaultRemoteName=inline --origin from_option parent clone-o-and-inline-config &&
     ++	git -C clone-o-and-inline-config rev-parse --verify refs/remotes/from_option/master
     ++
     ++'
     ++
     + test_expect_success 'redirected clone does not show progress' '
     + 
     + 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&

-- 
gitgitgadget
