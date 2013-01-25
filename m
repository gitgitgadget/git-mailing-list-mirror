From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Fri, 25 Jan 2013 10:34:56 -0800
Message-ID: <7v1ud95cxb.fsf@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
 <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
 <7vr4l97v3h.fsf@alter.siamese.dyndns.org>
 <20130125042326.GA31281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:35:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyo7f-0007rJ-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 19:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab3AYSfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 13:35:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083Ab3AYSe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 13:34:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0E96CA29;
	Fri, 25 Jan 2013 13:34:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EjgMUVdQlpfJPyexDgwL/2kgkPY=; b=VQuJH2
	Ngm5vynWML6JUKVGtAYUR6wHuSx0FrTE3xhlsSLnNcr1bjt0bxr5jLlWU5jR2nrF
	Oxv872C2yKGKZU7R6j6qgXqo8t3wdlLbzhx8a5kCH+cYVxCRgQIDyb8BqOCmo4Bo
	gvf3rCq2JfJbSa1TGmC6XJTtJqELhSyOPbGZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o4zKkPgmb6fO2gEJq1hYKPD5Y9uNR9Ig
	vokQrc9SskAQqkovsT3U21lTzsjZrFBewlp/7X7e0qlI/YsuaApOEedU0EfDqm+5
	5gjYYbi6+42Dr46XKvNxDuJwwu5VkHr54wHV6shxh6XAe97lnBnDgFz60qprWLP1
	lsyTpWcmCgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6364CA28;
	Fri, 25 Jan 2013 13:34:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 241B1CA27; Fri, 25 Jan 2013
 13:34:58 -0500 (EST)
In-Reply-To: <20130125042326.GA31281@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 23:23:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBC123C6-671D-11E2-A5BB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214566>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 24, 2013 at 08:19:30PM -0800, Junio C Hamano wrote:
>
>> > Ahh, ok, we show one element per line and just make sure "bundle"
>> > is there, and we do not care what other buns appear in the output.
>> >
>> Not so quick, though.  The lower level "read from help -a" is only
>> run once and its output kept in a two-level cache hierarchy; we need
>> to reset both.
>
> Ugh, I didn't even think about that.
>
> I wonder if it would be simpler if the completion tests actually ran a
> new bash for each test. That would be slower, but it somehow seems
> cleaner.

I agree 100% with that.  Let's leave this fix as-is, at least as a
tentative fix while "git check-ignore" graduates into the upcoming
release, and let somebody who is interested work on an update to
this test script to do so as an independent topic.


>
>> It starts to look a bit too intimately tied to the implementation of
>> what is being tested for my taste, though.
>> [...]
>> +test_expect_success 'help -a read correctly by command list generator' '
>> +	__git_all_commands= &&
>> +	__git_porcelain_commands= &&
>> +	GIT_TESTING_COMMAND_COMPLETION= &&
>> +	run_completion "git bun" &&
>> +	grep "^bundle $" out
>> +'
>
> Agreed. I could take or leave it at this point. It's nice to check that
> changes to "help -a" will not break it, but ultimately it feels a bit
> too contrived to catch anything useful.
>
> -Peff
