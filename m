From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Tue, 18 Dec 2012 09:53:33 -0800
Message-ID: <7v1uengsbm.fsf@alter.siamese.dyndns.org>
References: <1355851510-13438-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 18:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl1MZ-0003qn-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 18:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab2LRRxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:53:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab2LRRxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:53:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7956BA5BD;
	Tue, 18 Dec 2012 12:53:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hak2T2HCaT4QjLdzIw8l46kJWI0=; b=KVBseb
	eEvxgLT95zq6niQok6cPMwHY5o2Saq6Vq7gFWKPD3NVNCBuIe1a+91J3GMMla9ZI
	ThRRimsr9r3rw0aanS3R5gv5UxVRchlfYRth7e3pEdIDSPzA9SP5PJkcR2WOaAGc
	y5IhTinNcKo/4lSNfZ7ECdkAqsQOkDMlwtM2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sYAZdJh1JIzlM9eor7E9wKdLtXM3qDEl
	rQ+ZbUbcZe302tgu5Ksou58PUimLYyYGXwI+nCuGs9XvWVQSmFPks7L2BvXmY5pB
	E+M5lEVvssqomHVnt+9ANir2dffE+SgEcVfReHnuPbO3mB3pYmEFq/1ZKAhTDprL
	ayqyEA5YYYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6461BA5BC;
	Tue, 18 Dec 2012 12:53:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 762F5A5AF; Tue, 18 Dec 2012
 12:53:35 -0500 (EST)
In-Reply-To: <1355851510-13438-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Tue, 18 Dec 2012 18:25:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8466BD0-493B-11E2-B8E1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211767>

[jch: cc'ed git-completion experts to review implementation details]

Manlio Perillo <manlio.perillo@gmail.com> writes:

> The git-completion.bash script did not implemented full, git aware,
> support for completion, for git commands that operate on files within
> the current working directory or the index.
>
> For these commands, only long options completion was available.

I find the "long options completion" is a misleading phrase.  It
sounds as if you changed the current completion that does not
complete "git commit -<TAB>" but does "git commit --<TAB>" to
complete the short options (e.g. "git commit -c"), but I do not
think that is the topic of this patch.

> As an example:
>
> 	git add <TAB>
>
> will suggest all files in the current working directory, including
> ignored files and files that have not been modified.
>
> Full support for completion is now implemented, for git commands where

s/Full.*implemented/Support more comprehensive completion/; or
something, talking in the imperative mood (i.e. as if you are giving
the order to the codebase to do something).

> the non-option arguments always refer to paths within the current
> working directory or the index, as the follow:
>
> * the path completion for the "git mv", "git rm" and "git ls-tree"
>   commands will suggest all cached files.

I thought you dropped "git mv" in this round.

> * the path completion for the "git add" command will suggest all
>   untracked and modified files.  Ignored files are excluded.
>
> * the path completion for the "git clean" command will suggest all
>   untracked files.  Ignored files are excluded.
>
> * the path completion for the "git commit" command will suggest all
>   files that have been modified from the HEAD.
>
> For all affected commands, completion will always stop at directory
> boundary.  Only standard ignored files are excluded, using the
> --exclude-standard option of the ls-files command.

I read "always stop at directory boundary" to mean that

	git cmd t<TAB>

will give us "t/ tag.c" (assuming there is a new or modified file in
t/ and tag.c is the only modified file at the root level that begins
with "t") and then

	git cmd t/<TAB>

will likewise show the files and top-level subdirectories within t/
directory.  That would be great.

> Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 112 ++++++++++++++++++++++++++++-----
>  1 file changed, 97 insertions(+), 15 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0b77eb1..923ef37 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -13,6 +13,7 @@
>  #    *) .git/remotes file names
>  #    *) git 'subcommands'
>  #    *) tree paths within 'ref:path/to/file' expressions
> +#    *) file paths within current working directory and index
>  #    *) common --long-options
>  #
>  # To use these routines:
> @@ -233,6 +234,59 @@ __gitcomp_nl ()
>  	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
>  }
>  
> +# Perl filter used to process path list returned by ls-files and
> +# diff-index --name-only commands, in order to list file names
> +# relative to a specified directory, and append a slash to directory
> +# names.
> +# The script expects the prefix path in the "pfx" environ variable.
> +# The output must be processed with the uniq filter, to remove
> +# duplicate directories.
> +# XXX remove duplicates in the Perl script ?

Surely, that will remove one fork/exec with pipeline.  I am not sure
what the performance implication of using Perl here, but because we
do not have to stick to POSIX shell in this file, the completion
experts would be able to help rewriting this logic as a pure bash
script.

> +__git_index_file_list_filter='$pfx = $ENV{"pfx"};
> +			$idx = index($_, $pfx);
> +			if ($idx == 0) {
> +				$_ = substr $_, length($pfx);
> +				@segments = split("/", $_);
> +				if ($segments[1]) {
> +					print $segments[0], "/\n"
> +				} else {
> +					print $segments[0], "\n"
> +				}
> +			}'
> +
> +# __git_files accepts 1 or 2 arguments:
> +# 1: A string for file index status mode ("c", "m", "d", "o"), as
> +#    supported by git ls-files command.  This is required.
> +# 2: An optional directory path.  If provided, only files within the
> +#    specified directory are listed.  Sub directories are never recursed.
> +#    Path must have a trailing slash.
> +__git_files ()
> +{
> +	local dir="$(__gitdir)" flags="-${1}"
> +
> +	if [ -d "$dir" ]; then
> +		git --git-dir="$dir" ls-files --exclude-standard ${flags} ${pfx} \
> +			| pfx=$2 perl -ne "${__git_index_file_list_filter}" \
> +			| uniq

This is purely a style thing (note that style suggestions are not
optional), but

        the data source command |
        a filter command |
        another filter command

is easier to read and can be spelled without the backslash.  The
same comment applies to git-commit-files as well.

Thanks.
