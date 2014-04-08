From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 08 Apr 2014 20:43:52 +0200
Message-ID: <53444368.9050607@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 20:44:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXb0B-0003cf-1u
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbaDHSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 14:44:00 -0400
Received: from mout.web.de ([212.227.17.11]:63433 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756314AbaDHSn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 14:43:59 -0400
Received: from [192.168.178.41] ([79.193.64.34]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LZeou-1XGsUv2h4O-00lRtq; Tue, 08 Apr 2014 20:43:53
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53432EA5.5060102@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:rJc6TItk5LDg1WDwLsBIa+ooacckrtvUTScWmpTcQoP7z24vrf7
 LUBo/dNKkPCs84feOl89tvSBCxBArUaW/3DT3BgsLX2zMxbm+72aZbCIKyzPZc2+EewHn3j
 0mIUx9I+YVMGXOTGzyMM8rQd3oQjUZKxMavPOpdCbn3MMhObu5A7ZJWqhg0NG0QqnWGzAHt
 pTFx7C3+2cXz7LR7UCmsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245944>

Am 08.04.2014 01:03, schrieb Ronald Weiss:
> Git commit honors the 'ignore' setting from .gitmodules or .git/config,
> but didn't allow to override it from command line, like other commands do.
> 
> Useful <when> values for commit are 'all' (default) or 'none'. The others
> ('dirty' and 'untracked') have same effect as 'none', as commit is only
> interested in whether the submodule's HEAD differs from what is commited
> in the superproject.

Unless it outputs a status message, then 'dirty' and 'untracked' do
influence what is shown there. Apart from that (and maybe tests for
these two cases ;-) this is looking good to me.

> This patch depends on Jens Lehmann's patch "commit -m: commit staged
> submodules regardless of ignore config". Without it,
> "commit -m --ignore-submodules" would not work and tests introduced
> here would fail.
> 
> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
>  Documentation/git-commit.txt        |  6 ++++++
>  builtin/commit.c                    |  8 ++++++-
>  t/t7513-commit-ignore-submodules.sh | 42 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 t/t7513-commit-ignore-submodules.sh
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 1a7616c..8d3b2db 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +	   [--ignore-submodules[=<when>]]
>  	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
>  
>  DESCRIPTION
> @@ -271,6 +272,11 @@ The possible options are:
>  The default can be changed using the status.showUntrackedFiles
>  configuration variable documented in linkgit:git-config[1].
>  
> +--ignore-submodules[=<when>]::
> +	Can be used to override any settings of the 'submodule.*.ignore'
> +	option in linkgit:git-config[1] or linkgit:gitmodules[5].
> +	<when> can be either "none" or "all", which is the default.
> +
>  -v::
>  --verbose::
>  	Show unified diff between the HEAD commit and what
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0db215b..121c185 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -360,7 +360,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  	 */
>  	if (all || (also && pathspec.nr)) {
>  		fd = hold_locked_index(&index_lock, 1);
> -		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
> +		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
>  		refresh_cache_or_die(refresh_flags);
>  		update_main_cache_tree(WRITE_TREE_SILENT);
>  		if (write_cache(fd, active_cache, active_nr) ||
> @@ -1492,6 +1492,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
>  		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
>  		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> +		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
> +		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
> +		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  		/* end commit contents options */
>  
>  		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
> @@ -1531,6 +1534,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> +
> +	s.ignore_submodule_arg = ignore_submodule_arg;
> +
>  	if (dry_run)
>  		return dry_run_commit(argc, argv, prefix, current_head, &s);
>  	index_file = prepare_index(argc, argv, prefix, current_head, 0);
> diff --git a/t/t7513-commit-ignore-submodules.sh b/t/t7513-commit-ignore-submodules.sh
> new file mode 100644
> index 0000000..83ce04c
> --- /dev/null
> +++ b/t/t7513-commit-ignore-submodules.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Ronald Weiss
> +#
> +
> +test_description='Test of git commit --ignore-submodules'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'create submodule' '
> +	test_create_repo sm && (
> +		cd sm &&
> +		>foo &&
> +		git add foo &&
> +		git commit -m "Add foo"
> +	) &&
> +	git submodule add ./sm &&
> +	git commit -m "Add sm"
> +'
> +
> +update_sm () {
> +	(cd sm &&
> +		echo bar >> foo &&
> +		git add foo &&
> +		git commit -m "Updated foo"
> +	)
> +}
> +
> +test_expect_success 'commit -a --ignore-submodules=all ignores dirty submodule' '
> +	update_sm &&
> +	test_must_fail git commit -a --ignore-submodules=all -m "Update sm"
> +'
> +
> +test_expect_success 'commit -a --ignore-submodules=none overrides ignore=all setting' '
> +	update_sm &&
> +	git config submodule.sm.ignore all &&
> +	git commit -a --ignore-submodules=none -m "Update sm" &&
> +	git diff --exit-code --ignore-submodules=none &&
> +	git diff --cached --exit-code --ignore-submodules=none
> +'
> +
> +test_done
> 
