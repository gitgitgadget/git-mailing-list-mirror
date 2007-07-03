From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-stash to "apply --index"
Date: Mon, 02 Jul 2007 21:33:16 -0700
Message-ID: <7vodiut8c3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707021213350.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:33:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5a4m-0008QE-HN
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbXGCEdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbXGCEdS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:33:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60399 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbXGCEdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:33:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703043317.BIQA1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Jul 2007 00:33:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JsZG1X00J1kojtg0000000; Tue, 03 Jul 2007 00:33:17 -0400
In-Reply-To: <Pine.LNX.4.64.0707021213350.4438@racer.site> (Johannes
	Schindelin's message of "Mon, 2 Jul 2007 12:14:49 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51452>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	I am not quite sure if this should not be the default, with
> 	--skip-index to turn it off if the trivial index merge fails,
> 	and the user might be interested only in the working directory
> 	changes anyway.
>
> 	Comments?

There is a bit of impedance mismatch between a rename-aware
three-way merge (aka merge-recursive) used to update the working
tree and a patch that updates the index.  The "rename-aware"
thing can be fixed by doing the diff with -M, though.

It might be easier to explain (1) not have --index option, but
attempt to do this always, and (2) even if the index cannot be
updated, keep going, without worrying about losing the
difference between I and W, probably with a message to the end
user.

Suppose you are the user who gets "perhaps you would want to run
without --index?" hint.  What can you do?  Run without --index,
or forget about unstashing.  But the latter does not sound like
an option.  So it feels to me that --index is an unnecessary
option.

The potential confusion problem I mentioned in two of my earlier
messages due to the program doing one thing sometimes and
another thing some other times still applies, though.
