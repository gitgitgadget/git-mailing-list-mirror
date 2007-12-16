From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Sun, 16 Dec 2007 14:23:27 -0800
Message-ID: <7vtzmii8io.fsf@gitster.siamese.dyndns.org>
References: <20071215111621.GA8139@coredump.intra.peff.net>
	<20071215155150.GA24810@coredump.intra.peff.net>
	<7vprx7n90t.fsf@gitster.siamese.dyndns.org>
	<20071215200202.GA3334@sigill.intra.peff.net>
	<20071216070614.GA5072@sigill.intra.peff.net>
	<7v8x3ul927.fsf@gitster.siamese.dyndns.org>
	<7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
	<20071216212104.GA32307@coredump.intra.peff.net>
	<7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
	<20071216221545.GA32596@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 16 23:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J41u6-0006io-Cj
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 23:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910AbXLPWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758213AbXLPWXr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 17:23:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013AbXLPWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 17:23:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E89A65716;
	Sun, 16 Dec 2007 17:23:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 586005715;
	Sun, 16 Dec 2007 17:23:34 -0500 (EST)
In-Reply-To: <20071216221545.GA32596@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 16 Dec 2007 17:15:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68496>

Jeff King <peff@peff.net> writes:

> This would probably work better as 'cat'.

Yeah, I amended it without adding another "re-" to the title ;-)  The
result has been already pushed out.

>> +test_expect_success 'diff -U0' '
>> +
>> +	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
>> +	diff -u expect actual
>
> Aren't we using "git diff" for the second diff there nowadays?

Some people seem to think that is a good idea, but I generally do not
like using "git diff" between expect and actual (both untracked) inside
tests.  The last "diff" is about validating what git does and using "git
diff" there would make the test meaningless when "git diff" itself is
broken.

This is especially so because comparison between untracked files is a
bolted-on afterthought and I am least confident about among the
codepaths in the whole "git diff" (it is not even my nor Linus's code).
