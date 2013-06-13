From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/checkout-last: checkout - doesn't work after rebase
Date: Thu, 13 Jun 2013 13:38:50 -0700
Message-ID: <7vhah1u4o5.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-2-git-send-email-artagnon@gmail.com>
	<7vfvwlvr7e.fsf@alter.siamese.dyndns.org>
	<CALkWK0nH5Qjc-PNNH0cAhsgZje7VzuLGqXZwjRQESOxLt-T78g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 22:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnEIM-0005Sx-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 22:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193Ab3FMUiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 16:38:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757770Ab3FMUix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 16:38:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B82C527646;
	Thu, 13 Jun 2013 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FfTCmpsiB10XZZHDxs+jPt9oPQ4=; b=CoWJot
	bmDA9Xkvoy63WFnhdhEEWTzpJrvBb+heWVPo1xDez0yWxehVwuL81ekPbD2ahjxj
	nEHfDlKZYIspahMjegiz71u411lhw0uOZcFOfOXhGxbF3uaQPUkKx3mtCEHuOkd5
	HMoQ0WT+/rjzgmwQHwK0XFdMNKlSwqbDGRiQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LlsFH9bWOdAuMdG/LBqEALCn2UhEhTlZ
	ae41H5yOpdDtzfKR53ui/DaiRIRH2Ob/fJvc9DfAAQ1Nj64PAJqt+NleGYrt4xrT
	3G0DNZjS0lZ2hgjvEDxX3p4c3BGlAWaLyyAyEF5pfDUSTVAKRJwJQCO5Bk3uSuTg
	Cm3nZ1V/LMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB9FE27645;
	Thu, 13 Jun 2013 20:38:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1201327642;
	Thu, 13 Jun 2013 20:38:51 +0000 (UTC)
In-Reply-To: <CALkWK0nH5Qjc-PNNH0cAhsgZje7VzuLGqXZwjRQESOxLt-T78g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 00:00:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4223B324-D469-11E2-9B87-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227775>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Why two?
>
> What breaks checkout - is the initial HEAD detachment (which writes
> that "checkout: " message), before anything else happens.  None of
> <onto>, <upstream>, and <branch> make any difference: I'm testing
> exactly the code that I patched.
>
> I have recently been told that I should be testing "end-user behavior"
> by treating the programs as black-boxes, instead of "implementation".
> What is your opinion on the issue?  Should I write more tests?

Of course, the behaviours that should be observable by end-users
need be spelled out.  Also, an impementation detail that cannot be
observed or make any difference to the end-user experience should
not be cast in stone.

The guideline is a good one, but you need to realize that there is a
difference between "do not test implementation details" and "do not
look at implementation when designing tests".  Only the former is
necessary and correct: it lets you avoid over-specifying the
behaviour.

Sometimes you can trivially tell that some obvious implementations
that may be different from what you have can break the expectation
you are setting.  For example, in v1.5.0, "rebase A B" literally ran
"git-checkout B" as the first thing, and if you want the end-user to
expect that @{-$n} does not resolve to B because such internal
"checkout" is not an user action, covering "rebase A B", even if you
know that the current implemention happens to be immune to such a
form of breakage, would be a good way to future-proof your code.

That still is testing the behaviour.  You are just taking advantage
of the fact that you know the implementation and can anticipate how
future changes by careless people could break the behaviour.
