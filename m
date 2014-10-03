From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Fri, 03 Oct 2014 13:12:31 -0700
Message-ID: <xmqqeguolxow.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
	<542DB2FE.609@gmail.com>
	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
	<542DB711.9040503@gmail.com>
	<xmqqiok2m494.fsf@gitster.dls.corp.google.com>
	<vpqeguptz5k.fsf@anie.imag.fr>
	<xmqq1tqpm2na.fsf@gitster.dls.corp.google.com>
	<vpq4mvlgchj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:12:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9DS-0002cT-A7
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbaJCUMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:12:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60321 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbaJCUMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:12:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2CBA93F4ED;
	Fri,  3 Oct 2014 16:12:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QvhzeoKzgYxeCN2jM4CU+C8Qnoc=; b=BnVE2+
	mO++4O4sWWKH7hdc3mszhadzAbfG9QrD4mmESali2xfcIIVqGu7TKEQtoU/dhJKb
	iF0qv1C7SrOKGfXyKiHuCTLX+Jp0VTpGmKaH4e2KclNvn2d0LplfzbZuXLh3vOtc
	gXYFlG4leZZVvEHxcsP4Yrc07vwqCjlSuMknw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErLHiljFLKdz5yqQr4jm3CVqdmdW3dLl
	4Tqn99/nEp/hU+VC799O7FHO7SCEk5StP2DP7accOw9dXrCGftcsCh5KHhZiHehS
	PnFMS5HzEojcrLBZ95jkS7YxYk+bVTo435RhRuHa1XOPLRj7986eC5aGhs/qSWVq
	9a9wkZJiSdc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20E0C3F4EC;
	Fri,  3 Oct 2014 16:12:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8246A3F4EB;
	Fri,  3 Oct 2014 16:12:32 -0400 (EDT)
In-Reply-To: <vpq4mvlgchj.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	03 Oct 2014 21:49:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BB42390-4B39-11E4-88E9-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257849>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The "git config [--add] section.var value" UI, [...] finds the "var = value"
>> definition at the end (or adds a "section" at the end and then adds
>> [...]
>>
>> It is fine for single-valued ones that follow "the last one wins"
>> semantics; "git config" would add the new definition at the end and
>> that definition will win.
>
> Not always.
>
> git config foo.bar old-value
> git config unset.variable foo.bar
> git config foo.bar new-value
>
> One could expect the new value to be taken into account, but it is not.

I think you misunderstood what I said.  With ordinary variables,
everything works fine, that is, without unset.variable, which this
series is trying to pretend as if it were just another ordinary
variable, but it is not.  You are just showing how broken it is to
treat unset.variable as just another ordinary variable, which is
what I've been telling you.

So we are in agreement.

>>> Well, the normal use-case for unset.variable is to put it in a local
>>> config file, to unset a variable set in another, lower-priority file.
>>
>> I agree that is one major use case.
>>
>>> This common use-case works with the command-line "git config", and it
>>> would be a pity to forbid the common use-case because of a particular,
>>> unusual case.
>>
>> Either you are being incoherent or I am not reading you right.  If
>> you said "If this common use-case worked with the command-line 'git
>> config', it would be nice, but it would be a pity because it does
>> not", I would understand.
>
> I think you missed the "another" in my sentence above. The normal
> use-case is to have foo.bar and unset.variable=foo.bar in different
> files. In this case, you do not care about the position in file.

I didn't miss anything.  The reason you want to have "unset foo.bar"
in your .git/config is to override a "foo.bar = z" you have in
another place, e.g. ~/.gitconfig; which would let you sanely do
another "foo.bar = x" in .git/config for multi-value foo.bar, *if*
the unset comes before foo.bar.

But what if you have this in your .git/config file

	[core]
		bare = false
            ... standard stuff left by git init ...
	[foo]
        	bar = x

before you add "unset foo.bar" there?

And that is not a contribed example.

The likely reason why you want to resort to "unset foo.bar" is that
you found that you get an unwanted foo.bar=z in addition to desired
foo.bar=z in a repository that has the above in .git/config, and at
that point you would want to say "I want to unset the outside
influence".

And there is no "[unset] variable = foo.bar" in there yet; without
some special casing, if you treated unset.variable as if it were
just another ordinary variable, it would go after you define your
own foo.bar=x, which is not what you want.
