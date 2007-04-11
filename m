From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 02:15:36 -0700
Message-ID: <7virc3p8zr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	<20070411080641.GF21701@admingilde.org>
	<81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
	<20070411083642.GH21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYvd-0003TM-4f
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXDKJPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 05:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbXDKJPi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:15:38 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46569 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbXDKJPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 05:15:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411091537.VKKE1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 05:15:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id llFc1W0091kojtg0000000; Wed, 11 Apr 2007 05:15:36 -0400
In-Reply-To: <20070411083642.GH21701@admingilde.org> (Martin Waitz's message
	of "Wed, 11 Apr 2007 10:36:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44212>

Martin Waitz <tali@admingilde.org> writes:

> Your working tree now contains a complete git repository which has
> features which are not available for normal files.  Notable, you
> have the possibility to create branches in the submodule.
> If you insist in using HEAD you throw away those submodule capabilities.

Why?  If you are working in the parent module (e.g integration)
and notice breakage due to a bug in a submodule, it is very
plausible that you would want to cd into the directory you have
the submodule checked out, which has its own .git/ as its
repository, and perform a fix-up there, with the goal of coming
up with a commit usable by the parent project pointed at by the
HEAD of the submodule repository.  And while working toward that
goal, you will use branches, rebase, rewind or use StGIT there
in that submodule repository.  It does not forbid you from using
any of these things -- as long as you end up with a good commit
at HEAD that the supermodule can use.

Once you come up with a suitable commit sitting at HEAD of the
submodule repository, you cd up to the parent module.  Top-level
git-diff would notice that the commit recorded at the submodule
path has been updated (because you now have a good commit at
HEAD of the submodule repository, while earlier the one in your
index was a dud).

So it is not clear to me what your argument about throwing away
capabilities is.
