From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANN] git-tbdiff: topic branch diff
Date: Sat, 11 May 2013 12:01:07 -0700
Message-ID: <7vsj1twdcc.fsf@alter.siamese.dyndns.org>
References: <87ip2pfs19.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 11 21:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbF2t-0002lq-8N
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 21:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3EKTBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 15:01:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3EKTBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 15:01:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA8771E556;
	Sat, 11 May 2013 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wbuEEZ+6tk6mo6ib5OGdns4zCPQ=; b=yX/sW4
	8xwUmEk/nzrWExM6BnmdRF/2CG6tdp24IoGB+xylcLG2q8SVNTGf6yB84DnIfQbJ
	zrBhIjAJ3Dr0lOs/Pzvc8bRqhaztHifA37Nb0XIdDRJh8itG3IBfS9O+GODGVZ4D
	6RwxnUucKcywDAFcCEeNLtpaakSd77Xzpxjds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AfyRaoTd543+qXtu8UnOEOmq3N8Lqgdi
	YpinmmF6u7exCQNj8lAOF/oCADbk+dYRIGRTtiEkeObPbUf4hHuXlNj3e7aIfkiX
	ZzBnvRLUmaDXgTW2qdcwCqGMDVg/W24amHsb9s+NnTCULVO75/3FfR0cbeD0QXLB
	TNlSpYqqxZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A094B1E555;
	Sat, 11 May 2013 19:01:09 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E72A1E554;
	Sat, 11 May 2013 19:01:08 +0000 (UTC)
In-Reply-To: <87ip2pfs19.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 11 May 2013 17:35:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23E0F630-BA6D-11E2-B9BD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224002>

Thomas Rast <trast@inf.ethz.ch> writes:

> In this case the matching up is trivial, but you can see that it clearly
> shows the added Signoffs and edited parts of message and patch.
>
> Have fun, and let me know if it breaks!

Nice.

I need to do this kind of comparison quite often, when a rerolled
series is received.  Since there is no reason to re_base_ the series
with with an updated one on a different fork-point, I tend to do:

	$ git checkout master...tr/topic
        $ git am -s3c ./+tr-topic-2.mbox
	... inspect the differences between tr/topic and HEAD ...
        $ git branch -f tr/topic

where the first step finds the bottom boundary of the previous
iteration and detaches the HEAD at the commit, the second step
applies the rerolled series and the topic branch is updated in
the final step.

The "inspect the differences" step can be helped if I can use this
tool to say

	$ git tbdiff master..tr/topic master..HEAD

It would probably be trivial to extend the command line parser to
also accept

	$ git tbdiff tr/topic...

but that is an icing on the cake.
