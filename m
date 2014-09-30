From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 30 Sep 2014 15:29:19 -0700
Message-ID: <xmqqbnpwrbcw.fsf@gitster.dls.corp.google.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Julien Carsique <julien.carsique@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 00:29:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ5vD-0007ZU-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 00:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbaI3W3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 18:29:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51612 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbaI3W3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 18:29:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F5023FC7D;
	Tue, 30 Sep 2014 18:29:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4IaDxB0AkTd5uamQtt6i1gcXc9Y=; b=kXbqcypOGr+uAo66PIc+
	96xv1OANTeoA/4tvMBhSdJeEUzy7AmhG4ygImBzInrTWL780aeuDFRpPe9lkNDH1
	pHR7zyiXzFzM84S6qQUGLS0rcE94IDo569/zyRL+O2wFTS1f8GZ6bOd7/ovGrNQQ
	8wj2dpVEV7knFIlnHBMvPhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hwgI9s+flngFvYE3gHwLFydlnVAYDgU4+P8DIzRo8YEmyG
	FH5eT7DFJm1qvdUJSgrcC41taIuavjOF5CAUQjiXmNgOopteqA0NlEg3Ihyapp4v
	czpGTrKBDLxJC9lA3FKmHZXJ8eORvThfp3Jn/+Qwj/LFwMqz9Cfkh4TUdC1Tc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 758933FC7C;
	Tue, 30 Sep 2014 18:29:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DAF7E3FC7B;
	Tue, 30 Sep 2014 18:29:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39123E38-48F1-11E4-8884-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257686>

Julien Carsique <julien.carsique@gmail.com> writes:

> From: Julien Carsique <julien.carsique@gmail.com>
>
> When using the "name" option of GIT_PS1_SHOWUPSTREAM to show the upstream
> abbrev name, if the upstream name is the same as the local name, then some
> space could be saved in the prompt. This is especially needed on long branch
> names.
>
> Replace the upstream name with the sign '=' if equal to the local one.
> Example:    [master * u= origin/=]$
> instead of: [master * u= origin/master]$
>
> Signed-off-by: Julien Carsique <julien.carsique@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c5473dc..a9aba20 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -209,6 +209,13 @@ __git_ps1_show_upstream ()
>  		if [[ -n "$count" && -n "$name" ]]; then
>  			__git_ps1_upstream_name=$(git rev-parse \
>  				--abbrev-ref "$upstream" 2>/dev/null)
> +
> +			__head=${b##refs/heads/}
> +			if [ "$__head" = "${__git_ps1_upstream_name##*/}" ]; then

When you are on your "xyz" branch that was forked off of
"refs/remote/origin/xyz/xyz", $__git_ps1_upstream_name would be
"origin/xyz/xyz" and $__head is "xyz" at this point.  The latter
matches the former after stripping */ maximally from its front
(i.e. "xyz").  It is unclear if you really want to make these two
match, but as long as you correctly abbreviate you would not lose
information, I would imagine.  I am guessing that you would want to
see "origin/xyz/=" in such a case, and if you started your "xyz" off
of "origin/abc/xyz", you would want "origin/abc/=".

> +				__git_ps1_upstream_name=${__git_ps1_upstream_name/$__head/=}

Now, what does ${__git_ps1_upstream_name/$__head/=} give us?
This should not do regexp substitution in the first place, I would
think.  You made sure $__head is the tail-matching substring of the
longer variable, so you chop that many bytes off of the latter.

Is this new feature something everybody should want unconditionally,
or are there valid reasons why some people may not want to see this
abbreviation happen (even if the implementation were not buggy)?

> +			fi
> +			unset __head

Unlike __git_ps1_upstream_name, this __head does not have to be
visible outside this function.  Wouldn't it be better to declare it
as local (this is bash prompt and we can afford to step outside
POSIX) and there is no need to "unset" after use if you did so, no?

>  			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
>  				p="$p \${__git_ps1_upstream_name}"
>  			else
