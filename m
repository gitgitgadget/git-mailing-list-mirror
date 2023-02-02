Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD21AC636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjBBN15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjBBN1x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:27:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01B18C43F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so1719661wru.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xtzko03anEzaPnq545+EvZSS4/9b6WJyvGQFUSxnyI=;
        b=pd6xzSFfaPQG/WeRYbYIArLc6ZWbTwIhFlRPwhoOFYLpGyF8MSd8jcLHFuyS65YR9U
         ylJZs2aldbzspcF4Dmu8vJzlOl4TY1+ImfjktjrazYmX7P3CW6/3SrkeOZqE8O2SbF01
         +5sbdi/qjrN6FtONkICcEK0p4Bj4oVMZK6+fGZt76jyxkU+Rm3ix662YkDRtU+Yf/DVm
         HPt3oNdWMWFQEJAdfR98sWKnpzRvcbsfPU6TaFtJnyFl/R0leLN3CjLj8NjcDh49yxJO
         d7OK1H4Fm0k5JrvgvbFn3vZpEzUqLF84d4BImPGfnKqhv+xfMWnFstUNrfOsq87rsaIy
         Rp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xtzko03anEzaPnq545+EvZSS4/9b6WJyvGQFUSxnyI=;
        b=MsrvXqijE9GhCZnO2NheuMSCTIlXLoD6vLHqQ2XAafxr/7LXVV0QagwLQpuugwzwTR
         4rSbPcqiQZYkm719kOi1f1P+ig0mwRGwaLvdWEcm95DKo0SDwlMgkZrZgcKIUrzxTqu3
         SjeIutx7rBCCgpIbyCiw0yvrncF5gC7U1XZe0V1Elo0zUQKDa/tgQqXeXkFJ0a6MKD3d
         qeuFDezTiX1qNTEWkm5554LvP2bGYb1hjvsIl1fjc2y0jxMS1aXiMgEzzX1W/o1KZ58I
         Vb4BWE4H5q4v/HF46IW+LcNnfjSwEu/1fpcfH+WSgguax1ylnUM3MW4/nEoForPPUNqv
         HBRQ==
X-Gm-Message-State: AO0yUKX1UCJP9Zr49MNg2u+tuo/BW0v3EVaULjXjl7As17IP8ZYKKPZK
        hKLFgY9qJjNzZndpb2e/AWmVfq0DECUwgRZm
X-Google-Smtp-Source: AK7set9ipRzFd2CzCdX1MOTfJvcSP4wqX4QjZ19GWQ6eUoM6DHm3CEf63/XX60VSI/58c5f3vmovcg==
X-Received: by 2002:a5d:5a83:0:b0:2bf:ecd8:c9f4 with SMTP id bp3-20020a5d5a83000000b002bfecd8c9f4mr6523428wrb.55.1675344447441;
        Thu, 02 Feb 2023 05:27:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/9] config API: make "multi" safe, fix numerous segfaults
Date:   Thu,  2 Feb 2023 14:27:12 +0100
Message-Id: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes numerous segfaults in config API users, because they
didn't expect *_get_multi() to hand them a string_list with a NULL in
it given config like "[a] key" (note, no "="'s).

A larger general overview at v1[1], but note the API changes in
v2[2]. Changes since v3[3] (in particular thanks to this series being
featured in the Review Club[4]):

* It wasn't clear from the early test commit messages why certain
  things were being tested, if the test were exhaustive etc. Covered
  that.

* Rewrote 2/9 to use a test helper function, which gives us better
  coverage.

* The v1 included a "lookup_value" family of functions, as some of the
  "multi" users are only using the API to check key existence.

  The feedback on that was that the API naming din't make sense[6],
  which I agree with. Rather than having e.g. a git_config_exists() we
  introduce a git_config_get(), this is just like
  git_config_get_{value,string,int,...}(), except that we don't have a
  "dest" argument.

  Other than that it works the same way, i.e. the return value
  indicates existence (or other errors).

  This helps to make subsequent changes smaller, as our "real" API
  conversion no longer needs to deal with these callers.

* Various other small tidbits, see the range-diff below.

CI & branch for this topic at:
https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com/
4. https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w
5. https://lore.kernel.org/git/patch-07.10-c01f7d85c94-20221026T151328Z-avarab@gmail.com/
6. https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (9):
  config tests: cover blind spots in git_die_config() tests
  config tests: add "NULL" tests for *_get_value_multi()
  config API: add and use a "git_config_get()" family of functions
  versioncmp.c: refactor config reading next commit
  config API: have *_multi() return an "int" and take a "dest"
  for-each-repo: error on bad --config
  config API users: test for *_get_value_multi() segfaults
  config API: add "string" version of *_value_multi(), fix segfaults
  for-each-repo: with bad config, don't conflate <path> and <cmd>

 builtin/for-each-repo.c              |  14 ++--
 builtin/gc.c                         |  15 ++--
 builtin/log.c                        |   6 +-
 builtin/submodule--helper.c          |   7 +-
 builtin/worktree.c                   |   3 +-
 config.c                             | 108 ++++++++++++++++++++++-----
 config.h                             |  69 ++++++++++++++---
 pack-bitmap.c                        |   6 +-
 submodule.c                          |   3 +-
 t/helper/test-config.c               |   6 +-
 t/t0068-for-each-repo.sh             |  19 +++++
 t/t1308-config-set.sh                |  41 ++++++++++
 t/t3309-notes-merge-auto-resolve.sh  |   7 +-
 t/t4202-log.sh                       |  15 ++++
 t/t5304-prune.sh                     |  12 ++-
 t/t5310-pack-bitmaps.sh              |  20 +++++
 t/t5552-skipping-fetch-negotiator.sh |  16 ++++
 t/t7004-tag.sh                       |  17 +++++
 t/t7413-submodule-is-active.sh       |  16 ++++
 t/t7900-maintenance.sh               |  38 ++++++++++
 versioncmp.c                         |  22 ++++--
 21 files changed, 388 insertions(+), 72 deletions(-)

Range-diff against v3:
 1:  5c8819ff388 <  -:  ----------- for-each-repo tests: test bad --config keys
 2:  3eb8da6086d !  1:  4ae56cab7c7 config tests: cover blind spots in git_die_config() tests
    @@ Commit message
         `git_die_config()` to the config-set API, 2014-08-07). We only tested
         "test_must_fail", but didn't assert the output.
     
    -    Let's check for that by extending the existing tests, and adding a new
    -    one for "fetch.negotiationAlgorithm" so that we have a test for a user
    -    of git_config_get_string*() calling git_die_config().
    +    We need tests for this because a subsequent commit will alter the
    +    return value of git_config_get_value_multi(), which is used to get the
    +    config values in the git_die_config() function. This test coverage
    +    helps to build confidence in that subsequent change.
     
    -    The other ones are testing:
    +    These tests cover different interactions with git_die_config():
     
    -    - For *-resolve.sh: A custom call to git_die_config(), or via
    -      git_config_get_notes_strategy()
    -    - For *-prune.sh: A call via git_config_get_expiry().
    +    - The "notes.mergeStrategy" test in
    +      "t/t3309-notes-merge-auto-resolve.sh" is a case where a function
    +      outside of config.c (git_config_get_notes_strategy()) calls
    +      git_die_config().
    +
    +    - The "gc.pruneExpire" test in "t5304-prune.sh" is a case where
    +      git_config_get_expiry() calls git_die_config(), covering a different
    +      "type" than the "string" test for "notes.mergeStrategy".
    +
    +    - The "fetch.negotiationAlgorithm" test in
    +      "t/t5552-skipping-fetch-negotiator.sh" is a case where
    +      git_config_get_string*() calls git_die_config().
     
         We also cover both the "from command-line config" and "in file..at
         line" cases here.
 3:  14b08dfc162 !  2:  1f0f8bdcde9 config tests: add "NULL" tests for *_get_value_multi()
    @@ Commit message
         git_config_bool() in 17712991a59 (Add ".git/config" file parser,
         2005-10-10).
     
    -    When the "t/t1308-config-set.sh" tests were added in [1] only one of
    -    the three "(NULL)" lines in "t/helper/test-config.c" had any test
    -    coverage. This change adds tests that stress the remaining two.
    +    When parts of the config_set API were tested for in [1] they didn't
    +    add coverage for 3/4 of the "(NULL)" cases handled in
    +    "t/helper/test-config.c". We'd test that case for "get_value", but not
    +    "get_value_multi", "configset_get_value" and
    +    "configset_get_value_multi".
    +
    +    We now cover all of those cases, which in turn expose the details of
    +    how this part of the config API works.
     
         1. 4c715ebb96a (test-config: add tests for the config_set API,
            2014-07-28)
    @@ t/t1308-config-set.sh: test_expect_success 'find multiple values' '
      	check_config get_value_multi case.baz sam bat hask
      '
      
    -+test_expect_success 'emit multi values from configset with NULL entry' '
    -+	test_when_finished "rm -f my.config" &&
    -+	cat >my.config <<-\EOF &&
    -+	[a]key=x
    -+	[a]key
    -+	[a]key=y
    -+	EOF
    -+	cat >expect <<-\EOF &&
    -+	x
    -+	(NULL)
    -+	y
    -+	EOF
    -+	test-tool config configset_get_value_multi a.key my.config >actual &&
    -+	test_cmp expect actual
    -+'
    ++test_NULL_in_multi () {
    ++	local op="$1" &&
    ++	local file="$2" &&
    ++
    ++	test_expect_success "$op: NULL value in config${file:+ in $file}" '
    ++		config="$file" &&
    ++		if test -z "$config"
    ++		then
    ++			config=.git/config &&
    ++			test_when_finished "mv $config.old $config" &&
    ++			mv "$config" "$config".old
    ++		fi &&
    ++
    ++		cat >"$config" <<-\EOF &&
    ++		[a]key=x
    ++		[a]key
    ++		[a]key=y
    ++		EOF
    ++		case "$op" in
    ++		*_multi)
    ++			cat >expect <<-\EOF
    ++			x
    ++			(NULL)
    ++			y
    ++			EOF
    ++			;;
    ++		*)
    ++			cat >expect <<-\EOF
    ++			y
    ++			EOF
    ++			;;
    ++		esac &&
    ++		test-tool config "$op" a.key $file >actual &&
    ++		test_cmp expect actual
    ++	'
    ++}
     +
    -+test_expect_success 'multi values from configset with a last NULL entry' '
    -+	test_when_finished "rm -f my.config" &&
    -+	cat >my.config <<-\EOF &&
    -+	[a]key=x
    -+	[a]key=y
    -+	[a]key
    -+	EOF
    -+	cat >expect <<-\EOF &&
    -+	(NULL)
    -+	EOF
    -+	test-tool config configset_get_value a.key my.config >actual &&
    -+	test_cmp expect actual
    -+'
    ++test_NULL_in_multi "get_value_multi"
    ++test_NULL_in_multi "configset_get_value" "my.config"
    ++test_NULL_in_multi "configset_get_value_multi" "my.config"
     +
      test_expect_success 'find value from a configset' '
      	cat >config2 <<-\EOF &&
 -:  ----------- >  3:  998b11ae4bc config API: add and use a "git_config_get()" family of functions
 4:  cb802b30cd8 !  4:  aae1d5c12a9 versioncmp.c: refactor config reading next commit
    @@ Commit message
         Refactor the reading of the versionSort.suffix and
         versionSort.prereleaseSuffix configuration variables to stay within
         the bounds of our CodingGuidelines when it comes to line length, and
    -    ta avoid repeating ourselves.
    +    to avoid repeating ourselves.
     
         Let's also split out the names of the config variables into variables
         of our own, so we don't have to repeat ourselves, and refactor the
 5:  e0e6ade3f38 !  5:  23449ff2c4e config API: have *_multi() return an "int" and take a "dest"
    @@ Commit message
         subsequent commits, but for now we're faithfully converting existing
         API callers.
     
    -    See [1] for the initial addition of "git_configset_get_value_multi()"
    -
    -    1. 3c8687a73ee (add `config_set` API for caching config-like files,
    -       2014-07-28).
    -
         A logical follow-up to this would be to change the various "*_get_*()"
         functions to ferry the git_configset_get_value() return value to their
         own callers, e.g. git_configset_get_int() returns "1" rather than
    @@ Commit message
     
         Most of this is straightforward, commentary on cases that stand out:
     
    -    - As we've tested for in a preceding commit we can rely on getting the
    -      config list in git_die_config(), and as we need to handle the new
    -      return value let's BUG() out if we can't acquire it.
    +    - To ensure that we'll properly use the return values of this function
    +      in the future we're using the "RESULT_MUST_BE_USED" macro introduced
    +      in [1].
     
    -    - In "builtin/for-each-ref.c" we could preserve the comment added in
    -      6c62f015520, but now that we're directly using the documented
    -      repo_config_get_value_multi() value it's just narrating something that
    -      should be obvious from the API use, so let's drop it.
    +      As git_die_config() now has to handle this return value let's have
    +      it BUG() if it can't find the config entry. As tested for in a
    +      preceding commit we can rely on getting the config list in
    +      git_die_config().
     
         - The loops after getting the "list" value in "builtin/gc.c" could
           also make use of "unsorted_string_list_has_string()" instead of using
           that loop, but let's leave that for now.
     
    -    - We have code e.g. in "builtin/submodule--helper.c" that only wants
    -      to check if a config key exists, and would be better served with
    -      another API, but let's keep using "git_configset_get_value_multi()"
    -      for now.
    -
         - In "versioncmp.c" we now use the return value of the functions,
    -      instead of checking if the lists are still non-NULL. This is strictly
    -      speaking unnecessary, but makes the API use consistent with the rest,
    -      but more importantly...
    +      instead of checking if the lists are still non-NULL.
     
    -    - ...because we always check our return values we can assert that with
    -      the RESULT_MUST_BE_USED macro added in 1e8697b5c4e (submodule--helper:
    -      check repo{_submodule,}_init() return values, 2022-09-01)
    +    1. 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
    +       return values, 2022-09-01),
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/for-each-repo.c ##
    -@@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
    - 	static const char *config_key = NULL;
    - 	int i, result = 0;
    - 	const struct string_list *values;
    -+	int err;
    - 
    - 	const struct option options[] = {
    - 		OPT_STRING(0, "config", &config_key, N_("config"),
     @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
      	if (!config_key)
      		die(_("missing --config=<config>"));
    @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
     -	values = repo_config_get_value_multi(the_repository,
     -					     config_key);
     -
    --	/*
    --	 * Do nothing on an empty list, which is equivalent to the case
    --	 * where the config variable does not exist at all.
    --	 */
    + 	/*
    + 	 * Do nothing on an empty list, which is equivalent to the case
    + 	 * where the config variable does not exist at all.
    + 	 */
     -	if (!values)
    -+	err = repo_config_get_value_multi(the_repository, config_key, &values);
    -+	if (err < 0)
    -+		return 0;
    -+	else if (err)
    ++	if (repo_config_get_value_multi(the_repository, config_key, &values))
      		return 0;
      
      	for (i = 0; !result && i < values->nr; i++)
     
      ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_register(int argc, const char **argv, const char *prefix)
    - 	else
    + 	if (git_config_get("maintenance.strategy"))
      		git_config_set("maintenance.strategy", "incremental");
      
     -	list = git_config_get_value_multi(key);
    @@ builtin/log.c: static void set_default_decoration_filter(struct decoration_filte
      		for_each_string_list_item(item, config_exclude)
      			string_list_append(decoration_filter->exclude_ref_config_pattern,
     
    - ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv, const char *prefix)
    - 		NULL
    - 	};
    - 	int ret = 1;
    -+	const struct string_list *values;
    - 
    - 	argc = parse_options(argc, argv, prefix, module_init_options,
    - 			     git_submodule_helper_usage, 0);
    -@@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv, const char *prefix)
    - 	 * If there are no path args and submodule.active is set then,
    - 	 * by default, only initialize 'active' modules.
    - 	 */
    --	if (!argc && git_config_get_value_multi("submodule.active"))
    -+	if (!argc && !git_config_get_value_multi("submodule.active", &values))
    - 		module_list_active(&list);
    - 
    - 	info.prefix = prefix;
    -@@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
    - 	if (opt.init) {
    - 		struct module_list list = MODULE_LIST_INIT;
    - 		struct init_cb info = INIT_CB_INIT;
    -+		const struct string_list *values;
    - 
    - 		if (module_list_compute(argv, opt.prefix,
    - 					&pathspec2, &list) < 0) {
    -@@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
    - 		 * If there are no path args and submodule.active is set then,
    - 		 * by default, only initialize 'active' modules.
    - 		 */
    --		if (!argc && git_config_get_value_multi("submodule.active"))
    -+		if (!argc && !git_config_get_value_multi("submodule.active",
    -+							 &values))
    - 			module_list_active(&list);
    - 
    - 		info.prefix = opt.prefix;
    -
      ## config.c ##
    -@@ config.c: void read_very_early_config(config_fn_t cb, void *data)
    - 	config_with_options(cb, data, NULL, &opts);
    - }
    - 
    --static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
    -+static int configset_find_element(struct config_set *cs, const char *key,
    -+				  struct config_set_element **dest)
    - {
    - 	struct config_set_element k;
    - 	struct config_set_element *found_entry;
    - 	char *normalized_key;
    -+	int ret;
    -+
    - 	/*
    - 	 * `key` may come from the user, so normalize it before using it
    - 	 * for querying entries from the hashmap.
    - 	 */
    --	if (git_config_parse_key(key, &normalized_key, NULL))
    --		return NULL;
    -+	ret = git_config_parse_key(key, &normalized_key, NULL);
    -+	if (ret < 0)
    -+		return ret;
    - 
    - 	hashmap_entry_init(&k.ent, strhash(normalized_key));
    - 	k.key = normalized_key;
    - 	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
    - 	free(normalized_key);
    --	return found_entry;
    -+	*dest = found_entry;
    -+	return 0;
    - }
    - 
    - static int configset_add_value(struct config_set *cs, const char *key, const char *value)
    -@@ config.c: static int configset_add_value(struct config_set *cs, const char *key, const cha
    - 	struct string_list_item *si;
    - 	struct configset_list_item *l_item;
    - 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
    -+	int ret;
    - 
    --	e = configset_find_element(cs, key);
    -+	ret = configset_find_element(cs, key, &e);
    -+	if (ret < 0)
    -+		return ret;
    - 	/*
    - 	 * Since the keys are being fed by git_config*() callback mechanism, they
    - 	 * are already normalized. So simply add them without any further munging.
     @@ config.c: int git_configset_add_file(struct config_set *cs, const char *filename)
      int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
      {
    @@ config.c: int git_configset_add_file(struct config_set *cs, const char *filename
      	 * value in the value list for that key.
      	 */
     -	values = git_configset_get_value_multi(cs, key);
    -+	ret = git_configset_get_value_multi(cs, key, &values);
    ++	if ((ret = git_configset_get_value_multi(cs, key, &values)))
    ++		return ret;
      
     -	if (!values)
    -+	if (ret < 0)
    -+		return ret;
    -+	else if (!values)
    - 		return 1;
    +-		return 1;
      	assert(values->nr > 0);
      	*value = values->items[values->nr - 1].string;
      	return 0;
    @@ config.c: int git_configset_add_file(struct config_set *cs, const char *filename
     +int git_configset_get_value_multi(struct config_set *cs, const char *key,
     +				  const struct string_list **dest)
      {
    --	struct config_set_element *e = configset_find_element(cs, key);
    --	return e ? &e->value_list : NULL;
    -+	struct config_set_element *e;
    + 	struct config_set_element *e;
     +	int ret;
    -+
    -+	ret = configset_find_element(cs, key, &e);
    -+	if (ret < 0)
    + 
    +-	if (configset_find_element(cs, key, &e))
    +-		return NULL;
    ++	if ((ret = configset_find_element(cs, key, &e)))
     +		return ret;
    -+	else if (!e)
    + 	else if (!e)
    +-		return NULL;
    +-	return &e->value_list;
     +		return 1;
     +	*dest = &e->value_list;
     +
     +	return 0;
      }
      
    - int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
    + int git_configset_get(struct config_set *cs, const char *key)
     @@ config.c: int repo_config_get_value(struct repository *repo,
      	return git_configset_get_value(repo->config, key, value);
      }
    @@ config.h: int git_configset_add_parameters(struct config_set *cs);
      
      /**
       * Clears `config_set` structure, removes all saved variable-value pairs.
    -@@ config.h: struct repository;
    - void repo_config(struct repository *repo, config_fn_t fn, void *data);
    +@@ config.h: RESULT_MUST_BE_USED
    + int repo_config_get(struct repository *repo, const char *key);
      int repo_config_get_value(struct repository *repo,
      			  const char *key, const char **value);
     -const struct string_list *repo_config_get_value_multi(struct repository *repo,
 6:  06d502bc577 !  6:  17c1218e74c for-each-repo: error on bad --config
    @@ Commit message
         2021-01-08) this command wants to ignore a non-existing config key,
         but let's not conflate that with bad config.
     
    +    Before this, all these added tests would pass with an exit code of 0.
    +
    +    We could preserve the comment added in 6c62f015520, but now that we're
    +    directly using the documented repo_config_get_value_multi() value it's
    +    just narrating something that should be obvious from the API use, so
    +    let's drop it.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/for-each-repo.c ##
     @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
    + 	static const char *config_key = NULL;
    + 	int i, result = 0;
    + 	const struct string_list *values;
    ++	int err;
    + 
    + 	const struct option options[] = {
    + 		OPT_STRING(0, "config", &config_key, N_("config"),
    +@@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
    + 	if (!config_key)
    + 		die(_("missing --config=<config>"));
      
    - 	err = repo_config_get_value_multi(the_repository, config_key, &values);
    - 	if (err < 0)
    --		return 0;
    +-	/*
    +-	 * Do nothing on an empty list, which is equivalent to the case
    +-	 * where the config variable does not exist at all.
    +-	 */
    +-	if (repo_config_get_value_multi(the_repository, config_key, &values))
    ++	err = repo_config_get_value_multi(the_repository, config_key, &values);
    ++	if (err < 0)
     +		usage_msg_optf(_("got bad config --config=%s"),
     +			       for_each_repo_usage, options, config_key);
    - 	else if (err)
    ++	else if (err)
      		return 0;
      
    + 	for (i = 0; !result && i < values->nr; i++)
     
      ## t/t0068-for-each-repo.sh ##
     @@ t/t0068-for-each-repo.sh: test_expect_success 'do nothing on empty config' '
      	git for-each-repo --config=bogus.config -- help --no-such-option
      '
      
    --test_expect_success 'bad config keys' '
    --	git for-each-repo --config=a &&
    --	git for-each-repo --config=a.b. &&
    --	git for-each-repo --config="'\''.b"
     +test_expect_success 'error on bad config keys' '
     +	test_expect_code 129 git for-each-repo --config=a &&
     +	test_expect_code 129 git for-each-repo --config=a.b. &&
     +	test_expect_code 129 git for-each-repo --config="'\''.b"
    - '
    - 
    ++'
    ++
      test_done
 7:  f35aacef4ca !  7:  7fc91eaf747 config API users: test for *_get_value_multi() segfaults
    @@ Metadata
      ## Commit message ##
         config API users: test for *_get_value_multi() segfaults
     
    -    As we'll discus in the subsequent commit these tests all
    +    As we'll discuss in the subsequent commit these tests all
         show *_get_value_multi() API users unable to handle there being a
         value-less key in the config, which is represented with a "NULL" for
         that entry in the "string" member of the returned "struct
         string_list", causing a segfault.
     
    +    These added tests exhaustively test for that issue, as we'll see in a
    +    subsequent commit we'll need to change all of the API users
    +    of *_get_value_multi(). These cases were discovered by triggering each
    +    one individually, and then adding these tests.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t4202-log.sh ##
    @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
     +	[maintenance]
     +		repo
     +	EOF
    -+	cat >expect <<-\EOF &&
    -+	error: missing value for '\''maintenance.repo'\''
    -+	EOF
     +	git maintenance unregister &&
     +	git maintenance unregister --force
     +'
 8:  b45189b4624 !  8:  a391ee17617 config API: add "string" version of *_value_multi(), fix segfaults
    @@ Commit message
     
         - Two cases in "builtin/submodule--helper.c", where it's used safely
           to see if any config exists.
    +
    +      We could refactor these away from "multi" to some "does it exist?"
    +      function, as [4] did, but as that's orthogonal to the "string"
    +      safety we're introducing here let's leave them for now.
    +
         - One in "builtin/for-each-repo.c", which we'll convert in a
           subsequent commit.
    -    - The "t/helper/test-config.c" code added in [3].
    +
    +    - The "t/helper/test-config.c" code added in [4].
     
         As seen in the preceding commit we need to give the
         "t/helper/test-config.c" caller these "NULL" entries.
    @@ Commit message
            2008-02-11)
         2. 6c47d0e8f39 (config.c: guard config parser from value=NULL,
            2008-02-11).
    -    3. 4c715ebb96a (test-config: add tests for the config_set API,
    +    3. https://lore.kernel.org/git/patch-07.10-c01f7d85c94-20221026T151328Z-avarab@gmail.com/
    +    4. 4c715ebb96a (test-config: add tests for the config_set API,
            2014-07-28)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_register(int argc, const char **argv, const char *prefix)
    - 	else
    + 	if (git_config_get("maintenance.strategy"))
      		git_config_set("maintenance.strategy", "incremental");
      
     -	if (!git_config_get_value_multi(key, &list)) {
    @@ config.c: int git_configset_get_value_multi(struct config_set *cs, const char *k
     +	return 0;
     +}
     +
    - int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
    + int git_configset_get(struct config_set *cs, const char *key)
      {
    - 	const char *value;
    + 	struct config_set_element *e;
     @@ config.c: int repo_config_get_value_multi(struct repository *repo, const char *key,
      	return git_configset_get_value_multi(repo->config, key, dest);
      }
    @@ t/t7900-maintenance.sh: test_expect_failure 'register with no value for maintena
      	test_when_finished mv .git/config.orig .git/config &&
      
     @@ t/t7900-maintenance.sh: test_expect_failure 'unregister with no value for maintenance.repo' '
    - 	cat >expect <<-\EOF &&
    - 	error: missing value for '\''maintenance.repo'\''
    + 	[maintenance]
    + 		repo
      	EOF
     -	git maintenance unregister &&
     -	git maintenance unregister --force
    ++	cat >expect <<-\EOF &&
    ++	error: missing value for '\''maintenance.repo'\''
    ++	EOF
     +	test_expect_code 128 git maintenance unregister 2>actual.raw &&
     +	grep ^error actual.raw >actual &&
     +	test_cmp expect actual &&
 9:  58ead3ca555 =  9:  c7a5f5b4133 for-each-repo: with bad config, don't conflate <path> and <cmd>
-- 
2.39.1.1397.g8c8c074958d

