From: Junio C Hamano <gitster@pobox.com>
Subject: Re: email address handling
Date: Fri, 01 Aug 2008 14:50:05 -0700
Message-ID: <7vvdykqub6.fsf@gitster.siamese.dyndns.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
 <20080801124550.26b9efc0.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
 <20080801132415.0b0314e4.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2Ws-0004xd-1q
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 23:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbYHAVuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754348AbYHAVuO
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:50:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbYHAVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 17:50:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 347D846B11;
	Fri,  1 Aug 2008 17:50:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F4A246B0E; Fri,  1 Aug 2008 17:50:06 -0400 (EDT)
In-Reply-To: <20080801135421.5ca0f6af.akpm@linux-foundation.org> (Andrew
 Morton's message of "Fri, 1 Aug 2008 13:54:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0A3D932-6013-11DD-BE0B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91103>

Andrew Morton <akpm@linux-foundation.org> writes:

>> The part _you_ don't seem to understand is that my point is
>> 
>>  - git changed that "From:" line to an "Author:" line
>> 
>>  - "git log" isn't an email system. It's a human-readable (and 
>>    machine-parseable, for that matter) log.
>
> What you're describing here is some explicit or implicit git design
> decision and then telling me how it's implemented.
>
> Well, what I'm saying is that it was an incorrect design decision.

What is the objective of your statement in this discussion?  Further add
fuel to flame, or to seek avenues that lead to some improvement in a
constructive way?

The thing is, I do not think reverting that design decision is an option
at this point.  People's repositories record <Name, Email> pair already in
"human readable" form, and people's scripts are assuming that.

I misspoke about git-send-email earlier; it already has sanitize_address()
that massages the addresses on From: To: and Cc: lines.  In fact, it even
seems to have logic to avoid double-quoting, so it would be Ok if you
changed the design decision this late in the game for that particular
script, but that does not mean it is a good change --- other scripts
people may have built around git would need to change.

So the earlier patch from Dscho (Johannes) may be a step in the right
direction, but if we are going to rewrite the author information, (1) it
has to be an option, and (2) when rewriting, it should not be just From:;
but Signed-off-by:, Cc: and other <Name, Email> pairs at the end of the
log message would need similar treatment, so that you can cut and paste
any of them to your MUA.
