From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed, 04 May 2016 13:44:26 -0700
Message-ID: <xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:44:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3es-0002xG-CS
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbcEDUoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:44:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752820AbcEDUo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:44:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EAF517D64;
	Wed,  4 May 2016 16:44:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0eaQsFSLJYhWklIBpL+vAHjwiVE=; b=bFvW/d
	75g/rQjUpPaX1/KyvIqqOE6gLS3raWBpcKBIB7SXQCw2t+876MuNVpN6yimWGzoV
	icVkXG4HuO1NKoBm4eVNI6eizQugFVkpLcFCmKu99ZClvKjc6JO6/9iNN0r23aWN
	FyVto/6kjRYHyraMi3Lijoshd/BwdQBJ2Hl5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ND5SefGnZJIzJo5IQFMpX4xplEwT51xy
	QpQA2GIUvtCJ6BD0J7YJkSr2j7HoLaqTMlHtaKLSCGIAKzLv0Vogs9RgWYhj7ssw
	WtUF/IDkEFqK8YI4/ZmB7z3ipEvbJGk9FXnqaM5s4S6FFJPeny6ssx3i2LQfaEaW
	+v5PnTuNnm8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56D3D17D62;
	Wed,  4 May 2016 16:44:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0ADE17D61;
	Wed,  4 May 2016 16:44:27 -0400 (EDT)
In-Reply-To: <1462324785-26389-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 3 May 2016 18:19:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE764F5E-1238-11E6-897D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293589>

Stefan Beller <sbeller@google.com> writes:

> The discussion in [1] realized that '.' is a faulty suggestion as
> there is a corner case where it fails:

A discussion does not "realize" (you may say "the discussion made me
realize" but that gets personal and subjective description that is
irrelevant in the project history), and this phrase has been
bothering me since the original round.

Perhaps s/realized/pointed out/ or something?

>
>> "submodule deinit ." may have "worked" in the sense that you would
>> have at least one path in your tree and avoided this "nothing
>> matches" most of the time.  It would have still failed with the
>> exactly same error if run in an empty repository, i.e.
>>
>>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>>        $ git init
>>        $ rungit v2.6.6 submodule deinit .
>>        error: pathspec '.' did not match any file(s) known to git.
>>        Did you forget to 'git add'?
>>        $ >file && git add file
>>        $ rungit v2.6.6 submodule deinit .
>>        $ echo $?
>>        0
>
> So instead of a path spec add a parameter '--all' to deinit all submodules

s/path spec/pathspec/;
s/a parameter '--all'/the '--all' option/;

> and add a test to check for the corner case of an empty repository.
>
> The code only needs to learn about the '--all' parameter and doesn't

Likewise.

> require further changes as `git submodule--helper list "$@"` will list
> all submodules in case of "$@" being empty.

I'd propose doing s/in case of.../when "$@" is empty./

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 1572f05..24d7197 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
> +'git submodule' [--quiet] deinit [-f|--force] (-a|--all|[--] <path>...)
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
>  	      [-f|--force] [--rebase|--merge] [--reference <repository>]
>  	      [--depth <depth>] [--recursive] [--] [<path>...]
> @@ -144,6 +144,11 @@ deinit::
>  	you really want to remove a submodule from the repository and commit
>  	that use linkgit:git-rm[1] instead.
>  +
> +To unregister all submodules use `--all` with no path spec. In

s/path spec/pathspec/;  But I'd rather see something more like this
instead of the first sentence:

	When the command is run without pathspec, it errors out,
	instead of deinit-ing everything, to prevent mistakes.


> +version 2.8 and prior, you were advised to give '.' to unregister
> +all submodules. This may continue to work in the future, but as the
> +path spec '.' may include regular files, this could stop working.

	... the command gave a suggestion to use '.' to unregister
	all submodules when it was invoked without any argument, but
	this suggestion did not work and gave a wrong message if you
	followed in pathological cases and is no longer recommended.

Do not predict the future in the documentation when we ourselves
have not committed to any concrete plan.

>  If `--force` is specified, the submodule's work tree will be removed even if
>  it contains local modifications.

I think this sentence talks about "working tree" (as opposed to
"worktree"), so s/work tree/working tree/.

> @@ -247,6 +252,11 @@ OPTIONS
>  --quiet::
>  	Only print error messages.
>  
> +-a::
> +--all::
> +	This option is only valid for the deinit command. Unregister all
> +	submodules in the work tree.

Likewise.

>  -b::
>  --branch::
>  	Branch of repository to add as submodule.
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43c68de..6dabb56 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> -   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> +   or: $dashless [--quiet] deinit [-f|--force] (-a|--all| [--] <path>...)
>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
> @@ -521,6 +521,7 @@ cmd_init()
>  cmd_deinit()
>  {
>  	# parse $args after "submodule ... deinit".
> +	deinit_all=
>  	while test $# -ne 0
>  	do
>  		case "$1" in
> @@ -530,6 +531,9 @@ cmd_deinit()
>  		-q|--quiet)
>  			GIT_QUIET=1
>  			;;
> +		-a|--all)
> +			deinit_all=t
> +			;;
>  		--)
>  			shift
>  			break
> @@ -544,9 +548,13 @@ cmd_deinit()
>  		shift
>  	done
>  
> -	if test $# = 0
> +	if test -n "$deinit_all" && test "$#" -ne 0
> +	then
> +		die "$(eval_gettext "usage: $dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)")"

I doubt that "usage:" wants to go thru l10n.

I suspect that it is more friendly to the user to say that in prose,
i.e.e.g. "--all and pathspec cannot be given at the same time", than
forcing them to grok the (alternative|possibilities).

> +	fi
> +	if test $# = 0 && test -z "$deinit_all"
>  	then
> -		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
> +		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
>  	fi

This is good.

>  	git submodule--helper list --prefix "$wt_prefix" "$@" |
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index e1abd19..6e28ea5 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -11,6 +11,10 @@ subcommands of git submodule.
>  
>  . ./test-lib.sh
>  
> +test_expect_success 'submodule deinit works on empty repository' '
> +	git submodule deinit --all
> +'
> +
>  test_expect_success 'setup - initial commit' '
>  	>t &&
>  	git add t &&
> @@ -858,7 +862,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
>  		>file &&
>  		git add file &&
>  		git commit -m "repo should not be empty"
> -		git submodule deinit .
> +		git submodule deinit --all
>  	)
>  '
>  
> @@ -887,12 +891,12 @@ test_expect_success 'submodule deinit from subdirectory' '
>  	rmdir init
>  '
>  
> -test_expect_success 'submodule deinit . deinits all initialized submodules' '
> +test_expect_success 'submodule deinit --all deinits all initialized submodules' '
>  	git submodule update --init &&
>  	git config submodule.example.foo bar &&
>  	git config submodule.example2.frotz nitfol &&
>  	test_must_fail git submodule deinit &&
> -	git submodule deinit . >actual &&
> +	git submodule deinit --all >actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> @@ -958,11 +962,11 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
>  	git submodule deinit init >actual &&
>  	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> -	git submodule deinit . >actual &&
> +	git submodule deinit --all >actual &&
>  	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> -	git submodule deinit . >actual &&
> +	git submodule deinit --all >actual &&
>  	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&

I would have expected that we'd be testing both '.' and '--all', by
keeping the '.' tests as they were and adding tests for '--all'.  It
is not like we are discouraging use of '.' when the repository is
known to have submodule(s) and '.' is expected to match.

Other than that, looks good to me.  Thanks.
