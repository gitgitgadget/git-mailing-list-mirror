From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] refer to post-patch lines in whitespace warnings
Date: Wed, 09 Jan 2008 12:22:48 -0800
Message-ID: <7vy7ayhhpj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0801091046100.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChSO-0001yb-7B
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYAIUW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYAIUW5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:22:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYAIUW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:22:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E3B356F;
	Wed,  9 Jan 2008 15:22:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C504A356D;
	Wed,  9 Jan 2008 15:22:50 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801091046100.13593@iabervon.org> (Daniel
	Barkalow's message of "Wed, 9 Jan 2008 10:57:40 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70007>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When I rebase series with bad whitespace, I end up with unhelpful messages 
> like:
>
> .dotest/patch:412: trailing whitespace.
> -- 
> .dotest/patch:446: trailing whitespace.
> -- 
>
> These line numbers obviously refer to lines in a file that's been removed 
> by the time I can do anything about it.

The message is more appropriate for a workflow to "git apply --check"
first, fix the patchfile and then applying for real.

> ... if, in the case where it leaves the working tree 
> modified with the non-compliant whitespace, it gave this location rather 
> than the patch's location (because, even if you have the patch still, 
> you'd need to revert it first in order to be able to apply a fixed version 
> anyway).

In such a case, "git diff" will highlight the non-compliant whitespace.

More problematic is if you used whitespace=warn to let it commit anyway.
You can use "git diff $beginning_of_series..HEAD" the same way
to locate the breakages, but you then need to do "rebase -i" to
fix it up (I personally would run "format-patch", fix the problems in
the patch text, and run "am", instead of "rebase -i", mostly
because I am used to working that way).
