From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Wed, 08 Oct 2014 12:52:24 -0700
Message-ID: <xmqqk34a8hl3.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
	<5433CBC3.5010202@gmail.com>
	<xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
	<vpqzjd7kta6.fsf@anie.imag.fr>
	<xmqqy4sqbi12.fsf@gitster.dls.corp.google.com>
	<vpq61fujtlk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Jakub =?utf-8?Q?Nar=C4=99bs?= =?utf-8?Q?ki?= <jnareb@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 08 21:52:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbxHk-0005Qy-67
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 21:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbaJHTw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 15:52:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753513AbaJHTw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 15:52:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 734A6140B6;
	Wed,  8 Oct 2014 15:52:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DhsWTtfRAoQZ8zs889Cw74NAfA8=; b=mXgzWB
	g65gEGGJMQ6XHrbcrLV26GSwcgLRI9AoqcrfBMQvcmF/iqt4l8Dn+2RQI0HzS/i8
	sxojcs+VaK5YTCz4kzB3Dz4lFqCkfczvKrDgnuRlMTNoLqs8tdxXAukbGsrgDKBI
	8RQCZyhZm7wVMmBtY60AKpWykf4tnW6xENUSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEGjqNDhxa10ASZLZ7LyMSMyHLTvRtTZ
	mdaVD/bsEAnmKVOhVwrYbTt5jQMs3FiDS/ZzqgzbHjG7Gw0CQ4kEvJuMgWLB7kvm
	RB8YcbfpR3kw/0J9fZMUJqoXnLfmsoKBeBdGYnMQldUbnnLxG0WoX0EPglCTiCp1
	AMhZ1GIrU/8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 676F6140B5;
	Wed,  8 Oct 2014 15:52:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE314140B4;
	Wed,  8 Oct 2014 15:52:25 -0400 (EDT)
In-Reply-To: <vpq61fujtlk.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	08 Oct 2014 20:37:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0912932-4F24-11E4-BE77-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not offhand think of a good example of an variable that we may
>> want to allow overriding but still want to limit its values myself.
>
> I just thought of a semi-realistic use-case : diff.*.{command,textconv}.
>
> One may want to allow per-project sets of diff drivers, but these
> variables contain actual commands, so clearly we can't allow any
> value for these variables.
>
> "semi-realistic" only because I never needed a per-project diff driver,
> I have my per-user preference and I'm happy with it.

This may open another aspect of the discussion, actually.

The whole reason why the actualy diff.*.command and textconv
commands are defined in .git/config while the filetype label is
assigned by in-tree .gitattributes is because these commands are
platform dependant.  So textconv on Linux, BSD and Windows may want
to be different commands, and the project that ships an in-tree
.gitconfig to be safe-included may want to not "set" the variable to
one specific value, but stop at offering a suggestion, i.e. "there
are these possibilities, perhaps you may want to pick one of them?"
without actually making the choice for the user.

And on the receiving side (i.e. [config "safe"] in .git/config), it
is unlikely that you would list textconv choices that are plausible
on different platforms.  Rather, you would say "I would want this
value to be set on textconv and not others".

But at that point, if you have to be that informed to set up the
[config "safe"] to list allowed values, I wonder why a user chooses
to do so and safe-include in-tree .gitconfig, instead of explicitly
setting her preferred textconv in .git/config herself, without
bothering to include anything.

> Anyway, the feature does not seem vital to me, but if someone comes up
> with a clever way to keep room for it in the namespace, that would be
> cool.

Yes.
