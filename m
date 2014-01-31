From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jn/pager-lv-default-env] pager test: make fake pager consume all its input
Date: Fri, 31 Jan 2014 09:07:44 -0800
Message-ID: <xmqq7g9ghyfz.fsf@gitster.dls.corp.google.com>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp>
	<20140106193339.GH3881@google.com>
	<874n5ghenr.fsf@helix.nebula.avasys.jp>
	<20140107021404.GK3881@google.com> <52E9FC23.2030200@mit.edu>
	<20140130164232.GF27577@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 31 18:07:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9HZL-0005yV-5y
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbaAaRHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 12:07:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbaAaRHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 12:07:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E66C66192;
	Fri, 31 Jan 2014 12:07:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v0DiLT5eQzsDfl35xEE3HAShDzQ=; b=Kqf2fi
	U4sj5CZhp4Q06wXooV88+Nvfsv2uAb1X6q1bURN9cMZG8PO39CKT77jSRPCHGUZm
	gJ486QXpPK3xs4Q9SvfC1IdiCliDnGglqCQHKr9ugZVDN1i6RnyJiauPXyCdDbib
	kJUa2Qgctr1+WHa+qrqohPefHC8utqkfc3bgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7YSAgJB2z8VLZkt/C8k2PCE4JEtBSMa
	3MG0tDq/lIs7rNPl08UxzdMZGb3PYjjPa5nuTHj/8q4Kf8f1dU7Wb7FhFan3qxtv
	Y7f4Iwm0/lSffFXhtG9B40vBLtAQsbseax1HeFILqGP+OgL/CLptWErmD+sfidjp
	Jg+/NXljjVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4C5F66190;
	Fri, 31 Jan 2014 12:07:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11B5B6618A;
	Fri, 31 Jan 2014 12:07:47 -0500 (EST)
In-Reply-To: <20140130164232.GF27577@google.com> (Jonathan Nieder's message of
	"Thu, 30 Jan 2014 08:42:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35A462AA-8A9A-11E3-86E7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241306>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Otherwise there is a race: if 'git log' finishes writing before the
> pager terminates and closes the pipe, all is well, and if the pager
> finishes quickly enough then 'git log' terminates with SIGPIPE.
>
>  died of signal 13 at /build/buildd/git-1.9~rc1/t/test-terminal.perl line 33.
>  not ok 6 - LESS and LV envvars are set for pagination
>
> Noticed on Ubuntu PPA builders, where the race was lost about half the
> time.  Compare v1.7.0.2~6^2 (tests: Fix race condition in t7006-pager,
> 2010-02-22).
>
> Reported-by: Anders Kaseorg <andersk@MIT.EDU>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks.  The use of "wc" looks cute (I would have used "cat").

> Anders Kaseorg wrote:
>> On 01/06/2014 09:14 PM, Jonathan Nieder wrote:
>
>>> +		PAGER="env >pager-env.out" &&
>>> +		export PAGER &&
>>> +
>>> +		test_terminal git log
> [...]
>> On the Ubuntu PPA builders, I’m seeing this new test fail with
>> SIGPIPE about half the time:
>>
>> died of signal 13 at /build/buildd/git-1.9~rc1/t/test-terminal.perl line 33.
>> not ok 6 - LESS and LV envvars are set for pagination
>
> Good catch.  Sorry for the trouble.
>
>  t/t7006-pager.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 7fe3367..b9365b4 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -40,7 +40,7 @@ test_expect_failure TTY 'pager runs from subdir' '
>  test_expect_success TTY 'LESS and LV envvars are set for pagination' '
>  	(
>  		sane_unset LESS LV &&
> -		PAGER="env >pager-env.out" &&
> +		PAGER="env >pager-env.out; wc" &&
>  		export PAGER &&
>  
>  		test_terminal git log
