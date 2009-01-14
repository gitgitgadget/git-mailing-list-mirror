From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Wed, 14 Jan 2009 11:02:44 -0800
Message-ID: <7vbpu91zjf.fsf@gitster.siamese.dyndns.org>
References: <vpqwscy81o8.fsf@bauges.imag.fr>
 <496DFC75.2000904@drmicha.warpmail.net>
 <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
 <496E0D1C.20807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNB2I-0006mJ-AX
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 20:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbZANTCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbZANTCy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:02:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZANTCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:02:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5500A909A6;
	Wed, 14 Jan 2009 14:02:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0FFF4909A0; Wed,
 14 Jan 2009 14:02:45 -0500 (EST)
In-Reply-To: <496E0D1C.20807@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 14 Jan 2009 17:04:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0FC03EE-E26D-11DD-9DBE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105682>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> So, should I prepare a series like:
>
> 1: test case and mark known fail
> 2: the 1 line fix
> 3: mark test pass
>
> Or should 2+3 be squashed into one?

If "git mv" already has its own sets of tests with a good coverage, please
strive to add a case that covers your fix to an existing script.  Then
step #1 above would be a patch to add a few "test_expect_failure" tests to
an existing file, and step #3 would be a patch to flip expect_failure to
expect_success.

And in such a case, for a single liner, all three can be squashed in to a
single patch.  It would show what changed in the code and have a few new
test_expect_success tests added to the test suite, and it would be obvious
to anybody who looks at such a change 6 months down the road that the test
cases added by the patch are the cases that did not work without the
changes to the code.  It never makes sense to separate steps #2 and #3 for
any fix.

If "git mv" did not have adequate test coverage, then please add a test
script with both expect_success (for cases that should have been there
when somebody worked on "git mv" originally), and expect_failure to expose
the bug you found in your first patch.  Again, the second patch would
update the code and flip expect_failure to expect_success.

I see there is t7001-mv and even though it claims to concentrate on its
operation from subdirectory, it has tests for more basic modes of the
operation.

So my recommendation would be to have a single patch that:

 (1) retitles t7001;
 (2) adds your new -k tests to it; and
 (3) adds the 1-liner fix.
