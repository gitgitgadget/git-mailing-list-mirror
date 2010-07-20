From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Tue, 20 Jul 2010 08:45:36 -0700
Message-ID: <7v39venom7.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <201007200048.18284.trast@student.ethz.ch>
 <7veiezni4m.fsf@alter.siamese.dyndns.org>
 <201007200951.56218.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 20 17:45:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObF11-0007s5-Qd
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 17:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392Ab0GTPps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 11:45:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab0GTPpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 11:45:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9B62C6C1C;
	Tue, 20 Jul 2010 11:45:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OiVvhbpukhYuhgXwLCb8POAiGP8=; b=enWT3f
	i4FSq4lUd/cYQl8/hJXbUIHUGEr/iJqgS9PXVxYDIFagU6rJk0dtnTEQNdIyk7FX
	ZpBrXXvOANLd5By+/Yyq5Bmulz9UDEMo6U0PO/BQwr4xc7CJz+UNmzdivpCdYlPA
	7fz5STKIdmxn3IEeqlDcAAYux4YEXHN/3JlZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vVU9k6268kIbQ62SdH9dLPXwuAoGnN+R
	QCjFIh12K6XaHAfOMMZ1dGm0VMuzxNYC26pWsMYfSQDqAuLZj6C7i37Da2Jla+Ne
	+66HXlWCenH4tVhy6ETqffVx/fDKqhy9+5ADr6ehPl4EN2I4EuoCrqvbTkaa46FS
	S3U5LJfbkw8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 830AFC6C18;
	Tue, 20 Jul 2010 11:45:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57FF0C6C17; Tue, 20 Jul
 2010 11:45:38 -0400 (EDT)
In-Reply-To: <201007200951.56218.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 20 Jul 2010 09\:51\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA78069E-9415-11DF-8592-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151318>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
> ...
>> I like the general direction, but I am not sure how far we want to take
>> that analogue with blame, though.
>> 
>> For example, Bo's "log -L" thing also works on more than one path, no?  I
>> suspect it might be be reasonable to teach "blame" to annotate more than
>> one path (with ranges) the same way.  There is no technical limitation in
>> the underlying scoreboard mechanism to prevent it from happening.
>> 
>> Very similar to "blame" but quite differently from any normal "log"
>> operation, "log -L" allows only one positive commit (starting point).
>
> AFAICT this is not a conceptual requirement, only one of the current
> implementation/option parsing.

I think "log -L" conceptually is very different from the normal "log with
pathspecs".

The "log with pathspecs" is about "I have these histories that lead to
these commits; show commits that touch paths that match them".  On the
other hand, "log -L" asks "I have these lines in these files; explain how
they came about in the history leading to...".  Now, the question is:
"leading to" WHAT?

Because you start from "I have _these lines_", you are fundamentally
discussing contents that appear as a set of line ranges _in a particular
version_, adjusting the range to match their older incarnations as
necessary as you dig deeper, no?

I would say that this is not just _only_ the implementation and option
parsing.  What is happening looks to me fundamentally very different.

Having said that, it is not entirely implausible to imagine that "log -L"
can further be enhanced to also dig into the future.  The request becomes
"I have these lines; explain how they came about, and how they went".

E.g. if you have a history of this shape where commit C is at the tip:

    ---o---A---x---B---o---C

you _could_ ask "log -p -L1,10,B:Makefile A..C" (I am not proposing this
syntax at all, by the way) to browse the history between A and C, looking
for commits that touch the region of Makefile that appeared as lines 1..10
in revision B.  Between B and C, some new lines might have been introduced
inside the range and you would dig in reverse enlarging the range to show
what have been added to it.

If you have that kind of "forward digging", then it would also not be
implausible to deal with a forked history like this:

                 y---z---D
                /
    ---o---A---x---B---o---C

and ask a similar "log -p -L1,10,C:Makefile A..C D" question.  You would
need to dig from C to x, finding the corresponding range in x, and then
map that corresponding range further while traversing through y, z and to
D in reverse, just like you mapped and traversed from B through o to C in
reverse that explained a part of Makefile in revision B in the earlier
example.

Also the implementation will have to be very different if you really
wanted to do this properly.  I would imagine you would first build a
sparse merge-simplified graph that consists of commits that touch Makefile
(using "Makefile" as a pathspec) in the first pass, map the line ranges
backward and forward in the second pass, and output the result in the
final pass.  Presumably you could collapse the backward traversing half of
the second pass and the third one (which is what Bo's patchset already
does), but I don't think you can stream x-y-z-D going forward, as "log -L"
output needs to follow the usual new-to-old order as the other parts of
the history.

IOW, that "explain how they came and how they went" is also very different
from the normal "log", even if you choose to lift that restriction.

Also I am not entirely sure if it is easy to explain to the users.

If you instead choose to retain the "start from one commit", then the way
you ask the question becomes "I have these lines in these files at this
commit; explain how they came about in the history", which is exactly what
you ask "blame".  You are just using a different presentation from what
the default "blame" output gives.

>> Perhaps these argue that this new feature shouldn't be a new option of
>> "log" at the UI level after all; rather, I wonder if this should be better
>> presented as a new mode of "blame" (e.g. "blame --log", unlike showing
>> "cvs annotate" like output, shows history like "git log" does).
>
> Then you suddenly have a mode of git-blame that takes the normal
> options, and another that takes all the git-log arguments that pertain
> to commit formatting.

I would consider it similar to "blame --incremental"; you can choose a
very different output format driven by a single switch to change the mode
of operation.
