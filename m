From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Fri, 17 May 2013 09:48:26 -0700
Message-ID: <7vfvxl1rj9.fsf@alter.siamese.dyndns.org>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch>
	<5195C4B1.3010201@viscovery.net>
	<87y5beav7d.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 18:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNpa-0001Na-EV
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab3EQQs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:48:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab3EQQs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:48:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A22791DAC7;
	Fri, 17 May 2013 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rp2sTLY2eSRiv3AfgavyPWn8TTk=; b=ImpgGo
	bi8lmcnL1g6aKYvoGl/1Vil/XgzPoCLs08AWlZrtZJWcPdPRg6nCBABatxVkLXpy
	XQVsB+aVQHyg1ApV7d79BQgj/S41RqYobpXxyfISv7JotLPbYLVahMkIiEQGdqRJ
	1VaunuOf26N0zYZo67NDiAoEgYMMFbxbRDEA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vpvi947l+gKwsb151mLGo64GO9Odj5YP
	9VjX4p/GsTa61co34lOfrFn5PjNOVqXTqQSBSN3hdEYa/lq2rxO+NH7OjC9zvDet
	AZERFoH+8uYyw6NxE5vNBY8ZoEdjNQsXbQJrQe3my+mINsAFjBFAAPt2WPHaXpJE
	BbVLRh3TfTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 995301DAC6;
	Fri, 17 May 2013 16:48:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02F571DAC1;
	Fri, 17 May 2013 16:48:27 +0000 (UTC)
In-Reply-To: <87y5beav7d.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 17 May 2013 10:04:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9934297C-BF11-11E2-A67B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224701>

Thomas Rast <trast@inf.ethz.ch> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Am 5/16/2013 22:50, schrieb Thomas Rast:
>>> +match_pattern_list () {
>>> +	arg="$1"
>>> +	shift
>>> +	test -z "$*" && return 1
>>> +	for pat in $@
>>
>> You should have double-quotes around $@ here, but then you can just as
>> well abbreviate to
>>
>> 	for pat
>>
>> and you don't need the 'test -z "$*' check anymore.
>
> Hmm, actually the quotes wouldn't help, because it currently reads
>
> -	for skp in $GIT_SKIP_TESTS
> -	do
> -		case $this_test.$test_count in
> -		$skp)
> -			to_skip=t
> -			break
> -		esac
> -	done
>
> so the splitting already happens, and in fact needs to, so that one can
> pass multiple patterns.  Or am I missing something?

I think you read it right.  I do pass multiple test number patterns
regularly and not quoting there is exactly for support that.

> But the 'for pat' with implicit $@ sounds nice regardless, thanks.

'for pat' is equivalent to 'for pat in "$@"', not 'for pat in $@';
would it still be useful when you need them split at $IFS?
