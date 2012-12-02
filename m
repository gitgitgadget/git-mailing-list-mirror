From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: add 'deinit' command
Date: Sat, 01 Dec 2012 18:00:06 -0800
Message-ID: <7vy5hhmcwp.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
 <50BA2892.7060706@web.de> <50BA3412.60309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:00:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeyrG-0006xv-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab2LBCAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 21:00:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab2LBCAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 21:00:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24964A336;
	Sat,  1 Dec 2012 21:00:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OSSGp9tiU9Y+W+iWQrogsbY4BEE=; b=VdTDhy
	Sr2rT1uVh35x1ZIyFT9TQdqTpO1GCfEw4imxmjssDOADZD81Q6tGbR17tKt/VP3x
	/C1lXdhBwtKbOFQE9AXU1zJmJMHN12N45d+WkEw7HBi3hVH5FwUDW22xZCYzAlB8
	UdYn7F/bARJqcc6Me4EFAbJcGCQHhGbI/VWho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxH3VhBtjYpPFEndQKBW/D51sluSBKOA
	IRgF9v2gfJd69KFYjnzGqg1o/rtVYRqzgm1y9vgcdNNcy8QtuG4pkETUORiN4YBM
	MdBRV3KGhvC6UM9ECamiqlNdFVX0QJczdl0lBTZfOnSY43bnpf4bDXHX8ST9WFfv
	jgs/n1TPfMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A70A335;
	Sat,  1 Dec 2012 21:00:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7A1EA334; Sat,  1 Dec 2012
 21:00:07 -0500 (EST)
In-Reply-To: <50BA3412.60309@web.de> (Jens Lehmann's message of "Sat, 01 Dec
 2012 17:45:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF5580FA-3C23-11E2-B1B6-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210988>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> With "git submodule init" the user is able to tell git he cares about one
> or more submodules and wants to have it populated on the next call to "git
> submodule update". But currently there is no easy way he could tell git he
> does not care about a submodule anymore and wants to get rid of his local
> work tree (except he knows a lot about submodule internals and removes the
> "submodule.$name.url" setting from .git/config himself).
>
> Help those users by providing a 'deinit' command. This removes the url
> setting from .git/config either for the given submodule(s) or for all
> those which have been initialized if none were given. Complain only when
> for a submodule given on the command line the url setting can't be found
> in .git/config.
>
> Add tests and link the man pages of "git submodule deinit" and "git rm" to
> assist the user in deciding whether removing or unregistering the submodule
> is the right thing to do for him.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

I fully agree with your analysis on the reason why the "url" element
is special and has to be copied to $GIT_DIR/config, but when you
deinit (or uninit) a submodule to say you are no longer interested
in it and do not want it populated in the context of the
superproject, I am not sure if removing only submodule.$name.url (so
that when you later decide to "init" it again, you will keep the
values for submodule.$name.update and other things from the previous
life) is the sane thing to do, or it is better to remove
submodule.$name.* altogether as if an earlier "init" has never
happened.  Would it be worth analyzing the pros-and-cons here?

> Am 01.12.2012 16:56, schrieb Jens Lehmann:
>> Am 01.12.2012 00:52, schrieb Phil Hord:
>>> If I never 'submodule init' a submodule, it does not get visited by
>>> 'git submodule foreach', among others.  I think some people use this
>>> behavior explicitly.
>>>
>>> On the other hand, I've also notice that a submodule which I have
>>> removed does not get de-inited later one.  It causes my 'git submodule
>>> foreach' to emit errors.  :-(
>> 
>> I'm currently hacking on "git submodule deinit" which removes the 'url'
>> setting from git/config. This should do the trick for you, right?
>
> And here we go ...
>
>
>  Documentation/git-rm.txt        |  4 ++++
>  Documentation/git-submodule.txt | 11 +++++++++
>  git-submodule.sh                | 50 ++++++++++++++++++++++++++++++++++++++++-
>  t/t7400-submodule-basic.sh      | 11 +++++++++
>  4 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 262436b..ec42bf5 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -149,6 +149,10 @@ files that aren't ignored are present in the submodules work tree.
>  Ignored files are deemed expendable and won't stop a submodule's work
>  tree from being removed.
>
> +If you only want to remove the local checkout of a submodule from your
> +work tree without committing that use `git submodule deinit` instead
> +(see linkgit:git-submodule[1]).
> +
>  EXAMPLES
>  --------
>  `git rm Documentation/\*.txt`::
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index b1de3ba..fba77f6 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  	      [--reference <repository>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> +'git submodule' [--quiet] deinit [--] [<path>...]
>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
>  	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
> @@ -134,6 +135,16 @@ init::
>  	the explicit 'init' step if you do not intend to customize
>  	any submodule locations.
>
> +deinit::
> +	Unregister the submodules, i.e. remove the `submodule.$name.url`
> +	setting from .git/config. Further calls to `git submodule update`,
> +	`git submodule foreach` and `git submodule sync` will skip any
> +	unregistered submodules until they are initialized again, so use
> +	this command if you don't want to have a local checkout of the
> +	submodule in your work tree anymore. If you really want to remove
> +	a submodule from the repository and commit that use
> +	linkgit:git-rm[1] instead.
> +
>  update::
>  	Update the registered submodules, i.e. clone missing submodules and
>  	checkout the commit specified in the index of the containing repository.
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2365149..4059a2e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,6 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> +   or: $dashless [--quiet] deinit [--] [<path>...]
>     or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
> @@ -516,6 +517,53 @@ cmd_init()
>  }
>
>  #
> +# Unregister submodules from .git/config
> +#
> +# $@ = requested paths (default to all)
> +#
> +cmd_deinit()
> +{
> +	# parse $args after "submodule ... init".
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		-q|--quiet)
> +			GIT_QUIET=1
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		-*)
> +			usage
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	module_list "$@" |
> +	while read mode sha1 stage sm_path
> +	do
> +		die_if_unmatched "$mode"
> +		name=$(module_name "$sm_path") || exit
> +		url=$(git config submodule."$name".url)
> +		if test -z "$url"
> +		then
> +			# Only mention uninitialized submodules when its
> +			# path have been specified
> +			test "$#" != "0" &&
> +			say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
> +			continue
> +		fi
> +		git config --unset submodule."$name".url &&
> +		say "$(eval_gettext "Submodule '\$name' (\$url) unregistered")"
> +	done
> +}
> +
> +#
>  # Update each submodule path to correct revision, using clone and checkout as needed
>  #
>  # $@ = requested paths (default to all)
> @@ -1108,7 +1156,7 @@ cmd_sync()
>  while test $# != 0 && test -z "$command"
>  do
>  	case "$1" in
> -	add | foreach | init | update | status | summary | sync)
> +	add | foreach | init | deinit | update | status | summary | sync)
>  		command=$1
>  		;;
>  	-q|--quiet)
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index de7d453..803bda7 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -756,4 +756,15 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
>  	)
>  '
>
> +test_expect_success 'submodule deinit should unregister submodule url from .git/config' '
> +	url=$(git config submodule.example.url) &&
> +	git submodule deinit &&
> +	test -z "$(git config submodule.example.url)"
> +'
> +
> +test_expect_success 'submodule deinit complains only when explicitly used on an uninitialized submodule' '
> +	git submodule deinit &&
> +	test_must_fail git submodule deinit example
> +'
> +
>  test_done
