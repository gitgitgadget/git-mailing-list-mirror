From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] sumodule--helper: fix submodule--helper clone usage and check argc count
Date: Mon, 29 Feb 2016 09:49:49 -0800
Message-ID: <xmqqr3fvcsoy.fsf@gitster.mtv.corp.google.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
	<1456532000-22971-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 18:50:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaRxG-0001bG-4z
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 18:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbcB2Rty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 12:49:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752407AbcB2Rtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 12:49:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2156484B6;
	Mon, 29 Feb 2016 12:49:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EQ1t7D6Cf0lJkE2eYpDGGD9pnM4=; b=fsv1TS
	l/yRTOuf86tntl6Q25dK0HqtNjNP4I0yg+CmoRU/9jWTbMcpUUfReXWtEEOBMpAJ
	phD5utU2GoSy8zzGJzGy3ap80M16JFDBPn1gm/d/Zl9SACWBDZ68xICrl+VMuuHU
	6xXfkuXY1of81z9bbN5eEAmFAKr6kPtvkMe3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpF+NUebtVvLMenHTAJQc1TwZs+H84+r
	sZoEc9yUGUhH7P5k8XSimoBcjNLE5+wmwhx8CwcIKAlUmG1YHOs6TtR7kCgKZhtF
	irNvhJNuCOB4v1500zgKebtEPMdYp/WQlayzLvJ5ra7+ez0atzOBKprwZzNeqR5b
	/2243esRp3w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9E07484B5;
	Mon, 29 Feb 2016 12:49:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32A68484B3;
	Mon, 29 Feb 2016 12:49:51 -0500 (EST)
In-Reply-To: <1456532000-22971-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 26 Feb 2016 16:13:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D515E066-DF0C-11E5-9891-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287852>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> git submodule--helper clone usage specified that paths come after the --
> as a sequence. However, the actual implementation does not, and requires
> only a single path passed in via --path. In addition, argc was
> unchecked. (allowing arbitrary extra arguments that were silently
> ignored).
>
> Fix the usage description to match implementation. Add an argc check to
> enforce no extra arguments. 

The above sounds very sensible.

> Fix a bug in the argument passing in
> git-submodule.sh which would pass --reference and --depth as empty
> strings when they were unused, resulting in extra argc after parsing
> options.

This does make sense but it is an unrelated fix.  Perhaps split this
patch into two?

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/submodule--helper.c | 5 ++++-
>  git-submodule.sh            | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff179b5..072d9bbd12a8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -187,13 +187,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	const char *const git_submodule_helper_usage[] = {
>  		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
>  		   "[--reference <repository>] [--name <name>] [--url <url>]"
> -		   "[--depth <depth>] [--] [<path>...]"),
> +		   "[--depth <depth>] [--path <path>]"),
>  		NULL
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, module_clone_options,
>  			     git_submodule_helper_usage, 0);
>  
> +	if (argc)
> +		usage(*git_submodule_helper_usage);
> +

That asterisk looks very unusual and wanting to be future-proofed
(i.e. who says that only the first entry matters?).  Should't this
be calling usage_with_options()?

>  	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
>  	sm_gitdir = strbuf_detach(&sb, NULL);
>  
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9bc5c5f94d1d..2dd29b3df0e6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -347,7 +347,7 @@ Use -f if you really want to add it." >&2
>  				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>  			fi
>  		fi
> -		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
> +		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
>  		(
>  			clear_local_git_env
>  			cd "$sm_path" &&
> @@ -709,7 +709,7 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>  		then
> -			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> +			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" ${reference:+"$reference"} ${depth:+"$depth"} || exit
>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
>  		else
