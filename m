From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck --lost-found: write blob's contents, not their SHA-1
Date: Sun, 22 Jul 2007 14:42:10 -0700
Message-ID: <7vodi4qfnx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707222120100.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjBw-0001oh-Kv
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbXGVVmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXGVVmO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:42:14 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35790 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbXGVVmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:42:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722214213.NGOO1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 17:42:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SliA1X00T1kojtg0000000; Sun, 22 Jul 2007 17:42:12 -0400
In-Reply-To: <Pine.LNX.4.64.0707222120100.14781@racer.site> (Johannes
	Schindelin's message of "Sun, 22 Jul 2007 21:20:26 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53326>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When looking for a lost blob, it is much nicer to be able to grep
> through .git/lost-found/other/* than to write an inefficient loop
> over the file names.  So write the contents of the dangling blobs,
> not their object names.

I think this is an idea to solve a good problem, but if we go
this route, the need for us to worry about expiring lost-found
entries would become more urgent, I suspect.

And when you think about expiring lost-found entries, another
possible solution emerges.  If we teach git-prune to remove the
corresponding entry from lost-found/other when it removes a
loose blob from the object store, then we can easily and safely
do this instead:

	$ cat .git/lost-found/other/* |
	  xargs -r git grep 'the word to look for'
