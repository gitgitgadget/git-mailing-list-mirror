Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC14C636D4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBGQLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBGQK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:10:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85746EA8
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:10:56 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eq11so16259738edb.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hSPs1gYvQA1BdrD+MtnVwxlJzAU8DF74u/EYLJ2+6c=;
        b=A8HMJ2nd7SorWuK4Dg6Mvro9TxKwrIUfNV4dV2S+tazw/RS1PtrYYubyrpMMAyRD66
         UOU7geoH1zQ5PlqM2kXMSaKJvN/22mwxtSyscC/JehmnJ79M+QA3lv2Tq3TOfz/TS1R4
         6YkLQUOiP2aXAaMzt7DSoneND2MbXYhOf3WeWgVQ7FyT78bZqlMmvbg1VF9yYaaXxE1M
         z0ptc6oSA2WC2YHxcSFvh840IjGHpjiPSOPLLatdaFUUBmei5C6S46aDN9thObLWJcV9
         eQtJjbbL08OzlhZunL7d6mmb9RfSZ2NTqPuIXObl2GK1C2CxT/V7RVsyGOtrsHSoQ6wg
         QBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hSPs1gYvQA1BdrD+MtnVwxlJzAU8DF74u/EYLJ2+6c=;
        b=kLwe0sQP4FE3/wN96/Smlxi+vPIYvgeCIWjgxJKQ/6yHjqfn7If4Sc+AfrOIdZbvJj
         Z25kpHMZYc0UEQvQOw3C12zW3hpevqGlHZ/4vUhCufa4S6QkzoGqrTX0U8NVLIJwKTBW
         yMFeeHeHH85NpZAy3aoQOvz9xb7PJs6hGaTt85i7KGQK5PtcOTByU8C6KVOp3+HHE/6U
         lv8XBOBa4aG2/YG0JTDvJ5sjerjmKhQdrbr050WupS0BSKIO1u5znrvr5URsoYmqqBCK
         sqo38lWtOSNgLOAb6SfscGgXJnKGoCoW3vUd9kT+Twq5/MN3T8QIlAkoJxQv7BNxxr55
         566Q==
X-Gm-Message-State: AO0yUKXRrhKgkbJg95dHhLI5BZHhK1o9DFQnDGUForS/Ev09S2KjXuZ1
        BOA4HEViMl4ETAN30IeOKzPvpAYhPYVGfTTo
X-Google-Smtp-Source: AK7set8Yk4o8xS3EzhXbGqmtRqtlcqTm1xg4HqiYEPQ3Q57913PQpUwXTqTzm8R0zlPNiiWNnxN3Hg==
X-Received: by 2002:a17:906:f95:b0:886:7eae:26c4 with SMTP id q21-20020a1709060f9500b008867eae26c4mr4217164ejj.5.1675786254697;
        Tue, 07 Feb 2023 08:10:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:10:54 -0800 (PST)
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
Subject: [PATCH v5 00/10] config API: make "multi" safe, fix segfaults, propagate "ret"
Date:   Tue,  7 Feb 2023 17:10:40 +0100
Message-Id: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
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
v2[2]. Changes since v4[3]:

* Added tests for value-less at the end of a list to 2/10, per Junio's
  request.

* Clarifications in the 3/10 commit message, per v4's discussion.

* Add RESULT_MUST_BE_USED to configset_find_element(), note that
  configset_add_value() doesn't have it, see the 3/10 commit message
  update.

* 3/10 now has tests for the "get" family of functions, this should
  clarify any questions about the semantics of the API.

* Junio suggested for 4/10 to skip renaming the
  "deprecated_prereleases" variable, I tried that, and if we keep it
  we need to wrap a line later in the series, which makes the
  versioncmp.c code harder to read. So I kept the renaming as it's
  refactored in 4/10.

* Glen suggested that the new *_get() family should "return 1" on
  non-zero like the rest of *_get_*() (i.e. coerce 'ret < 0' to
  'return 1').

  That could be done here, but for the later "for-each-repo.c" we need
  to distinguish "bad key" v.s. "does this exist?", and just having
  that API return a more meaningful value would make it inconsistent
  with the rest.

  As the much of the point of this series is to make that API less of
  a special snowflake a new 6/10 instead finishes up the work of
  having most of the rest of the API return the un-coerced "ret" from
  the depths of the config API.

  That patch is quite large by line count, but pretty trivial in
  complexity. All of those functions are copy/pasted versions of one
  another with very minor variations.

* Updated the 8/10 commit message, which was stale from a previous
  version of this topic.

Branch & CI for this at:
https://github.com/avar/git/tree/avar/have-git_configset_get_value-use-dest-and-int-pattern-5

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  config tests: cover blind spots in git_die_config() tests
  config tests: add "NULL" tests for *_get_value_multi()
  config API: add and use a "git_config_get()" family of functions
  versioncmp.c: refactor config reading next commit
  config API: have *_multi() return an "int" and take a "dest"
  config API: don't lose the git_*get*() return values
  for-each-repo: error on bad --config
  config API users: test for *_get_value_multi() segfaults
  config API: add "string" version of *_value_multi(), fix segfaults
  for-each-repo: with bad config, don't conflate <path> and <cmd>

 builtin/for-each-repo.c              |  14 +-
 builtin/gc.c                         |  15 +-
 builtin/log.c                        |   6 +-
 builtin/submodule--helper.c          |   7 +-
 builtin/worktree.c                   |   3 +-
 config.c                             | 226 ++++++++++++++++++---------
 config.h                             |  84 ++++++++--
 pack-bitmap.c                        |   6 +-
 submodule.c                          |   3 +-
 t/helper/test-config.c               |  28 +++-
 t/t0068-for-each-repo.sh             |  19 +++
 t/t1308-config-set.sh                | 108 ++++++++++++-
 t/t3309-notes-merge-auto-resolve.sh  |   7 +-
 t/t4202-log.sh                       |  15 ++
 t/t5304-prune.sh                     |  12 +-
 t/t5310-pack-bitmaps.sh              |  20 +++
 t/t5552-skipping-fetch-negotiator.sh |  16 ++
 t/t7004-tag.sh                       |  17 ++
 t/t7413-submodule-is-active.sh       |  16 ++
 t/t7900-maintenance.sh               |  38 +++++
 versioncmp.c                         |  22 ++-
 21 files changed, 549 insertions(+), 133 deletions(-)

Range-diff against v4:
 1:  4ae56cab7c7 =  1:  cefc4188984 config tests: cover blind spots in git_die_config() tests
 2:  1f0f8bdcde9 !  2:  91a44456327 config tests: add "NULL" tests for *_get_value_multi()
    @@ t/t1308-config-set.sh: test_expect_success 'find multiple values' '
     +			mv "$config" "$config".old
     +		fi &&
     +
    ++		# Value-less in the middle of a list
     +		cat >"$config" <<-\EOF &&
     +		[a]key=x
     +		[a]key
    @@ t/t1308-config-set.sh: test_expect_success 'find multiple values' '
     +			;;
     +		esac &&
     +		test-tool config "$op" a.key $file >actual &&
    ++		test_cmp expect actual &&
    ++
    ++		# Value-less at the end of a least
    ++		cat >"$config" <<-\EOF &&
    ++		[a]key=x
    ++		[a]key=y
    ++		[a]key
    ++		EOF
    ++		case "$op" in
    ++		*_multi)
    ++			cat >expect <<-\EOF
    ++			x
    ++			y
    ++			(NULL)
    ++			EOF
    ++			;;
    ++		*)
    ++			cat >expect <<-\EOF
    ++			(NULL)
    ++			EOF
    ++			;;
    ++		esac &&
    ++		test-tool config "$op" a.key $file >actual &&
     +		test_cmp expect actual
     +	'
     +}
 3:  998b11ae4bc !  3:  4a73151abde config API: add and use a "git_config_get()" family of functions
    @@ Commit message
         can now use a helper function that doesn't require a throwaway
         variable.
     
    -    We could have changed git_configset_get_value_multi() to accept a
    -    "NULL" as a "dest" for all callers, but let's avoid changing the
    -    behavior of existing API users. Having an "unused" value that we throw
    -    away internal to config.c is cheap.
    +    We could have changed git_configset_get_value_multi() (and then
    +    git_config_get_value() etc.) to accept a "NULL" as a "dest" for all
    +    callers, but let's avoid changing the behavior of existing API
    +    users. Having an "unused" value that we throw away internal to
    +    config.c is cheap.
    +
    +    A "NULL as optional dest" pattern is also more fragile, as the intent
    +    of the caller might be misinterpreted if he were to accidentally pass
    +    "NULL", e.g. when "dest" is passed in from another function.
     
         Another name for this function could have been
         "*_config_key_exists()", as suggested in [1]. That would work for all
    @@ Commit message
         commit where the git_configset_get_value_multi() function itself will
         expose this new return value.
     
    -    1. https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/
    +    This still leaves various inconsistencies and clobbering or ignoring
    +    of the return value in place. E.g here we're modifying
    +    configset_add_value(), but ever since it was added in [2] we've been
    +    ignoring its "int" return value, but as we're changing the
    +    configset_find_element() it uses, let's have it faithfully ferry that
    +    "ret" along.
    +
    +    Let's also use the "RESULT_MUST_BE_USED" macro introduced in [3] to
    +    assert that we're checking the return value of
    +    configset_find_element().
    +
    +    We're leaving the same change to configset_add_value() for some future
    +    series. Once we start paying attention to its return value we'd need
    +    to ferry it up as deep as do_config_from(), and would need to make
    +    least read_{,very_}early_config() and git_protected_config() return an
    +    "int" instead of "void". Let's leave that for now, and focus on
    +    the *_get_*() functions.
    +
    +    In a subsequent commit we'll fix the other *_get_*() functions to so
    +    that they'll ferry our underlying "ret" along, rather than normalizing
    +    it to a "return 1". But as an intermediate step to that we'll need to
    +    fix git_configset_get_value_multi() to return "int", and that change
    +    itself is smaller because of this change to migrate some callers away
    +    from the *_value_multi() API.
    +
    +    1. 3c8687a73ee (add `config_set` API for caching config-like files, 2014-07-28)
    +    2. https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/
    +    3. 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
    +       return values, 2022-09-01),
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ config.c: void read_very_early_config(config_fn_t cb, void *data)
      }
      
     -static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
    ++RESULT_MUST_BE_USED
     +static int configset_find_element(struct config_set *cs, const char *key,
     +				  struct config_set_element **dest)
      {
    @@ config.c: void git_config_clear(void)
     
      ## config.h ##
     @@ config.h: void git_configset_clear(struct config_set *cs);
    - 
    - /*
    -  * These functions return 1 if not found, and 0 if found, leaving the found
    -- * value in the 'dest' pointer.
    -+ * value in the 'dest' pointer (if any).
    +  * value in the 'dest' pointer.
       */
      
     +RESULT_MUST_BE_USED
    @@ config.h: void git_protected_config(config_fn_t fn, void *data);
     + * documentation.
       */
      
    ++RESULT_MUST_BE_USED
     +int git_config_get(const char *key);
     +
      /**
       * Finds the highest-priority value for the configuration variable `key`,
       * stores the pointer to it in `value` and returns 0. When the
    +
    + ## t/helper/test-config.c ##
    +@@
    +  * get_value_multi -> prints all values for the entered key in increasing order
    +  *		     of priority
    +  *
    ++ * get -> print return value for the entered key
    ++ *
    +  * get_int -> print integer value for the entered key or die
    +  *
    +  * get_bool -> print bool value for the entered key or die
    +@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    + 			printf("Value not found for \"%s\"\n", argv[2]);
    + 			goto exit1;
    + 		}
    ++	} else if (argc == 3 && !strcmp(argv[1], "get")) {
    ++		int ret;
    ++
    ++		if (!(ret = git_config_get(argv[2])))
    ++			goto exit0;
    ++		else if (ret == 1)
    ++			printf("Value not found for \"%s\"\n", argv[2]);
    ++		else if (ret == -CONFIG_INVALID_KEY)
    ++			printf("Key \"%s\" is invalid\n", argv[2]);
    ++		else if (ret == -CONFIG_NO_SECTION_OR_NAME)
    ++			printf("Key \"%s\" has no section\n", argv[2]);
    ++		else
    ++			/*
    ++			 * A normal caller should just check "ret <
    ++			 * 0", but for our own tests let's BUG() if
    ++			 * our whitelist of git_config_parse_key()
    ++			 * return values isn't exhaustive.
    ++			 */
    ++			BUG("Key \"%s\" has unknown return %d", argv[2], ret);
    ++		goto exit1;
    + 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
    + 		if (!git_config_get_int(argv[2], &val)) {
    + 			printf("%d\n", val);
    +
    + ## t/t1308-config-set.sh ##
    +@@ t/t1308-config-set.sh: test_expect_success 'setup default config' '
    + 		skin = false
    + 		nose = 1
    + 		horns
    ++	[value]
    ++		less
    + 	EOF
    + '
    + 
    +@@ t/t1308-config-set.sh: test_expect_success 'find value with the highest priority' '
    + 	check_config get_value case.baz "hask"
    + '
    + 
    ++test_expect_success 'return value for an existing key' '
    ++	test-tool config get lamb.chop >out 2>err &&
    ++	test_must_be_empty out &&
    ++	test_must_be_empty err
    ++'
    ++
    ++test_expect_success 'return value for value-less key' '
    ++	test-tool config get value.less >out 2>err &&
    ++	test_must_be_empty out &&
    ++	test_must_be_empty err
    ++'
    ++
    ++test_expect_success 'return value for a missing key' '
    ++	cat >expect <<-\EOF &&
    ++	Value not found for "missing.key"
    ++	EOF
    ++	test_expect_code 1 test-tool config get missing.key >actual 2>err &&
    ++	test_cmp actual expect &&
    ++	test_must_be_empty err
    ++'
    ++
    ++test_expect_success 'return value for a bad key: CONFIG_INVALID_KEY' '
    ++	cat >expect <<-\EOF &&
    ++	Key "fails.iskeychar.-" is invalid
    ++	EOF
    ++	test_expect_code 1 test-tool config get fails.iskeychar.- >actual 2>err &&
    ++	test_cmp actual expect &&
    ++	test_must_be_empty out
    ++'
    ++
    ++test_expect_success 'return value for a bad key: CONFIG_NO_SECTION_OR_NAME' '
    ++	cat >expect <<-\EOF &&
    ++	Key "keynosection" has no section
    ++	EOF
    ++	test_expect_code 1 test-tool config get keynosection >actual 2>err &&
    ++	test_cmp actual expect &&
    ++	test_must_be_empty out
    ++'
    ++
    + test_expect_success 'find integer value for a key' '
    + 	check_config get_int lamb.chop 65
    + '
    +@@ t/t1308-config-set.sh: test_expect_success 'proper error on error in default config files' '
    + 	cp .git/config .git/config.old &&
    + 	test_when_finished "mv .git/config.old .git/config" &&
    + 	echo "[" >>.git/config &&
    +-	echo "fatal: bad config line 34 in file .git/config" >expect &&
    ++	echo "fatal: bad config line 36 in file .git/config" >expect &&
    + 	test_expect_code 128 test-tool config get_value foo.bar 2>actual &&
    + 	test_cmp expect actual
    + '
 4:  aae1d5c12a9 !  4:  382a77ca69e versioncmp.c: refactor config reading next commit
    @@ Commit message
         the bounds of our CodingGuidelines when it comes to line length, and
         to avoid repeating ourselves.
     
    +    Renaming "deprecated_prereleases" to "oldl" doesn't help us to avoid
    +    line wrapping now, but it will in a subsequent commit.
    +
         Let's also split out the names of the config variables into variables
    -    of our own, so we don't have to repeat ourselves, and refactor the
    -    nested if/else to avoid indenting it, and the existing bracing style
    -    issue.
    +    of our own, and refactor the nested if/else to avoid indenting it, and
    +    the existing bracing style issue.
     
         This all helps with the subsequent commit, where we'll need to start
         checking different git_config_get_value_multi() return value. See
 5:  23449ff2c4e !  5:  8f17bf8150c config API: have *_multi() return an "int" and take a "dest"
    @@ Commit message
         return an "int" and populate a "**dest" parameter like every other
         git_configset_get_*()" in the API.
     
    -    As we'll see in in subsequent commits this fixes a blind spot in the
    -    API where it wasn't possible to tell whether a list was empty from
    -    whether a config key existed. We'll take advantage of that in
    -    subsequent commits, but for now we're faithfully converting existing
    -    API callers.
    -
    -    A logical follow-up to this would be to change the various "*_get_*()"
    -    functions to ferry the git_configset_get_value() return value to their
    -    own callers, e.g. git_configset_get_int() returns "1" rather than
    -    ferrying up the "-1" that "git_configset_get_value()" might return,
    -    but that's not being done in this series
    +    As we'll take advantage of in subsequent commits, this fixes a blind
    +    spot in the API where it wasn't possible to tell whether a list was
    +    empty from whether a config key existed. For now we don't make use of
    +    those new return values, but faithfully convert existing API users.
     
         Most of this is straightforward, commentary on cases that stand out:
     
 -:  ----------- >  6:  b515ff13f9b config API: don't lose the git_*get*() return values
 6:  17c1218e74c =  7:  8a83c30ea78 for-each-repo: error on bad --config
 7:  7fc91eaf747 =  8:  d9abc78c2be config API users: test for *_get_value_multi() segfaults
 8:  a391ee17617 !  9:  65fa91e7ce7 config API: add "string" version of *_value_multi(), fix segfaults
    @@ Commit message
           - 92156291ca8 (log: add default decoration filter, 2022-08-05)
           - 50a044f1e40 (gc: replace config subprocesses with API calls, 2022-09-27)
     
    -    There are now three remaining files using the low-level API:
    -
    -    - Two cases in "builtin/submodule--helper.c", where it's used safely
    -      to see if any config exists.
    -
    -      We could refactor these away from "multi" to some "does it exist?"
    -      function, as [4] did, but as that's orthogonal to the "string"
    -      safety we're introducing here let's leave them for now.
    +    There are now two users ofthe low-level API:
     
         - One in "builtin/for-each-repo.c", which we'll convert in a
           subsequent commit.
     
    -    - The "t/helper/test-config.c" code added in [4].
    +    - The "t/helper/test-config.c" code added in [3].
     
         As seen in the preceding commit we need to give the
         "t/helper/test-config.c" caller these "NULL" entries.
    @@ Commit message
            2008-02-11)
         2. 6c47d0e8f39 (config.c: guard config parser from value=NULL,
            2008-02-11).
    -    3. https://lore.kernel.org/git/patch-07.10-c01f7d85c94-20221026T151328Z-avarab@gmail.com/
    -    4. 4c715ebb96a (test-config: add tests for the config_set API,
    +    3. 4c715ebb96a (test-config: add tests for the config_set API,
            2014-07-28)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
 9:  c7a5f5b4133 = 10:  4db3c6d0ed9 for-each-repo: with bad config, don't conflate <path> and <cmd>
-- 
2.39.1.1430.gb2471c0aaf4

