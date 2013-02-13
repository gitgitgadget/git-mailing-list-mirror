From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t9903: add tests for bash.showUntrackedFiles
Date: Wed, 13 Feb 2013 08:23:50 -0800
Message-ID: <7v621wb2sp.fsf@alter.siamese.dyndns.org>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
 <1360753321-5002-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5f85-0000xx-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 17:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759953Ab3BMQXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 11:23:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759890Ab3BMQXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 11:23:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94C58C829;
	Wed, 13 Feb 2013 11:23:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NaduWy7yu3y3A1hBmhjY/N43XzM=; b=tFkTm2
	bPp+/3mnIHwVH5hwGFbjf4yZxujpYBSJSDPe97rz6m3Sk9LVgCKoUcCmwfCtL6Pm
	xBfiSkcdjpOJyLve9xEIy0WmPb3wR3VktWsZK0YsdFrhF/n74p1+gR6MHm3lWcwN
	1v52y0xOJPryPqSzewnwLQlz9Cem7iO84fAgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQetJQPx358wNsfqJAhx3E58ePpKaCrV
	xyoP4XUkP6TOf3XyMYA+kPwFHsuhvYYXwXjh7XXDsXs9aQmIw4GmqvlAFk+hEOCS
	S5bJt6plfpptRgt9Nf101HjTMgyKVgyMysb6wFdKaNVNPef3cBw+a5Ojc7ZSIGNS
	bE8r4jsPsTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84B7CC828;
	Wed, 13 Feb 2013 11:23:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4996C825; Wed, 13 Feb 2013
 11:23:51 -0500 (EST)
In-Reply-To: <1360753321-5002-2-git-send-email-martinerikwerner@gmail.com>
 (Martin Erik Werner's message of "Wed, 13 Feb 2013 12:01:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0F9D166-75F9-11E2-8C9F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216267>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Add 4 test for the bash.showUntrackedFiles config option, covering all
> combinations of the shell var being set/unset and the config option
> being enabled/disabled.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>  t/t9903-bash-prompt.sh |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index f17c1f8..cb008e2 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -437,6 +437,46 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
>  	test_cmp expected "$actual"
>  '
>  
> +test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
> +	printf " (master)" > expected &&
> +	test_config bash.showUntrackedFiles false &&
> +	(
> +		unset -v GIT_PS1_SHOWUNTRACKEDFILES &&

We do not use "unset -v" anywhere else in our system.  Shells
mimicking SysV may choke on it.  A Portable POSIX script can omit
"-v" when unsetting a variable.

Also "unset" can return false when the variable is not set to begin
with with some shells.

Neither of these matters for this particular case because we know we
are running this under bash in non-posix mode.  I however wonder if
we can do something to prevent careless coders to copy and paste
this piece when updating other tests that are not limited to bash.
Commenting each and every use of "unset -v" does not sound like a
good solution and perhaps I am being unnecessarily worried too much.
