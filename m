From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 4/4] t7510: test verify-commit
Date: Fri, 27 Jun 2014 12:32:30 -0700
Message-ID: <xmqqk382173l.fsf@gitster.dls.corp.google.com>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
	<02b475e94770ed809e18e6258d593242abd23569.1403877431.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:32:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0bt4-0007Gf-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 21:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbaF0Tcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 15:32:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57306 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbaF0Tci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 15:32:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80FCC2212F;
	Fri, 27 Jun 2014 15:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sy+ol2BV8vm2u6D2quoYeZe4Prs=; b=w7kHaC
	G6P6oGhh86SkqWkDslGMnLZz1W9W7o20G9LfvrP9VCCmYrAqF0JMaPOfIuTyMEkC
	yuPYNnc/FWubm1w+S+uYrr5BWddBrtoaRYYhn/jb0Va+3ozFIHVq6abtZcb6k8v3
	K7//Bd+sIDWE37pBQU+rpMrcXZlUfV85DTrAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdbY7cyCGMUiH1YAcQDIyahnnkGyaMPF
	EhxO6ZeP9CrtjVPOB4SyVC4a8VwLorNPdAkDPhlxRcGbx0piRZ7itRIsZSfZLMYI
	eHUFTmPZLVCyuJ81w+xV3dD2B7reoMIxcXc0ad/T6vAFs8xRcWEoom+4WN5yOwRb
	37n2EBByqmE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75E452212D;
	Fri, 27 Jun 2014 15:32:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D0922212A;
	Fri, 27 Jun 2014 15:32:24 -0400 (EDT)
In-Reply-To: <02b475e94770ed809e18e6258d593242abd23569.1403877431.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 27 Jun 2014 16:13:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3F7F890-FE31-11E3-B435-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252574>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
>  	git hash-object -w -t commit forged1 >forged1.commit &&
> +	! git verify-commit $(cat forged1.commit) &&

test_must_fail git verify-commit ... &&

>  	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
>  	grep "BAD signature from" actual1 &&
>  	! grep "Good signature from" actual1
> @@ -94,6 +110,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
>  	cat raw >forged2 &&
>  	echo Qwik | tr "Q" "\000" >>forged2 &&
>  	git hash-object -w -t commit forged2 >forged2.commit &&
> +	! git verify-commit $(cat forged2.commit) &&

test_must_fail git verify-commit ... &&

>  	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
>  	grep "BAD signature from" actual2 &&
>  	! grep "Good signature from" actual2
> @@ -102,6 +119,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
>  test_expect_success GPG 'amending already signed commit' '
>  	git checkout fourth-signed^0 &&
>  	git commit --amend -S --no-edit &&
> +	git verify-commit HEAD &&
>  	git show -s --show-signature HEAD >actual &&
>  	grep "Good signature from" actual &&
>  	! grep "BAD signature from" actual

Most of the tests, unlike "git show --show-signature" tests, do not
seem to check the output from the command.  Is it because its
primary interface to scripts is its exit status [*1*]?

[Footnote]

*1* "Yes" is totally an acceptable answer and a justification for
not checking the output in many of these tests.
