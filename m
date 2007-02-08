From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am and workflow question
Date: Wed, 07 Feb 2007 23:27:44 -0800
Message-ID: <7vodo5153j.fsf@assigned-by-dhcp.cox.net>
References: <FA0FC64E-75D2-4722-8BD9-F7E6C8C9AFA7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF3h8-0002ms-8N
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161442AbXBHH1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 02:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbXBHH1q
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:27:46 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43688 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030661AbXBHH1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 02:27:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208072745.BWGB1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 02:27:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LvTl1W0021kojtg0000000; Thu, 08 Feb 2007 02:27:45 -0500
In-Reply-To: <FA0FC64E-75D2-4722-8BD9-F7E6C8C9AFA7@kernel.crashing.org> (Kumar
	Gala's message of "Wed, 7 Feb 2007 18:34:05 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39037>

Kumar Gala <galak@kernel.crashing.org> writes:

> I poked around the docs and mailing lists but didn't find an answer to
> my question some simple searches so I figured it might be easier  to
> just post a query to the list.
>
> So my problem is that I'm applying some patches from a mbox and want
> to be able to do some slight modifications before actually committing
> the change.  I was wondering how people solve this problem (if at all).

I am one of the two people who have been applying e-mailed
patches to a repository using git for the longest time, so I am
probably qualified to comment.  The other person is obviously
Linus, but our workflows are a bit different.

Linus's first pass is to read his mails in his usual e-mail
client; he saves potentially worthy patches in a separate
mailbox for later review.  In the second pass, he opens the
saved mailbox in an editor, while fixing up bits in the commit
messages and diff text.  Then after making another pass for the
final review, he applies them in a single batch.

I tend to work more incrementally.  My "first pass" is to read
mails and fire off kibitzing responses without doing anything
other than marking potentially worthy patches for later review.
My second pass is actually applying the patch by piping each
e-mail message from my e-mail client to "git am -3 -s", and if I
do not like something in the patch, I make corrections and then
run "git commit --amend".  My final pass is "git log -p", and if
I find something I want to fix, I do "git format-patch -$N" and
"git reset --hard HEAD~$N", fix it up in the editor by editing
the commit message and the diff text, and "git am" to rebind the
branch.

In short, there are two different approaches:

 - If a fix is something trivial, and if you are comfortable
   editing diff text in your editor, then edit it before
   applying.

 - If a fix is more involved, you are probably better off
   stopping immediately after applying the patch you want to fix
   up, make the fix in your working tree, and commit it with
   "git commit --amend".
