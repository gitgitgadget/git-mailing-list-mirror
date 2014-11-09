From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Sun, 09 Nov 2014 14:40:09 -0800
Message-ID: <xmqq8ujkath2.fsf@gitster.dls.corp.google.com>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
	<20141107185053.16854.5660.chriscool@tuxfamily.org>
	<xmqqzjc2eoyw.fsf@gitster.dls.corp.google.com>
	<20141109.113509.1363113947439404678.chriscool@tuxfamily.org>
	<xmqqfvdse308.fsf@gitster.dls.corp.google.com>
	<xmqqlhnkb5bf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
	marcnarc@xiplink.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnb9j-0001ua-UN
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 23:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaKIWkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 17:40:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424AbaKIWkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 17:40:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2E2C1B11B;
	Sun,  9 Nov 2014 17:40:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9z0ATkW866lT62lSI/NqLPAVTuc=; b=d9q+RZ
	EwXeCMG0kjY1Gs4CYBA3OO0po1j81cW/QW64q5WXMNkIINjBIS0SOxQnMbu8ISY4
	fC+uf/K658kwA29AM33FY+tebDIEdFrxpZffh6YiZ0XEHH7xvxqv4thj1SkLxrXh
	a+wQbrbjIjaHNTTEPOh82IaeCNe5+pFH5MWvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l/BAQhgqWLVSB3zH/TehREzRK5maGhIT
	xJfBy1lTLNFqhl7I0oLc+ojMi+0SyReCqHE+yqTxYZJd255Qs0xO95IrrxQs/EbZ
	6RU1WrGY9aSK0maVALveTZhsNEPw+GcNomiuH9Va7banSz1rF4/w5MQUHyy0BOXM
	OXxPrKii1ng=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D807B1B11A;
	Sun,  9 Nov 2014 17:40:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 523421B119;
	Sun,  9 Nov 2014 17:40:10 -0500 (EST)
In-Reply-To: <xmqqlhnkb5bf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 09 Nov 2014 10:24:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CB0BE8E-6861-11E4-9523-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> Yeah, it won't be as efficient as using only one strbuf and only byte
>>> oriented functions, and it looks much less manly too :-) But over time in
>>> Git we have developed a number of less efficient but quite clean
>>> abstractions like strbuf, argv_array, sha1_array and so on, that we
>>> are quite happy with.
>>
>> Actually, all these examples you gave are fairly efficient and clean
>> abstractions.  I find it insulting to pretend that the "one line per
>> strbuf" is in the same league.  It isn't.
>>
>> And it is not about manliness.
>
> By the way, I do not mean to say that all of strbuf (which is a
> rather full API) is uniformly efficient and cleanly abstracted.
> ...

Having said all that, please notice that I said "might need to be
rethought before the code becomes ready for production."

After all, it would have perfectly been OK to experiment with this
new topic in a script; e.g. this topic being text processing, it
might have happened as a Perl script while we get the semantics and
desirable features nailed down before rewriting the real thing in C.

And if that were what happened here, I wouldn't have been talking
about data structures and unnecessary complexity having to have one
strbuf per line only to join them into one string (or printf() out
to a stream one-after-another) later.

In other words, I did not say "this code is too ugly to live and we
should clean it up as soon as possible or we should revert it from
'master'---it was a mistake to merge it".

I consider the "trailer" code in 'master' today as experimental (in
other words, something I might have written in a scripting language
as a mock-up if I were doing it) that needs to be worked on further
to still get the features and semantics right.  And the patch series
in this thread are hopefully taking us in the right direction to get
them right [*1*].

You could have just said "Yeah, I realize that the code is way
suboptimal, but lets get it feature complete first and then clean it
up", or something, instead of getting defensive with unnecessary
excuses.


[Footnote]

*1* ... even though this step exposes why the approach taken,
splitting the input lines first into individual lines without even
looking at them, is a wrong one---if you started from a single
buffer that is not yet split, it would have been much easier to find
where the trailer block is, and that is why you are re-joining the
buffer you have already split into lines (i.e. what I called
"impedance mismatch"), which shows that the initial splitting is
done prematurely.  Hopefully you would realize that by now ;-).
