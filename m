From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 01 Jun 2016 09:57:06 -0700
Message-ID: <xmqqfuswzw2l.fsf@gitster.mtv.corp.google.com>
References: <20160531225628.GA4585@sigill.intra.peff.net>
	<CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
	<20160601023159.GA5411@sigill.intra.peff.net>
	<20160601033139.GB5411@sigill.intra.peff.net>
	<20160601034413.GC5411@sigill.intra.peff.net>
	<20160601053325.GA20797@sigill.intra.peff.net>
	<20160601054048.GB20797@sigill.intra.peff.net>
	<xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
	<20160601070425.GA13648@sigill.intra.peff.net>
	<xmqqfusx0wyj.fsf@gitster.mtv.corp.google.com>
	<20160601160735.GB9219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89SG-0005kq-9c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbcFAQ5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:57:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751951AbcFAQ5K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:57:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03B9821F68;
	Wed,  1 Jun 2016 12:57:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qy2xfwTU4x9WJfMRJodRqh7S3ZE=; b=itYqTu
	937EhHl3ceLwAI2j4FhcDABsSPpJm5XawKzcpJNcTOlm+CjF/so6RGngCFfSwNsF
	nmKalFLY+ek+Pr5CGkDSRj3V/nBpN+3QjskKKU8CdNpRndsD3HQ+9f1VV9hGiE1b
	e87jSAX/fgtq0smqN7DloV+mPoDKh5L6N32pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgl4SZ8pWRUVhlcVPzxKY0A5RECQmzz9
	7dvjBFC/lHA0xe10oyuWqJVICMonY8BKN85tmAz085khd1CUiICQeeWd0ufNhtG6
	Jds2YvdSJLqgMbwBijXDof4v727FwtGTsMuOb3ErHtbTeHda87FufxCYvPfBPwpl
	k+NuwQ/kmIk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDD5021F67;
	Wed,  1 Jun 2016 12:57:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7166021F66;
	Wed,  1 Jun 2016 12:57:08 -0400 (EDT)
In-Reply-To: <20160601160735.GB9219@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jun 2016 12:07:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E05B200C-2819-11E6-8239-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296134>

Jeff King <peff@peff.net> writes:

> Maybe:
>
>     We sometimes get around this by using env, like:
>
>       test_must_fail env FOO=BAR some-program
>
>     But that works for test_must_fail because it further runs its
>     arguments via the shell, so we can stick the "env" on the right-hand
>     side of the function. It would not work to do:
>
>       env FOO=BAR test_must_fail some-program
>
>     because env does not know about our shell functions...
>
> is more clear?

I don't know.  What I wanted to say was that "test_must_fail env"
pattern works _only_ when some-program is not a shell function, even
though "test_must_fail some-program" itself without env is OK when
some-program is a shell function.
