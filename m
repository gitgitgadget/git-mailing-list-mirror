From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support generate poison .mo files for testing
Date: Wed, 22 Aug 2012 09:22:46 -0700
Message-ID: <7v393ec2w9.fsf@alter.siamese.dyndns.org>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org>
 <1345613246-4053-1-git-send-email-pclouds@gmail.com>
 <7vboi3b2n8.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dp5FZd9Ko6o18r5TeS5dfbjv61wOmP1452zyvHfX5LMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:22:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Dhp-0004fC-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935Ab2HVQWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794Ab2HVQWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:22:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37F3180F4;
	Wed, 22 Aug 2012 12:22:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbyag27prduQMGf++ggUB9RxnYU=; b=Qd95gk
	XHFOe//78ygEPkIya/tJPlHrFTOCQRSKRtCew2X450fqnAEuKNur9ar2gp6D9clP
	3D9SD9NoOTIdeQkTXkBa5F9ElaQidCotXRdm5e5aulyxN9CX6tmfDVxfFsiXYEKW
	KwDIs9PGOU1dbzoZmXlv6vyaUepKDo/YJh84s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iglpequqTrmPIj32Wr1EvGGBl8YBD/UB
	F6tYvrewtSEBzmXfXZCcB/PCMf80Dje1IlIFqbfeuWgaQIDzKR0pbw9nYjPKMh1j
	hYeVACqZNKieb+vR1g3wUA7CYwHcaDL6B9246PNL8LCuuWiOn9fzDJsAlRUN7LZS
	bKdjih/wKdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B6E80F3;
	Wed, 22 Aug 2012 12:22:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EBCF80F2; Wed, 22 Aug 2012
 12:22:48 -0400 (EDT)
In-Reply-To: <CACsJy8Dp5FZd9Ko6o18r5TeS5dfbjv61wOmP1452zyvHfX5LMQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 22 Aug 2012 19:37:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CE306B6-EC75-11E1-848B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204025>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> But a better way could be
> replacing "tracked" with "t r a c k e d". We know the rule so we can
> recreate the that string from "tracked" in test_i18n*. Or reverse the
> upper/lower case, whichever is easier for the recreation by test_i18n*

That does not make much sense to me, so either one of us must be
slightly confused.  I thought the only purpose of testing with the
"poison" was to find messages that must not be localized but were
localized by mistake.  For that, we have to make sure that anything
that uses test_i18n* is reading from Porcelain, in other words, we
must use the byte-for-byte comparison without using test_i18n* when
verifying the plumbing output.  And the primary requirement for this
arrangement to work is that the expected output in C locale and the
actual ouptut in the synthetic poison locale are reliably different.
They do not have to be reversible (I was actually going to suggest
rot13 of the original instead of cycling through the "* gettext
poison *" in your patch --- prefixing with QQ would not work, as it
is likely that the test with "grep" may not be anchored at the left
end).

Teaching test_i18n* to fuzzily match the expected output in C locale
against the actual output in synthetic poison locale may or may not
be doable, but spending any cycle working on that sounds like a
total waste of time (even though it might be fun).  It does not test
that we are translating Porcelain messages correctly.

Am I missing something?  Puzzled...
