From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 15:50:43 -0800
Message-ID: <7vsl0gkx7w.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
	<20080128055933.GA13521@coredump.intra.peff.net>
	<alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
	<20080129222007.GA3985@coredump.intra.peff.net>
	<7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
	<7vwspskynz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 00:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK0Eu-0007kc-ES
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 00:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYA2XvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 18:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbYA2XvI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 18:51:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYA2XvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 18:51:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC1A267E;
	Tue, 29 Jan 2008 18:51:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CE642669;
	Tue, 29 Jan 2008 18:50:54 -0500 (EST)
In-Reply-To: <7vwspskynz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 29 Jan 2008 15:19:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72016>

Junio C Hamano <gitster@pobox.com> writes:

> This instead allocates and keeps only M records in core.  For
> each dst, we compute similarlity with all sources (so the number
> of similarity estimate computations we do is still N x M), but
> we keep the best src for each dst.  This is essentially to save
> memory drastically by giving up to come up with better pairing.
>
> I guess we could keep a handful best candidates per dst, instead
> of just one, to further improve on this approach, and such a
> change should be fairly straightforward.

An obvious side note to this patch is that if we are going to
limit us to only 1 source candidate per destination, we do not
even have to allocate.  We can just do similarity one-by-one for
each destination, and pair up with the best source as we go.

I did not code it that way, primarily because that would
permanently close the door to extend it back to keep multiple
candidates per dst, so that later ones that gets processed can
notice what happened to earlier ones.
