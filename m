From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 05 Feb 2008 21:30:38 -0800
Message-ID: <7vwspi4poh.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
	<7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
	<alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
	<7vir13g9hx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
	<7vprvb6k9u.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802051648410.2967@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 06:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMcsW-0004iy-CX
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 06:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYBFFaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 00:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbYBFFaw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 00:30:52 -0500
Received: from rune.pobox.com ([208.210.124.79]:53186 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbYBFFav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 00:30:51 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 13039193FFB;
	Wed,  6 Feb 2008 00:31:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 53224193C97;
	Wed,  6 Feb 2008 00:31:06 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802051648410.2967@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 5 Feb 2008 16:52:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72756>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But the revision.c change might be worth it, if only as a slight band-aid 
> for the current issue. It won't fix the original problem, though (because 
> that broken repo had a five *year* clock skew, not an hour :)
>
> I'll continue to think about whether I can come up with some sane 
> heuristic that allows non-broken cases to not go all the way up to the 
> root.

I really wish this was still May 2005.  Then I (actually, you)
could just decree:

	Sorry guys, but you all need to run convert-objects to
	update your repo.  What it does is to add a "generation"
	header to each and every commit object.  Then upgrade
	your git to this version, that maintains the
	"generation" number, defined as:

        (1) parentless commit gets generation #0;

        (2) otherwise the generation number of a commit is
	    max(its parents' generation number)+1.
