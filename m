From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sat, 09 Feb 2008 12:57:46 -0800
Message-ID: <7vr6fletkl.fsf@gitster.siamese.dyndns.org>
References: <20080209162234.GA25533@fieldses.org>
	<alpine.LNX.1.00.0802091251430.13593@iabervon.org>
	<20080209185038.GB25533@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:58:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwmk-00018x-QS
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbYBIU6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYBIU6L
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:58:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbYBIU6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:58:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B5583A7E;
	Sat,  9 Feb 2008 15:58:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8006C3A7D;
	Sat,  9 Feb 2008 15:58:03 -0500 (EST)
In-Reply-To: <20080209185038.GB25533@fieldses.org> (J. Bruce Fields's message
	of "Sat, 9 Feb 2008 13:50:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73264>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Yeah, fair enough.  Hard to know where to start, though.  OK, just to
> get an idea, I committed a completely empty tree, made a diff (with
> --binary), then applied with --whitespace=fix and compared to the
> original.  In some cases these seem to be accidental, in some cases
> (git-p4) I assume they're intended to use the different style.

I personally have this in .git/config

[core]
	whitespace = indent,trail,space

and the following three lines in contrib/.gitattributes (untracked)

*.py whitespace=!indent,trail,space
*.el whitespace=!indent,trail,space
fast-import/git-p4 whitespace=!indent,trail,space

The latter I added after receiving a fix-up patch from Toby
Allsopp a few days ago.  I applied git-p4 patch with the
strictest rule.

As you argued correctly earlier, when we made the whitespace
rules per-path using the attributes mechanism, the whitespace
policy should be project wide, just like coding style, so I
think it is a good idea to have in-tree .gitattributes files
that spell out what the policy is more explicitly.

At least I think we can all agree that this one entry in the
toplevel .gitattributes is a safe and good idea.

*.[ch] whitespace

I am not sure about the AsciiDoc Documentation.  I've always
assumed that the docs would format exactly the same before and
after running expand and/or unexpand on Documentation/*.txt, and
if that is indeed the case we should add

*.txt whitespace

to Documentation/.gitattributes as well.

Then I should _discard_ the one in my .git/config and the
untracked contrib/.gitattributes file.
