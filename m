From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in a
 non-bash shell
Date: Thu, 29 Jul 2010 09:25:32 -0700
Message-ID: <7v4ofiuuf7.fsf@alter.siamese.dyndns.org>
References: <4C50B005.1030004@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	solsTiCe d'Hiver <solstice.dhiver@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 18:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeVvj-0004dk-Mi
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 18:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab0G2QZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 12:25:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758070Ab0G2QZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 12:25:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21AFDC9A0D;
	Thu, 29 Jul 2010 12:25:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NKpeqtM1+1KHyYNoUYjRKY37W64=; b=KVlFe7
	qEngFw/iUTMb8+OdvMIS57NXpEZYbVspr+VmpzBusRovO5XOnLQ3/doOs+Zt+Unj
	bH5EK81pP8D/SK6lfP8ZOHThHH81zAAccz3e2+f3rB4jNPlYK2VjQtMHid07PmKK
	GIuxngMm+DrqMnxQNOU3ucHJcCmvKLHX7HeAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U336v2rYCtlDdB/5qlG6MtfgjQTfDMFV
	S4PMuGajZNSoVwj65tt8pnzRWDXIWkAC6oMZ4qOt8VnM0tLT2kfoJ5IDe1oiu3qo
	PBzcb9EYGFFYy9jN0yFzISwn2OOZu7k6m0yLD6Exm0PZDAcWxubKIUiE2fVbaiB7
	dNp/bey9W+g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D65D2C9A0C;
	Thu, 29 Jul 2010 12:25:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B488C9A08; Thu, 29 Jul
 2010 12:25:33 -0400 (EDT)
In-Reply-To: <4C50B005.1030004@pileofstuff.org> (Andrew Sayers's message of
 "Wed\, 28 Jul 2010 23\:32\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBEDCCC8-9B2D-11DF-83D2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152186>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> Detect whether the shell supports process substitution with <()
> Shells that fail the test will not be able to load git-completion.bash
>
> If a bad shell is found, print a warning which gives the user as much debugging
> information as possible.
>
> This was added in response to a bug report on the git mailing list:
>   http://permalink.gmane.org/gmane.comp.version-control.git/151723
>
> Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
> ---

> +# Check in case we were called with something like "sh git-completion.bash":
> +$(
> +	exec 2>/dev/null
> +	$(exec < <( ))
> + )
> +if [[ 0 -ne $? ]]
> +then
> +	cat <<EOF
> +
> +ERROR: you don't seem to be running a full bash shell.
> +git-completion.bash is probably about to fail with a syntax error.
> +If you are sure that your system is calling git-completion.bash from a bash,
> +then please include the following in a bug report to git@vger.kernel.org:

I needed to read this twice to realize that majority of people who will
ever see this message on their screen are _not_ expected to send any bug
report to us.  Also if the user's "full bash" groks <() indirection but
still fails to run completion script correctly, this message does not help
them to find where to file a bug report at all.

I do agree that there need to be a way to find that information for the
end users, especially for those who just use binary-packaged git given by
their distros, but this codepath is _not_ the place to do it.

How about replacing these with something simple like:

    echo >&2 "You are not running full 'bash'; exiting." ; exit 127

> +	BASH_VERSION: {$BASH_VERSION}
> +	BASHOPTS: {$BASHOPTS}
> +	SHELLOPTS: {$SHELLOPTS}
> +	POSIXLY_CORRECT: {$POSIXLY_CORRECT}
> +EOF
> +	echo -n "	command line: {"
> +	tr '\0' ' ' < /proc/$$/cmdline

This looks like a Linux-ism to me.
