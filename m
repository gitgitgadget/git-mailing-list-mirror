From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/21] t/test-lib-functions.sh: generalize test_cmp_rev
Date: Mon, 25 Apr 2016 11:08:54 -0700
Message-ID: <xmqqvb35lfwp.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-4-git-send-email-s-beyer@gmx.net>
	<xmqqd1pqbq2a.fsf@gitster.mtv.corp.google.com>
	<571D23CB.8020305@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:09:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukwT-00042a-V8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbcDYSI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 14:08:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754800AbcDYSI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 14:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 620E1150AE;
	Mon, 25 Apr 2016 14:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SQr2d2LXizV8mlKYgjkkjm3tyI8=; b=sa1AZ3
	JPyGQtSReB8XOLPBZCzjZzpCpaNyUBpS707rMpe2TsscP12b0o8UTgAMf+gCkrR7
	hrJRxc5frE/SZ1eyWkmighcxxKO2YSAq1Lt2UqMjo/DqvvCi+NQLmhTd3V/LeEQJ
	LfLTzUqFioujMlnWAcZ1nNh3aNJ8Y7C0Roktg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WOMz+nXxCO7VEfoJuDAhVfNvIwipHs3q
	o2qANv70mMj2em7hUj3wW+Mq8ty2pU1cWx0zHN6ySedf0d/TVMQdZMW9PKXSAzwX
	ccTciaU34XyATz+NptqBTGnw1iD25bzWeScN77svEEqGI+4xurz1VNWNIyPisO6j
	6iKj/mmGHXY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 578DE150AD;
	Mon, 25 Apr 2016 14:08:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CD48150AC;
	Mon, 25 Apr 2016 14:08:55 -0400 (EDT)
In-Reply-To: <571D23CB.8020305@gmx.net> (Stephan Beyer's message of "Sun, 24
	Apr 2016 21:51:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C65A0EAA-0B10-11E6-9BDB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292536>

Stephan Beyer <s-beyer@gmx.net> writes:

> Hi,
>
> On 04/15/2016 10:00 PM, Junio C Hamano wrote:
>> Stephan Beyer <s-beyer@gmx.net> writes:
>> 
>>> test_cmp_rev() took exactly two parameters, the expected revision
>>> and the revision to test. This commit generalizes this function
>>> such that it takes any number of at least two revisions: the
>>> expected one and a list of actual ones. The function returns true
>>> if and only if at least one actual revision coincides with the
>>> expected revision.
>> 
>> There may be cases where you want to find the expected one among
>> various things you actually have (which is what the above talks
>> about; it is like "list-what-I-actually-got | grep what-i-want"),
>> but an equally useful use case would be "I would get only one
>> outcome from test, I anticipate one of these things, all of which is
>> OK, but I cannot dictate which one of them should come out" (it is
>> like "list-what-I-can-accept | grep what-I-actually-got").
>
> I see that these are strictly speaking (slightly) different semantics
> but in the end it boils down to be the same, or am I missing anything?
>
>> I am not enthused by the new test that implements the "match one
>> against multi" check only in one way among these possible two to
>> squat on a very generic name, test_cmp_rev.
>> 
>> The above _may_ appear a non-issue until you realize one thing that
>> is there to help those who debug the tests, which is ...
>> 
>>> While at it, the side effect of generating two (temporary) files
>>> is removed.
>> 
>> That is not strictly a side effect.  test_cmp allows you to see what
>> was expected and what you actually had when the test failed (we
>> always compare expect with actual and not the other way around, so
>> that "diff -u expect actual" would show how the actual behaviour
>> diverted from our expectation in a natural way).
>
> I was referring to *generating the files* as a side effect. I did not
> even think about the fact that "diff" in the original code does not only
> return an exit code but that it also generates output that can be used
> as "helpful diagnostic information" (referring to Eric Sunshine's mail
> here). I was not aware that the Git tests should -- besides testing --
> already include "tools" for easier debugging in case of a failure... So
> dropping this information was not intentional.
>
>> Something with the semantics of these two:
>> 
>> 	test_revs_have_expected () {
>>         	expect=$1
>> 		shift
>> 		git rev-parse "$@" | grep -e "$expect" >/dev/null && return
>> 		echo >&2 "The expected '$1' is not found in:"
>>                 printf >&2 " '%s'\n", "$@"
>>                 return 1
>> 	}
>> 
>> 	test_rev_among_expected () {
>> 		actual=$1
>>                 shift
>> 		git rev-parse "$@" | grep -e "$actual" >/dev/null && return
>> 		echo >&2 "'$1' is not among expected ones:"
>>                 printf >&2 " '%s'\n", "$@"
>>                 return 1
>> 	}
>> 
>> might be more appropriate.
>
> Ah! That's what I meant above. The code is copy&paste besides variable
> naming and the output "title". Such code duplication for the sake of
> "easier debugging" in case of a failure?
>
> Also I wonder if test authors in the future would really know *which*
> one is the right one to use.

I saw that even you were originally confused about it ;-).

In your proposed log message, you talk about "the expected, and list
of actual ones", which can only mean "there may be multiple answers
from the command (e.g. "merge-base --all") and we only require that
one of the answers is the expected one", which is why among the two
necessary functions I listed "test_revs_have_expected" above first,
but I think most (if not all) of the invocations of the multi-match
form in your patch actually wanted "test_rev_among_expected"
variant, i.e. "there will be one answer from the command, but there
are multiple acceptable answers, all of them valid".

I do not think test authors who understands the reason why we always
say "test_cmp actual expect" and not the other way around will share
the same confusion (and now you were explained and understood why
"diff" in the original was given the expected and actual result in
that order, you no longer are confused wrt this).

And no, this is not "for the sake of easier debugging in case of a
failure".  It is about knowing what you are doing--are you going to
have multiple answers and making sure one right one appears in it,
or are you going to have one answer and allowing any one of multiple
valid ones?  These two are quite different things and it helps the
readers of the test to know which one is being used.
