From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Wed, 23 Apr 2014 11:40:44 -0700
Message-ID: <xmqqlhuvzy6r.fsf@gitster.dls.corp.google.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
	<1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 20:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd275-0000K1-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 20:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbaDWSku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 14:40:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaDWSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 14:40:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E197E2CA;
	Wed, 23 Apr 2014 14:40:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kPPU1VhtPGQ6E2ajvLnqLrhRako=; b=OoZBjb
	85m5FiJ4KdW5Ssbwve4V2leljWYD0JCoh90ZhJW5X6L8wyGh/qeiJsRB35uJ89pY
	7q/T0UzOhtGwEXel3cgJp9tE1HrZ+KjKpvUlQ6aY6Cc1sMZpRrsgQ047uRiUGJPf
	V9nWYCAVpuk5GTXwUseXDl6VczT7H0WPEIi70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NpskNNoMe+WnzKeGQs25pU6RScBfwnUi
	CdBuqcQsYidRpbCjlJoIkHKEvz+ekr2rqLV3P5/xxMui932oDwgHb67WCtL73Hpo
	5WnX0nyc/sp7qwUb/q2tFZqR11VnOUNCRElP1w4gdnY4CmsZhAWRuUnZ0d2U+eUu
	UXGMGTfiTLk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54E4C7E2C9;
	Wed, 23 Apr 2014 14:40:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 501007E2C2;
	Wed, 23 Apr 2014 14:40:46 -0400 (EDT)
In-Reply-To: <1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com> (Ilya
	Bobyr's message of "Tue, 22 Apr 2014 01:19:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C874AB82-CB16-11E3-A6D3-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246865>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> @@ -187,10 +192,70 @@ and either can match the "t[0-9]{4}" part to skip the whole
>  test, or t[0-9]{4} followed by ".$number" to say which
>  particular test to skip.
>  
> -Note that some tests in the existing test suite rely on previous
> -test item, so you cannot arbitrarily disable one and expect the
> -remainder of test to check what the test originally was intended
> -to check.
> +For an individual test suite --run could be used to specify that
> +only some tests should be run or that some tests should be
> +excluded from a run.
> +
> +The argument for --run is a list of individual test numbers or
> +ranges with an optional negation prefix that define what tests in
> +a test suite to include in the run.  A range is two numbers
> +separated with a dash and matches a range of tests with both ends
> +been included.  You may omit the first or the second number to
> +mean "from the first test" or "up to the very last test"
> +respectively.
> +
> +Optional prefix of '!' means that the test or a range of tests
> +should be excluded from the run.
> +
> +If --run starts with an unprefixed number or range the initial
> +set of tests to run is empty. If the first item starts with '!'
> +all the tests are added to the initial set.  After initial set is
> +determined every test number or range is added or excluded from
> +the set one by one, from left to right.
> +
> +Individual numbers or ranges could be separated either by a space
> +or a comma.
> +
> +For example, common case is to run several setup tests (1, 2, 3)
> +and then a specific test (21) that relies on that setup:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
> +
> +or:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run=1,2,3,21
> +
> +or:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'

Good and easily understandable examples. 

> +To run only tests up to a specific test (21), one could do this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-21'
> +
> +or this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='-21'

These may be redundant, given that the reader would have to have
grokked the earlier "-3 21" already at this point.

> +As noted above, the test set is built going though items left to
> +right, so this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
> +
> +will run tests 1, 2, and 4.

I do not quite understand what you mean by "left to right"; is that
implementation detail necessary for the user of the feature, or is
it talking about some limitation coming from the implementation?
e.g. perhaps "!3 1-4" would not work as people would expect "do not
run 3, but run tests from 1 thru 4 otherwise", and warning against
having such an expectation that cannot be fulfilled?

> +You may use negation with ranges.  The following will run all
> +test as a test suite except from 7 upto 11:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'

Hmm, that is somewhat counter-intuitive or at least ambiguous.  I
first thought you would be running everything but skipping 7 thru
11, but your explanation is that it is equivalent to "-6,8-11" (that
is, to intersect set "-11" and set "!7").

The above two illustrate the reason rather well why I said it would
be better to avoid negation because it would complicate the mental
model the user needs to form when using the feature.

> +Some tests in a test suite rely on the previous tests performing
> +certain actions, specifically some tests are designated as
> +"setup" test, so you cannot _arbitrarily_ disable one test and
> +expect the rest to function correctly.

What this text (moved from the top of this hunk) tells the reader
applies to both the traditional t0123.4 and the new "--run=1-3,5-"
syntaxes, but the new placement of it make it sound as if it is only
for skipping with "--run", especially because the text before this
paragraph and also after this paragraph both apply only to "--run".

> +--run is mostly useful when you want to focus on a specific test
> +and know what you are doing.  Or when you want to run up to a
> +certain test.

Likewise for "and know what you are doing" part.  I'd suggest
dropping that phrase from here, and/or make it part of the "you
cannot randomly omit and expect later ones to work" that covers both
ways to skip tests.

Thanks.
