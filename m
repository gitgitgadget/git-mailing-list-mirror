From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 10:12:59 -0700
Message-ID: <7vfy3fkpr8.fsf@assigned-by-dhcp.cox.net>
References: <20070723041741.GA22461@midwinter.com>
	<Pine.LNX.4.64.0707231059490.14781@racer.site>
	<46A481B4.7000502@midwinter.com>
	<Pine.LNX.4.64.0707231136530.14781@racer.site>
	<46A48949.1020501@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 19:13:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1Sx-0003qC-Q3
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829AbXGWRNB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756598AbXGWRNB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:13:01 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:40378 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131AbXGWRNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 13:13:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723171300.JAW1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 13:13:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id T5Cz1X00C1kojtg0000000; Mon, 23 Jul 2007 13:12:59 -0400
In-Reply-To: <46A48949.1020501@midwinter.com> (Steven Grimm's message of "Mon,
	23 Jul 2007 18:56:09 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53446>

Steven Grimm <koreth@midwinter.com> writes:

> With the patch, my intent was:
>
> * Strip off all comment lines
> * Strip off all Signed-off-by: lines
> * Trim whitespace
> * If the result has no content (! -s file), abort.
> * If a template file was specified:
>   * Strip off all comment and Signed-off-by: lines from the template
>   * Trim whitespace from the template
>   * If the resulting trimmed template is the same as the trimmed
> commit message, abort.
>
> So I guess before getting to the specifics of the code, I'll ask: does
> the above make sense as a design? I wanted to preserve the existing
> behavior in the absence of a template.

Offhand, an "interesting" side effect of the above I can see is
that you will cry "wolf" if the only thing the user did is to
add his own Signed-off-by: line ;-)  But that is sane in the
context of coming up with totally new commit log message.

I am more worried about how this should interact with cases
where you usually do not start the log message from scratch.
For example, are there cases / policies where being able to use
templates to leave comments on merge commits are needed?
Squash-commits?  Perhaps "apply this template but only when you
have hand resolved a conflicting merges"?

Or even the case of amending a commit made by somebody else,
without changing the tree contents, in order to make the commit
log message to conform to the company standard?
