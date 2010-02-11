From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Thu, 11 Feb 2010 15:23:09 -0800
Message-ID: <7vwryjpdb6.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net> <7vmxzj8hca.fsf@alter.siamese.dyndns.org> <20100210054957.GG28526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfiNk-0006gy-MP
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab0BKXXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 18:23:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab0BKXXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 18:23:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A80ED994BC;
	Thu, 11 Feb 2010 18:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=puDS6nf3+nV7UKDQ12/MuimRD4A=; b=FDQfMsGEUZ+pJ2X6B0vb5tU
	ci0+2yBNCjEGTITchT+WyzC+ryoriOelJM85rM3eWYqxKIsXkcNJDPlIFChtkjUa
	NlA0BeMFe7FJ5Y5exgBpKr4DonuEHu2qSA2yMPvXWLK2l3uf+VY3/p9DtW01lI9t
	ErBcVYQwXr6wzQNJA4sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EUL+hgh31EteiJGY83xHvXPzPwQR9EqK/hph/VIQz8JcyAtae
	abfnyLA5a4wLybP38PC13TkfVblEhT7f3GLtg23Oqi+ygQlm3eUm70N+FoiGtpC7
	P6k72o5QSyrh43soXz86i5q+hfZiaWz9DqbquUGPTeL/b8Kp4hHxHJ/X6s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 752D5994BB;
	Thu, 11 Feb 2010 18:23:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94622994B6; Thu, 11 Feb
 2010 18:23:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D6D828C-1764-11DF-8639-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139643>

Jeff King <peff@peff.net> writes:

> Would it make sense to clear _all_ advice if we are just in porcelain
> mode for git-push? That is, let's say I am in "push --porcelain" and I
> try to write a reflog entry for a local tracking ref, but my identity is
> implicitly picked up from the hostname[1]. Should it trigger
> advice_implicit_identity and say "by the way, your identity is implicit"
> on stderr or not?
>
> I would say yes. The advice output should all be on stderr, and the
> porcelain output should all be on stdout. So there is no parsing
> conflict. And stderr either goes to /dev/null (because the porcelain is
> not terminal-based, or doesn't want the terminal screwed up), in which
> case the advice does nothing, or stderr goes to the terminal (because
> the porcelain is some simple script), in which case the message is
> probably something the user would want to see.

Hmm, if we make it a rule to send all the advice messages to the standard
error stream, wouldn't the logical conclusion be that the hunk you are
commenting is unnecessary?  "push --porcelain" should give advice just as
usual (but we would simply send the advice to the standard error stream).
