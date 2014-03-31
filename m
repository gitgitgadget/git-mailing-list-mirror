From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: Git 1.8 on Ubuntu 13.10 refs not valid
Date: Mon, 31 Mar 2014 11:27:53 -0700
Message-ID: <xmqqbnwm6x5i.fsf@gitster.dls.corp.google.com>
References: <5334398E.8090402@gmail.com>
	<20140327184916.GA28668@sigill.intra.peff.net>
	<5339A38D.1080504@gmail.com>
	<20140331180118.GA31023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siggi <siggin@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:28:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgwI-0001pB-Da
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbaCaS17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:27:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273AbaCaS14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:27:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A10B77D43;
	Mon, 31 Mar 2014 14:27:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hladxi9xbnhfJPtnYDGVeWCrmbs=; b=len23f
	mN+tgwcsrMP5xQHSxrtLoBI4ekGFGpmkyQyZrGKgIAaEWqD0vC+dsAOPBWhjUdxS
	rG0vMKlUyH7/c8Lfd2QFQ5JLCQbt4khqw7nVjDjoiGjUoFPhfb9UeIwBBwVbm+cm
	MK72UIXe638opRdpe1zNtnUrv3RLW57qaSLW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJ2bSKFhvVdezdHbrAALLWyiY/XueB5O
	FOoMQ6cZNouabp5ONgMXapBXJMPEk7L+RT384QLkMXpHmXp3JTOhBu3N/JOTyk2e
	xqBswTikCfPrPPyWDm8FYZ//SSs0k9fryETC8AM8uL9m8wmxWeecAxnwhR89wx7w
	a61NQh9fEBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3455777D42;
	Mon, 31 Mar 2014 14:27:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9907277D41;
	Mon, 31 Mar 2014 14:27:55 -0400 (EDT)
In-Reply-To: <20140331180118.GA31023@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 31 Mar 2014 14:01:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D8A1650-B902-11E3-B709-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245504>

Jeff King <peff@peff.net> writes:

> That being said, git _could_ be more liberal in accepting a content-type
> with parameters (even though it does not know about any parameters, and
> charset here is completely meaningless). I have mixed feelings on that.

It may be just a matter of replacing strbuf_cmp() with "the initial
part must be this string" followed by "it could have an optional
whitespaces and semicolon after that", but I share the mixed
feelings.

I am not sure if it is a right thing to follow "be liberal to
accept" dictum in this case.  It may be liberal in accepting
blindly, but if the other end is asking a behaviour that is not
standard (but perhaps in future versions of Git such an enhanced
service may be implemented by the client), by ignoring the parameter
we do not even know about how to handle, we would be giving surprises
to the overall protocol exchange.
