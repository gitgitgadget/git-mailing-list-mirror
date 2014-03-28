From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Fri, 28 Mar 2014 09:41:53 -0700
Message-ID: <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
References: <20140224074905.GE9969@sigill.intra.peff.net>
	<20140326110559.GA32625@hashpling.org>
	<20140326182103.GB7087@sigill.intra.peff.net>
	<20140326185153.GA12912@sigill.intra.peff.net>
	<xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
	<20140326192536.GA13989@sigill.intra.peff.net>
	<20140326193359.GA14105@sigill.intra.peff.net>
	<20140326212227.GC6991@hashpling.org>
	<20140326215741.GA17716@sigill.intra.peff.net>
	<20140326224616.GA9454@hashpling.org>
	<20140327224837.GB32434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:42:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTZr0-0006Nm-CC
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 17:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbaC1Ql6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 12:41:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbaC1Ql5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 12:41:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 892A076610;
	Fri, 28 Mar 2014 12:41:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JVRwr56ldstODu9gM3vr16S1JlA=; b=vnRArF
	BjF2Llf2zbO4/1woTGgsrK6402LGnXwEmXjH3rTj9o7Ksqgqt4T/3VogHpRNEEPQ
	iKkHYieAXh9XqHcmHcULbt5wqd9Xfj7MuY5O+p08XG/3dh8sDLpadxsILq0Ydwyt
	5H6uGnEqTuh1GV/WxU35EpDz8uwDhGI33IEhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WJikTuNgX70weiUvDDua55C+SHW0bq80
	7P4vqZ9wmlqB/K+Iindrfj5Ta5Zgz+T0A0NlhYZfkMTw1d+qRkN8euwFvITH07Ud
	0MBUwKaQ6VW3WWuP9si8+02krU8Pd6Vm+kfhhTNSQ9dKPSyneKLkdcXmXdXJ4gnK
	XdH9dkFfkOU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61FBA7660F;
	Fri, 28 Mar 2014 12:41:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BE3576607;
	Fri, 28 Mar 2014 12:41:55 -0400 (EDT)
In-Reply-To: <20140327224837.GB32434@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Mar 2014 18:48:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF73E3A4-B697-11E3-9BAD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245392>

Jeff King <peff@peff.net> writes:

>> 9999999999999999 Sat Jan 25 10:46:39 316889355 -0700
>> 99999999999999999 Wed Sep 6 02:46:39 -1126091476 -0700
>> 999999999999999999 Thu Oct 24 18:46:39 1623969404 -0700
>
> Thanks. Given the value where it fails, it kind of looks like there is
> some signed 32-bit value at work (~300 million years is OK, but 10 times
> that, rather than yielding ~3 billion, gets us -1 billion). Perhaps
> tm.tm_year is 32-bit.

That is what it looks like to me, too.  It makes me wonder if some
other platforms may have similar breakage using 16-bit signed
tm_year and how such a breakage would look like, though ;-)

> So what do we want to do? I think the options are:
>
>   1. Try to guess when we have a bogus timestamp value with an arbitrary
>      cutoff like "greater than 1 million years from now" (and enforce it
>      via time_t seconds, and avoid gmtime entirely). That is made-up and
>      arbitrary, but it also is sufficiently far that it won't ever
>      matter, and sufficiently close that any gmtime should behave
>      sensibly with it.

I think that two assumptions here are that

 (1) we would be able to find a single insane value (like 3 billion
     years from now expressed in time_t seconds) the test script
     would be able to feed and expect it to fail on all platforms we
     care about, even though how exactly that value causes various
     platforms fail may be different (glibc may give us a NULL from
     gmtime, FreeBSD may leave their own sentinel in gmtime we can
     recognize, and some others may simply wrap around the years);
     and that

 (2) the only other class of failure mode we haven't considered
     bevore Charles's report is tm_year wrapping around 32-bit
     signed int.

Offhand, the three possible failure modes this thread identified
sounds to me like the only plausible ones, and I think the best way
forward might be to

 - teach the "is the result sane, even though we may have got a
   non-NULL from gmtime?  otherwise let's signal a failure by
   replacing it with a known sentinel value" codepath the new
   failure mode Charles's report suggests---if we feed a positive
   timestamp and gmtime gave us back a tm_year+1900 < 0, that is
   certainly an overflow; and

 - Use that 3-billion years timestamp from Charles's report in the
   test and make sure we convert it to the known sentinel value.

perhaps?

>   2. Accept that we can't guess at every broken gmtime's output, and
>      just loosen the test to make sure we don't segfault.

Of course that is a simpler option, but we may have identified all
plausible failure modes, in which case we can afford to go with your
original plan to validate that we not just avoid segfaulting on one
of the three failure modes from gmtime, but also cover the other two
failure modes and signal any of them with a sentinel.  That way may
allow us to identify the fourth failure mode we haven't anticipated.
