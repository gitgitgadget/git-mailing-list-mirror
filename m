From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 08:28:31 -0800
Message-ID: <7vy5es9o0g.fsf@alter.siamese.dyndns.org>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
 <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5fCe-0007QL-MA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 17:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759932Ab3BMQ2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 11:28:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759377Ab3BMQ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 11:28:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 728E7CC6B;
	Wed, 13 Feb 2013 11:28:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e1snjAzMyr7UrVsBkt23vaRCSu8=; b=uIWJJc
	XuR+SbO5w0uQj5ZfahrCmaSA8TO1c/q8iAaJV1Abu9MRacvRCwQi4cnE0aZbsu3y
	fXzdaC6OSiwe+d2wDaoCLaLbuAq1QVQw8nFJ5t2tJQwho/s893NE32zf3sqhIdBc
	6y5iW10Rq33dRSQeDrwUMwn8V+L/cOr60UaZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SLdpt+6DwIzh/n4Im6aKB3jE+6mVmmkc
	E/cPJhyn14mnIoZRTTA+WAZBLIrYASP7UmXmH9C0wJWhB0DPrdjAQD6TApX2UUmS
	3fpSc/VmzsjBz4hZ54paKGWZB2sDFLT3NzG7sXHinUwxb0cPe8U8EZXSAQovkZx5
	tSwm7QZZObM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65ADDCC69;
	Wed, 13 Feb 2013 11:28:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C20EACC62; Wed, 13 Feb 2013
 11:28:32 -0500 (EST)
In-Reply-To: <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
 (Martin Erik Werner's message of "Wed, 13 Feb 2013 12:02:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68618F66-75FA-11E2-B3BC-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216268>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Added 3 extra tests for the bash.showDirtyState config option, tests
> should now cover all combinations of the shell var being set/unset and
> the config option being enabled/disabled, given a dirty file.

Strictly speaking, you have 6 not 4 combinations (shell variable
set/unset * config missing/set to false/set to true).  I think these
additional tests cover should all 6 because "config missing" case
should already have had tests before bash.showDirtyState was added.

> * Renamed test 'disabled by config' to 'shell variable set with config
>   disabled' for consistency
> ---

Sign-off?

>  t/t9903-bash-prompt.sh |   38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index cb008e2..fa81b09 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -360,12 +360,48 @@ test_expect_success 'prompt - dirty status indicator - before root commit' '
>  	test_cmp expected "$actual"
>  '
>  
> -test_expect_success 'prompt - dirty status indicator - disabled by config' '
> +test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
>  	printf " (master)" > expected &&
>  	echo "dirty" > file &&
>  	test_when_finished "git reset --hard" &&
>  	test_config bash.showDirtyState false &&
>  	(
> +		unset -v GIT_PS1_SHOWDIRTYSTATE &&
> +		__git_ps1 > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
> +	printf " (master)" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	test_config bash.showDirtyState true &&
> +	(
> +		unset -v GIT_PS1_SHOWDIRTYSTATE &&
> +		__git_ps1 > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
> +	printf " (master)" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	test_config bash.showDirtyState false &&
> +	(
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		__git_ps1 > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
> +	printf " (master *)" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	test_config bash.showDirtyState true &&
> +	(
>  		GIT_PS1_SHOWDIRTYSTATE=y &&
>  		__git_ps1 > "$actual"
>  	) &&
