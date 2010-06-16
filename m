From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] bash completion: Support "divergence from upstream"
 messages in __git_ps1
Date: Wed, 16 Jun 2010 12:05:06 -0700
Message-ID: <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
References: <20100612000002.GA30196@neumann>
 <cover.1276336602.git.trast@student.ethz.ch>
 <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch>
 <4C17F5B3.4070907@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Jun 16 21:05:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOxvc-0006Av-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 21:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759421Ab0FPTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 15:05:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759408Ab0FPTFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 15:05:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3925EBCB03;
	Wed, 16 Jun 2010 15:05:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KPjeWbQA4hxXVzVQAOMh90mpaig=; b=ImNT37
	blxI9YAWWJ3L7/1K7RscVL4jbkYnr2LxkZ5DGAl12WakjGWLd7gmi29BS+F/NxMl
	6ts4xc69XcmV4wKs/TxaA08qzwjZbT6hIfZjtPFj6OY467Ua/GKs1ez5tGYUDn+j
	kHFQ2lzphIdkeRMCnXX4zlNdDOqE5JvW/y9vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+TKVL2ZEK+6FzDTcnEzhw2Kj6kWg4Ox
	YmIwp0AC06rAAFj0RoXpNIu4OQjiLqL3OSAxCaifO7oQ6zLqcINgmHTjB2DIXtj1
	T4PYAJ1//bMSe0il5eKZzEcZnLKFBhGBFMuzI8+M+f7gnvJwOHwr+IYvk71OiuTx
	rw6e4U9scmY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2E17BCB02;
	Wed, 16 Jun 2010 15:05:13 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACD71BCAFE; Wed, 16 Jun
 2010 15:05:08 -0400 (EDT)
In-Reply-To: <4C17F5B3.4070907@pileofstuff.org> (Andrew Sayers's message of
 "Tue\, 15 Jun 2010 22\:50\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17EFADBC-797A-11DF-8538-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149269>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> Add a notification in the command prompt specifying whether (and optionally how
> far) your branch has diverged from its upstream.  This is especially helpful in
> small teams that very frequently (forget to) push to each other.
>
> Support git-svn upstream detection as a special case, as migrators from
> centralised version control systems are especially likely to forget to push.
>
> Support for other types of upstream than SVN should be easy to add if anyone is
> so inclined.
> ---

Sign-off?

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 57245a8..dabcdaa 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -42,6 +42,23 @@
>  #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
>  #       untracked files, then a '%' will be shown next to the branch name.
>  #
> +#       If you would like to see the difference between HEAD and its
> +#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.  A "<"
> +#       indicates you are behind, ">" indicates you are ahead, and
> +#       "<>" indicates you have diverged.  You can further control
> +#       behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated
> +#       list of values:
> +#           git           compare HEAD to @{upstream}
> +#           svn           compare HEAD to your SVN upstream
> +#           verbose       show number of commits ahead/behind (+/-) upstream
> +#           legacy        don't use the '--count' option available in recent
> +#                         versions of git-rev-list
> +#       By default, __git_ps1 will compare HEAD to your SVN upstream
> +#       if it can find one, or @{upstream} otherwise.

This feels somewhat weird.

I can sort-of read from the above that I can set the variable to a random
string, e.g. "garbage", if I only want a simple show-upstream feature
without frills (i.e. I don't want it to be verbose, I don't want it to
restrict the comparison only to "git" upstream nor "svn" upstream, and I
don't think I would ever use ancient git that lack "rev-list --count").
But the description does not assure me that the random string I happened
to choose (in this case "garbage") is a safe one.  Perhaps list (and
implement) "default" as a safe, otherwise-no-op value?

How much overhead are we shaving if you specify "git" (without "svn") or
"svn" (without "git") to the variable?  I suspect that the bulk of the
time is spent by reading from "git config" to look for svn-remote.*.url,
which you seem to unconditionally do even when "git" was asked for
anyway.

> +#       You can
> +#       override the value of GIT_PS1_SHOWUPSTREAM on a per-repository
> +#       basis by setting the bash.showUpstream config variable.

That's totally backwards from it should be, isn't it?

Usually configuration variables are used to give you the default, and
you use environment variables to override them.

> +# stores the divergence from upstream in $p
> +# used by GIT_PS1_SHOWUPSTREAM
> +__git_ps1_show_upstream ()
> +{
> +	local key value
> +	local svn_remote=() svn_url_pattern count n
> +	local upstream=git legacy verbose
> +
> +	# get some config options from git-config
> +	while read key value; do
> +		case "$key" in
> +			bash.showupstream)
> +				GIT_PS1_SHOWUPSTREAM="$value"
> +				if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
> +					p=""
> +					return
> +				fi

This is the "backwards" part.

> +				;;
> +			svn-remote.*.url)
> +				svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
> +				svn_url_pattern+="\\|$value"
> +				upstream=svn # default upstream is SVN if available
> +				;;

I expected that (1) when on a branch that is a fork of a svn upstream, you
would use the svn magic; (2) otherwise when on a branch that is a fork of
a git upstream, you would use "@{upstream}".  That way, the users do not
even have to say "git" or "svn" in GIT_PS1_SHOWUPSTREAM at all, no?

But that does not seem to be what is happening here.  Your loop seems to
force "upstream=svn" if I have one branch that is a fork from svn
upstream, even if my current branch does not have anything to do with that
branch nor svn upstream.  Is that what was intended?

Oh, also, all of your case arms are one-indent too deep.  Please write
them like this:

	case foo in
        arm1)
        	stmt1
                ;;
	esac

> +		esac
> +	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')

If you "tr" to trash "\0" anyway, do you need to run "config -z"?

> +	# parse configuration values
> +	for option in ${GIT_PS1_SHOWUPSTREAM}; do

Is this safe under "set -u"?  See 25a31f8 (bash-completion: Support
running when set -u is enabled, 2009-01-15).
