Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87C3C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiKAXFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKAXFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA2175A9
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f27so40926773eje.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVFfe6Bc+lT69o1yOB/+ZNDZzyh4J1Bu8xICr/6a0ZQ=;
        b=A8U8CZtTxeQT2P7Py8IhZehIY4DTdDoirNpVABpSDBX7O0MBIJ0S+1Up1vy8JfZPUO
         PptArDkoLJ8uX4tIV46c5E0wChVPnE8X4spDHTw5aOrUWmdQjQXCKzntkm1OXIXX3aer
         /xD3yRQeAyeiSoyne6XOJBVa9a1dby6Ci3800nIV2xijIW/6qnjsMTsasrJk4M//tJz2
         k1gd/6+kgZZw58TkLENDUsXj7JP1VCnfSk26VHVC2gzf1IYi21NkQCFJHtl2nShaqKgp
         Z87wTEp7rM9VTxgHeYPEGweClZU37dYX7cCKBleViBOTT0tbnxrn9iq9RJMBBURhayqH
         ZqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVFfe6Bc+lT69o1yOB/+ZNDZzyh4J1Bu8xICr/6a0ZQ=;
        b=qZxktFTY9S3TFQwVlD3CxJiWlGbLm1teKPa9T6bsm0cOwaWKplXuwWUtF73iTfwLdX
         lCD2KLuR9CbQDkmRUdEEIINDuNogcGoD4hn3vx+cOuOHrn7FRZvnVRJ5Yy+IGylvMjsI
         sgOjtyQmjfB5g5bxtcjBgnftsVXP8s/P5dBNIZJ1j+IoQrB1bvr7S2VB5ipE1YC3+qFG
         vhy7AGlahyB5T8tgaB+7KkfSFt7GujbInL7qFbSj2GP6wCJflBQB7OdTDkBedtmYN7RF
         5+kxyXjXb134mwMZyFP5IWVwFS6dT31TqvM1s5nJwdHnHad61fyRqye0i2aGcj/eMLeL
         SUCg==
X-Gm-Message-State: ACrzQf3YHUXJn0ytLfkDPqU3WSgYLveaUo71E5nJd2sfsl0x4Bg4wa/W
        i7lheHdWnvjbbVrbduqUWuK0Y2QDIuFfbQ==
X-Google-Smtp-Source: AMsMyM7/jp1/1TDWeKSdu2kJPegCHql87dg9hSwka6n/JFB4QvmeSH9qQlMBQh1BJSK3lit6yobxgQ==
X-Received: by 2002:a17:906:fd8d:b0:780:997:8b7b with SMTP id xa13-20020a170906fd8d00b0078009978b7bmr20865567ejb.635.1667343932174;
        Tue, 01 Nov 2022 16:05:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] config API: make "multi" safe, fix numerous segfaults
Date:   Wed,  2 Nov 2022 00:05:11 +0100
Message-Id: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes numerous segfaults in config API users, because they
didn't expect *_get_multi() to hand them a string_list with a NULL in
it given config like "[a] key" (note, no "="'s).

A larger general overview at:
https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/

Changes since v1:
 
 * Fixed that "ret < 1" v.s. "ret < 0" thinko in the commit message
   (code was fine).

 * This is now much reduced in scope. The v1 was 10 patches, this is
   9, but as the range-diff shows there's 3x new tests at the
   beginning. So the meat of this is smaller.

 * The previous main fix is now in 7-8/9 instead of one patch, I split
   up the test addition (starting with test_expect_failure) and the
   fix.

 * There's no more "known key" API that'll BUG() out if we get < 0.

 * There's no more "lookup_value". We just leave the API users that
   only care if there is a list in-place.

 * The digression to add "const"-ing to the "struct string_list" is
   gone, and the change to use unsorted_string_list_has_string() in
   builtin/gc.c. I can submit that on top of this.

 * Rewrote/redid some things to make subsequent diffs
   smaller. E.g. 4/9 makes 5/9 and especialy 6/9 smaller.

 * Renamed the new helper from git_config_get_value_multi() to
   git_config_get_string_multi().

 * There's still a low-level git_config_get_value_multi(). The updated
   8/9 commit message makes the case for it, i.e. as opposed to having
   all of *_multi() have the equivalent of "--type=string" semantics
   (although we don't expose that via the "git config" tool...).

Passing CI for this at:
https://github.com/avar/git/tree/avar/have-git_configset_get_value-use-dest-and-int-pattern-2

Ævar Arnfjörð Bjarmason (9):
  for-each-repo tests: test bad --config keys
  config tests: cover blind spots in git_die_config() tests
  config tests: add "NULL" tests for *_get_value_multi()
  versioncmp.c: refactor config reading next commit
  config API: have *_multi() return an "int" and take a "dest"
  for-each-repo: error on bad --config
  config API users: test for *_get_value_multi() segfaults
  config API: add "string" version of *_value_multi(), fix segfaults
  for-each-repo: with bad config, don't conflate <path> and <cmd>

 builtin/for-each-repo.c              | 14 ++---
 builtin/gc.c                         |  6 +-
 builtin/log.c                        |  5 +-
 builtin/submodule--helper.c          |  6 +-
 config.c                             | 88 +++++++++++++++++++++++-----
 config.h                             | 50 +++++++++++++---
 pack-bitmap.c                        |  6 +-
 submodule.c                          |  3 +-
 t/helper/test-config.c               |  6 +-
 t/t0068-for-each-repo.sh             | 19 ++++++
 t/t1308-config-set.sh                | 30 ++++++++++
 t/t3309-notes-merge-auto-resolve.sh  |  7 ++-
 t/t4202-log.sh                       | 15 +++++
 t/t5304-prune.sh                     | 12 +++-
 t/t5310-pack-bitmaps.sh              | 21 +++++++
 t/t5552-skipping-fetch-negotiator.sh | 16 +++++
 t/t7004-tag.sh                       | 17 ++++++
 t/t7413-submodule-is-active.sh       | 16 +++++
 t/t7900-maintenance.sh               | 38 ++++++++++++
 versioncmp.c                         | 22 ++++---
 20 files changed, 337 insertions(+), 60 deletions(-)

Range-diff against v1:
 -:  ----------- >  1:  b8fd3bea4d1 for-each-repo tests: test bad --config keys
 -:  ----------- >  2:  6cd0d6faf3c config tests: cover blind spots in git_die_config() tests
 8:  e7568dbe6fe =  3:  f2a8766a802 config tests: add "NULL" tests for *_get_value_multi()
 -:  ----------- >  4:  42cfc61202d versioncmp.c: refactor config reading next commit
 1:  eefa253ab1f !  5:  48fb7cbf585 config API: have *_multi() return an "int" and take a "dest"
    @@ Metadata
      ## Commit message ##
         config API: have *_multi() return an "int" and take a "dest"
     
    -    The git_configset_get_value_multi() function added in 3c8687a73ee (add
    -    `config_set` API for caching config-like files, 2014-07-28) is a
    -    fundamental part of of the config API, and
    -    e.g. "git_config_get_value()" and others are implemented in terms of
    -    it.
    +    Have the "git_configset_get_value_multi()" function and its siblings
    +    return an "int" and populate a "**dest" parameter like every other
    +    git_configset_get_*()" in the API.
     
    -    But it has had the limitation that configset_find_element() calls
    -    git_config_parse_key(), but then throws away the distinction between a
    -    "ret < 1" return value from it, and return values that indicate a key
    -    doesn't exist. As a result the git_config_get_value_multi() function
    -    would either return a "const struct string_list *", or NULL.
    +    As we'll see in in subsequent commits this fixes a blind spot in the
    +    API where it wasn't possible to tell whether a list was empty from
    +    whether a config key existed. We'll take advantage of that in
    +    subsequent commits, but for now we're faithfully converting existing
    +    API callers.
     
    -    By changing the *_multi() function to return an "int" for the status
    -    and to write to a "const struct string_list **dest" parameter we can
    -    avoid losing this information. API callers can now do:
    +    See [1] for the initial addition of "git_configset_get_value_multi()"
     
    -            const struct string_list *dest;
    -            int ret;
    +    1. 3c8687a73ee (add `config_set` API for caching config-like files,
    +       2014-07-28).
     
    -            ret = git_config_get_value_multi(key, &dest);
    -            if (ret < 1)
    -                    die("bad key: %s", key);
    -            else if (ret)
    -                    ; /* key does not exist */
    -            else
    -                    ; /* got key, can use "dest" */
    -
    -    A "get_knownkey_value_multi" variant is also provided, which will
    -    BUG() out in the "ret < 1" case. This is useful in the cases where we
    -    hardcode the keyname in our source code, and therefore use the more
    -    idiomatic pattern of:
    -
    -            if (!git_config_get_value_multi(key, &dest)
    -                    ; /* got key, can use "dest" */
    -            else
    -                    ; /* key does not exist */
    +    A logical follow-up to this would be to change the various "*_get_*()"
    +    functions to ferry the git_configset_get_value() return value to their
    +    own callers, e.g. git_configset_get_int() returns "1" rather than
    +    ferrying up the "-1" that "git_configset_get_value()" might return,
    +    but that's not being done in this series
     
    -    The "knownkey" name was picked instead of e.g. "const" to avoid a
    -    repeat of the issues noted in f1de981e8b6 (config: fix leaks from
    -    git_config_get_string_const(), 2020-08-14) and 9a53219f69b (config:
    -    drop git_config_get_string_const(), 2020-08-17). API users might think
    -    that "const" means that the value(s) don't need to be free'd.
    +    Most of this is straightforward, commentary on cases that stand out:
     
    -    As noted in commentary here we treat git_die_config() as a
    -    special-case, i.e. we assume that a value we're complaining about has
    -    already had its key pass the git_config_parse_key() check.
    +    - As we've tested for in a preceding commit we can rely on getting the
    +      config list in git_die_config(), and as we need to handle the new
    +      return value let's BUG() out if we can't acquire it.
     
    -    Likewise we consider the keys passed to "t/helper/test-config.c" to be
    -    "knownkey", and will emit a BUG() if they don't pass
    -    git_config_parse_key(). Those will come from our *.sh tests, so
    -    they're also "known keys" coming from our sources.
    +    - In "builtin/for-each-ref.c" we could preserve the comment added in
    +      6c62f015520, but now that we're directly using the documented
    +      repo_config_get_value_multi() value it's just narrating something that
    +      should be obvious from the API use, so let's drop it.
     
    -    A logical follow-up to this would be to change the various "*_get_*()"
    -    functions to ferry the git_configset_get_value() return value to their
    -    own callers, e.g.:
    +    - The loops after getting the "list" value in "builtin/gc.c" could
    +      also make use of "unsorted_string_list_has_string()" instead of using
    +      that loop, but let's leave that for now.
     
    -            diff --git a/config.c b/config.c
    -            index 094ad899e0b..7e8ee4cfec1 100644
    -            --- a/config.c
    -            +++ b/config.c
    -            @@ -2479,11 +2479,14 @@ static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
    -             int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
    -             {
    -                    const char *value;
    -            -       if (!git_configset_get_value(cs, key, &value)) {
    -            -               *dest = git_config_int(key, value);
    -            -               return 0;
    -            -       } else
    -            -               return 1;
    -            +       int ret;
    -            +
    -            +       if ((ret = git_configset_get_value(cs, key, &value)))
    -            +               goto done;
    -            +
    -            +       *dest = git_config_int(key, value);
    -            +done:
    -            +       return ret;
    -             }
    +    - We have code e.g. in "builtin/submodule--helper.c" that only wants
    +      to check if a config key exists, and would be better served with
    +      another API, but let's keep using "git_configset_get_value_multi()"
    +      for now.
     
    -             int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
    +    - In "versioncmp.c" we now use the return value of the functions,
    +      instead of checking if the lists are still non-NULL. This is strictly
    +      speaking unnecessary, but makes the API use consistent with the rest,
    +      but more importantly...
     
    -    Most of those callers don't care, and call those functions as
    -    "if (!func(...))", but if they do they'll be able to tell key
    -    non-existence from errors we encounter. Before this change those API
    -    users would have been unable to tell the two conditions apart, as
    -    git_configset_get_value() hid the difference.
    +    - ...because we always check our return values we can assert that with
    +      the RESULT_MUST_BE_USED macro added in 1e8697b5c4e (submodule--helper:
    +      check repo{_submodule,}_init() return values, 2022-09-01)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/for-each-repo.c ##
     @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
    - {
      	static const char *config_key = NULL;
      	int i, result = 0;
    --	const struct string_list *values;
    -+	const struct string_list *values = NULL;
    + 	const struct string_list *values;
    ++	int err;
      
      	const struct option options[] = {
      		OPT_STRING(0, "config", &config_key, N_("config"),
    @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
      
     -	values = repo_config_get_value_multi(the_repository,
     -					     config_key);
    -+	repo_config_get_value_multi(the_repository, config_key, &values);
    +-
    +-	/*
    +-	 * Do nothing on an empty list, which is equivalent to the case
    +-	 * where the config variable does not exist at all.
    +-	 */
    +-	if (!values)
    ++	err = repo_config_get_value_multi(the_repository, config_key, &values);
    ++	if (err < 0)
    ++		return 0;
    ++	else if (err)
    + 		return 0;
      
    - 	/*
    - 	 * Do nothing on an empty list, which is equivalent to the case
    + 	for (i = 0; !result && i < values->nr; i++)
     
      ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_register(int argc, const char **argv, const char *prefix)
    @@ builtin/gc.c: static int maintenance_register(int argc, const char **argv, const
      
     -	list = git_config_get_value_multi(key);
     -	if (list) {
    -+	if (!git_config_get_knownkey_value_multi(key, &list)) {
    ++	if (!git_config_get_value_multi(key, &list)) {
      		for_each_string_list_item(item, list) {
      			if (!strcmp(maintpath, item->string)) {
      				found = 1;
    @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, con
      
     -	list = git_config_get_value_multi(key);
     -	if (list) {
    -+	if (!git_config_get_knownkey_value_multi(key, &list)) {
    ++	if (!git_config_get_value_multi(key, &list)) {
      		for_each_string_list_item(item, list) {
      			if (!strcmp(maintpath, item->string)) {
      				found = 1;
    @@ builtin/log.c: static void set_default_decoration_filter(struct decoration_filte
     +	const struct string_list *config_exclude;
      
     -	if (config_exclude) {
    -+	if (!git_config_get_knownkey_value_multi("log.excludeDecoration",
    -+					      &config_exclude)) {
    ++	if (!git_config_get_value_multi("log.excludeDecoration",
    ++					&config_exclude)) {
      		struct string_list_item *item;
      		for_each_string_list_item(item, config_exclude)
      			string_list_append(decoration_filter->exclude_ref_config_pattern,
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      		struct init_cb info = INIT_CB_INIT;
     +		const struct string_list *values;
      
    - 		if (module_list_compute(argc, argv, opt.prefix,
    + 		if (module_list_compute(argv, opt.prefix,
      					&pathspec2, &list) < 0) {
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
      		 * If there are no path args and submodule.active is set then,
    @@ config.c: static int configset_add_value(struct config_set *cs, const char *key,
      	/*
      	 * Since the keys are being fed by git_config*() callback mechanism, they
      	 * are already normalized. So simply add them without any further munging.
    -@@ config.c: int git_configset_add_parameters(struct config_set *cs)
    +@@ config.c: int git_configset_add_file(struct config_set *cs, const char *filename)
      int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
      {
      	const struct string_list *values = NULL;
    @@ config.c: int git_configset_add_parameters(struct config_set *cs)
      }
      
     -const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
    -+static int git_configset_get_value_multi_1(struct config_set *cs, const char *key,
    -+					   const struct string_list **dest,
    -+					   int knownkey)
    ++int git_configset_get_value_multi(struct config_set *cs, const char *key,
    ++				  const struct string_list **dest)
      {
     -	struct config_set_element *e = configset_find_element(cs, key);
     -	return e ? &e->value_list : NULL;
    @@ config.c: int git_configset_add_parameters(struct config_set *cs)
     +	int ret;
     +
     +	ret = configset_find_element(cs, key, &e);
    -+	if (ret < 0 && knownkey)
    -+		BUG("*_get_knownkey_*() only accepts known-good (hardcoded) keys, but '%s' is bad!", key);
    -+	else if (ret < 0)
    ++	if (ret < 0)
     +		return ret;
     +	else if (!e)
     +		return 1;
     +	*dest = &e->value_list;
     +
     +	return 0;
    -+}
    -+
    -+int git_configset_get_value_multi(struct config_set *cs, const char *key,
    -+				  const struct string_list **dest)
    -+{
    -+	return git_configset_get_value_multi_1(cs, key, dest, 0);
    -+}
    -+
    -+int git_configset_get_knownkey_value_multi(struct config_set *cs,
    -+					   const char *const key,
    -+					   const struct string_list **dest)
    -+{
    -+	return git_configset_get_value_multi_1(cs, key, dest, 1);
      }
      
      int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
    @@ config.c: int repo_config_get_value(struct repository *repo,
      
     -const struct string_list *repo_config_get_value_multi(struct repository *repo,
     -						      const char *key)
    -+int repo_config_get_value_multi(struct repository *repo,
    -+				const char *key,
    ++int repo_config_get_value_multi(struct repository *repo, const char *key,
     +				const struct string_list **dest)
      {
      	git_config_check_init(repo);
     -	return git_configset_get_value_multi(repo->config, key);
     +	return git_configset_get_value_multi(repo->config, key, dest);
    -+}
    -+
    -+int repo_config_get_knownkey_value_multi(struct repository *repo,
    -+					 const char *const key,
    -+					 const struct string_list **dest)
    -+{
    -+	git_config_check_init(repo);
    -+	return git_configset_get_knownkey_value_multi(repo->config, key, dest);
      }
      
      int repo_config_get_string(struct repository *repo,
    @@ config.c: int git_config_get_value(const char *key, const char **value)
      
     -const struct string_list *git_config_get_value_multi(const char *key)
     +int git_config_get_value_multi(const char *key, const struct string_list **dest)
    -+{
    -+	return repo_config_get_value_multi(the_repository, key, dest);
    -+}
    -+
    -+int git_config_get_knownkey_value_multi(const char *const key,
    -+					const struct string_list **dest)
      {
     -	return repo_config_get_value_multi(the_repository, key);
    -+	return repo_config_get_knownkey_value_multi(the_repository, key, dest);
    ++	return repo_config_get_value_multi(the_repository, key, dest);
      }
      
      int git_config_get_string(const char *key, char **dest)
    @@ config.c: void git_die_config(const char *key, const char *err, ...)
      		va_end(params);
      	}
     -	values = git_config_get_value_multi(key);
    -+
    -+	/*
    -+	 * We don't have a "const" key here, but we should definitely
    -+	 * have one that's passed git_config_parse_key() already, if
    -+	 * we're at the point of complaining about its value. So let's
    -+	 * use *_knownkey_value_multi() here to get that BUG(...).
    -+	 */
    -+	if (git_config_get_knownkey_value_multi(key, &values))
    -+		BUG("key '%s' does not exist, should not be given to git_die_config()",
    -+		    key);
    ++	if (git_config_get_value_multi(key, &values))
    ++		BUG("for key '%s' we must have a value to report on", key);
      	kv_info = values->items[values->nr - 1].util;
      	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
      }
     
      ## config.h ##
     @@ config.h: int git_configset_add_parameters(struct config_set *cs);
    - 
      /**
       * Finds and returns the value list, sorted in order of increasing priority
    -- * for the configuration variable `key` and config set `cs`. When the
    +  * for the configuration variable `key` and config set `cs`. When the
     - * configuration variable `key` is not found, returns NULL. The caller
     - * should not free or modify the returned pointer, as it is owned by the cache.
    -+ * for the configuration variable `key` and config set `cs`.
    -+ *
    -+ * When the configuration variable `key` is not found, returns 1
    -+ * without touching `value`.
    ++ * configuration variable `key` is not found, returns 1 without touching
    ++ * `value`.
     + *
     + * The key will be parsed for validity with git_config_parse_key(), on
    -+ * error a negative value will be returned. See
    -+ * git_configset_get_knownkey_value_multi() for a version of this which
    -+ * BUG()s out on negative return values.
    ++ * error a negative value will be returned.
     + *
     + * The caller should not free or modify the returned pointer, as it is
     + * owned by the cache.
    -+ */
    -+int git_configset_get_value_multi(struct config_set *cs, const char *key,
    -+				  const struct string_list **dest);
    -+
    -+/**
    -+ * Like git_configset_get_value_multi(), but BUG()s out if the return
    -+ * value is < 0. Use it for keys known to pass git_config_parse_key(),
    -+ * i.e. those hardcoded in the code, and never user-provided keys.
       */
     -const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
    -+int git_configset_get_knownkey_value_multi(struct config_set *cs,
    -+					   const char *const key,
    -+					   const struct string_list **dest);
    ++RESULT_MUST_BE_USED
    ++int git_configset_get_value_multi(struct config_set *cs, const char *key,
    ++				  const struct string_list **dest);
      
      /**
       * Clears `config_set` structure, removes all saved variable-value pairs.
    @@ config.h: struct repository;
      			  const char *key, const char **value);
     -const struct string_list *repo_config_get_value_multi(struct repository *repo,
     -						      const char *key);
    -+int repo_config_get_value_multi(struct repository *repo,
    -+				const char *key,
    ++RESULT_MUST_BE_USED
    ++int repo_config_get_value_multi(struct repository *repo, const char *key,
     +				const struct string_list **dest);
    -+int repo_config_get_knownkey_value_multi(struct repository *repo,
    -+					 const char *const key,
    -+					 const struct string_list **dest);
      int repo_config_get_string(struct repository *repo,
      			   const char *key, char **dest);
      int repo_config_get_string_tmp(struct repository *repo,
    @@ config.h: int git_config_get_value(const char *key, const char **value);
     + *
     + * The caller should not free or modify the returned pointer, as it is
     + * owned by the cache.
    -+ */
    -+int git_config_get_value_multi(const char *key,
    -+			       const struct string_list **dest);
    -+
    -+/**
    -+ * A wrapper for git_config_get_value_multi() which does for it what
    -+ * git_configset_get_knownkey_value_multi() does for
    -+ * git_configset_get_value_multi().
       */
     -const struct string_list *git_config_get_value_multi(const char *key);
    -+int git_config_get_knownkey_value_multi(const char *const key,
    -+					const struct string_list **dest);
    ++RESULT_MUST_BE_USED
    ++int git_config_get_value_multi(const char *key,
    ++			       const struct string_list **dest);
      
      /**
       * Resets and invalidates the config cache.
    @@ pack-bitmap.c: int bitmap_is_midx(struct bitmap_index *bitmap_git)
     -	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
     +	const struct string_list *dest;
     +
    -+	if (!repo_config_get_knownkey_value_multi(r, "pack.preferbitmaptips",
    -+					       &dest))
    ++	if (!repo_config_get_value_multi(r, "pack.preferbitmaptips", &dest))
     +		return dest;
     +	return NULL;
      }
    @@ submodule.c: int is_tree_submodule_active(struct repository *repo,
      	/* submodule.active is set */
     -	sl = repo_config_get_value_multi(repo, "submodule.active");
     -	if (sl) {
    -+	if (!repo_config_get_knownkey_value_multi(repo, "submodule.active", &sl)) {
    ++	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
      		struct pathspec ps;
      		struct strvec args = STRVEC_INIT;
      		const struct string_list_item *item;
    @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
     -		strptr = git_config_get_value_multi(argv[2]);
     -		if (strptr) {
    -+		if (!git_config_get_knownkey_value_multi(argv[2], &strptr)) {
    ++		if (!git_config_get_value_multi(argv[2], &strptr)) {
      			for (i = 0; i < strptr->nr; i++) {
      				v = strptr->items[i].string;
      				if (!v)
    @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      		}
     -		strptr = git_configset_get_value_multi(&cs, argv[2]);
     -		if (strptr) {
    -+		if (!git_configset_get_knownkey_value_multi(&cs, argv[2], &strptr)) {
    ++		if (!git_configset_get_value_multi(&cs, argv[2], &strptr)) {
      			for (i = 0; i < strptr->nr; i++) {
      				v = strptr->items[i].string;
      				if (!v)
     
      ## versioncmp.c ##
     @@ versioncmp.c: int versioncmp(const char *s1, const char *s2)
    - 	}
    - 
      	if (!initialized) {
    --		const struct string_list *deprecated_prereleases;
    -+		const struct string_list *deprecated_prereleases = NULL;
    -+
    + 		const char *const newk = "versionsort.suffix";
    + 		const char *const oldk = "versionsort.prereleasesuffix";
    ++		const struct string_list *newl;
    + 		const struct string_list *oldl;
    ++		int new = git_config_get_value_multi(newk, &newl);
    ++		int old = git_config_get_value_multi(oldk, &oldl);
    + 
    +-		prereleases = git_config_get_value_multi(newk);
    +-		oldl = git_config_get_value_multi(oldk);
    +-		if (prereleases && oldl)
    ++		if (!new && !old)
    + 			warning("ignoring %s because %s is set", oldk, newk);
    +-		else if (!prereleases)
    ++		if (!new)
    ++			prereleases = newl;
    ++		else if (!old)
    + 			prereleases = oldl;
    + 
      		initialized = 1;
    --		prereleases = git_config_get_value_multi("versionsort.suffix");
    --		deprecated_prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
    -+		git_config_get_knownkey_value_multi("versionsort.suffix",
    -+						 &prereleases);
    -+		git_config_get_value_multi("versionsort.prereleasesuffix",
    -+					   &deprecated_prereleases);
    -+
    - 		if (prereleases) {
    - 			if (deprecated_prereleases)
    - 				warning("ignoring versionsort.prereleasesuffix because versionsort.suffix is set");
 2:  e17de2a2664 <  -:  ----------- for-each-repo: error on bad --config
 3:  3519d3de010 <  -:  ----------- config API: mark *_multi() with RESULT_MUST_BE_USED
 4:  40b3cc9b8d4 <  -:  ----------- string-list API: mark "struct_string_list" to "for_each_string_list" const
 5:  b32b2e99aba <  -:  ----------- string-list API: make has_string() and list_lookup() "const"
 6:  9c36f17481b <  -:  ----------- builtin/gc.c: use "unsorted_string_list_has_string()" where appropriate
 7:  c01f7d85c94 <  -:  ----------- config API: add and use "lookup_value" functions
 9:  bda9d504b89 <  -:  ----------- config API: add "string" version of *_value_multi(), fix segfaults
 -:  ----------- >  6:  a0c29d46556 for-each-repo: error on bad --config
 -:  ----------- >  7:  c12805f3d55 config API users: test for *_get_value_multi() segfaults
 -:  ----------- >  8:  6b76f9eac90 config API: add "string" version of *_value_multi(), fix segfaults
10:  b59cbed8f61 !  9:  e2f8f7c52e3 for-each-repo: with bad config, don't conflate <path> and <cmd>
    @@ Commit message
         running commands.
     
         As noted in the preceding commit the fix is to move to a safer
    -    "*_multi_string()" version of the *__multi() API. This change is
    +    "*_string_multi()" version of the *_multi() API. This change is
         separated from the rest because those all segfaulted. In this change
         we ended up with different behavior.
     
    @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
      		die(_("missing --config=<config>"));
      
     -	err = repo_config_get_value_multi(the_repository, config_key, &values);
    -+	err = repo_config_get_value_multi_string(the_repository, config_key, &values);
    ++	err = repo_config_get_string_multi(the_repository, config_key, &values);
      	if (err < 0)
      		usage_msg_optf(_("got bad config --config=%s"),
      			       for_each_repo_usage, options, config_key);
-- 
2.38.0.1280.g8136eb6fab2

