From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 15:31:47 -0800
Message-ID: <xmqqsi0l8wt8.fsf@gitster.mtv.corp.google.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
	<CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:31:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdTn-0004SR-UD
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcBUXbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:31:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752434AbcBUXbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:31:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C7D0455BD;
	Sun, 21 Feb 2016 18:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1OPQZIo4sqXWIfHzOSazXxs3GPo=; b=HfNqBx
	raflubIh+i7CWtSEGykwz/r+YL/96qAEfYWl0pes4wDaldSXjGxw3CnRatNfhFgh
	dUDrwKJr1nAjgYj2ifqKgMkfxFRlShze9HkB5BaxwSyz1z3qNVp5mUQ10a3CRja0
	/ypMLai1P37NVLDsWjsDO+owumwuLqdXIDm8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JV63BW3GzLfhUTuXoqgS0ygd2i4CaKHn
	NgNIllqYJ2xpAQ4egjapi8i+ydmTjM4pTzDuXHMJ/Q23J6FQqG2ws+urKKqcYpDc
	KS6fwV+7MxSM91G8bZjuab5C/l7wftdZM4e6QxnSkxoBpKDy5FCG5OpWPcSNbE6u
	0VvOrTo51Gk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 939FB455BC;
	Sun, 21 Feb 2016 18:31:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 462C3455BA;
	Sun, 21 Feb 2016 18:31:49 -0500 (EST)
In-Reply-To: <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 21 Feb 2016 16:01:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4781C888-D8F3-11E5-9EF5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286846>

Eric Sunshine <sunshine@sunshineco.com> writes:

> These tests all crash and burn with BSD sed (including Mac OS X) since
> you're not restricting yourself to BRE (basic regular expressions).
> You _could_ request extended regular expressions, which do work on
> those platforms, as well as with GNU sed:
>
>     sed -nEe "/^(author|summary) /p" ...

An obvious way to avoid any RE is to write it as two separate
statements.  As there are repeated invocations of this filtering
in this script, perhaps a helper function can hide this ugliness?
