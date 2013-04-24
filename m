From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote: add a test for extra arguments, according to docs
Date: Wed, 24 Apr 2013 14:37:54 -0700
Message-ID: <7vhaiva9u5.fsf@alter.siamese.dyndns.org>
References: <cover.1366811347.git.trast@inf.ethz.ch>
	<372aa93e4a7a3583730c02543583ce93e095ec64.1366811347.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:38:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7O7-0000IY-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283Ab3DXVh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:37:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758222Ab3DXVh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:37:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86136199AA;
	Wed, 24 Apr 2013 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=3H//PCFYfnh807FRmhWVSxvV7A0=; b=pnelgN+qzue/OR3BTK7D
	fKB9UVZ3NpgDmlexANcx9A11s7XC/4/T1H7hQ4Oj1I5xqiwirzaigz/Xu4K6eqha
	q3JMTgzgbv1G/edXhIZjIZ4ydySBWb6wuaXxOTgj+0Kj0/FTdnpCT/OFDcJ+AMV5
	jfjthASvISmpw0BSgBX1MZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MnbThY8/1UhEFwqxO83Ppyxx4Cmu46NBwElVbzmlpY7vNH
	2jgIvg9A6wut8kMKYbU1VnL5C5SK24EK3/U/9j6PzvsRn8pdCUrwr0SCMW8WNaqx
	5kPH3bMVKhqG/xYDfiDem/A7Rsfh6sT21NTaEOGd7wDI7/EDUNdbM/7NBlIIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796A1199A9;
	Wed, 24 Apr 2013 21:37:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2BAE199A7;
	Wed, 24 Apr 2013 21:37:55 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39D36A70-AD27-11E2-84EB-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222330>

Thomas Rast <trast@inf.ethz.ch> writes:

> +test_extra_arg () {
> +	expect="success"
> +	if test "z$1" = "z-f"; then
> +		expect=failure
> +		shift
> +	fi
> +	test_expect_$expect "extra args: $*" "
> +		test_must_fail git remote $* bogus_extra_arg 2>actual &&
> +		grep '^usage:' actual
> +	"
> +}
> +
> +test_extra_arg -f add nick url
> +test_extra_arg rename origin newname

Perhaps just a taste in readability thing, but I would prefer to see
them more like

	test_extra_arg_expect failure add nick url
	test_extra_arg_expect success rename origin newname

than misunderstanding-inviting "-f" that often stands for "--force".

Other than that, the whole series was a pleasant read.  Thanks.


> +test_extra_arg remove origin
> +test_extra_arg set-head origin master
> +# set-branches takes any number of args
> +test_extra_arg set-url origin newurl oldurl
> +test_extra_arg -f show origin
> +test_extra_arg -f prune origin
> +# update takes any number of args
> +
>  test_done
