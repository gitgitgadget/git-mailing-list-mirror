Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CDC209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163497AbdEZDPj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:15:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33035 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946762AbdEZDPY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:15:24 -0400
Received: by mail-io0-f193.google.com with SMTP id m4so377531ioe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5aj2JPUjBjry2AMpbdSpw5bv9oPusL9hxX9jxxjx/E=;
        b=i8p+3RUovGqBXHym2Kl2wcWpaS4Nrk03xL+TR2+tRkK50kTa2u9gdhiQYLt/ZINXBg
         EUXgYhg/Ul5n/a+DVVncnfpHx3FM5dudH7tMfwkjiAzoDfbOjvBqLZqKs/K+g9Quwi0z
         I5aIP7qlS0bhFU9gXojn5ZVJMhAcev/BWb7TPWz1sDmkeELDHEpF/9P9dm0OCV4QVZ6J
         Am8VBZ1mm3gr4RQP+2wpASEiNSXTNZm//e9W8bbV9oVEDnZ6wO9IA+PhxSxcHZtEvqYg
         hH0oR0rw5JUTFqyqFV/5H6UD5N39ulcqcYLqLr/ruSOKIpHWI8VKdKS+iNpSI1Nkh2Z6
         1zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5aj2JPUjBjry2AMpbdSpw5bv9oPusL9hxX9jxxjx/E=;
        b=lzXpdVQWEpsOoK1AW0IDTbpF7GrxZydf2rdV1Y/OzL22dAYrfA1W9iQeySPhYDjtVR
         WhEPuQB5cGdngYzPTCyMu5edlN9gcKObCYxpI/jPkbL6yqcKB8BPIwKc5xegFKL6Aft9
         jwV7r0Jvo42SrdzGU1UGezZhTd+OOVljUvvUN54WRSbBbkuVaZz2Ad5qK0p7dtQ7B1AZ
         wuRuG1vmjXCYbWWMuI9jIW3B2n1YuF49/vc+mlRKr2/bf7fxiwZRQQnfLajTuIvDi0yf
         uS1lgO+0dwe/d4MK+Ewc8BPFW9UP+22Sb4m2ihNh2S6jTNHuQYXtUUTRaYKsUxV/svSq
         buXQ==
X-Gm-Message-State: AODbwcAa5EaIdSdt4ZwGWZuZbMgc5tQM8kPRzFG04j0xdWVozEDVlB+z
        gSricIOnMr9Gig==
X-Received: by 10.107.10.223 with SMTP id 92mr47782060iok.108.1495768523088;
        Thu, 25 May 2017 20:15:23 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 200sm3920070itl.7.2017.05.25.20.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 20:15:22 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: [PATCH v4 02/10] rebase -i: generate the script via rebase--helper
Date:   Thu, 25 May 2017 23:15:16 -0400
Message-Id: <20170526031516.26287-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
References: <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> The first step of an interactive rebase is to generate the so-called "todo
> script", to be stored in the state directory as "git-rebase-todo" and to
> be edited by the user.
> 
> Originally, we adjusted the output of `git log <options>` using a simple
> sed script. Over the course of the years, the code became more
> complicated. We now use shell scripting to edit the output of `git log`
> conditionally, depending whether to keep "empty" commits (i.e. commits
> that do not change any files).
> 
> On platforms where shell scripting is not native, this can be a serious
> drag. And it opens the door for incompatibilities between platforms when
> it comes to shell scripting or to Unix-y commands.
> 
> Let's just re-implement the todo script generation in plain C, using the
> revision machinery directly.
> 
> This is substantially faster, improving the speed relative to the
> shell script version of the interactive rebase from 2x to 3x on Windows.
> 
> Note that the rearrange_squash() function in git-rebase--interactive
> relied on the fact that we set the "format" variable to the config setting
> rebase.instructionFormat. Relying on a side effect like this is no good,
> hence we explicitly perform that assignment (possibly again) in
> rearrange_squash().
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase--helper.c   |  8 +++++++-
>  git-rebase--interactive.sh | 44 +++++++++++++++++++++--------------------
>  sequencer.c                | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                |  3 +++
>  4 files changed, 82 insertions(+), 22 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index ca1ebb2fa18..821058d452d 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -11,15 +11,19 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> +	int keep_empty = 0;
>  	enum {
> -		CONTINUE = 1, ABORT
> +		CONTINUE = 1, ABORT, MAKE_SCRIPT
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> +		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  				CONTINUE),
>  		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
>  				ABORT),
> +		OPT_CMDMODE(0, "make-script", &command,
> +			N_("make rebase script"), MAKE_SCRIPT),
>  		OPT_END()
>  	};
>  
> @@ -36,5 +40,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!sequencer_continue(&opts);
>  	if (command == ABORT && argc == 1)
>  		return !!sequencer_remove_state(&opts);
> +	if (command == MAKE_SCRIPT && argc > 1)
> +		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2c9c0165b5a..609e150d38f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -785,6 +785,7 @@ collapse_todo_ids() {
>  # each log message will be re-retrieved in order to normalize the
>  # autosquash arrangement
>  rearrange_squash () {
> +	format=$(git config --get rebase.instructionFormat)
>  	# extract fixup!/squash! lines and resolve any referenced sha1's
>  	while read -r pick sha1 message
>  	do
> @@ -1210,26 +1211,27 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> -format=$(git config --get rebase.instructionFormat)
> -# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
> -git rev-list $merges_option --format="%m%H ${format:-%s}" \
> -	--reverse --left-right --topo-order \
> -	$revisions ${restrict_revision+^$restrict_revision} | \
> -	sed -n "s/^>//p" |
> -while read -r sha1 rest
> -do
> -
> -	if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
> -	then
> -		comment_out="$comment_char "
> -	else
> -		comment_out=
> -	fi
> +if test t != "$preserve_merges"
> +then
> +	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
> +		$revisions ${restrict_revision+^$restrict_revision} >"$todo"
> +else
> +	format=$(git config --get rebase.instructionFormat)
> +	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
> +	git rev-list $merges_option --format="%m%H ${format:-%s}" \
> +		--reverse --left-right --topo-order \
> +		$revisions ${restrict_revision+^$restrict_revision} | \
> +		sed -n "s/^>//p" |
> +	while read -r sha1 rest
> +	do
> +
> +		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
> +		then
> +			comment_out="$comment_char "
> +		else
> +			comment_out=
> +		fi
>  
> -	if test t != "$preserve_merges"
> -	then
> -		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> -	else
>  		if test -z "$rebase_root"
>  		then
>  			preserve=t
> @@ -1248,8 +1250,8 @@ do
>  			touch "$rewritten"/$sha1
>  			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
>  		fi
> -	fi
> -done
> +	done
> +fi
>  
>  # Watch for commits that been dropped by --cherry-pick
>  if test t = "$preserve_merges"
> diff --git a/sequencer.c b/sequencer.c
> index 130cc868e51..88819a1a2a9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2388,3 +2388,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  
>  	strbuf_release(&sob);
>  }
> +
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv)
> +{
> +	char *format = NULL;
> +	struct pretty_print_context pp = {0};
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info revs;
> +	struct commit *commit;
> +
> +	init_revisions(&revs, NULL);
> +	revs.verbose_header = 1;
> +	revs.max_parents = 1;
> +	revs.cherry_pick = 1;
> +	revs.limited = 1;
> +	revs.reverse = 1;
> +	revs.right_only = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +	revs.topo_order = 1;
> +
> +	revs.pretty_given = 1;
> +	git_config_get_string("rebase.instructionFormat", &format);
> +	if (!format || !*format) {
> +		free(format);
> +		format = xstrdup("%s");
> +	}
> +	get_commit_format(format, &revs);
> +	free(format);
> +	pp.fmt = revs.commit_format;
> +	pp.output_encoding = get_log_output_encoding();
> +
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		return error(_("make_script: unhandled options"));
> +
> +	if (prepare_revision_walk(&revs) < 0)
> +		return error(_("make_script: error preparing revisions"));
> +
> +	while ((commit = get_revision(&revs))) {
> +		strbuf_reset(&buf);
> +		if (!keep_empty && is_original_commit_empty(commit))
> +			strbuf_addf(&buf, "%c ", comment_line_char);

I've never had to use empty commits before, but while testing this, I
noticed that `git rebase -i --keep-empty` behaves differently if using
the --root option instead of a branch or something like 'HEAD~10'.
I also tested this on v2.13.0 and the behavior is the same.

> +		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
> +		pretty_print_commit(&pp, commit, &buf);
> +		strbuf_addch(&buf, '\n');
> +		fputs(buf.buf, out);
> +	}
> +	strbuf_release(&buf);
> +	return 0;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index f885b68395f..83f2943b7a9 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,6 +45,9 @@ int sequencer_continue(struct replay_opts *opts);
>  int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv);
> +
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
> -- 
> 2.12.2.windows.2.800.gede8f145e06

Liam

