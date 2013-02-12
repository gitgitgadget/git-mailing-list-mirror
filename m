From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t9903: add test case for bash.showUntrackedFiles
Date: Tue, 12 Feb 2013 14:29:58 -0800
Message-ID: <7vr4kldv2x.fsf@alter.siamese.dyndns.org>
References: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
 <1360699936-28688-3-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5OMz-00025p-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab3BLWaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:30:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964Ab3BLWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:30:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D24CBCE13;
	Tue, 12 Feb 2013 17:30:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rQktyGxXcWqyAFUjWoalnKG7oDg=; b=kdMq8E
	mEV95/A35V+lrYC6pm8E4SaUgRITfav+k5y9O0ePu3y068QPFu46Kl/W13KsoJ5k
	wMlARfDBkcmmBgmU7ex2tCYnVwoPyUmkbQYQjQYHoMvT3tSGW8jqD8ABpxC/95Sd
	JNFYrtK5Wgv8Ft/g7cSVQq9WPfzbr9MouWTXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c21zj1+o2U1RdJAMxwJ8ZkXCC6YIAcKp
	nsFJK4ExE+KnN0ZplS8P37DsJfMEQ9oFgqzRIWzIgmo2W2eY3pOyJmOgvp7gf0Tb
	qdP7IJzMJSvApwKQUomJdsMMkh0Ioew6nHl2ppQg/4csICjSr40n9Z8CWwtm4HBN
	LsFUjC5IFeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B559CE07;
	Tue, 12 Feb 2013 17:30:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D04DCE01; Tue, 12 Feb 2013
 17:30:01 -0500 (EST)
In-Reply-To: <1360699936-28688-3-git-send-email-martinerikwerner@gmail.com>
 (Martin Erik Werner's message of "Tue, 12 Feb 2013 21:12:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD9533A8-7563-11E2-998B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216209>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Add a test case for the bash.showUntrackedFiles config option, which
> checks that the config option can disable the global effect of the
> GIT_PS1_SHOWUNTRACKEDFILES environmant variable.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>  t/t9903-bash-prompt.sh |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index f17c1f8..c9417b9 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -447,6 +447,17 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
>  	test_cmp expected "$actual"
>  '
>  
> +test_expect_success 'prompt - untracked files status indicator - disabled by config' '
> +	printf " (master)" > expected &&
> +	echo "untracked" > file_untracked &&
> +	test_config bash.showUntrackedFiles false &&
> +	(
> +		GIT_PS1_SHOWUNTRACKEDFILES=y &&
> +		__git_ps1 > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'

All six combinations need checking:

 * not having the configuration at all and not having the shell
   variable should not show the untracked indicator (already tested).

 * not having the configuration at all and having the shell variable
   should show the untracked indicator (already tested).

 * setting configuration to true without having the shell variable
   should not show the untracked indicator.

 * setting configuration to true and having the shell variable
   should show the unttracked indicator.

 * setting configuration to false and having the shell variable
   should not show the untracked indicator (the above test checks
   this).

 * setting configuration to false without having the shell variable
   should not show the untracked indicator.

to prevent others from breaking the code you wrote for [PATCH 1/2],
so you need three more tests, I guess?
