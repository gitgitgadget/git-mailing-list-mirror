From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Fri, 18 Apr 2014 14:09:59 +0200
Message-ID: <53511617.80506@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com> <5349C314.50500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 18 14:10:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb7cP-0005tv-J8
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 14:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbaDRMKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 08:10:05 -0400
Received: from mout.web.de ([212.227.15.4]:52892 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaDRMKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 08:10:03 -0400
Received: from [192.168.178.41] ([79.193.66.64]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MYeuk-1WOYa53EYM-00VRGe; Fri, 18 Apr 2014 14:09:59
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5349C314.50500@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:/viqtewA799byZqn6OCaZDT1PqUWW6fQ8DQmtHJg/TR8Ia3NUgI
 +nclHG+DnaVIw7vN28wNEB2bVFxr418iBzlUf54Ulck7rjJSfR2moe3coxr5ZUw/TtSf3GU
 zw6zVEEPS/AtY9IPckI9bA+d3otmz0CnLdFggEjGblp4FK+czWg4Mc0vzsNHzWPuEsdEFuf
 sBxZvOg7b7o0BJdIC+bxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246466>

Am 13.04.2014 00:49, schrieb Ronald Weiss:
> Allow ignoring submodules (or not) by command line switch, like diff
> and status do.
> 
> Git commit honors the 'ignore' setting from .gitmodules or .git/config,
> but didn't allow to override it from command line.
> 
> This patch depends on Jens Lehmann's patch "commit -m: commit staged
> submodules regardless of ignore config". Without it,
> "commit -m --ignore-submodules" would not work and tests introduced
> here would fail.

Apart from the flags of the test (see below) I get three failures when
running t7513. And I'm wondering why you are using "test_might_fail"
there, shouldn't we know exactly if a commit should succeed or not
and test exactly for that?

> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
>  Documentation/git-commit.txt        |  7 ++++
>  builtin/commit.c                    |  8 +++-
>  t/t7513-commit-ignore-submodules.sh | 78 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 t/t7513-commit-ignore-submodules.sh
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 0bbc8f5..de0e8fe 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +	   [--ignore-submodules[=<when>]]
>  	   [-i | -o] [-S[<key-id>]] [--] [<file>...]
>  
>  DESCRIPTION
> @@ -277,6 +278,12 @@ The possible options are:
>  The default can be changed using the status.showUntrackedFiles
>  configuration variable documented in linkgit:git-config[1].
>  
> +--ignore-submodules[=<when>]::
> +	Can be used to override any settings of the 'submodule.*.ignore'
> +	option in linkgit:git-config[1] or linkgit:gitmodules[5].
> +	<when> can be either "none", "dirty, "untracked" or "all", which
> +	is the default.
> +
>  -v::
>  --verbose::
>  	Show unified diff between the HEAD commit and what
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a148e28..8c4d05e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -361,7 +361,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  	 */
>  	if (all || (also && pathspec.nr)) {
>  		fd = hold_locked_index(&index_lock, 1);
> -		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
> +		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
>  		refresh_cache_or_die(refresh_flags);
>  		update_main_cache_tree(WRITE_TREE_SILENT);
>  		if (write_cache(fd, active_cache, active_nr) ||
> @@ -1526,6 +1526,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
>  		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
>  		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> +		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
> +		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
> +		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  		/* end commit contents options */
>  
>  		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
> @@ -1564,6 +1567,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

Flags: 100755

> index 0000000..52ab37d
> --- /dev/null
> +++ b/t/t7513-commit-ignore-submodules.sh
> @@ -0,0 +1,78 @@
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
> +test_expect_success 'commit --ignore-submodules status of submodule with untracked content' '
> +	GIT_EDITOR=cat &&
> +	export GIT_EDITOR &&
> +	echo untracked > sm/untracked &&
> +
> +	test_might_fail git commit --ignore-submodules=none > output &&
> +	test_i18ngrep modified output &&
> +
> +	test_might_fail git commit --ignore-submodules=untracked > output &&
> +	test_must_fail test_i18ngrep modified output &&
> +
> +	test_might_fail git commit --ignore-submodules=dirty > output &&
> +	test_must_fail test_i18ngrep modified output &&
> +
> +	test_might_fail git commit --ignore-submodules=all > output &&
> +	test_must_fail test_i18ngrep modified output
> +'
> +
> +test_expect_success 'commit --ignore-submodules status of dirty submodule' '
> +	GIT_EDITOR=cat &&
> +	export GIT_EDITOR &&
> +	echo dirty > sm/foo &&
> +
> +	test_might_fail git commit --ignore-submodules=none > output &&
> +	test_i18ngrep modified output &&
> +
> +	test_might_fail git commit --ignore-submodules=untracked > output &&
> +	test_i18ngrep modified output &&
> +
> +	test_might_fail git commit --ignore-submodules=dirty > output &&
> +	test_must_fail test_i18ngrep modified output &&
> +
> +	test_might_fail git commit --ignore-submodules=all > output &&
> +	test_must_fail test_i18ngrep modified output
> +'
> +
> +test_done
> 
