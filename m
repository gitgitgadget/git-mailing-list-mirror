Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C748DC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiGYS3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYS3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 14:29:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8E1EEF5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 11:29:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f15so6635503edc.4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aECiWqv6v+AtXWI1PtbnbLUsRZOldJqXRmB4fFnU4IE=;
        b=TmPnL7IUI+cyHRdu5dxnCORr9Qr6gXvj8Wd2+YIl8cwWP8wMZT0zXDd03G5u9SKjqb
         9vne9/phTJPB4xObXR1LsYX0bT9+uibYDBpH1EcyxoiWbqLpC7b7A2uMpOnl21K8I+yz
         UlCUAvTE6mTN+4eaQ4UfKKLXNT0ed9hx6bCK891GzmhrvjmWgmNqIwESQMEAH4mPCu3Y
         /Md4cWr5WmHhO59AwZztX1UErYCruLjT/EHhw29NKgA5sJ/2CVInv6YIsEcgYbXXVPfq
         XmXuAQH6vOSz7SZ9qePWJqfUYUFO8mfXeUtHbraSCS7a4fxWbvs42ydDLBA9GH+Oo0SQ
         uliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aECiWqv6v+AtXWI1PtbnbLUsRZOldJqXRmB4fFnU4IE=;
        b=uZUQzH8F1YG9PKY0Lk6YKIjHULpRwm5RP4+MJ+rcwTeLvlot7uC2mCM1PFwaf1C/ql
         GHEEx1AlOJGBGxg1aQXGM2trtRvKotlRXfmmxgytBW+6Kw8DEUds0F6e5KJKpV+pNvY6
         yfs/sMM/FagjP8b3McmMNb8l1njCW/YKJ1iTTCTWnihUSU1f6qORseyKFQQ6ngVU7Pxj
         uTel1+Zi/TOPUf273QnoZI+Qmg9cFZk/KojhDHSNxp7Tzqq1GKA4QSkG1sHSS0nzTGSM
         KsjkBFKszhtV/li72mIE5YDmFWuqX1xtKyw/fEFmBsdCSvMAp93tCcb7LebHtTAFncub
         hKlg==
X-Gm-Message-State: AJIora8AqRk/Be2brpbqu32lR6rDVxFJyj0Qnfh9NauhREdvMU683W+c
        l36cjojlfiANL8wXxkcX7Yg=
X-Google-Smtp-Source: AGRyM1tjKDxiLAqFJQHQoQWiuV29zpmaLYs+Ps3eOEFF6wox9oqg27fok7b9j4M2znITb3aVRopUSA==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id s26-20020a056402015a00b0043171b986f3mr14489512edu.249.1658773752816;
        Mon, 25 Jul 2022 11:29:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906329300b0072b6d91b056sm5599178ejw.142.2022.07.25.11.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:29:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oG2pL-005qbN-9N;
        Mon, 25 Jul 2022 20:29:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Subject: SANITIZE=address failure on master (was: [PATCH v8 3/5] config:
 learn `git_protected_config()`)
Date:   Mon, 25 Jul 2022 20:26:41 +0200
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
 <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
 <30ac73716cbc234a1f176d2d417bf0e2b0b335cf.1657834081.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <30ac73716cbc234a1f176d2d417bf0e2b0b335cf.1657834081.git.gitgitgadget@gmail.com>
Message-ID: <220725.861qu9oxl4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> `uploadpack.packObjectsHook` is the only 'protected configuration only'
> variable today, but we've noted that `safe.directory` and the upcoming
> `safe.bareRepository` should also be 'protected configuration only'. So,
> for consistency, we'd like to have a single implementation for protected
> configuration.
>
> The primary constraints are:
>
> 1. Reading from protected configuration should be fast. Nearly all "git"
>    commands inside a bare repository will read both `safe.directory` and
>    `safe.bareRepository`, so we cannot afford to be slow.
>
> 2. Protected configuration must be readable when the gitdir is not
>    known. `safe.directory` and `safe.bareRepository` both affect
>    repository discovery and the gitdir is not known at that point [1].
>
> The chosen implementation in this commit is to read protected
> configuration and cache the values in a global configset. This is
> similar to the caching behavior we get with the_repository->config.
>
> Introduce git_protected_config(), which reads protected configuration
> and caches them in the global configset protected_config. Then, refactor
> `uploadpack.packObjectsHook` to use git_protected_config().
>
> The protected configuration functions are named similarly to their
> non-protected counterparts, e.g. git_protected_config_check_init() vs
> git_config_check_init().
>
> In light of constraint 1, this implementation can still be improved.
> git_protected_config() iterates through every variable in
> protected_config, which is wasteful, but it makes the conversion simple
> because it matches existing patterns. We will likely implement constant
> time lookup functions for protected configuration in a future series
> (such functions already exist for non-protected configuration, i.e.
> repo_config_get_*()).
>
> An alternative that avoids introducing another configset is to continue
> to read all config using git_config(), but only accept values that have
> the correct config scope [2]. This technically fulfills constraint 2,
> because git_config() simply ignores the local and worktree config when
> the gitdir is not known. However, this would read incomplete config into
> the_repository->config, which would need to be reset when the gitdir is
> known and git_config() needs to read the local and worktree config.
> Resetting the_repository->config might be reasonable while we only have
> these 'protected configuration only' variables, but it's not clear
> whether this extends well to future variables.
>
> [1] In this case, we do have a candidate gitdir though, so with a little
> refactoring, it might be possible to provide a gitdir.
> [2] This is how `uploadpack.packObjectsHook` was implemented prior to
> this commit.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  config.c                     | 43 ++++++++++++++++++++++++++++++++++++
>  config.h                     | 16 ++++++++++++++
>  t/t5544-pack-objects-hook.sh |  7 +++++-
>  upload-pack.c                | 27 +++++++++++++---------
>  4 files changed, 82 insertions(+), 11 deletions(-)
>
> diff --git a/config.c b/config.c
> index 9b0e9c93285..015bec360f5 100644
> --- a/config.c
> +++ b/config.c
> @@ -81,6 +81,17 @@ static enum config_scope current_parsing_scope;
>  static int pack_compression_seen;
>  static int zlib_compression_seen;
>  
> +/*
> + * Config that comes from trusted scopes, namely:
> + * - CONFIG_SCOPE_SYSTEM (e.g. /etc/gitconfig)
> + * - CONFIG_SCOPE_GLOBAL (e.g. $HOME/.gitconfig, $XDG_CONFIG_HOME/git)
> + * - CONFIG_SCOPE_COMMAND (e.g. "-c" option, environment variables)
> + *
> + * This is declared here for code cleanliness, but unlike the other
> + * static variables, this does not hold config parser state.
> + */
> +static struct config_set protected_config;
> +
>  static int config_file_fgetc(struct config_source *conf)
>  {
>  	return getc_unlocked(conf->u.file);
> @@ -2378,6 +2389,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
>  	return git_config_from_file(config_set_callback, filename, cs);
>  }
>  
> +int git_configset_add_parameters(struct config_set *cs)
> +{
> +	return git_config_from_parameters(config_set_callback, cs);
> +}
> +
>  int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
>  {
>  	const struct string_list *values = NULL;
> @@ -2619,6 +2635,33 @@ int repo_config_get_pathname(struct repository *repo,
>  	return ret;
>  }
>  
> +/* Read values into protected_config. */
> +static void read_protected_config(void)
> +{
> +	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
> +
> +	git_configset_init(&protected_config);
> +
> +	system_config = git_system_config();
> +	git_global_config(&user_config, &xdg_config);
> +
> +	git_configset_add_file(&protected_config, system_config);
> +	git_configset_add_file(&protected_config, xdg_config);
> +	git_configset_add_file(&protected_config, user_config);
> +	git_configset_add_parameters(&protected_config);
> +
> +	free(system_config);
> +	free(xdg_config);
> +	free(user_config);
> +}
> +
> +void git_protected_config(config_fn_t fn, void *data)
> +{
> +	if (!protected_config.hash_initialized)
> +		read_protected_config();
> +	configset_iter(&protected_config, fn, data);
> +}
> +
>  /* Functions used historically to read configuration from 'the_repository' */
>  void git_config(config_fn_t fn, void *data)
>  {
> diff --git a/config.h b/config.h
> index 7654f61c634..ca994d77147 100644
> --- a/config.h
> +++ b/config.h
> @@ -446,6 +446,15 @@ void git_configset_init(struct config_set *cs);
>   */
>  int git_configset_add_file(struct config_set *cs, const char *filename);
>  
> +/**
> + * Parses command line options and environment variables, and adds the
> + * variable-value pairs to the `config_set`. Returns 0 on success, or -1
> + * if there is an error in parsing. The caller decides whether to free
> + * the incomplete configset or continue using it when the function
> + * returns -1.
> + */
> +int git_configset_add_parameters(struct config_set *cs);
> +
>  /**
>   * Finds and returns the value list, sorted in order of increasing priority
>   * for the configuration variable `key` and config set `cs`. When the
> @@ -505,6 +514,13 @@ int repo_config_get_maybe_bool(struct repository *repo,
>  int repo_config_get_pathname(struct repository *repo,
>  			     const char *key, const char **dest);
>  
> +/*
> + * Functions for reading protected config. By definition, protected
> + * config ignores repository config, so these do not take a `struct
> + * repository` parameter.
> + */
> +void git_protected_config(config_fn_t fn, void *data);
> +
>  /**
>   * Querying For Specific Variables
>   * -------------------------------
> diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
> index dd5f44d986f..54f54f8d2eb 100755
> --- a/t/t5544-pack-objects-hook.sh
> +++ b/t/t5544-pack-objects-hook.sh
> @@ -56,7 +56,12 @@ test_expect_success 'hook does not run from repo config' '
>  	! grep "hook running" stderr &&
>  	test_path_is_missing .git/hook.args &&
>  	test_path_is_missing .git/hook.stdin &&
> -	test_path_is_missing .git/hook.stdout
> +	test_path_is_missing .git/hook.stdout &&
> +
> +	# check that global config is used instead
> +	test_config_global uploadpack.packObjectsHook ./hook &&
> +	git clone --no-local . dst2.git 2>stderr &&
> +	grep "hook running" stderr
>  '
>  
>  test_expect_success 'hook works with partial clone' '
> diff --git a/upload-pack.c b/upload-pack.c
> index 3a851b36066..09f48317b02 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1321,18 +1321,27 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
>  		data->advertise_sid = git_config_bool(var, value);
>  	}
>  
> -	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
> -	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
> -		if (!strcmp("uploadpack.packobjectshook", var))
> -			return git_config_string(&data->pack_objects_hook, var, value);
> -	}
> -
>  	if (parse_object_filter_config(var, value, data) < 0)
>  		return -1;
>  
>  	return parse_hide_refs_config(var, value, "uploadpack");
>  }
>  
> +static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
> +{
> +	struct upload_pack_data *data = cb_data;
> +
> +	if (!strcmp("uploadpack.packobjectshook", var))
> +		return git_config_string(&data->pack_objects_hook, var, value);
> +	return 0;
> +}
> +
> +static void get_upload_pack_config(struct upload_pack_data *data)
> +{
> +	git_config(upload_pack_config, data);
> +	git_protected_config(upload_pack_protected_config, data);
> +}
> +
>  void upload_pack(const int advertise_refs, const int stateless_rpc,
>  		 const int timeout)
>  {
> @@ -1340,8 +1349,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
>  	struct upload_pack_data data;
>  
>  	upload_pack_data_init(&data);
> -
> -	git_config(upload_pack_config, &data);
> +	get_upload_pack_config(&data);
>  
>  	data.stateless_rpc = stateless_rpc;
>  	data.timeout = timeout;
> @@ -1695,8 +1703,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
>  
>  	upload_pack_data_init(&data);
>  	data.use_sideband = LARGE_PACKET_MAX;
> -
> -	git_config(upload_pack_config, &data);
> +	get_upload_pack_config(&data);
>  
>  	while (state != FETCH_DONE) {
>  		switch (state) {

Noticed after it landed on master: This change fails with:

	make SANITIZE=address test T=t0410*.sh

Running that manually shows that we fail like this:
	
	$ cat trash\ directory.t0410-partial-clone/httpd/error.log | grep -o AH0.*
	AH00163: Apache/2.4.54 (Debian) configured -- resuming normal operations
	AH00094: Command line: '/usr/sbin/apache2 -d /home/avar/g/git/t/trash directory.t0410-partial-clone/httpd -f /home/avar/g/git/t/lib-httpd/apache.conf -c Listen 127.0.0.1:10410'
	AH01215: AddressSanitizer:DEADLYSIGNAL: /home/avar/g/git/git-http-backend
	AH01215: =================================================================: /home/avar/g/git/git-http-backend
	AH01215: ==27820==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x7f7af5dc0d66 bp 0x7fff11964450 sp 0x7fff11963be8 T0): /home/avar/g/git/git-http-backend
	AH01215: ==27820==The signal is caused by a READ memory access.: /home/avar/g/git/git-http-backend
	AH01215: ==27820==Hint: address points to the zero page.: /home/avar/g/git/git-http-backend
	AH01215:     #0 0x7f7af5dc0d66 in __sanitizer::internal_strlen(char const*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167: /home/avar/g/git/git-http-backend
	AH01215:     #1 0x7f7af5d512f2 in __interceptor_fopen64 ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:6220: /home/avar/g/git/git-http-backend
	AH01215:     #2 0x562a65e37cc8 in git_fopen compat/fopen.c:22: /home/avar/g/git/git-http-backend
	AH01215:     #3 0x562a65df3879 in fopen_or_warn wrapper.c:431: /home/avar/g/git/git-http-backend
	AH01215:     #4 0x562a65a12476 in git_config_from_file_with_options config.c:1982: /home/avar/g/git/git-http-backend
	AH01215:     #5 0x562a65a124f4 in git_config_from_file config.c:1993: /home/avar/g/git/git-http-backend
	AH01215:     #6 0x562a65a15288 in git_configset_add_file config.c:2389: /home/avar/g/git/git-http-backend
	AH01215:     #7 0x562a65a16a37 in read_protected_config config.c:2649: /home/avar/g/git/git-http-backend
	AH01215:     #8 0x562a65a16b5c in git_protected_config config.c:2661: /home/avar/g/git/git-http-backend
	AH01215:     #9 0x562a65dd9f9a in get_upload_pack_config upload-pack.c:1342: /home/avar/g/git/git-http-backend
	AH01215:     #10 0x562a65ddc1cb in upload_pack_v2 upload-pack.c:1706: /home/avar/g/git/git-http-backend
	AH01215:     #11 0x562a65d2eb8a in process_request serve.c:308: /home/avar/g/git/git-http-backend
	AH01215:     #12 0x562a65d2ec18 in protocol_v2_serve_loop serve.c:323: /home/avar/g/git/git-http-backend
	AH01215:     #13 0x562a6593c5ae in cmd_upload_pack builtin/upload-pack.c:55: /home/avar/g/git/git-http-backend
	AH01215:     #14 0x562a656cf8ff in run_builtin git.c:466: /home/avar/g/git/git-http-backend
	AH01215:     #15 0x562a656d02ab in handle_builtin git.c:720: /home/avar/g/git/git-http-backend
	AH01215:     #16 0x562a656d09d5 in run_argv git.c:787: /home/avar/g/git/git-http-backend
	AH01215:     #17 0x562a656d174f in cmd_main git.c:920: /home/avar/g/git/git-http-backend
	AH01215:     #18 0x562a6594b0b9 in main common-main.c:56: /home/avar/g/git/git-http-backend
	AH01215:     #19 0x7f7af5a5681c in __libc_start_main ../csu/libc-start.c:332: /home/avar/g/git/git-http-backend
	AH01215:     #20 0x562a656cb209 in _start (git+0x1d1209): /home/avar/g/git/git-http-backend
	AH01215: : /home/avar/g/git/git-http-backend
	AH01215: AddressSanitizer can not provide additional info.: /home/avar/g/git/git-http-backend
	AH01215: SUMMARY: AddressSanitizer: SEGV ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167 in __sanitizer::internal_strlen(char const*): /home/avar/g/git/git-http-backend
	AH01215: ==27820==ABORTING: /home/avar/g/git/git-http-backend
	AH01215: error: upload-pack died of signal 6: /home/avar/g/git/git-http-backend

(We really should have a SANITIZE=address in CI, but it takes a while...)
