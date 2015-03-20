From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test &&-chain lint
Date: Fri, 20 Mar 2015 10:04:43 -0700
Message-ID: <xmqq384zha6s.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
	<20150320013217.GA15302@peff.net>
	<CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
	<20150320020851.GC15302@peff.net> <20150320022532.GA5502@peff.net>
	<xmqqd244go0h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0Lw-0006kn-LT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbbCTREw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:04:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbbCTREv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 649EF3FF12;
	Fri, 20 Mar 2015 13:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ueA0PqwU3cAZJgWZO5RA/D7XCiQ=; b=CNOFYY
	PRNGoITTMEIuqfIctgnOfv5eXxSCzT3Vpsy6h6bCFEzmd6aADpjkYaNz5lg7+ZCB
	RweBZWuoA97/csolBLzCgW0006kOWXjGIfsrlzsNPJRZ8NT7IxM6VxFMOJCbJ6a+
	KtEW5EEXlo2O55OGnaHmzmYmdcXCEH31jXi88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ItReSa8ycVLTRSxuVFSpKRieQTN2D5MW
	7e4P9hzDdPb0UDIoipv79vxUTKV1+0Ag3H7/a5sQk+SBokBkxN6ruRbBOo+wWuQH
	PDzBgHVW7AZYfMHrp/QClZYgm8lJnqbx54bKWvDMTN83GEF8cKfEGX1JLx1MkgRK
	ogFtLugW2Ig=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C8EA3FF11;
	Fri, 20 Mar 2015 13:04:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 333A73FF06;
	Fri, 20 Mar 2015 13:04:44 -0400 (EDT)
In-Reply-To: <xmqqd244go0h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 Mar 2015 23:51:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34B3434C-CF23-11E4-A02A-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265911>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> [+cc Jonathan, whose patch I apparently subconsciously copied]
>>
>> On Thu, Mar 19, 2015 at 10:08:51PM -0400, Jeff King wrote:
>>
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index c096778..02a03d5 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -524,6 +524,21 @@ test_eval_ () {
>>>  test_run_ () {
>>>  	test_cleanup=:
>>>  	expecting_failure=$2
>>> +
>>> +	if test -n "$GIT_TEST_CHAIN_LINT"; then
>>> +		# 117 is unlikely to match the exit code of
>>> +		# another part of the chain
>>> +		test_eval_ "(exit 117) && $1"
>>> +		if test "$?" != 117; then
>>> +			# all bets are off for continuing with other tests;
>>> +			# we expected none of the rest of the test commands to
>>> +			# run, but at least some did. Who knows what weird
>>> +			# state we're in? Just bail, and the user can diagnose
>>> +			# by running in --verbose mode
>>> +			error "bug in the test script: broken &&-chain"
>>> +		fi
>>> +	fi
>> ...
> Hmmm, they do look similar and unfamiliar ;-)  It happened while I
> was offline, it seems.

One case where this might misdetect a good test would be this one:

    test_expect_success 'either succeed or fail with status 1' '
	git subcmd || case "$?" in 1) : happy ;; *) false failure ;; esac
    '

which would turn into

	(exit 117) && git subcmd || case ...

and fail to set $? to 117, triggering a false positive.

I do not have a good solution fo that, though.  Obviously, turning
the check into

	(exit 117) && {
        	$1
	}

misses the entire point of the chain-lint.

I wonder if another valid way to make it harder for us to commit
"broken && chain" errors in our test may be to make it not an error
in the first place.  Do we know how buggy various implementations of
shells are with respect to their handling of "set -e"?

We know that chaining commands with && is much less likely to be
broken in various reimplementation of bourne shells, and that is
the primary reason we stick to this style in our tests, but if
everybody implements "set -e" reliably and consistently, flipping
that bit in test_eval_ and removing the need to &&-cascade the
commands might not be such a bad idea.

Just thinking aloud...
