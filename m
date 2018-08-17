Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0B31F954
	for <e@80x24.org>; Fri, 17 Aug 2018 13:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeHQQab (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 12:30:31 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:64486 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeHQQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 12:30:30 -0400
Received: from [192.168.2.201] ([92.22.43.193])
        by smtp.talktalk.net with SMTP
        id qemLfl9pOdJAeqemLfYcdb; Fri, 17 Aug 2018 14:27:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534512422;
        bh=l8cMSYpVuBwEZciJRv7B3Y3Hc0bQ5NFBoLFW44h38/E=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Uxsu+RhF+ZowdE7o5BNOt5iXCy/5Kci82WJWsTjISh3IkdsXQAsOT9Uk4FoHaqjY4
         rNNLqp86ZbJvpzbcU+/pW8rFok0W+r6qmGWy1MyQz56W9cVQeFJxAdyuZsNLzE5QlR
         rpg+SHpWY8F+oYK09R86ZV+XklWBVORxKvHyeTho=
X-Originating-IP: [92.22.43.193]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=0uAVYj1wOgJByxYeJIV+0Q==:117
 a=0uAVYj1wOgJByxYeJIV+0Q==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=GOQpW_Y6qwpmYg8duBAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v6 15/20] rebase -i: rewrite write_basic_state() in
 C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180810165147.4779-16-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3da3ce19-38f8-0c46-47a1-9510f203b65f@talktalk.net>
Date:   Fri, 17 Aug 2018 14:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180810165147.4779-16-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHQiTxcaNm6pnUFzRa65Vb/60MDgSVZm56GYYVRnKwLIwA0CYSY/5zkF/YFFJIEt1CXco2j4FXkycJLjB6/YhG6Ii/+ahfNSytJD28c960VGc6kkHoyS
 BaR81Rt0/VjObtgIMmOmSCifyl1zEXQIMKcQFtakBOD9Qgp62D6RKmhFbDXf5701QVK0YYuk9uHreWmbRzpdncAAJ5Hgn1SOsWdbu2193R0UTkmb4nUwWa0s
 +VCRpd7oYRzBZgRLVAVh7qxYnQbczmIrAj6IBut6NL38yBEhuT/ATXsK+kIOmDjvGmTzTJvauJnv2I5hMZZQ9Hig0pfdsqeKvC7x5aDJ82FNhLLZ3dxteHYG
 8ODsrTTpk9tAI4NX8legG4Tz/8UyTTc858FKC//6se8gQMWSPqs+wkVVb4TonUqOBoTInaaI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2018 17:51, Alban Gruin wrote:
> This rewrites write_basic_state() from git-rebase.sh in C.  This is the
> first step in the conversion of init_basic_state(), hence the mode in
> rebase--helper.c is called INIT_BASIC_STATE.  init_basic_state() will be
> converted in the next commit.
> 
> The part of read_strategy_opts() that parses the stategy options is
> moved to a new function to allow its use in rebase--helper.c.
> 
> Finally, the call to write_basic_state() is removed from
> git-rebase--interactive.sh, replaced by a call to `--init-basic-state`.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> No changes since v5.
> 
>  builtin/rebase--helper.c   | 28 +++++++++++++-
>  git-rebase--interactive.sh |  7 +++-
>  sequencer.c                | 77 ++++++++++++++++++++++++++++++++------
>  sequencer.h                |  4 ++
>  4 files changed, 102 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index 0716bbfd78..63c5086e42 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -5,6 +5,8 @@
>  #include "sequencer.h"
>  #include "rebase-interactive.h"
>  #include "argv-array.h"
> +#include "rerere.h"
> +#include "alias.h"
>  
>  static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>  
> @@ -53,11 +55,12 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
>  	int abbreviate_commands = 0, rebase_cousins = -1, ret;
>  	const char *head_hash = NULL, *onto = NULL, *restrict_revision = NULL,
> -		*squash_onto = NULL, *upstream = NULL;
> +		*squash_onto = NULL, *upstream = NULL, *head_name = NULL;
> +	char *raw_strategies = NULL;
>  	enum {
>  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>  		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
> -		COMPLETE_ACTION
> +		COMPLETE_ACTION, INIT_BASIC_STATE
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -69,6 +72,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			 N_("keep original branch points of cousins")),
>  		OPT_BOOL(0, "autosquash", &autosquash,
>  			 N_("move commits that begin with squash!/fixup!")),
> +		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
>  		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  				CONTINUE),
> @@ -93,6 +97,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
>  		OPT_CMDMODE(0, "complete-action", &command,
>  			    N_("complete the action"), COMPLETE_ACTION),
> +		OPT_CMDMODE(0, "init-basic-state", &command,
> +			    N_("initialise the rebase state"), INIT_BASIC_STATE),
>  		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
>  		OPT_STRING(0, "restrict-revision", &restrict_revision,
>  			   N_("restrict-revision"), N_("restrict revision")),
> @@ -100,6 +106,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			   N_("squash onto")),
>  		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
>  			   N_("the upstream commit")),
> +		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
> +		OPT_STRING('S', "gpg-sign", &opts.gpg_sign, N_("gpg-sign"),
> +			   N_("GPG-sign commits")),
> +		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
> +			   N_("rebase strategy")),
> +		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
> +			   N_("strategy options")),
> +		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
>  		OPT_END()
>  	};
>  
> @@ -176,6 +190,16 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		free(shortrevisions);
>  		return !!ret;
>  	}
> +	if (command == INIT_BASIC_STATE) {
> +		if (raw_strategies)
> +			parse_strategy_opts(&opts, raw_strategies);
> +
> +		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, NULL);
> +		if (ret)
> +			return ret;
> +
> +		return !!write_basic_state(&opts, head_name, onto, head_hash);
> +	}
>  
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 08e9a21c2f..6367da66e2 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -57,7 +57,6 @@ init_basic_state () {
>  	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
>  
>  	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
> -	write_basic_state
>  }
>  
>  git_rebase__interactive () {
> @@ -70,6 +69,12 @@ git_rebase__interactive () {
>  	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
>  	init_basic_state
>  
> +	git rebase--helper --init-basic-state ${upstream:+--upstream "$upstream"} \
> +		${onto:+--onto "$onto"} ${head_name:+--head-name "$head_name"} \
> +		${verbose:+--verbose} ${strategy:+--strategy "$strategy"} \
> +		${strategy_opts:+--strategy-opts="$strategy_opts"} \
> +		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff" || exit
> +
>  	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
>  		${rebase_merges:+--rebase-merges} \
>  		${rebase_cousins:+--rebase-cousins} \
> diff --git a/sequencer.c b/sequencer.c
> index 3800439c10..beff749904 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -144,7 +144,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>  
>  /*
>   * The following files are written by git-rebase just after parsing the
> - * command-line (and are only consumed, not modified, by the sequencer).
> + * command-line.
>   */
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
> @@ -156,6 +156,7 @@ static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
>  static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
>  static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
>  static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
> +static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
>  
>  static int git_sequencer_config(const char *k, const char *v, void *cb)
>  {
> @@ -2205,21 +2206,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  	return 0;
>  }
>  
> -static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
> +void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
>  {
>  	int i;
> -	char *strategy_opts_string;
> +	char *strategy_opts_string = raw_opts;
>  
> -	strbuf_reset(buf);
> -	if (!read_oneliner(buf, rebase_path_strategy(), 0))
> -		return;
> -	opts->strategy = strbuf_detach(buf, NULL);
> -	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
> -		return;
> -
> -	strategy_opts_string = buf->buf;
>  	if (*strategy_opts_string == ' ')
>  		strategy_opts_string++;
> +
>  	opts->xopts_nr = split_cmdline(strategy_opts_string,
>  				       (const char ***)&opts->xopts);
>  	for (i = 0; i < opts->xopts_nr; i++) {
> @@ -2230,6 +2224,18 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>  	}
>  }
>  
> +static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
> +{
> +	strbuf_reset(buf);
> +	if (!read_oneliner(buf, rebase_path_strategy(), 0))
> +		return;
> +	opts->strategy = strbuf_detach(buf, NULL);
> +	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
> +		return;
> +
> +	parse_strategy_opts(opts, buf->buf);
> +}
> +
>  static int read_populate_opts(struct replay_opts *opts)
>  {
>  	if (is_rebase_i(opts)) {
> @@ -2297,6 +2303,55 @@ static int read_populate_opts(struct replay_opts *opts)
>  	return 0;
>  }
>  
> +static void write_strategy_opts(struct replay_opts *opts)
> +{
> +	int i;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	for (i = 0; i < opts->xopts_nr; ++i)
> +		strbuf_addf(&buf, " --%s", opts->xopts[i]);
> +
> +	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
> +	strbuf_release(&buf);
> +}
> +
> +int write_basic_state(struct replay_opts *opts, const char *head_name,
> +		      const char *onto, const char *orig_head)

If this is going to live in libgit then I think it could do with a less
generic name such as write_rebase_state() so it is clear which command
the function is writing the state for.

> +{
> +	const char *quiet = getenv("GIT_QUIET");
> +
> +	if (head_name)
> +		write_file(rebase_path_head_name(), "%s\n", head_name);

write_file() can call die() which isn't encouraged for code in libgit.
I'm not sure how much it matters in this case. Rewriting all these as

	if (head_name && write_message(onto, strlen(onto), rebase_path_onto(), 1))
		return -1;

is a bit tedious. An alternative would be it leave it for now and in the
longer term move this function (and the ones above which I've just
noticed also call write_file()) to in builtin/rebase.c (assuming that
builtin/rebase--interactive.c and builtin/rebase.c get merged once
they're finalized - I'm not sure if there is a plan for that or not.)

Best Wishes

Phillip

> +	if (onto)
> +		write_file(rebase_path_onto(), "%s\n", onto);
> +	if (orig_head)
> +		write_file(rebase_path_orig_head(), "%s\n", orig_head);
> +
> +	if (quiet)
> +		write_file(rebase_path_quiet(), "%s\n", quiet);
> +	else
> +		write_file(rebase_path_quiet(), "\n");
> +
> +	if (opts->verbose)
> +		write_file(rebase_path_verbose(), "");
> +	if (opts->strategy)
> +		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
> +	if (opts->xopts_nr > 0)
> +		write_strategy_opts(opts);
> +
> +	if (opts->allow_rerere_auto == RERERE_AUTOUPDATE)
> +		write_file(rebase_path_allow_rerere_autoupdate(), "--rerere-autoupdate\n");
> +	else if (opts->allow_rerere_auto == RERERE_NOAUTOUPDATE)
> +		write_file(rebase_path_allow_rerere_autoupdate(), "--no-rerere-autoupdate\n");
> +
> +	if (opts->gpg_sign)
> +		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
> +	if (opts->signoff)
> +		write_file(rebase_path_signoff(), "--signoff\n");
> +
> +	return 0;
> +}
> +
>  static int walk_revs_populate_todo(struct todo_list *todo_list,
>  				struct replay_opts *opts)
>  {
> diff --git a/sequencer.h b/sequencer.h
> index 02e3d7940e..aab280f276 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -119,3 +119,7 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
>  void print_commit_summary(const char *prefix, const struct object_id *oid,
>  			  unsigned int flags);
>  #endif
> +
> +void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
> +int write_basic_state(struct replay_opts *opts, const char *head_name,
> +		      const char *onto, const char *orig_head);
> 

