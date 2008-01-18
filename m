From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 18:25:50 -0800
Message-ID: <7v1w8fkgy9.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org>
	<7vodblpmyc.fsf@gitster.siamese.dyndns.org>
	<20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net>
	<20080117110132.GB12285@hashpling.org>
	<478F4CDC.2090703@viscovery.net>
	<7vbq7jkixg.fsf@gitster.siamese.dyndns.org>
	<7v63xrki29.fsf@gitster.siamese.dyndns.org>
	<20080118021300.GR24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:26:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFgwM-0007lL-PF
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbYARC0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757755AbYARC0N
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:26:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584AbYARC0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:26:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E96F3A74;
	Thu, 17 Jan 2008 21:26:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C5A00382E;
	Thu, 17 Jan 2008 21:26:02 -0500 (EST)
In-Reply-To: <20080118021300.GR24004@spearce.org> (Shawn O. Pearce's message
	of "Thu, 17 Jan 2008 21:13:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70951>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I think the problem is nobody has tested fast-import updating an
> existing ref while using NO_MMAP.  Or if they did, they didn't report
> the problem as they didn't figure they needed fast-import that badly.
>
> Updating an existing ref is not a common operation, but the test
> suite does test for it.  So it must be the NO_MMAP configuration
> is simply not being tested well enough.

Ok, thanks.

Now a more important question is how we would properly fix this
issue?

I suspect that fast-import is the only one that opens windows
into an unfinalized pack, and if that is the case, it would be
the only program that may be hit by the issue of mmap emulation
getting stale data.

I do not think the patch I posted was correct at all.

Especially, I am not sure if the issue only exists at the
end_packfile() boundary.  Don't we have the same issue reading
from the packfile being built, and isn't the only reason my hack
works it around is because access patterns of the testsuite
happens to not trigger it?
