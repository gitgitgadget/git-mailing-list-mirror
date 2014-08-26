From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Tue, 26 Aug 2014 14:54:11 -0700
Message-ID: <xmqq38cihq7w.fsf@gitster.dls.corp.google.com>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
	<1409066605-4851-3-git-send-email-prohaska@zib.de>
	<20140826182125.GC17546@peff.net>
	<xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
	<20140826203158.GA30651@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:54:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMOh8-00032i-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 23:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbaHZVyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 17:54:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58112 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650AbaHZVyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 17:54:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87551347DE;
	Tue, 26 Aug 2014 17:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UvVuKiI25eWqBznGMfkeQ6muZJo=; b=tFuMcU
	ZpnmRMisywEM2n4MJ1WKg7bqfckT3LI1/KjyQKxVUdFMg8GVwZqntHV7dFVOeIfH
	8YasViLUG0m+BDl9iK0oD1u+UJqmxQuEw9vQtYdWr9XNGBwlyF8E9NJS36dAQ/sw
	nTt4zABardNns5+caKGdzmRhzKjVdviVoxanA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BpZsy9miOwOlQ6jZ7U6QLjdsJEy+9sGn
	RGMB7fSd/yS68zOXI7+Xtm1IDctADG/Jk8yPYwIanxG6T3Ein0fn+/E30+Od7IOD
	Od7NtBrhrZrlGThnO8WE2RGS/jl2VWqR24xSPIeRggMKcRz9x1WsUfPxFmIGSx3c
	+P5Rk57Jz7s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BE10347DD;
	Tue, 26 Aug 2014 17:54:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A31DB347D7;
	Tue, 26 Aug 2014 17:54:13 -0400 (EDT)
In-Reply-To: <20140826203158.GA30651@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 16:31:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 849B4E04-2D6B-11E4-9639-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255948>

Jeff King <peff@peff.net> writes:

> If it is truly "some people prefer it one way and some the other", I am
> not sure if we should leave it as-is (that is preferring one way). 

A worse position is to have git_env_bool() that says "empty is
false" and add a new git_env_ulong() that says "empty is unset".

We should pick one or the other and use it for both.

As you pointed out in the later part of the message, an empty string
is a valid way to spell "false" in the config subsystem since the
beginning at 17712991 (Add ".git/config" file parser, 2005-10-10);
consistency with it probably is sensible.

But perhaps my brain is rotten with too much Perl and Python X-<.
I do not know where Linus picked up that, though ;-)

> The middle ground would be to die(). That does not seem super-friendly, but
> then we would also die with GIT_SMART_HTTP=foobar, so perhaps it is not
> unreasonable to just consider it a syntax error.

Hmm, I am not sure if dying is better.  Unless we decide to make
empty string no longer false everywhere and warn now and then later
die as part of a 3.0 transition plan or something, that is.
