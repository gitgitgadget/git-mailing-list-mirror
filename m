From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 04 Feb 2008 23:14:50 -0800
Message-ID: <7vir13g9hx.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
	<7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
	<alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 08:15:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMI1k-0006Zo-IQ
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 08:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbYBEHPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 02:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbYBEHPB
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 02:15:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbYBEHPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 02:15:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C99C82E9C;
	Tue,  5 Feb 2008 02:14:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 277E82E9B;
	Tue,  5 Feb 2008 02:14:53 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 4 Feb 2008 12:50:03 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72630>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 4 Feb 2008, Linus Torvalds wrote:
>> 
>> Gaah. This is that stupid apporach.
>
> .. and it won't actually solve the problem you pointed to. It's not enough 
> that the positive commits should be connected to the negative ones, the 
> problem is that no negative ones could possibly connect to the positives. 
>
> So scratch that patch as broken too. 
>
> Really annoying. It does look like we really want to check the *totally* 
> connected case, and we simply cannot do the "two unconnected trees" 
> decision case without traversing both trees fully (since we won't know 
> that they are *really* unconnected until we do).
>
> And that seems really quite expensive. I wonder if I've missed something 
> again.

I tend to agree.  In a totally connected history, the upper
bound we would need to traverse is down to the merge base of
still positive commits in the "newlist" and negative ones still
on the "list" when everybody on list becomes uninteresting.  And
if there are two unrelated histories, that traversal will need
to traverse down to respective roots.

Which sucks.
