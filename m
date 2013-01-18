From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Thu, 17 Jan 2013 20:36:17 -0800
Message-ID: <7vfw1zrttq.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
 <7vobgpxeel.fsf@alter.siamese.dyndns.org>
 <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
 <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
 <20130118010638.GA29453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw3h4-0000De-2h
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 05:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab3AREgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 23:36:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab3AREgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 23:36:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 647D7A9DE;
	Thu, 17 Jan 2013 23:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cgG9s+Hg/sJdxusZ3W8ygkv+e1Q=; b=ilOnyPGHg2VI/y4TK4Dz
	LIfmCpL29pl4TrDXVeu+UekLbrCbudOCANxHedzBR8psOmEZ47wOdduSPLX0Fqu/
	XK/NezYHBq712VW5EenFYpu8mlKn5fMs2RKIUddQOMvYurdrfd/oMk/WtuLygFnr
	VkCAUtvEvs6sEQ/lKCEscyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qTzRt8N7MIhpFNt+h/0NK0uKyvzBzmrbfG+dQ/5dqZBWwH
	V5U6HSjTxu7HwAE8981xiIf2SnrIKS9lkR2A72SFcDpOILAqLl3koKzXzlYzwA7W
	LjNibwq550p+lUm+hiEITmllWldMXrL3yE2PPzDDw+KdPXdv82viOtoiuYYNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58411A9DC;
	Thu, 17 Jan 2013 23:36:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCB06A9DB; Thu, 17 Jan 2013
 23:36:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A331884-6128-11E2-8FBE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213901>

Jeff King <peff@peff.net> writes:

> However, if instead of the rule being "blobs on the remote side
> cannot be replaced", if it becomes "the old value on the remote
> side must be referenced by what we replace it with", that _is_
> something we can calculate reliably on the sending side.  And that
> is logically an extension of the fast-forward rule,...

It may be an extension of the fast-forward, but only in the graph
reachability sense.  I can buy that it is mathmatically consistent
with the mode that has proven to be useful for commits at the branch
tips, which we know why "fast-forward" rule is an appropriate
default for.  You haven't shown if that mathmatical consistency is
useful for non-commit case.


The primary reason "fast-forward" is a good default for branches is
not that "we do not want to lose objects to gc" (you have reflog for
that).  The reason is non fast-forward is a sign of unintended
rewind, and later will cause duplicated history with merge
conflicts.

That comes from the way objects pointed by refs/heads aka branches
are used.  It is not just "commit" (as object type), but how these
objects are used.  Think why we decided it was a good idea to do one
thing in the topic that introduced the regression under discussion:
"Even if the new commit is a descendant of the old commit, we do not
want to fast-forward a ref if it is under refs/tags/".  Type of object
may be one factor, but how it is used is more important factor in
deciding what kind of policy is appropriate.

If users have workflows that want to have a ref hierarchy that point
at a blob, there will not be any update to such a ref that will
satisfy your definition of "extended" fast-forward requirement, and
that requirement came solely from mathematical purity (i.e. graph
reachability), not from any workflow consideration.  That is very
disturbing to me.

A workflow that employes such a "blob at a ref" may perfectly be
happy with replacing the blob as last-one-wins basis. I do not think
the client side should enforce a policy to forbid such a push.

I personally think the current client side that insists that updates
to any ref has to have the current object and must fast-forward and
requires --force otherwise was a mistake (this predates the change
by Chris).  The receiving end does not implement such an arbitrary
restriction outside refs/heads/, and does so only for refs/heads/
only when deny-non-fast-forwards is set.
