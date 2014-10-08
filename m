From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Wed, 08 Oct 2014 09:58:34 -0700
Message-ID: <xmqq7g0acxc5.fsf@gitster.dls.corp.google.com>
References: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>
	<20141007212941.GA24508@peff.net>
	<xmqqiojvczrd.fsf@gitster.dls.corp.google.com>
	<54346663.7090006@alum.mit.edu> <20141008011304.GA26864@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 18:58:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbuZY-0007bS-2W
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 18:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbaJHQ6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 12:58:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62912 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752719AbaJHQ6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 12:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4195141F4;
	Wed,  8 Oct 2014 12:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=voi7kgHBw7Fq4YBXXQL4n0ze3v8=; b=xXzgT0
	14Dzz7D+cDnYxwZlEHzgk3gbwpYxQAoM/CXgAoD4zCX+ms+5tk3eUClXvkfOx8mr
	o0sHZHtCy6eM6jbnHtfmIJS2aulQEv9kobUoEYZwdpG4UPt1S4GkfuJ3xs/axp7h
	iQS2+lZFPNnU5pJ3SgEzCKfKPu+XnE05vrcOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kC2XniNABmllf52NT3AUBmJzzbtgFh0O
	lAbLPelVd3IRW0B41eRAFpyBAI9e4KIhno7PeM0n4xLtuxy1MdmHr9wc0+lH3bVk
	IF5coUyyrAjVZxzZ3CCIB/QFQ9E7krxcKduo7hgXnzBNBPBaF5xhGEf+xEuals9O
	3baere5497c=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD39E141F3;
	Wed,  8 Oct 2014 12:58:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37C75141F0;
	Wed,  8 Oct 2014 12:58:36 -0400 (EDT)
In-Reply-To: <20141008011304.GA26864@peff.net> (Jeff King's message of "Tue, 7
	Oct 2014 21:13:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57FE1530-4F0C-11E4-8D30-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 08, 2014 at 12:17:07AM +0200, Michael Haggerty wrote:
>
>> On 10/07/2014 11:53 PM, Junio C Hamano wrote:
>> > Hmph, your 'test' in that name is a generic verb "we check that...",
>> > which I think aligns better with the other test_foo functions.  When
>> > I suggested 'test_verbose', 'test' in that name was specifically
>> > meant to refer to the 'test' command.
>
> I actually meant "test" as a namespace to indicate it is part of the
> test suite (just like "test_seq" is not testing anything). I think that
> is why the names are so silly. We are using the "test" command in our
> "test" suite to "test" some conditions.
>
>> I like "verbose_test $foo = $bar" because it puts the word "test" next
>> to the condition, where the built-in command "test" would otherwise be.
>> 
>> We could even define a command
>> 
>> 	verbose () {
>> 		"$@" && return 0
>> 		echo >&2 "command failed: $*"
>> 		return 1
>> 	}
>> 
>> and use it like
>> 
>> 	verbose test $foo = $bar
>
> I kind of like this. It is easy to see which shell command is being
> invoked, and it would extend naturally to other silent commands.
>
>> Somehow I feel like I'm reinventing something that must already exist...
>
> Yes, we're basically reinventing "set -x" here, with the caveat that we
> only _really_ care about showing failed commands. The problem with "set
> -x" is that it also wants to apply itself to the test harness itself, so
> you end up with a lot of cruft.

As you have done, I've done my share of running tests under "sh -x",
and I agree that it gives too much noise. Which is almost impossible
to read through without a lot of patience, but at least it contains
everything we could ask, short of running a specific step under gdb.

The "verbose" thing that reports only when the expectation is violated
cuts down the cruft (so does your original test_cond/verbose_test),
so it may make it easier than the bare-metal "sh -x".

But it may cut down a bit too much.  Often in a test that consists
of multiple commands chained together with && inside a single
test_expect_success, what leads to the eventual unsatisfied
expectation is an earlier step that succeeds in the sense that it
satisfies the expectation of that step (e.g. "git branch foo &&" and
we only check it did not exit with non-zero status) but did not
actually do what we wanted it to do (e.g. that "git branch" did not
create a new branch 'foo' but created 'refs/foo' by mistake), and
then a later step is tripped by the unsatisified expectation that
was not explicitly tested (e.g. after that "git checkout foo" would
not quite fail but instead of checking out a branch to build upon,
it detaches the HEAD at that commit, because the earlier "git branch"
was faulty but we did not notice it).

So I dunno.  For harder cases we always have to resort to "sh -x",
but "verbose" thing may still help easier cases, just like the use
of test_cmp instead of cmp is helping us while viewing output from
running test with the "-v" option today, and that would be a good
enough improvement.
