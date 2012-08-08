From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/4] check-docs: get documented command list from
 Makefile
Date: Wed, 08 Aug 2012 14:35:38 -0700
Message-ID: <7vwr19qd79.fsf@alter.siamese.dyndns.org>
References: <20120808205456.GB29528@sigill.intra.peff.net>
 <20120808205752.GD12838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:35:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDut-0005LW-DK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 23:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab2HHVfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 17:35:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304Ab2HHVfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 17:35:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C23D76300;
	Wed,  8 Aug 2012 17:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TUKRh5lA/+TzlzhCatct4d0kZDQ=; b=nGnbV5
	QeOSXqbsgawcE37s8t+TSffD65khgZ12SbMY0kEhTagqf25rJR9MF8prEw4LOjEu
	SjQhooBgU1HGaS6pKtVWEuW5diC6jpZS/BW8MWhTgCyWsHxusP8sBcJmRIIFaGZ7
	9xY1MiRkdFb4nrlY6nEHh4ryVMd2iNDu172y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3mc+FSiidujUD9hh0AaLQyG+YV7sDp3
	TQe6B54pAnQwSUPJSVih4W3FIwOglIFWUKWahVRanmUKlbUZiHZXxPZKH77ZGU7d
	cgNb2efW83m66GsV71uuuWNgaNuEs81jbpBH7bzldGtaaW1fZcJBQYucpm66Jyek
	38ij0vcfXyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AECD362FF;
	Wed,  8 Aug 2012 17:35:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 115D962FE; Wed,  8 Aug 2012
 17:35:39 -0400 (EDT)
In-Reply-To: <20120808205752.GD12838@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 8 Aug 2012 16:57:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFD1E95C-E1A0-11E1-8B43-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203135>

Jeff King <peff@peff.net> writes:

> The current code tries to get a list of documented commands
> by doing "ls Documentation/git*txt" and culling a bunch of
> special cases from the result. Looking for "git-*.txt" would
> be more accurate, but would miss a few commands like
> "gitweb" and "gitk".
>
> Fortunately, Documentation/Makefile already knows what this
> list is, so we can just ask it. Annoyingly, we still have to
> post-process its output a little, since make will print
> extra cruft like "GIT-VERSION-FILE is up to date" to stdout.

Yeah, traditional way to do this is to give special markers around
what you want your Makefile to tell you, e.g.

	sayit:
        	echo "@@@ $(FOO) ###"
	useit:
        	$(MAKE) sayit | \
                sed -ne 's/^@@@ \(.*\) ###$/\1/p' | \
                ... use it ...

but in this case we know we want "*.txt", so the way you filtered
the output is sufficient.

> Now that our list is accurate, we can remove all of the ugly
> special-cases.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/Makefile |  3 +++
>  Makefile               | 26 ++------------------------

Yay, maintainability comes with a large line reduction bonus ;-)

Thanks.
