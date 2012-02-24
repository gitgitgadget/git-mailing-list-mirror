From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] contrib: added git-diffall
Date: Fri, 24 Feb 2012 12:03:32 -0800
Message-ID: <7vzkc8xaln.fsf@alter.siamese.dyndns.org>
References: <1330044581-792-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com, stefano.lattarini@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Mk-0000aZ-GM
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab2BXUDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:03:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab2BXUDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:03:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90552613F;
	Fri, 24 Feb 2012 15:03:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oaJQw2byvzCv2Ohmi8fSVYZZaRA=; b=vMHUk/Xwj21n8RZL3mN2
	04lWcq+qSXe0XKYTsspD79EbsyktizzhgGN3n/s4TNCI0N+uu8uCDYdU+hYYzPSM
	e0dEDpcAzoMd+UzfPHo+/RsfPsOWboKzx4UnaW1KgFeaECot3tBaJq6gORoWRW69
	jYBOC/NVerUO85pvbopUH3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nXIo4Rr1Nc+7cq3wsOmvVsbazkxcbSCbgSqQDpBL/qruy7
	yo90lO0QqbYelWcqbUhDFQYCG+elUwFzBWOvkc0PpeAn52wIwU63chzhCxs8CdE2
	sqVK6g9pTd2FsxwNVgDwUYepzX/dkINLFZrmgP07tCv505UnaPdVqqI3CUtq4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88A18613E;
	Fri, 24 Feb 2012 15:03:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD1DF613D; Fri, 24 Feb 2012
 15:03:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A165F0BC-5F22-11E1-BBF3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191458>

Tim Henigan <tim.henigan@gmail.com> writes:

> The 'git difftool' command allows the user to view diffs using an
> external tool.  It runs a separate instance of the tool for each
> file in the diff. This makes it tedious to review changes spanning
> multiple files.
>
> The 'git-diffall' script instead prepares temporary directories
> with the files to be compared and launches a single instance of
> the external diff tool to view them (i.e. a directory diff).
>
> The 'diff.tool' or 'merge.tool' configuration variable is used
> to specify which external tool is used.

Shouldn't the primary interface "--extcmd=" also be advertised here?

> diff --git a/contrib/diffall/README b/contrib/diffall/README
> new file mode 100644
> index 0000000..111f3f6
> --- /dev/null
> +++ b/contrib/diffall/README
> @@ -0,0 +1,24 @@
> +The git-diffall script provides a directory based diff mechanism
> +for git.  The script relies on the diff.tool configuration option
> +to determine what diff viewer is used.

Same here.

> +This script is compatible with most common forms used to specify a
> +range of revisions to diff:
> +
> +  1. git diffall: shows diff between working tree and staged changes
> +  2. git diffall --cached [<commit>]: shows diff between staged
> +     changes and HEAD (or other named commit)
> +  3. git diffall <commit>: shows diff between working tree and named
> +     commit
> +  4. git diffall <commit> <commit>: show diff between two named commit

I seem to recall the previous round said "named commits" here...

> +  5. git diffall <commit>..<commit>: same as above
> +  6. git diffall <commit>...<commit>: show the changes on the branch
> +     containing and up to the second , starting at a common ancestor
> +     of both <commit>
> +
> +Note: all forms take an optional path limiter [--] [<path>*]

Doesn't 3. above make "--" mandatory if you give a pathspec?  I.e.

	... take an optional pathspec [-- <pathspec>]*

> diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
> new file mode 100755
> index 0000000..e00fe89
> --- /dev/null
> +++ b/contrib/diffall/git-diffall
> @@ -0,0 +1,261 @@
> ...
> +# mktemp is not available on all platforms (missing from msysgit)
> +# Use a hard-coded tmp dir if it is not available
> +tmp="$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
> +	tmp=/git-diffall-tmp.$$

Missing /tmp in front?

> +	mkdir "$tmp" || exit 1
> +}
> + ...
> +while test $# != 0
> +do
> +	case "$1" in
> +	-h|--h|--he|--hel|--help)
> +		usage
> +		;;
> +	--cached)
> +		compare_staged=1
> +		;;
> +	--copy-back)
> +		copy_back=1
> +		;;
> +	-x|--e|--ex|--ext|--extc|--extcm|--extcmd)
> +		if test -z $2

testing $# would be more logical, no?

> +		then
> +			echo You must specify the tool for use with --extcmd
> +			usage
> +		else
> +			diff_tool=$2
> +			shift
> +		fi
> +		;;
> +	--)
> +		path_sep=1

The name path_sep makes one wonder "are we somehow talking about
differences between '/' vs '\' here?"  In other parts of the system, this
is typically called "dashdash_seen"; the meaning of it is "expect nothing
but pathspecs from here on", so "expect_pathspec" could be an alternative
name for it.

> ...
> +elif test -n "$compare_staged"
> +then
> +	while read name
> +	do
> +		ls_list=$(git ls-files -- "$name")

Ok, the use of $name is now slightly tightened with the surrounding dq
throughout the script.  Better (even though $paths are still prone to
splitting by $IFS).

Thanks, will replace what was queued in 'pu'.
