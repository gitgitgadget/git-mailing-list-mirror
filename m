From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sun, 03 Feb 2008 00:18:06 -0800
Message-ID: <7vir16xxkx.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<7vr6fuzgq1.fsf@gitster.siamese.dyndns.org>
	<20080203071318.GA13849@coredump.intra.peff.net>
	<20080203071833.GA16273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 09:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLa49-0007Gg-PX
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 09:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbYBCISU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 03:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756075AbYBCISU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 03:18:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbYBCIST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 03:18:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0534E56CC;
	Sun,  3 Feb 2008 03:18:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 824D356C9;
	Sun,  3 Feb 2008 03:18:13 -0500 (EST)
In-Reply-To: <20080203071833.GA16273@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 3 Feb 2008 02:18:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72338>

Jeff King <peff@peff.net> writes:

> There is probably a performance impact since we will end up traversing
> the whole commit chain just to mark them all uninteresting.

Yes.  "tip..initial" obviously need to traverse almost all
history to find out that the initial is reachable from tip, but
there is no avoiding that.

However, a typical usage is "old..new" and old and new are both
far from the initial commit, and forcing traversal down to the
initial commit in such a usual case is unacceptable.

I think we only need to traverse down to their merge bases to
prove that new cannot be reachable from old, and we can find out
all of their merge bases without traversing down to root.
