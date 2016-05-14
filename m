From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Sat, 14 May 2016 11:31:59 -0700
Message-ID: <xmqqwpmw7aow.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1605130820160.4092@virtualbox>
	<CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
	<alpine.DEB.2.20.1605140807310.4092@virtualbox>
	<CAP8UFD376guRRPpMVjC36K0dvWy17xdaHvV1WoRjMaNpdp0bqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 20:32:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1eMI-00041P-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 20:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbcENScF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 14:32:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932178AbcENScE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 14:32:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 85245186FA;
	Sat, 14 May 2016 14:32:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jhyfrk6gGRt+NLuLZTnj4lAf0iY=; b=o8wThr
	1ptPiXX0P7vw3659Z6EJIcsXGLlN7+IklNzOIeLm33LTfuylw1Hjqs8YYVl7Jsb6
	Y9vLTPQa96ddp1WyGq/wkpRPIe0BdS4+gKvEo7uFVZi8vuO5aBZ1YMuIvRasAEm/
	voVZMOJI438g2TiTGekrFSs4SVtoID3xI342E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4TLjHfxGPtSybkbxb+cHhoziQ2/SJX+
	oFRBg1E0T5nWkT5tcQZcFwVEOpvmKtCqkauqurHq6KvNsRXCQ06mo787H4NcVqP5
	yesKdtiYg7DM0tgXbsO30q8twJhFF0Q7nSwU0go/J5hBbBfpTuRyIA1Hn89BaSxl
	Q8bUczXwk+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C785186F8;
	Sat, 14 May 2016 14:32:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5B82186F3;
	Sat, 14 May 2016 14:32:01 -0400 (EDT)
In-Reply-To: <CAP8UFD376guRRPpMVjC36K0dvWy17xdaHvV1WoRjMaNpdp0bqQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 14 May 2016 11:19:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26753076-1A02-11E6-BCA8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294621>

Christian Couder <christian.couder@gmail.com> writes:

>>> So it looks to me that --quiet means something like "don't tell the
>>> story of your life, but in case of problem you are allowed to
>>> complain". In other word --quiet generally doesn't suppress error
>>> messages from error() or die().
>>
>> Right.
>>
>> And if you care to take a step back, this is most likely what we want in
>> libified code.
>
> In the previous discussion, Junio asked:
>
> "How far can you go with just set-error-routine?  Are there things,
> other than the file descriptors, that you need to futz with in order
> to covert that "we'd fallback, so this early round must be silent"
> codepath?"
>
> So it looks to me that the goal is to have something that replicate
> the current behavior, which is to not even display messages from
> error().

Note that I was not endorsing the approach to use set-error-routine,
one of whose downside is that it is easy to silence everything
unconditionally.  Between --quiet/--silent, I wasn't making any
choice, as I hadn't even formed an opinion back when I wrote it.

I was merely asking "is use of set-error-routine the worst thing you
need to do, or do you need to do anything more gross?", half
anticipating "no, it turns out that I need to longjmp(3) from my
die-routine to come back from deep in the existing code because I do
not think I'd bother propagating the error status all the way along
the call stack", at which point my response would have been "Ugh,
use of set-error-routine to avoid properly refactoring, even if we
assume it is OK to squelch the errors unconditionally, is bad
enough.  If you need to longjmp(3), that's no longer a libification.
You are better off using the run_command() interface to give the
caller and the callee a proper isolation".

Libification is not just "now it runs inside a single process" at
all.  It is more about "it has proper abstraction and separation so
that callers have _more_ control than they used to (compared to
interacting with a spawned process) while retaining the control of
their own environment".

And as this thread showed, when turning an implementation that uses
run-command with program's standard error sent to /dev/null into a
"libified" implementation, we _gain_ a possibility to be more
selective in what we silence.  I think that exactly falls into
"callers have more control" category of libification benefit.

Quite honestly, I was sort of surprised by the quality of the
argument for proper libification Dscho has been making in this
thread, and that was why I didn't say much here.

Having said all that, as to --quiet/--silent, another way to surface
the "even more quiet" used is with "-q -q" (i.e. multiple levels of
quietness).  I am just saying this for the record without suggesting
it is better or worse suited for this case than what has been
discussed.

In any case, I do see the need for what your --silent option does
internally when a caller like "am" calls into the libified "apply"
machinery.  When we _know_ we will run a "fallback" invocation after
an initial "more strict" apply attempt fails, we do want the initial
invocation to be totally silent, not even with any error message,
because we know that it is sufficient to let the fallback invocation
show its error message (if it fails).  The fallback may even succeed
in which case error messages from the initial invocation serves only
as an explanation of the reason why we used fallback, which is not
interesting to the end user at all.

I however do not see a reason why you need to expose that feature to
the users of "git apply".  So I am not sure if any of us care deeply
the choice among --silent, --quiet and -q -q.
