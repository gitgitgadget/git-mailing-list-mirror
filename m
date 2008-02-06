From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 05 Feb 2008 18:10:47 -0800
Message-ID: <7vr6fq6di0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org>
	<alpine.LSU.1.00.0802050139470.8543@racer.site>
	<alpine.LNX.1.00.0802042152560.13593@iabervon.org>
	<7v1w7r7yv0.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802052011290.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 03:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMZlC-0007wO-SW
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 03:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760684AbYBFCLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 21:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760128AbYBFCLF
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 21:11:05 -0500
Received: from rune.pobox.com ([208.210.124.79]:45629 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758370AbYBFCLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 21:11:04 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 18663193FFF;
	Tue,  5 Feb 2008 21:11:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D56B193FEB;
	Tue,  5 Feb 2008 21:11:16 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802052011290.13593@iabervon.org> (Daniel
	Barkalow's message of "Tue, 5 Feb 2008 20:13:51 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72747>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 5 Feb 2008, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>> > Well, it's something I tripped over when builtin-checkout wasn't passing 
>> > the tests and I couldn't figure out what it was doing wrong from the 
>> > output. Like [3/9], it's relevant to evaluating whether the series works, 
>> > even if it's not important for whether it actually does work.
>> 
>> Yeah, using "diff -u" instead of just "diff" is an improvement
>> for debuggability which matters a lot in the test scripts.
>
> I think I asked before and didn't hear back (or maybe I got distracted 
> and didn't ask); do you want this to use "diff -u" everywhere or "git 
> diff" everywhere? This test is currently part "diff" and part "git diff", 
> and I went for git diff" everywhere, but you seemed to prefer "diff -u".

Typically the test sequence is "do this with git, do that with
git, produce the output with git, now what happened?  did we
produce a correct result?"  And we often compare 'expect' and
'actual' to see if there are discrepancies.

My preference is NEVER using "git diff" when comparing expected
result and the actual output from git.  When "git diff" has
breakage, it would break unrelated tests and make debugging
needlessly harder.

We need to have tests for regressions in "git diff", but such a
test would use "git diff" in earlier parts of the test sequence
that _produce_ the output to be compared with expected result.
