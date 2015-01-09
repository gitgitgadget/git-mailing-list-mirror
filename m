From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] receive-pack.c: only accept push-cert if push_cert_nonce was advertised
Date: Fri, 09 Jan 2015 15:57:13 -0800
Message-ID: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
References: <1420836437-11068-1-git-send-email-sbeller@google.com>
	<xmqqsifjbmu2.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZhUZBU886UkqbAXZwSO+xE90FyEqcJYB+AQZ9Aa_c9xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:57:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9jQq-0007Pi-OB
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 00:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbbAIX5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 18:57:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040AbbAIX5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 18:57:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EFEC2E779;
	Fri,  9 Jan 2015 18:57:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4peoE6MQr3tmErwm6+rKK9BU2C8=; b=VIzhLo
	OF/hH0/3R96SPhlRZoiDWfCtk9iPL8m+TpPQ9xg57HcK55L8ChKaZs/uGcllxyMA
	6X/2hcU6DCZtfQvh8Z5ttBolOcCQUYgrTPzXahg1jOksEOw9HBDjIjtJUunCH2ph
	Fiw8DzeBq8lW6a+7qcnoY9wKvF7GCnFKLACG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iv56jVpUEpFC3I58mAm9DIcdyuTed96x
	EzZcD/f4gr+Iz5s+8zeffr4ZiBUtvde2q0+ZKnm6PLGLNucFgIflgSL15RLhJBdk
	fQCOYp2zLn2oKwe2HNgMwuWGgXGYd3tpJMwYI5AT2gApRb37IH5jl7ID0zaU3u65
	F5nX8ht0SRM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 765BC2E778;
	Fri,  9 Jan 2015 18:57:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBE8A2E777;
	Fri,  9 Jan 2015 18:57:14 -0500 (EST)
In-Reply-To: <CAGZ79kZhUZBU886UkqbAXZwSO+xE90FyEqcJYB+AQZ9Aa_c9xg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 9 Jan 2015 15:15:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C433F44-985B-11E4-BBCB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262252>

Stefan Beller <sbeller@google.com> writes:

> Your proposal to acknowledge the correctness of the message leads
> to more questions. How would we proceed?

How would it fail if we pretend that "push-cert" line had to be
old/new/ref line?  Failing the same way, but with a better
diagnosis, would be sufficient.

> I expect such behavior only from malicious clients which actively
> want to abuse a feature which wasn't advertised,...

Do not assume malice; it is not 2005 anymore.  You have to remember
that we are mature enough that there are many reimplementations of
Git, all of which (us included ;-) start with a buggy version.

>> When the protocol exchange gets to this state, in practice, we know
>> we are talking with somebody who has push privilege into the
>> repository,
>
> Yeah but what is one repository compared to the whole server?

Huh?  If an auth good enough for one repository allows things to
another repository, then I consider that to that other repository
the pusher also has push privilege.  So what is the problem?

But again, our first version could just be "pretend we do not know
anything about push-cert", with discussions on alternative
considered in its log message.  I do not think it is a blocker to
lack the "more helpful diagnosis" feature.
