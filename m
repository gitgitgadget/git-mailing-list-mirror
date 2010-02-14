From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] for-each-ref --format='%(symref) %(symref:short)'
Date: Sun, 14 Feb 2010 02:32:29 -0800
Message-ID: <7vy6iwp0oy.fsf@alter.siamese.dyndns.org>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
 <1266093033-9526-4-git-send-email-gitster@pobox.com>
 <20100214063243.GA20630@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 11:35:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngboc-0006Nl-Kj
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 11:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab0BNKci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 05:32:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0BNKch (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 05:32:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8CF599B97;
	Sun, 14 Feb 2010 05:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I8NIfk4j7k1lnY1X0CtTF7vHxOs=; b=bCuxAy
	ZpTLpGTQ3Sd4ko+9ulla6UiquGnIQfH2+9B9zwNFrkp4XZJfqn7L7tPze36BBRRk
	mJdCNRQkKPnbMGE0JYANGl0DuitqMb1N2Ur2nwtuboWv3lAZOrUPo98KRXc89fGj
	yVykaG2vqx3UwysRMgml4JaNSNoEtQ95LF1j0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tXmjOfCe9X+W7GcRobCzGU8oRe5iDVyN
	+/zPxynhrpKzy74QRa6kt5u8+4TYiXGFMgEpy63GnjrRllNr4JAApQa9dkVpdWFR
	9ZAc5qOQ4iNe2DCXaFV1vmj0gAdqfdG74C3BfgcXnqZxalT343HXa6klujI4fIx6
	sYWIZNgqYYI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F00E99B96;
	Sun, 14 Feb 2010 05:32:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5C2299B91; Sun, 14 Feb
 2010 05:32:30 -0500 (EST)
In-Reply-To: <20100214063243.GA20630@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 14 Feb 2010 01\:32\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42E80842-1954-11DF-A907-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139894>

Jeff King <peff@peff.net> writes:

> It feels ugly that we need to re-resolve the ref when we simply threw
> that information away earlier from when we called resolve_ref in
> get_ref_dir...

It is true and I indeed thought about it while doing the patch, but "how
often would we see symref in the entire refs list, and what percentage of
callers would benefit from seeing this information?" stopped me from going
further in that direction.

> ...
> If we were going to do this for real, I would be tempted to actually
> change the signature of each_ref_fn to take a struct so this doesn't
> come up again.

That would actually be sensible.  Adding symref parameter all over just so
that we do not have to re-resolve symbolic refs in a few codepaths feels
like a "it would have been nicer if things were that way from day one, but
how much does that churn really buys us now" kind of change, but carrying
the full information around in the internal API is a "right thing to do".
