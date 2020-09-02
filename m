Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E991C433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365AF206C0
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="gyoEEBeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgIBGR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBGR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:17:57 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F2C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:17:56 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j10so1714078qvk.11
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBYyrPyKzkAQgifJ/iPTsMXy+EeZ42DjJ7TncxX4DCk=;
        b=gyoEEBebhYQ0TxM3DdGYmZKx170784JSW1p18/qFU6GwNCvGM0gnMtjlbcn+xiCAH0
         HQta7HUpbYD7Y0ZCJFPdU1+rPdwq1f207zgKK2+yiTWTjNO21PtAwXwtyxAdvEKjehbY
         jvAKn5177CYFtCNuUDl2Hzb4+SGjfdQ5W+tMqhRd+7tQ5x9hltqfkfua6m/B8SmcreMc
         yy/LR3LUNboflj2pUtH5tEOJJL/6Vtu7+9dskMu1snnggN1nLNxDztb2tFfOBPHe/1xo
         sJc9pkZ5k7EBtgmTngwysuI1gyC7zm3psel9aS9W1knNfE/9wbK9IfwSIUf3p3++ixa8
         5iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBYyrPyKzkAQgifJ/iPTsMXy+EeZ42DjJ7TncxX4DCk=;
        b=EnJRbqcEd2/hUHI5sDKwpnQLr7wdWMiUMbJUBvk0IvzKynpUpH427opgAk+AOvlLZz
         phyTl8bcfVUR750SfQFxXBzYDtOQpWSkSheQQo+Y+eNedbim1pX80K3AbhB2Vg9pnQBx
         zZuPecuEI1LDSt5N0HOWa1nF9nPg5kd/qjcqMqhJIRh//gair+WgXbnv+RQ9LuEVXLIi
         XKJXbqtgEtNLgXWbPM7iBzq/vvKog46cnEfKmJbOn9L8aC7gmSOygK6IzbBuFi5ar56J
         VStttloL7YXB39btineJ9Re1G7uZ/jJZHdIbwVGaOsB88+Ql4DMhmABAmEqiUAwYFBgR
         sRmA==
X-Gm-Message-State: AOAM533ODfWFi8Cs81JFLU7yVVfh7KNcjGT+31NLymz9wzm38NM37GW7
        ERHFWlZOyFKggJ4Rs67r1LfCS/N6wQYPbw==
X-Google-Smtp-Source: ABdhPJylp1cjkZd9L28YiVKJCD3O8Wi4bzIzmcfDbU4DUfHXkanOolD51Xu7hZKd2pwzoJV6NX7E1g==
X-Received: by 2002:ad4:524c:: with SMTP id s12mr5646452qvq.209.1599027474957;
        Tue, 01 Sep 2020 23:17:54 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:17:53 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 0/8] grep: honor sparse checkout and add option to ignore it
Date:   Wed,  2 Sep 2020 03:17:29 -0300
Message-Id: <cover.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1591974940.git.matheus.bernardino@usp.br>
References: <cover.1591974940.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes git-grep restrict its output to the sparsity patterns when
requested by the user. A new global option is added to control this behavior
in grep and hopefully more commands in the future. There are also a
couple fixes in t/helper/test-config and in a test that uses it.

Changes since v4:

- Rebased on top of master to use repo_config_get_string_tmp(), added in
  jk/leakfix, in t/helper/test-config (patch 6).

- Added patch 2, to make sure a test that relies on test-config checks its
  output in addition to the exit code, to avoid false positives.

- Split patch "t/helper/test-config: return exit codes consistently" into
  three separated ones, as these are in fact three non-related changes:
	"t/helper/test-config: unify exit labels"
	"t/helper/test-config: check argc before accessing argv"
	"t/helper/test-config: be consistent with exit codes"

- Removed TC_USAGE_ERROR in favor of calling die(). Also removed the
  test_config_exit_code enum.

- On "config: correctly read worktree configs in submodules":
  * Improved commit message to focus on the problem instead of the
    implementation and remove section about the grep example.
  * Made use of the parse_options API
  * Allocated subrepo struct in the stack instead of malloc()'ing.

Matheus Tavares (8):
  doc: grep: unify info on configuration variables
  t1308-config-set: avoid false positives when using test-config
  t/helper/test-config: be consistent with exit codes
  t/helper/test-config: check argc before accessing argv
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
 builtin/grep.c                         | 134 ++++++++++-
 config.c                               |  21 +-
 contrib/completion/git-completion.bash |   2 +
 git.c                                  |   5 +
 sparse-checkout.c                      |  18 ++
 sparse-checkout.h                      |  11 +
 t/helper/test-config.c                 | 126 ++++++----
 t/t1308-config-set.sh                  |   8 +-
 t/t2404-worktree-config.sh             |  16 ++
 t/t7011-skip-worktree-reading.sh       |   9 -
 t/t7817-grep-sparse-checkout.sh        | 321 +++++++++++++++++++++++++
 t/t9902-completion.sh                  |   4 +-
 18 files changed, 652 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h
 create mode 100755 t/t7817-grep-sparse-checkout.sh

Range-diff against v4:
1:  fc47a96bfa = 1:  70c9a4e741 doc: grep: unify info on configuration variables
-:  ---------- > 2:  f53782f14c t1308-config-set: avoid false positives when using test-config
-:  ---------- > 3:  85e1588d6c t/helper/test-config: be consistent with exit codes
-:  ---------- > 4:  0750191342 t/helper/test-config: check argc before accessing argv
2:  874aab36dd ! 5:  56535b0e36 t/helper/test-config: return exit codes consistently
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    t/helper/test-config: return exit codes consistently
    +    t/helper/test-config: unify exit labels
     
    -    The test-config helper may exit with a variety of at least four
    -    different codes, to reflect the status of the requested operations.
    -    These codes are sometimes checked in the tests, but not all of the codes
    -    are returned consistently by the helper: 1 will usually refer to a
    -    "value not found", but usage errors can also return 1 or 128. Moreover,
    -    128 is also expected on errors within the configset functions. These
    -    inconsistent uses of the exit codes can lead to false positives in the
    -    tests. Although all tests which expect errors and check the helper's
    -    exit code currently also check the output, it's still better to
    -    standardize the exit codes and avoid future problems in new tests.
    -    While we are here, let's also check that we have the expected argc for
    -    configset_get_value and configset_get_value_multi, before trying to use
    -    argv.
    -
    -    Note: this change is implemented with the unification of the exit
    -    labels. This might seem unnecessary, for now, but it will benefit the
    -    next patch, which will increase the cleanup section.
    +    test-config's main function has three different exit labels, all of
    +    which have to perform the same cleanup code before returning. Unify the
    +    labels in preparation for a future patch which will increase the cleanup
    +    section.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## t/helper/test-config.c ##
    -@@
    -  * iterate -> iterate over all values using git_config(), and print some
    -  *            data for each
    -  *
    -+ * Exit codes:
    -+ *     0:   success
    -+ *     1:   value not found for the given config key
    -+ *     2:   config file path given as argument is inaccessible or doesn't exist
    -+ *     129: test-config usage error
    -+ *
    -+ * Note: tests may also expect 128 for die() calls in the config machinery.
    -+ *
    -  * Examples:
    -  *
    -  * To print the value with highest priority for key "foo.bAr Baz.rock":
     @@ t/helper/test-config.c: static int early_config_cb(const char *var, const char *value, void *vdata)
      	return 0;
      }
      
    -+enum test_config_exit_code {
    -+	TC_SUCCESS = 0,
    -+	TC_VALUE_NOT_FOUND = 1,
    -+	TC_CONFIG_FILE_ERROR = 2,
    -+	TC_USAGE_ERROR = 129,
    -+};
    ++#define TC_VALUE_NOT_FOUND 1
    ++#define TC_CONFIG_FILE_ERROR 2
     +
      int cmd__config(int argc, const char **argv)
      {
    - 	int i, val;
    +-	int i, val;
    ++	int i, val, ret = 0;
      	const char *v;
      	const struct string_list *strptr;
      	struct config_set cs;
    -+	enum test_config_exit_code ret = TC_SUCCESS;
      
      	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
      		read_early_config(early_config_cb, (void *)argv[2]);
     -		return 0;
    -+		return TC_SUCCESS;
    ++		return ret;
      	}
      
      	setup_git_directory();
    - 
    - 	git_configset_init(&cs);
    - 
    --	if (argc < 2) {
    --		fprintf(stderr, "Please, provide a command name on the command-line\n");
    --		goto exit1;
    --	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
    -+	if (argc < 2)
    -+		goto print_usage_error;
    -+
    -+	if (argc == 3 && !strcmp(argv[1], "get_value")) {
    - 		if (!git_config_get_value(argv[2], &v)) {
    - 			if (!v)
    +@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      				printf("(NULL)\n");
      			else
      				printf("%s\n", v);
    @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
     -			goto exit1;
     +			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (!strcmp(argv[1], "configset_get_value")) {
    -+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
    + 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
      		for (i = 3; i < argc; i++) {
      			int err;
      			if ((err = git_configset_add_file(&cs, argv[i]))) {
    @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
     -			goto exit1;
     +			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
    -+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
    + 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
      		for (i = 3; i < argc; i++) {
      			int err;
      			if ((err = git_configset_add_file(&cs, argv[i]))) {
    @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      		git_config(iterate_cb, NULL);
     -		goto exit0;
     +	} else {
    -+print_usage_error:
    -+		fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
    -+		ret = TC_USAGE_ERROR;
    ++		die("%s: Please check the syntax and the function name", argv[0]);
      	}
      
     -	die("%s: Please check the syntax and the function name", argv[0]);
3:  c5093099f3 < -:  ---------- t/helper/test-config: facilitate addition of new cli options
4:  b510de0de0 ! 6:  3e02e1bd24 config: correctly read worktree configs in submodules
    @@ Metadata
      ## Commit message ##
         config: correctly read worktree configs in submodules
     
    -    One of the steps in do_git_config_sequence() is to load the
    -    worktree-specific config file. Although the function receives a git_dir
    -    string, it relies on git_pathdup(), which uses the_repository->git_dir,
    -    to make the path to the file. Furthermore, it also checks that
    -    extensions.worktreeConfig is set through the
    -    repository_format_worktree_config variable, which refers to
    -    the_repository only. Thus, when a submodule has worktree-specific
    -    settings, a command executed in the superproject that recurses into the
    -    submodule won't find the said settings.
    +    The config machinery is not able to read worktree configs from a
    +    submodule in a process where the_repository represents the superproject.
    +    Furthermore, when extensions.worktreeConfig is set on the superproject,
    +    querying for a worktree config in a submodule will, instead, return
    +    the value set at the superproject.
     
    -    This will be especially important in the next patch: git-grep will learn
    -    to honor sparse checkouts and, when running with --recurse-submodules,
    -    the submodule's sparse checkout settings must be loaded. As these
    -    settings are stored in the config.worktree file, they would be ignored
    -    without this patch. So let's fix this by reading the right
    -    config.worktree file and extensions.worktreeConfig setting, based on the
    -    git_dir and commondir paths given to do_git_config_sequence(). Also
    -    add a test to avoid any regressions.
    +    The problem resides in do_git_config_sequence(). Although the function
    +    receives a git_dir string, it uses the_repository->git_dir when making
    +    the path to the worktree config file. And when checking if
    +    extensions.worktreeConfig is set, it uses the global
    +    repository_format_worktree_config variable, which refers to
    +    the_repository only. So let's fix this by using the git_dir given to the
    +    function and reading the extension value from the right place. Also add
    +    a test to avoid any regressions.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ t/helper/test-config.c
      #include "config.h"
      #include "string-list.h"
     +#include "submodule-config.h"
    ++#include "parse-options.h"
      
      /*
       * This program exposes the C API of the configuration mechanism
    @@ t/helper/test-config.c
       *
       * get_value -> prints the value with highest priority for the entered key
       *
    -@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    +@@ t/helper/test-config.c: static int early_config_cb(const char *var, const char *value, void *vdata)
    + #define TC_VALUE_NOT_FOUND 1
    + #define TC_CONFIG_FILE_ERROR 2
    + 
    ++static const char *test_config_usage[] = {
    ++	"test-tool config [--submodule=<path>] <cmd> [<args>]",
    ++	NULL
    ++};
    ++
    + int cmd__config(int argc, const char **argv)
    + {
    + 	int i, val, ret = 0;
    + 	const char *v;
      	const struct string_list *strptr;
    - 	struct config_set cs = { .hash_initialized = 0 };
    - 	enum test_config_exit_code ret = TC_SUCCESS;
    -+	struct repository *repo = the_repository;
    + 	struct config_set cs;
    ++	struct repository subrepo, *repo = the_repository;
     +	const char *subrepo_path = NULL;
    - 
    - 	argc--; /* skip over "config" */
    - 	argv++;
    -@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 	if (argc == 0)
    - 		goto print_usage_error;
    - 
    -+	if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
    -+		argc--;
    -+		argv++;
    -+		if (argc == 0)
    -+			goto print_usage_error;
    -+	}
     +
    - 	if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
    -+		if (subrepo_path) {
    -+			fprintf(stderr, "Cannot use --submodule with read_early_config\n");
    -+			return TC_USAGE_ERROR;
    -+		}
    - 		read_early_config(early_config_cb, (void *)argv[1]);
    - 		return TC_SUCCESS;
    ++	struct option options[] = {
    ++		OPT_STRING(0, "submodule", &subrepo_path, "path",
    ++			   "run <cmd> on the submodule at <path>"),
    ++		OPT_END()
    ++	};
    ++
    ++	argc = parse_options(argc, argv, NULL, options, test_config_usage,
    ++			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
    ++	if (argc < 2)
    ++		die("Please, provide a command name on the command-line");
    + 
    + 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
    ++		if (subrepo_path)
    ++			die("cannot use --submodule with read_early_config");
    + 		read_early_config(early_config_cb, (void *)argv[2]);
    + 		return ret;
      	}
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 	setup_git_directory();
    + 
      	git_configset_init(&cs);
      
    +-	if (argc < 2)
    +-		die("Please, provide a command name on the command-line");
     +	if (subrepo_path) {
     +		const struct submodule *sub;
    -+		struct repository *subrepo = xcalloc(1, sizeof(*repo));
     +
     +		sub = submodule_from_path(the_repository, &null_oid, subrepo_path);
    -+		if (!sub || repo_submodule_init(subrepo, the_repository, sub)) {
    -+			fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
    -+				subrepo_path);
    -+			free(subrepo);
    -+			ret = TC_USAGE_ERROR;
    -+			goto out;
    -+		}
    -+		repo = subrepo;
    -+	}
    ++		if (!sub || repo_submodule_init(&subrepo, the_repository, sub))
    ++			die("invalid argument to --submodule: '%s'", subrepo_path);
     +
    - 	if (argc == 2 && !strcmp(argv[0], "get_value")) {
    --		if (!git_config_get_value(argv[1], &v)) {
    -+		if (!repo_config_get_value(repo, argv[1], &v)) {
    ++		repo = &subrepo;
    ++	}
    + 
    + 	if (argc == 3 && !strcmp(argv[1], "get_value")) {
    +-		if (!git_config_get_value(argv[2], &v)) {
    ++		if (!repo_config_get_value(repo, argv[2], &v)) {
      			if (!v)
      				printf("(NULL)\n");
      			else
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
    --		strptr = git_config_get_value_multi(argv[1]);
    -+		strptr = repo_config_get_value_multi(repo, argv[1]);
    + 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
    +-		strptr = git_config_get_value_multi(argv[2]);
    ++		strptr = repo_config_get_value_multi(repo, argv[2]);
      		if (strptr) {
      			for (i = 0; i < strptr->nr; i++) {
      				v = strptr->items[i].string;
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (argc == 2 && !strcmp(argv[0], "get_int")) {
    --		if (!git_config_get_int(argv[1], &val)) {
    -+		if (!repo_config_get_int(repo, argv[1], &val)) {
    + 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
    +-		if (!git_config_get_int(argv[2], &val)) {
    ++		if (!repo_config_get_int(repo, argv[2], &val)) {
      			printf("%d\n", val);
      		} else {
    - 			printf("Value not found for \"%s\"\n", argv[1]);
    + 			printf("Value not found for \"%s\"\n", argv[2]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
    --		if (!git_config_get_bool(argv[1], &val)) {
    -+		if (!repo_config_get_bool(repo, argv[1], &val)) {
    + 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
    +-		if (!git_config_get_bool(argv[2], &val)) {
    ++		if (!repo_config_get_bool(repo, argv[2], &val)) {
      			printf("%d\n", val);
      		} else {
     +
    - 			printf("Value not found for \"%s\"\n", argv[1]);
    + 			printf("Value not found for \"%s\"\n", argv[2]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (argc == 2 && !strcmp(argv[0], "get_string")) {
    --		if (!git_config_get_string_tmp(argv[1], &v)) {
    -+		if (!repo_config_get_string_tmp(repo, argv[1], &v)) {
    + 	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
    +-		if (!git_config_get_string_tmp(argv[2], &v)) {
    ++		if (!repo_config_get_string_tmp(repo, argv[2], &v)) {
      			printf("%s\n", v);
      		} else {
    - 			printf("Value not found for \"%s\"\n", argv[1]);
    + 			printf("Value not found for \"%s\"\n", argv[2]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
    -+		if (subrepo_path) {
    -+			fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
    -+			ret = TC_USAGE_ERROR;
    -+			goto out;
    -+		}
    - 		for (i = 2; i < argc; i++) {
    + 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
    ++		if (subrepo_path)
    ++			die("cannot use --submodule with configset_get_value");
    ++
    + 		for (i = 3; i < argc; i++) {
      			int err;
      			if ((err = git_configset_add_file(&cs, argv[i]))) {
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
    -+		if (subrepo_path) {
    -+			fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
    -+			ret = TC_USAGE_ERROR;
    -+			goto out;
    -+		}
    - 		for (i = 2; i < argc; i++) {
    + 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
    ++		if (subrepo_path)
    ++			die("cannot use --submodule with configset_get_value_multi");
    ++
    + 		for (i = 3; i < argc; i++) {
      			int err;
      			if ((err = git_configset_add_file(&cs, argv[i]))) {
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      			ret = TC_VALUE_NOT_FOUND;
      		}
    - 	} else if (!strcmp(argv[0], "iterate")) {
    + 	} else if (!strcmp(argv[1], "iterate")) {
     -		git_config(iterate_cb, NULL);
     +		repo_config(repo, iterate_cb, NULL);
      	} else {
    - print_usage_error:
    --		fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
    -+		fprintf(stderr, "Invalid syntax. Usage: test-tool config"
    -+				" [--submodule=<path>] <cmd> [args]\n");
    - 		ret = TC_USAGE_ERROR;
    + 		die("%s: Please check the syntax and the function name", argv[0]);
      	}
      
      out:
      	git_configset_clear(&cs);
    -+	if (repo != the_repository) {
    ++	if (repo != the_repository)
     +		repo_clear(repo);
    -+		free(repo);
    -+	}
      	return ret;
      }
     
5:  6d9720abf5 = 7:  902556a7b6 grep: honor sparse checkout patterns
6:  affb931d35 = 8:  70e7d7b90c config: add setting to ignore sparsity patterns in some cmds
-- 
2.28.0

