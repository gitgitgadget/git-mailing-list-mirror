Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3519C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968E0207D8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f88SRpxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgFZOJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgFZOJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:09:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400ECC03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:09:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so4201669pgg.10
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cXmb7D9N4vhQrHdWJG5zo3CCZlPJocUEjbjOvo1OTyo=;
        b=f88SRpxU5myiTAlopOL/bu/cnRHCJNUCCTrRIwx+CqboDR+VYuVh0crWNKTkeqxH2/
         tOB3f5NDl0zvvnnSylWiJGo13Jjh1uiTnb/BPoB83BsaHX6GUm60hkv6++Fb7neVYYI7
         YEPbveRH0WAEfznGpLQCpjpL5EQ2W0H7I+8TUoDlPmDMlnchi7RXU0ye1c7gjq9BA8NU
         GhTYwz4rhTwYfWct5IvJVXfUFuie/qJ27gIgjRmODPpmjpN4nNQ2mZsl+fcJ6gqB/CEW
         wzOgkoWbwqYjqkTMRyjwJdW6L2HXXHcQ3bzSPqwWprfQ35qwsXmgeaScmoLQw4Jq43d8
         mR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXmb7D9N4vhQrHdWJG5zo3CCZlPJocUEjbjOvo1OTyo=;
        b=EY9oRnQt2ed7hZesXeCmMNXSVEfaSbcrHgh4XY6uXWvGlGKRr9+ebuthgBYSKt0vjC
         UEkw+50ocQqnqjuOh+yLYNP/fdjLzt0ioJPY90MuI+50hu6ZwiGyqSytgd39q9kD08sA
         GHK+WNhZjxU9KRPgCGJKnFT+4Ys/33eu3e0lOUC8pWOcKzypEVAYSiPmrOXydypPczbT
         YfUkJ/DN/xieWLE331UBeqqbYKte2IkIQCJS1e0Gd9M9/YF4+Kyw+JVB57zm54i+zDHx
         7o3itwNRIE7EhCNWwlThwKxUNWAgGFC5YJixEYvowlDU1HO5NQvF4+cHxbseMG2+wSIY
         n7Gg==
X-Gm-Message-State: AOAM532G1qvHsv+UJ2D+vCEq4AZf0pTv9Kf+GpulHWj8ujGMptkLCcYK
        xsO3b0VyAYO8z4dOjpt9svY=
X-Google-Smtp-Source: ABdhPJycvCRZTgUgowxMgnVgagDCE9Em4DgZ4Nyd5u3ZVbTQXIwqGOUpXI+qs7zIFukK5N6BjPwqxg==
X-Received: by 2002:aa7:8507:: with SMTP id v7mr1713972pfn.218.1593180548733;
        Fri, 26 Jun 2020 07:09:08 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id z3sm2485896pfz.38.2020.06.26.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 07:09:07 -0700 (PDT)
Date:   Fri, 26 Jun 2020 21:09:05 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] rebase -i: support --ignore-date
Message-ID: <20200626140854.GC12504@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
 <20200626095528.117524-5-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626095528.117524-5-phillip.wood123@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-26 10:55:27+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Rebase is implemented with two different backends - 'apply' and
> 'merge' each of which support a different set of options. In
> particular the apply backend supports a number of options implemented
> by 'git am' that are not implemented in the merge backend. This means
> that the available options are different depending on which backend is
> used which is confusing. This patch adds support for the --ignore-date
> option to the merge backend. This option uses the current time as the
> author date rather than reusing the original author date when
> rewriting commits. We take care to handle the combination of
> --ignore-date and --committer-date-is-author-date in the same way as
> the apply backend.
> 
> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt   |  7 +++--
>  builtin/rebase.c               | 13 +++++---
>  sequencer.c                    | 50 ++++++++++++++++++++++++++++--
>  sequencer.h                    |  1 +
>  t/t3436-rebase-more-options.sh | 56 ++++++++++++++++++++++++++++++++++
>  5 files changed, 117 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index dfa70263e6..e2717e20e6 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -450,8 +450,9 @@ See also INCOMPATIBLE OPTIONS below.
>  	date. This option implies --force-rebase.
>  
>  --ignore-date::
> -	This flag is passed to 'git am' to change the author date
> -	of each rebased commit (see linkgit:git-am[1]).
> +	Instead of using the author date of the original commit, use
> +	the current time as the	author date of the rebased commit.  This
> +	option implies `--force-rebase`.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
> @@ -589,7 +590,6 @@ INCOMPATIBLE OPTIONS
>  The following options:
>  
>   * --apply
> - * --ignore-date
>   * --whitespace
>   * -C
>  
> @@ -617,6 +617,7 @@ In addition, the following pairs of options are incompatible:
>   * --preserve-merges and --empty=
>   * --preserve-merges and --ignore-whitespace
>   * --preserve-merges and --committer-date-is-author-date
> + * --preserve-merges and --ignore-date
>   * --keep-base and --onto
>   * --keep-base and --root
>  
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a7c3d5c92b..890dd4c588 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -89,6 +89,7 @@ struct rebase_options {
>  	char *gpg_sign_opt;
>  	int autostash;
>  	int committer_date_is_author_date;
> +	int ignore_date;
>  	char *cmd;
>  	int allow_empty_message;
>  	int rebase_merges, rebase_cousins;
> @@ -127,6 +128,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>  	replay.committer_date_is_author_date =
>  					opts->committer_date_is_author_date;
> +	replay.ignore_date = opts->ignore_date;
>  	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>  	replay.strategy = opts->strategy;
>  
> @@ -1503,8 +1505,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "committer-date-is-author-date",
>  			 &options.committer_date_is_author_date,
>  			 N_("make committer date match author date")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> +		OPT_BOOL(0, "ignore-date", &options.ignore_date,
> +			 "ignore author date and use current date"),

Nit: The options' description is subjected to l10n.

s/".*"/N_(&)/

>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>  				  N_("passed to 'git apply'"), 0),
>  		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
> @@ -1797,13 +1799,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	    options.autosquash) {
>  		allow_preemptive_ff = 0;
>  	}
> -	if (options.committer_date_is_author_date)
> +	if (options.committer_date_is_author_date || options.ignore_date)
>  		options.flags |= REBASE_FORCE;
>  
>  	for (i = 0; i < options.git_am_opts.argc; i++) {
>  		const char *option = options.git_am_opts.argv[i], *p;
> -		if (!strcmp(option, "--ignore-date") ||
> -		    !strcmp(option, "--whitespace=fix") ||
> +		if (!strcmp(option, "--whitespace=fix") ||
>  		    !strcmp(option, "--whitespace=strip"))
>  			allow_preemptive_ff = 0;
>  		else if (skip_prefix(option, "-C", &p)) {
> @@ -1862,6 +1863,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (options.committer_date_is_author_date)
>  			argv_array_push(&options.git_am_opts,
>  					"--committer-date-is-author-date");
> +		if (options.ignore_date)
> +			argv_array_push(&options.git_am_opts, "--ignore-date");
>  	} else if (ignore_whitespace) {
>  			string_list_append (&strategy_options,
>  					    "ignore-space-change");
> diff --git a/sequencer.c b/sequencer.c
> index 29f6d1bc39..f8e1e38623 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -150,6 +150,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>   */
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
> +static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -889,6 +890,24 @@ static const char *author_date_from_env_array(const struct argv_array *env)
>  	BUG("GIT_AUTHOR_DATE missing from author script");
>  }
>  
> +/* Construct a free()able author string with current time as the author date */
> +static char *ignore_author_date(const char *author)
> +{
> +	int len = strlen(author);
> +	struct ident_split ident;
> +	struct strbuf new_author = STRBUF_INIT;
> +
> +	if (split_ident_line(&ident, author, len) < 0) {
> +		error(_("malformed ident line '%s'"), author);
> +		return NULL;
> +	}
> +
> +	len = ident.mail_end - ident.name_begin + 1;
> +	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);

I wonder if we can do this instead:

	strbuf_add(&new_author, ident.name_begin, len);

Quick skim through the code and nothing crashes when make test with:

	CFLAGS="-fstack-clash-protection -D_FORTIFY_SOURCE=2"

I think it's OK to be changed.

> +	datestamp(&new_author);
> +	return strbuf_detach(&new_author, NULL);
> +}
> +

-- 
Danh
