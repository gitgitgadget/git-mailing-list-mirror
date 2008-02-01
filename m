From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 01 Feb 2008 02:22:10 -0800
Message-ID: <7v63x99dt9.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<200802010534.55925.robin.rosenberg.lists@dewire.com>
	<7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
	<200802011010.41938.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKt2y-0007AR-5w
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 11:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbYBAKW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 05:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbYBAKW1
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 05:22:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYBAKW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 05:22:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C7263DFB;
	Fri,  1 Feb 2008 05:22:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 357303DFA;
	Fri,  1 Feb 2008 05:22:17 -0500 (EST)
In-Reply-To: <200802011010.41938.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Fri, 1 Feb 2008 10:10:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72165>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

>> > +test_expect_failure 'add a directory outside the work tree' '
>> > +	d1="$(cd .. ; pwd)" &&
>> > +	git add "$d1"
>> > +	echo $?
>> > +'
>
> Oops. Remove the echo $?. It still fails, i.e. git add succeeds when
> it shouldn't. I was double checking it just before sending the patch.

Ah, you found breakages.

I could not quite tell what you meant by these tests with
test_expect_failure, either they were misuse or "currently fails
but they shouldn't".  Coming up with a small reproducible
failure case is 50% of solving the problem.  That's very
appreciated.

In any case, I think the large-ish test framework update patch I
sent tonight should go in very early post 1.5.4 cycle, so plesae
use the new-and-improved test_expect_failure to mark these
reproducible failure cases.  Also, there is no need for hurry
for you to just send test cases without fixes.  When I say I do
not take patches early, I do mean it --- I do not even take _my_
own patches like the one you are following up on.  I've sent
quite a many of them, and I think some are on 'pu' or 'offcuts',
but most are only in the list archive.  If nobody cares deeply
enough about them to test and resend with Tested-by: , I am not
planning to go back to pick them up.

>>  * First, the obvious one.  You are creating a garbage file
>>    outside of t/trash directory.  Don't.  If you need to, dig a
>>    test directory one level lower inside t/trash and play around
>>    there.
>
> Can we move the default trash one level down for all tests? That
> would give us one free level to play with.

I'd rather not.  Most tests do not have to step outside and it
is very handy to debug any breakage they find by always being
able to go there with "cd t/trash".
