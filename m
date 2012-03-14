From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Wed, 14 Mar 2012 15:17:28 -0700
Message-ID: <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Mar 14 23:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7wVl-0000gJ-2m
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 23:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761148Ab2CNWRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 18:17:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab2CNWRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 18:17:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB57773F1;
	Wed, 14 Mar 2012 18:17:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YEthyZM+IWfw
	tu77CwkJbhycolI=; b=eNGkAQ18wTL4JI6yeRVJ6mt17NT5RDQclhjugU/m61fp
	rcViQMUIBatkAKSXcb0lIsQlTAJ/FohJ3BAgOL0BRhV6kAtQ8LpKROfjRAUozaru
	zfMXMo0SY4Kv6uivBmyfUEf0VQ9UmCqpHM041NJQV0ji9fOV9VI+Z0AfnySgark=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gZjPs8
	xK4/RdTLToVoE+s2hYZsq32Koa3hHsbL78n37w03t5nBr3LA5J+pcSmrHva2+GD0
	t1gwHoOrIPOTuephvYgaUVvOo0zEuaTyRUeC0ytL7rmc47T/cTZXgy49cSTfAgKY
	8oskYx7yvoA1TfzFcLHsu+1HilDFtWNvNmfFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F9473F0;
	Wed, 14 Mar 2012 18:17:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3490973EF; Wed, 14 Mar 2012
 18:17:30 -0400 (EDT)
In-Reply-To: <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 14 Mar 2012
 15:18:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D42CA74-6E23-11E1-92B1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193167>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> t0300-credential-helpers.sh requires GIT_TEST_CREDENTIAL_HELPER to be
> configured to do something sensible. If it is not set, prove will say=
:
>   ./t0303-credential-external.sh .. skipped: (no reason given)
> which isn't very nice.
>
> Use skip_all=3D"..." && test_done to bail out immediately and provide=
 a
> nicer message. In case GIT_TEST_CREDENTIAL_HELPER is set, but the
> timeout tests are skipped, mention GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=
=2E
>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  t/t0303-credential-external.sh |   40 ++++++++++++++++--------------=
----------
>  1 files changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-exte=
rnal.sh
> index 267f4c8..4479bf8 100755
> --- a/t/t0303-credential-external.sh
> +++ b/t/t0303-credential-external.sh
> @@ -4,36 +4,28 @@ test_description=3D'external credential helper test=
s'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-credential.sh
> =20
> -pre_test() {
> -	test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
> -	eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
> -
> -	# clean before the test in case there is cruft left
> -	# over from a previous run that would impact results
> -	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> -}
> -
> -post_test() {
> -	# clean afterwards so that we are good citizens
> -	# and don't leave cruft in the helper's storage, which
> -	# might be long-term system storage
> -	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> -}
> -
>  if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
> -	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELP=
ER)"
> -else
> -	pre_test
> -	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
> -	post_test
> +	skip_all=3D"used to test external credential helpers"
> +	test_done
>  fi
> =20
> +$GIT_TEST_CREDENTIAL_HELPER_SETUP

This used to be 'test -z "$it" || eval "$it"'; doesn't it make a
difference?

What is the value expected to be in this variable?  Nobody seems to set=
 it
in our codebase, so I cannot say "with the current code, this rewrite i=
s
safe" or anything like that.

This is probably not related to your patch, but

	GIT_TEST_CREDENTIAL_HELPER=3Dcache sh t0303-*.sh

passes OK for me while

	make GIT_TEST_CREDENTIAL_HELPER=3Dcache T=3Dt0303-*.sh prove

seems to get stuck forever.
