From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 04 Feb 2013 08:46:29 -0800
Message-ID: <7vboc03u3e.fsf@alter.siamese.dyndns.org>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net>
 <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
 <20130204093821.GA32095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jongman.heo@samsung.com, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PC3-0004aJ-2h
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab3BDQqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:46:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348Ab3BDQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:46:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90AFFCE76;
	Mon,  4 Feb 2013 11:46:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vmQrkfM7o9cEbPL44xJppC2A3yw=; b=HnAIJG
	xFduqbtk/mwvy0WRiwkBNjer39m3KqEAjsQ9mptH99eRiFmz3YUjq0B4//fQka1C
	YDVrqt0WCvWN1f0qFxrZNlHH0IyBgR95QkPnZ6ng7maUG1K1QzKlB4cYzbY3CGnu
	E00cXxTZCGpcScsdSZWQ0lBPQigiqjMHcYNmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tc0KGTrihbH7RsErHl7Ux6S6MjgOAiUg
	YfUCxFh1Obktb0hg5I0OUDSf2FOZs9dLetP5jiLCqH51ChP0n0hdrTHkcV5N19Jz
	QIw8VWWpehdQr/oWJDN34V+tOoFBz0xg2IMU1IyhjALbggOeJVgSSIkKizQ1uuSC
	dk/m0d8s47M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EFCCE74;
	Mon,  4 Feb 2013 11:46:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0ADDCE6A; Mon,  4 Feb 2013
 11:46:30 -0500 (EST)
In-Reply-To: <20130204093821.GA32095@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 4 Feb 2013 04:38:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D471B02-6EEA-11E2-9599-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215393>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 04, 2013 at 01:16:08AM -0800, Junio C Hamano wrote:
>
>> I think this really boils down to where we draw the "this is good
>> enough" line.  I am not sure if losing the file as in $gmane/215211
>> is common enough to be special cased to buy us much, while leaving
>> other ".depend/foo.o.d was updated to contain a wrong info" cases
>> still broken.
>
> Hmm. Yeah, I was thinking it might be more common than ordinary munging
> due to something like an interrupted "git clean -x". But given that:
>
>   1. As far as I can tell, it is not a situation that can happen through
>      regular use of checkout/make/etc, and...
>
>   2. We have zero reports of it happening in practice (I only discovered
>      it while explicitly trying to break the Makefile), and...
>
>   3. It is just one of many possible breakages, all of which can be
>      fixed by "git clean -dx" if you suspect issues...
>
> let's just leave it. Thanks for a sanity check.

The only case that worries me is when make or cc gets interrupted.
As long as make removes the ultimate target *.o in such a case, it
is fine to leave a half-written .depend/foo.o.d (or getting it
removed) behind.

How expensive to generate the dependency for a single foo.c file
into a temporary without compiling it into foo.o, and comparing the
resulting dependency with existing .depend/foo.o.d?  If it is very
cheap, it might be worth doing it before linking the final build
product and error the build out when we see discrepancies.  I dunno.
