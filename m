From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sat, 07 Apr 2012 21:25:29 -0700
Message-ID: <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 06:26:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGjhY-00080M-4E
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 06:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab2DHEZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 00:25:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab2DHEZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 00:25:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3097D75D4;
	Sun,  8 Apr 2012 00:25:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UGDo5Ixyg/13Q9DPZshJk0HNdIg=; b=O/8lYY
	hwZDnrIMmuJsAu66syGEpRzopz5Ic1ReV7ZATYBe5ffUMxI7Zck1+mIkvsDxI1t+
	7YdHlnBgMRFe8kk2kYb3p4Qg+0t8aFk0kaFF67hMKbnEzZC30zIzkQ5ZsVOlNPyY
	eTzOkg1iG1SzyF5XQH6bejVzcEs1rVJmsWL6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bknx7uDPfMMMG4Vul3jLoINZ8wn/XW0D
	ruOL3XlKNOE9XP/Km7mgC1li88SBGmwQyf+cq9D2Vry0FgEf+NUvFj+iYgQJ0B7q
	BU6ZLd9OBbhJAN6VGA9bkaqAvnWHKIFSSbDQYFxWLYlchrSOMGi1Lfypxh7rC66N
	HukYtL+MT5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275E675D3;
	Sun,  8 Apr 2012 00:25:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B11875D2; Sun,  8 Apr 2012
 00:25:30 -0400 (EDT)
In-Reply-To: <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 8 Apr 2012 06:07:48 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E01176CE-8132-11E1-B495-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194973>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh |  201 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100755 t/t9902-completion.sh
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> new file mode 100755
> index 0000000..7eb80dd
> --- /dev/null
> +++ b/t/t9902-completion.sh
> @@ -0,0 +1,201 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Felipe Contreras
> +#
> +
> +if type bash >/dev/null 2>&1
> +then
> +	# execute inside bash
> +	test -z "$BASH" && exec bash "$0" "$@"
> +else
> +	echo '1..0 #SKIP skipping bash completion tests; bash not available'
> +	exit 0
> +fi

What shell do you use on your system as /bin/sh (or if you use SHELL_PATH
in the Makefile to override it, what do you use)?

Bash has a special case code to behave in a "posixly correct" mode, where
a lot of extensions are disabled, when invoked as "sh".  Unfortunately, it
still defines BASH_* variables, including BASH, when operating in this
mode.

This unfortunately breaks the above code on a system where /bin/sh is
symlinked to "bash".  "make" runs test scripts using with SHELL_PATH,
defaulting to /bin/sh, and you say "Ah, bash is available, oh, we have
BASH defined so let's keep going" without doing an "exec", so later,

> +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"

may trigger errors like this:

  sh: .../git-completion.bash: line 128: syntax error near unexpected token `<'
  sh: .../git-completion.bash: line 128: `    done < <(git config -z --get...

depending on what bash-ism is used in the then-current version of that
file.

So we may want to be a bit more careful like this:

if test "z${BASH%/bash}" != "z${BASH}"
then
	: ends with bash so we are already running bash as bash
elif type bash >/dev/null 2>&1
then
	exec bash "$0" "$@"
else
	echo '1..0 #SKIP skipping bash completion tests; bash not available'
	exit 0
fi

This incidentally avoids running type twice when we are already running as
bash.

> +
> +test_description='test bash completion'
> +
> +. ./test-lib.sh
> +
> +complete ()
> +{
> +	# do nothing
> +	return 0
> +}
> +
> +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> +
> +print_comp ()
> +{
> +	local IFS=$'\n'
> +	echo "${COMPREPLY[*]}" > out
> +}
> +
> +_get_comp_words_by_ref ()
> +{
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		cur)
> +			cur=${_words[_cword]}
> +			;;
> +		prev)
> +			prev=${_words[_cword-1]}
> +			;;
> +		words)
> +			words=("${_words[@]}")
> +			;;
> +		cword)
> +			cword=$_cword
> +			;;
> +		esac
> +		shift
> +	done
> +}

Could you add an explanation before this function to describe what is
going on?  The completion script being tested relies on the shell function
of the same name defined there to behave one way, and this overrides it
with a different implementation.  Often such an override is an effective
way to intercept and expose the internal state to test framework, but the
above does not seem to be such an override, and it is unclear what is
going on here.
