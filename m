From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 12:04:34 -0700
Message-ID: <xmqqlh4gf1vh.fsf@gitster.mtv.corp.google.com>
References: <20160414180709.28968-1-gitster@pobox.com>
	<20160414180709.28968-2-gitster@pobox.com>
	<20160414182102.GB22068@sigill.intra.peff.net>
	<xmqq1t68gi92.fsf@gitster.mtv.corp.google.com>
	<20160414182900.GD22068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:04:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqmZF-0002TS-VS
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 21:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbcDNTEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 15:04:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755830AbcDNTEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 15:04:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0D8213D24;
	Thu, 14 Apr 2016 15:04:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nrxLipU/JgU6LF8Uq/N4mnvX0F0=; b=VUvZk/
	26pfKxNn3Yz8vfj+b76NpYgkeGawcEoB71bByki/9YsuDHBFb5oZ1zMAWSxk+NY1
	/yo0a418KqSKAfMXMcxQGRKWxdobm7tkDGbr0212swb8Tc0IRlzxKoIxaKAxf3ku
	L0ZZKqtBZVjT1aWMQZFR4uHoDjB2Q6djysfSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xR+XssYWDHkqwISqMn5re3O8A0yZAIUQ
	CpLTFiYNLISpEEZSZ6J3Mqx8+a1Ml7u6GBxMc4gnLn8qwJE/BcnFfOhJ768NsX5K
	hP6wSF2p+cwXbYzZXolaZQ6cyxlLfbNti/v0T1qyQiPNfc1cMfa74YB8c4t5GgMA
	XcE5Yf0RkCc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C830013D23;
	Thu, 14 Apr 2016 15:04:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BE5413D22;
	Thu, 14 Apr 2016 15:04:35 -0400 (EDT)
In-Reply-To: <20160414182900.GD22068@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2016 14:29:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA5DB61A-0273-11E6-96D6-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291557>

Jeff King <peff@peff.net> writes:

> But I do agree in general that we should be checking as many things as
> we can.

I was about to say "I agree with that in principle, but there are
cases where you would want to say 'if the object does not pass even
this basic check, it is not worth validating it further', and
verify-headers may fall into that category".  That's another way of
saying that something that we cannot even parse into constituent
fields we cannot check the validity of each field for the semantics.

However, with the current "violations of various classes can be
configured out" way of doing things, that is a difficult stance to
take.  If you choose to accept syntax violation that makes us unable
to parse, you must accept warnings and errors coming from "missing"
fields due to our inability to parse and your telling us to proceed
anyway.

So in the end, I do agree that we should be checking as many things
as we can.
