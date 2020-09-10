Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E655C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F015E2064B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Ie71DA1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIJRWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgIJRVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:21:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A690C061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so6889616qkc.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8fOn8aLffQS9l1OB8KnXAUfvu+EZ6vojfbnqflr1N8=;
        b=Ie71DA1cmtZawINVK4ZO/WVpt7NvSC/zDtFpNNNBFurj0BO1Pucq74Y0cdwcsnUSMY
         RmwUO4j1r3Rhlzs/ILVCNaaqv7J3LbLw9HZXfMjO6F+RqlqeGFa27Pq3pdu+6+fSye22
         vW8tC1rT39aHf2C3F2ViOa5OPVCHWPnLx3lHVV18ibikKc+knySHyLk9u5V4mIMTXwjW
         9JFl2hfUUEURFa94UhbHDRGAZUeXCHvw+QvE13WuVC98cEXlHMn0TcKz3vB8+ig2/EMu
         ZEEjtUy5vPXgvmc/jypT7D/tWCwT2bzZILOcnYRaYntj23CJt3S+EmqtV78YDaXXe2o5
         rpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8fOn8aLffQS9l1OB8KnXAUfvu+EZ6vojfbnqflr1N8=;
        b=Tz215ic3KF/miC/Aj7zJiZWF5j8AFKfspsYV0kAw4aN89PIpuzdzx2YffjT37NRuzO
         wbpCquszWP9vOx8x4B1k0ZzvM9nz1oE1R/xzLK/Zt42g8Ui46xthZuDZBam6Zc/+TP9U
         ROuDevx+CMyZ/5VOJzM5iowhAhZw+eOkPPHDjG0HdQzm+RIkUh987L4Ze/ismFukBOkB
         vEUdtl2sjWflR0OcDLOq2Y6tvkDhm/MSZ4lbMNw3tnuHt8I3EwVQnfAii2OozwdMfxf+
         hcHoerlb2oO9Z7HJIhiHsYkeAkTtvVQVl2teYBYbMhWPa5O93XYSridMY4vKCtLhDYRL
         ZKsg==
X-Gm-Message-State: AOAM532kqU0b2EMqt9bUJdcQBwPttxqrhvPhUPJsDDm/fz/dtwBprQlx
        X3xB8+We09gVChsgJLzw2xxrxDo/DPIHYg==
X-Google-Smtp-Source: ABdhPJxgHQ56bRVF4H4tXtufdXErlf6lFqKID4nz8i+XLzw4F/edJPebuB5+koRoJ7qRtLZQW2vgcQ==
X-Received: by 2002:a05:620a:4d0:: with SMTP id 16mr8572279qks.200.1599758497042;
        Thu, 10 Sep 2020 10:21:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:36 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 0/9] grep: honor sparse checkout and add option to ignore it
Date:   Thu, 10 Sep 2020 14:21:19 -0300
Message-Id: <cover.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes git-grep restrict its output to the sparsity patterns when
requested by the user. A new global option is added to control this behavior
in grep and hopefully more commands in the future. There is also a fix in
config.c, to correctly read worktree-specific settings on submodules.

Changes since v5:

Patch 2:
- Avoid complex '\'quoting\'' by using '.', as the string is going to
  be used in a grep search.
- Split the check_config auxiliary function into two, to remove some
  unecessary logic and future-proof them against wrong usages of
  test-config.

Patch 4: reword commit message to focus on correctly diagnosing missing
         arguments.

Patch 5: don't replace explicit `return 0` with `return ret`.

Added patch 6, passing a `struct repository` to do_git_config_sequence().

Patch 6:
- Removed global `repository_format_worktree_config` and cached
  extensions.worktreeConfig value in `struct repository`, to avoid repeating
  repository format discovery.
- Improved commit message as suggested by Jonathan.
- Use usage_with_options()


Jonathan Nieder (1):
  config: make do_git_config_sequence receive a 'struct repository'

Matheus Tavares (8):
  doc: grep: unify info on configuration variables
  t1308-config-set: avoid false positives when using test-config
  t/helper/test-config: be consistent with exit codes
  t/helper/test-config: diagnose missing arguments
  t/helper/test-config: unify exit labels
  config: correctly read worktree configs in submodules
  grep: honor sparse checkout patterns
  config: add setting to ignore sparsity patterns in some cmds

 Documentation/config.txt               |   2 +
 Documentation/config/grep.txt          |  18 +-
 Documentation/config/sparse.txt        |  20 ++
 Documentation/git-grep.txt             |  36 +--
 Documentation/git.txt                  |   4 +
 Makefile                               |   1 +
 builtin/config.c                       |   8 +-
 builtin/grep.c                         | 134 ++++++++++-
 cache.h                                |   1 -
 config.c                               |  47 ++--
 config.h                               |   4 +-
 contrib/completion/git-completion.bash |   2 +
 environment.c                          |   1 -
 git.c                                  |   5 +
 repository.c                           |   1 +
 repository.h                           |   1 +
 setup.c                                |   4 +-
 sparse-checkout.c                      |  18 ++
 sparse-checkout.h                      |  11 +
 t/helper/test-config.c                 | 124 ++++++----
 t/t1308-config-set.sh                  |  28 +--
 t/t2404-worktree-config.sh             |  16 ++
 t/t7011-skip-worktree-reading.sh       |   9 -
 t/t7817-grep-sparse-checkout.sh        | 321 +++++++++++++++++++++++++
 t/t9902-completion.sh                  |   4 +-
 25 files changed, 682 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h
 create mode 100755 t/t7817-grep-sparse-checkout.sh

Range-diff against v5:
 1:  70c9a4e741 =  1:  70c9a4e741 doc: grep: unify info on configuration variables
 2:  f53782f14c <  -:  ---------- t1308-config-set: avoid false positives when using test-config
 -:  ---------- >  2:  3c2d722152 t1308-config-set: avoid false positives when using test-config
 3:  85e1588d6c =  3:  45d13744b7 t/helper/test-config: be consistent with exit codes
 4:  0750191342 !  4:  51656e43c3 t/helper/test-config: check argc before accessing argv
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    t/helper/test-config: check argc before accessing argv
    +    t/helper/test-config: diagnose missing arguments
     
    -    Check that we have the expected argc in 'configset_get_value' and
    -    'configset_get_value_multi' before trying to access argv elements.
    +    test-config verifies that the correct number of arguments was given for
    +    all of its commands except for 'configset_get_value' and
    +    'configset_get_value_multi'. Add the check to these two, so that we
    +    properly report missing arguments and prevent out-of-bounds access to
    +    argv[].
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
 5:  56535b0e36 !  5:  924d2e8ceb t/helper/test-config: unify exit labels
    @@ t/helper/test-config.c: static int early_config_cb(const char *var, const char *
      	const char *v;
      	const struct string_list *strptr;
      	struct config_set cs;
    - 
    - 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
    - 		read_early_config(early_config_cb, (void *)argv[2]);
    --		return 0;
    -+		return ret;
    - 	}
    - 
    - 	setup_git_directory();
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      				printf("(NULL)\n");
      			else
 -:  ---------- >  6:  f5c0fc3336 config: make do_git_config_sequence receive a 'struct repository'
 6:  3e02e1bd24 !  7:  3a28b8e608 config: correctly read worktree configs in submodules
    @@ Commit message
         config: correctly read worktree configs in submodules
     
         The config machinery is not able to read worktree configs from a
    -    submodule in a process where the_repository represents the superproject.
    -    Furthermore, when extensions.worktreeConfig is set on the superproject,
    -    querying for a worktree config in a submodule will, instead, return
    -    the value set at the superproject.
    -
    -    The problem resides in do_git_config_sequence(). Although the function
    -    receives a git_dir string, it uses the_repository->git_dir when making
    -    the path to the worktree config file. And when checking if
    -    extensions.worktreeConfig is set, it uses the global
    -    repository_format_worktree_config variable, which refers to
    -    the_repository only. So let's fix this by using the git_dir given to the
    -    function and reading the extension value from the right place. Also add
    -    a test to avoid any regressions.
    +    submodule in a process where the_repository represents the superproject
    +    and extensions.worktreeConfig is not set there. Furthermore, when
    +    extensions.worktreeConfig is set on the superproject, querying for a
    +    worktree config in a submodule will, instead, return the value set at
    +    the superproject.
    +
    +    The relevant code is in do_git_config_sequence(). Although it is
    +    designed to act on an arbitrary repository, specified in the passed-in
    +    `struct config_options`, it accidentally depends on the_repository in
    +    two places:
    +
    +    - it reads the global variable `repository_format_worktree_config`,
    +      which is set based on the content of the_repository, to determine
    +      whether extensions.worktreeConfig is set.
    +
    +    - it uses the git_pathdup() helper to find the config.worktree file,
    +      instead of making a path using the passed-in repository.
    +
    +    Sever these dependencies and add a regression test. Also, to avoid
    +    future misuses of `repository_format_worktree_config` like this one,
    +    remove this global variable and store the config value on
    +    `struct repository` itself.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    + ## builtin/config.c ##
    +@@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
    + 		given_config_source.scope = CONFIG_SCOPE_LOCAL;
    + 	} else if (use_worktree_config) {
    + 		struct worktree **worktrees = get_worktrees();
    +-		if (repository_format_worktree_config)
    ++		if (!nongit && the_repository->worktree_config_extension)
    + 			given_config_source.file = git_pathdup("config.worktree");
    + 		else if (worktrees[0] && worktrees[1])
    + 			die(_("--worktree cannot be used with multiple "
    +
    + ## cache.h ##
    +@@ cache.h: extern int grafts_replace_parents;
    + #define GIT_REPO_VERSION 0
    + #define GIT_REPO_VERSION_READ 1
    + extern int repository_format_precious_objects;
    +-extern int repository_format_worktree_config;
    + 
    + /*
    +  * You _have_ to initialize a `struct repository_format` using
    +
      ## config.c ##
     @@ config.c: static int do_git_config_sequence(const struct config_options *opts,
      		ret += git_config_from_file(fn, repo_config, data);
    @@ config.c: static int do_git_config_sequence(const struct config_options *opts,
     -		if (!access_or_die(path, R_OK, 0))
     -			ret += git_config_from_file(fn, path, data);
     -		free(path);
    -+	if (!opts->ignore_worktree && repo_config && opts->git_dir) {
    -+		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
    -+		struct strbuf buf = STRBUF_INIT;
    -+
    -+		read_repository_format(&repo_fmt, repo_config);
    -+
    -+		if (!verify_repository_format(&repo_fmt, &buf) &&
    -+		    repo_fmt.worktree_config) {
    -+			char *path = mkpathdup("%s/config.worktree", opts->git_dir);
    -+			if (!access_or_die(path, R_OK, 0))
    -+				ret += git_config_from_file(fn, path, data);
    -+			free(path);
    -+		}
    -+
    -+		strbuf_release(&buf);
    -+		clear_repository_format(&repo_fmt);
    ++	if (!opts->ignore_worktree && opts->repo && opts->repo->gitdir &&
    ++	    opts->repo->worktree_config_extension) {
    ++		struct strbuf path = STRBUF_INIT;
    ++		strbuf_repo_git_path(&path, opts->repo, "config.worktree");
    ++		if (!access_or_die(path.buf, R_OK, 0))
    ++			ret += git_config_from_file(fn, path.buf, data);
    ++		strbuf_release(&path);
      	}
      
      	current_parsing_scope = CONFIG_SCOPE_COMMAND;
     
    + ## environment.c ##
    +@@ environment.c: int warn_ambiguous_refs = 1;
    + int warn_on_object_refname_ambiguity = 1;
    + int ref_paranoia = -1;
    + int repository_format_precious_objects;
    +-int repository_format_worktree_config;
    + const char *git_commit_encoding;
    + const char *git_log_output_encoding;
    + char *apply_default_whitespace;
    +
    + ## repository.c ##
    +@@ repository.c: int repo_init(struct repository *repo,
    + 		goto error;
    + 
    + 	repo_set_hash_algo(repo, format.hash_algo);
    ++	repo->worktree_config_extension = format.worktree_config;
    + 
    + 	if (worktree)
    + 		repo_set_worktree(repo, worktree);
    +
    + ## repository.h ##
    +@@ repository.h: struct repository {
    + 
    + 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
    + 	unsigned different_commondir:1;
    ++	unsigned worktree_config_extension:1;
    + };
    + 
    + extern struct repository *the_repository;
    +
    + ## setup.c ##
    +@@ setup.c: static int check_repository_format_gently(const char *gitdir, struct repository_
    + 
    + 	repository_format_precious_objects = candidate->precious_objects;
    + 	set_repository_format_partial_clone(candidate->partial_clone);
    +-	repository_format_worktree_config = candidate->worktree_config;
    ++	the_repository->worktree_config_extension = candidate->worktree_config;
    + 	string_list_clear(&candidate->unknown_extensions, 0);
    + 	string_list_clear(&candidate->v1_only_extensions, 0);
    + 
    +-	if (repository_format_worktree_config) {
    ++	if (the_repository->worktree_config_extension) {
    + 		/*
    + 		 * pick up core.bare and core.worktree from per-worktree
    + 		 * config if present
    +
      ## t/helper/test-config.c ##
     @@
      #include "cache.h"
    @@ t/helper/test-config.c: static int early_config_cb(const char *var, const char *
     +	argc = parse_options(argc, argv, NULL, options, test_config_usage,
     +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
     +	if (argc < 2)
    -+		die("Please, provide a command name on the command-line");
    ++		usage_with_options(test_config_usage, options);
      
      	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
     +		if (subrepo_path)
     +			die("cannot use --submodule with read_early_config");
      		read_early_config(early_config_cb, (void *)argv[2]);
    - 		return ret;
    + 		return 0;
      	}
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      
 7:  902556a7b6 =  8:  2fc889c9c2 grep: honor sparse checkout patterns
 8:  70e7d7b90c =  9:  92bc5351cf config: add setting to ignore sparsity patterns in some cmds
-- 
2.28.0

