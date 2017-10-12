Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5780D1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 02:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdJLCtI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 22:49:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51737 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752120AbdJLCtH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 22:49:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9557B699F;
        Wed, 11 Oct 2017 22:49:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ITqjs4/4yU/p8CYlFGXrDaCrluA=; b=AJ2j6c
        qVml9Vu9xwu5oZam+vHtPKA6RIlUOutilGBUQy1MVRf2HqzN/H1qIIS3T1+KCvlI
        EeO2Ug6VhpzXlHheoIczzHVTCOsItQqf9E73uu/n5iEJ/y+ZLqN7VddMHkXnGVWD
        V8gT/hd7iJm8c+SKdQlO5A0DOerYhzUzWj5GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cN2g+wqhIWVh1gYmpuVKvOKZ8bVzo82m
        t0nVVaeH37HsGUFJ+FNblxo7ogKFCD7p0++jZT6ewH19e4Pe8aWCSu3e8y0yM3Kb
        kZ1PsT8s28mcViYLi0M/T3yUzLE1OchDgpTntNVIcxWZ9PXAWDw3tgjtPxU0UxnC
        6nbsmIuVe8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBAF0B699E;
        Wed, 11 Oct 2017 22:49:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3875B699D;
        Wed, 11 Oct 2017 22:49:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2 1/5] Teach status options around showing ignored files
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171011133504.15049-1-jamill@microsoft.com>
        <20171011133504.15049-2-jamill@microsoft.com>
Date:   Thu, 12 Oct 2017 11:49:04 +0900
In-Reply-To: <20171011133504.15049-2-jamill@microsoft.com> (Jameson Miller's
        message of "Wed, 11 Oct 2017 09:35:00 -0400")
Message-ID: <xmqqy3oh13of.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9B8FA14-AEF7-11E7-9A7D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> This change teaches the status command more options to control which
> ignored files are reported independently of the which untracked files
> are reported by allowing the `--ignored` option to take additional
> arguments.  Currently, the shown ignored files are linked to how
> untracked files are reported. Both ignored and untracked files are
> controlled by arguments to `--untracked-files` option. This makes it
> impossible to show all untracked files individually, but show ignored
> "files and directories" (that is, ignored directories are shown as 1
> entry, instead of having all contents shown).

The description makes sense.  And it makes sense to show a directory
known to contain only ignored paths as just one entry, instead of
exploding that to individual files.

> Our application (Visual Studio) has a specific set of requirements
> about how it wants untracked / ignored files reported by git status.

This sentence does not read well.  VS has no obligation to read from
"git status", so there is no "specific set of requirements" that
make us care.  If the output from "status" is insufficient you could
be reading from "ls-files --ignored", for example, if you want more
details than "git status" gives you.

The sentence, and the paragraph that immediately follows it, need a
serious attitude adjustment ;-), even though it is good as read as
an explanation of what the proposed output wants to show.

> The reason for controlling these behaviors separately is that there
> can be a significant performance impact to scanning the contents of
> excluded directories. Additionally, knowing whether a directory
> explicitly matches an exclude pattern can help the application make
> decisions about how to handle the directory. If an ignored directory
> itself matches an exclude pattern, then the application will know that
> any files underneath the directory must be ignored as well.

While the above description taken standalone makes sense, doesn't
the "we want all paths listed, without abbreviated to the directory
and requiring the reader to infer from the fact that aidrectory is
shown that everything in it are ignored" the log message stated
earlier contradict another change you earlier sent, that avoids
scanning a directory that is known to be completely untracked
(i.e. no path under it in the index) and return early once an
untracked file is found in it?

> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  builtin/commit.c | 31 +++++++++++++++++++++++++------
>  dir.c            | 24 ++++++++++++++++++++++++
>  dir.h            |  3 ++-
>  wt-status.c      | 11 ++++++++---
>  wt-status.h      |  8 +++++++-
>  5 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d75b3805ea..98d84d0277 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -118,7 +118,7 @@ static int edit_flag = -1; /* unspecified */
>  static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>  static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message;
> -static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
> +static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit;
>  
>  /*
> @@ -139,7 +139,7 @@ static const char *cleanup_arg;
>  static enum commit_whence whence;
>  static int sequencer_in_use;
>  static int use_editor = 1, include_status = 1;
> -static int show_ignored_in_status, have_option_m;
> +static int have_option_m;
>  static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
> @@ -1075,6 +1075,19 @@ static const char *find_author_by_nickname(const char *name)
>  	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
>  }
>  
> +static void handle_ignored_arg(struct wt_status *s)
> +{
> +	if (!ignored_arg)
> +		; /* default already initialized */
> +	else if (!strcmp(ignored_arg, "traditional"))
> +		s->show_ignored_mode = SHOW_TRADITIONAL_IGNORED;
> +	else if (!strcmp(ignored_arg, "no"))
> +		s->show_ignored_mode = SHOW_NO_IGNORED;
> +	else if (!strcmp(ignored_arg, "matching"))
> +		s->show_ignored_mode = SHOW_MATCHING_IGNORED;
> +	else
> +		die(_("Invalid ignored mode '%s'"), ignored_arg);
> +}
>  
>  static void handle_untracked_files_arg(struct wt_status *s)
>  {
> @@ -1363,8 +1376,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  		  N_("mode"),
>  		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
>  		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> -		OPT_BOOL(0, "ignored", &show_ignored_in_status,
> -			 N_("show ignored files")),
> +		{ OPTION_STRING, 0, "ignored", &ignored_arg,
> +		  N_("mode"),
> +		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
> +		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
>  		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
>  		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>  		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> @@ -1383,8 +1398,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	finalize_deferred_config(&s);
>  
>  	handle_untracked_files_arg(&s);
> -	if (show_ignored_in_status)
> -		s.show_ignored_files = 1;
> +	handle_ignored_arg(&s);
> +
> +	if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
> +	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
> +		die(_("Unsupported combination of ignored and untracked-files arguments"));
> +
>  	parse_pathspec(&s.pathspec, 0,
>  		       PATHSPEC_PREFER_FULL,
>  		       prefix, argv);
> diff --git a/dir.c b/dir.c
> index 1d17b800cf..b9af87eca9 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1389,6 +1389,30 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  	case index_nonexistent:
>  		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>  			break;
> +		if (exclude &&
> +			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
> +			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
> +
> +			/*
> +			 * This is an excluded directory and we are
> +			 * showing ignored paths that match an exclude
> +			 * pattern.  (e.g. show directory as ignored
> +			 * only if it matches an exclude pattern).
> +			 * This path will either be 'path_excluded`
> +			 * (if we are showing empty directories or if
> +			 * the directory is not empty), or will be
> +			 * 'path_none' (empty directory, and we are
> +			 * not showing empty directories).
> +			 */
> +			if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> +				return path_excluded;
> +
> +			if (read_directory_recursive(dir, istate, dirname, len,
> +						     untracked, 1, 1, pathspec) == path_excluded)
> +				return path_excluded;
> +
> +			return path_none;
> +		}
>  		if (!(dir->flags & DIR_NO_GITLINKS)) {
>  			unsigned char sha1[20];
>  			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
> diff --git a/dir.h b/dir.h
> index e3717055d1..57b0943dae 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -152,7 +152,8 @@ struct dir_struct {
>  		DIR_COLLECT_IGNORED = 1<<4,
>  		DIR_SHOW_IGNORED_TOO = 1<<5,
>  		DIR_COLLECT_KILLED_ONLY = 1<<6,
> -		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
> +		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
> +		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8
>  	} flags;
>  	struct dir_entry **entries;
>  	struct dir_entry **ignored;
> diff --git a/wt-status.c b/wt-status.c
> index 6f730ee8f2..8301c84946 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -660,10 +660,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
>  	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
>  		dir.flags |=
>  			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> -	if (s->show_ignored_files)
> +	if (s->show_ignored_mode) {
>  		dir.flags |= DIR_SHOW_IGNORED_TOO;
> -	else
> +
> +		if (s->show_ignored_mode == SHOW_MATCHING_IGNORED)
> +			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
> +	} else {
>  		dir.untracked = the_index.untracked;
> +	}
> +
>  	setup_standard_excludes(&dir);
>  
>  	fill_directory(&dir, &the_index, &s->pathspec);
> @@ -1621,7 +1626,7 @@ static void wt_longstatus_print(struct wt_status *s)
>  	}
>  	if (s->show_untracked_files) {
>  		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
> -		if (s->show_ignored_files)
> +		if (s->show_ignored_mode)
>  			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
>  		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
>  			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> diff --git a/wt-status.h b/wt-status.h
> index 64f4d33ea1..fe27b465e2 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -27,6 +27,12 @@ enum untracked_status_type {
>  	SHOW_ALL_UNTRACKED_FILES
>  };
>  
> +enum show_ignored_type {
> +	SHOW_NO_IGNORED,
> +	SHOW_TRADITIONAL_IGNORED,
> +	SHOW_MATCHING_IGNORED,
> +};
> +
>  /* from where does this commit originate */
>  enum commit_whence {
>  	FROM_COMMIT,     /* normal */
> @@ -70,7 +76,7 @@ struct wt_status {
>  	int display_comment_prefix;
>  	int relative_paths;
>  	int submodule_summary;
> -	int show_ignored_files;
> +	enum show_ignored_type show_ignored_mode;
>  	enum untracked_status_type show_untracked_files;
>  	const char *ignore_submodule_arg;
>  	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
