From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/2] add: add --ignore-submodules[=<when>] parameter
Date: Fri, 18 Apr 2014 13:53:30 +0200
Message-ID: <5351123A.9060201@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com> <5349C226.9090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 18 13:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb7NX-0004Iq-MT
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 13:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaDRLyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 07:54:09 -0400
Received: from mout.web.de ([212.227.15.14]:64242 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbaDRLx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 07:53:57 -0400
Received: from [192.168.178.41] ([79.193.66.64]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LwYnz-1X0vWS2JNn-018G4V; Fri, 18 Apr 2014 13:53:51
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5349C226.9090709@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:UOS8am4MtSa2O+37cRwSLznfnfhFfa+Ph+g/HafRAjJMMayDYVN
 v5Uzcy7g/zyPJTpVjVXDIbe49mCKaF1TmWRshH8xoBS3Z5CftB6H+95VBuQdCqW3cgE1tc0
 kqkxzb3DDK7zF/1Ga2y4Ee0x1z2U7NjO0jg8ggS4QADxB2X6C68q0oRuUNefxh6qvhHxKe4
 e7l1iiFvuWr88u1DnZmDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246465>

Am 13.04.2014 00:45, schrieb Ronald Weiss:
> Allow ignoring submodules (or not) by command line switch, like diff
> and status do.
> 
> Git add currently doesn't honor ignore from .gitmodules or .git/config,
> which is related functionality, however I'd like to change that in
> another patch, coming soon.

I think we should drop this paragraph from this commit message. Though
I believe it's helpful to add this information after the "---" below
to inform readers of the list of your future plans.

> This commit is also a prerequisite for the next one in series, which
> adds the --ignore-submodules switch to git commit.

But this information definitely belongs here.

> That's why signature
> of function add_files_to_cache was changed.

But that's necessary for this patch too, no?

> That also requires compilo fixes in checkout.c and commit.c

Sorry, but I don't know what a "compilo fix" is ;-) .. I suspect you
mean that add_files_to_cache() needs a new NULL argument in some
places. What about dropping the last two sentences and adding
something like "Add a new argument to add_files_to_cache() to pass
the command line option and update all other call sites to pass
NULL instead." to the first paragraph?

Apart from that and the flags of the test (see below) this patch
is looking good to me.

> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
>  Documentation/git-add.txt        |  7 ++++++-
>  builtin/add.c                    | 16 ++++++++++++--
>  builtin/checkout.c               |  2 +-
>  builtin/commit.c                 |  2 +-
>  cache.h                          |  2 +-
>  t/t3704-add-ignore-submodules.sh | 45 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 68 insertions(+), 6 deletions(-)
>  create mode 100644 t/t3704-add-ignore-submodules.sh
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 9631526..b2c936f 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
>  	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
>  	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
> -	  [--] [<pathspec>...]
> +	  [--ignore-submodules[=<when>]] [--] [<pathspec>...]
>  
>  DESCRIPTION
>  -----------
> @@ -164,6 +164,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>  	be ignored, no matter if they are already present in the work
>  	tree or not.
>  
> +--ignore-submodules[=<when>]::
> +	Can be used to override any settings of the 'submodule.*.ignore'
> +	option in linkgit:git-config[1] or linkgit:gitmodules[5].
> +	<when> can be either "none" or "all", which is the default.
> +
>  \--::
>  	This option can be used to separate command-line options from
>  	the list of files, (useful when filenames might be mistaken
> diff --git a/builtin/add.c b/builtin/add.c
> index 459208a..85f2110 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -83,7 +83,8 @@ static void update_callback(struct diff_queue_struct *q,
>  }
>  
>  int add_files_to_cache(const char *prefix,
> -		       const struct pathspec *pathspec, int flags)
> +		       const struct pathspec *pathspec, int flags,
> +		       const char *ignore_submodules_arg)
>  {
>  	struct update_callback_data data;
>  	struct rev_info rev;
> @@ -99,6 +100,12 @@ int add_files_to_cache(const char *prefix,
>  	rev.diffopt.format_callback = update_callback;
>  	rev.diffopt.format_callback_data = &data;
>  	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
> +
> +	if (ignore_submodules_arg) {
> +		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> +		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
> +	}
> +
>  	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
>  	return !!data.add_errors;
>  }
> @@ -237,6 +244,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
>  static int addremove = ADDREMOVE_DEFAULT;
>  static int addremove_explicit = -1; /* unspecified */
>  
> +static char *ignore_submodule_arg;
> +
>  static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
>  {
>  	/* if we are told to ignore, we are not adding removals */
> @@ -262,6 +271,9 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>  	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>  	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> +	{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
> +	  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
> +	  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  	OPT_END(),
>  };
>  
> @@ -434,7 +446,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	plug_bulk_checkin();
>  
> -	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
> +	exit_status |= add_files_to_cache(prefix, &pathspec, flags, ignore_submodule_arg);
>  
>  	if (add_new_files)
>  		exit_status |= add_files(&dir, flags);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 07cf555..607af47 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -525,7 +525,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			 * entries in the index.
>  			 */
>  
> -			add_files_to_cache(NULL, NULL, 0);
> +			add_files_to_cache(NULL, NULL, 0, NULL);
>  			/*
>  			 * NEEDSWORK: carrying over local changes
>  			 * when branches have different end-of-line
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9cfef6c..a148e28 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -361,7 +361,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  	 */
>  	if (all || (also && pathspec.nr)) {
>  		fd = hold_locked_index(&index_lock, 1);
> -		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
> +		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
>  		refresh_cache_or_die(refresh_flags);
>  		update_main_cache_tree(WRITE_TREE_SILENT);
>  		if (write_cache(fd, active_cache, active_nr) ||
> diff --git a/cache.h b/cache.h
> index 107ac61..a6cedc0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1370,7 +1370,7 @@ void packet_trace_identity(const char *prog);
>   * return 0 if success, 1 - if addition of a file failed and
>   * ADD_FILES_IGNORE_ERRORS was specified in flags
>   */
> -int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
> +int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, const char *ignore_submodules_arg);
>  
>  /* diff.c */
>  extern int diff_auto_refresh_index;
> diff --git a/t/t3704-add-ignore-submodules.sh b/t/t3704-add-ignore-submodules.sh
> new file mode 100644

The flags should be 100755 here, currently "make test" fails because
of this.

> index 0000000..db58f0c
> --- /dev/null
> +++ b/t/t3704-add-ignore-submodules.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Ronald Weiss
> +#
> +
> +test_description='Test of git add with ignoring submodules'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'create dirty submodule' '
> +	test_create_repo sm && (
> +		cd sm &&
> +		>foo &&
> +		git add foo &&
> +		git commit -m "Add foo"
> +	) &&
> +	git submodule add ./sm &&
> +	git commit -m "Add sm" && (
> +		cd sm &&
> +		echo bar >> foo &&
> +		git add foo &&
> +		git commit -m "Update foo"
> +	)
> +'
> +
> +test_expect_success 'add --ignore-submodules ignores submodule' '
> +	git reset &&
> +	git add -u --ignore-submodules &&
> +	git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_expect_success 'add --ignore-submodules=all ignores submodule' '
> +	git reset &&
> +	git add -u --ignore-submodules=all &&
> +	git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_expect_success 'add --ignore-submodules=none overrides ignore=all from config' '
> +	git reset &&
> +	git config submodule.sm.ignore all &&
> +	git add -u --ignore-submodules=none &&
> +	test_must_fail git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_done
> 
