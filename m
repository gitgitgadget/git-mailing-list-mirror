From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cleanup argument passing in submodule status command
Date: Sun, 29 Jul 2012 14:57:40 -0700
Message-ID: <7vk3xmut63.fsf@alter.siamese.dyndns.org>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
 <20120728102209.GA13370@book.hvoigt.net>
 <20120728121956.GA36429@book.hvoigt.net>
 <7vtxwrw0g0.fsf@alter.siamese.dyndns.org> <501556CF.1000605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Stefan Zager <szager@google.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:57:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvbUi-0006Ij-Nj
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab2G2V5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 17:57:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690Ab2G2V5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 17:57:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7B9E8F72;
	Sun, 29 Jul 2012 17:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hxD03udd5oxKoNAoPuuJCK4adDo=; b=Ipdwod
	xVTuAz7OwJowtkJjMKazjSJM4zEOLG3TA+Kku2JNRdCw7dCZ06LOJ+vQqXhIQ/72
	XCyGifnNMYKDyjFYLmK6o7Ne3VRN5O6k2LKGmBATR0Q115/xwSzN3ONJiw+pEzI1
	AZek4ndNmcFwybWgdNQiU/nD+SjkIFqq5YBKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WyKVJP4njtEN0MkT9SOebzYdkwQSI9Qj
	8J6YXp6VvxwfpNSUl7pah9UNyWRefu3q3EwybUffZ2XpNhrXhI5L/t7IRKHTMxI5
	kdEBqxK2FM32NColzVePEhcctH5Ir8SDAe0lHXQUzJxGM23EK1CvCENMr6GmHDx3
	gneX81l7JXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D668F6D;
	Sun, 29 Jul 2012 17:57:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 097168F6C; Sun, 29 Jul 2012
 17:57:41 -0400 (EDT)
In-Reply-To: <501556CF.1000605@web.de> (Jens Lehmann's message of "Sun, 29
 Jul 2012 17:29:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BA4B712-D9C8-11E1-B4FB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202502>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I tried today. Before this change no arguments got passed down and
> afterwards they are (but just the arguments, no submodule paths
> were passed on in either case; which is what Kevin fixed in the
> commit Heiko referenced). Three arguments are allowed for "git
> submodule status":
>
> --recursive:
> It doesn't matter if we pass that on or not because $recursive is
> reused when "eval cmd_status" is executed.
>
> --quiet:
> Same as recursive, GIT_QUIET is set the first time and then reused
> in the recursion.
>
> --cached:
> This was dropped when recursing into submodules but isn't anymore
> with Heiko's change, so we do have a change in behavior here.
> ...
> Hmm, when --cached is used together with --recursive, I would expect
> it to show the commit stored in the index for the deeper submodules
> too (and not magically switch to show their HEAD again after the
> first level of submodules). To me this looks like a bug which Kevin
> accidentally introduced and nobody noticed and/or reported until now.
>
> So I'd vote for making this a bugfix patch for "git submodule status
> --cached --recursive" (and would love to see a test for it ;-).

Yeah, I am not opposed to a "fix".  I just wanted it to be labelled
as such, and analysed correctly.

And with test ;-)

Thanks.
