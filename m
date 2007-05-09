From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 08 May 2007 21:06:46 -0700
Message-ID: <7vps5azlm1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
	<20070509031803.GA27980@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed May 09 06:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HldSY-0004QT-Rz
	for gcvg-git@gmane.org; Wed, 09 May 2007 06:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969113AbXEIEGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 00:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969283AbXEIEGu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 00:06:50 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55055 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S969113AbXEIEGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 00:06:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509040647.QYVI13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 00:06:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ws6m1W00o1kojtg0000000; Wed, 09 May 2007 00:06:47 -0400
In-Reply-To: <20070509031803.GA27980@fieldses.org> (J. Bruce Fields's message
	of "Tue, 8 May 2007 23:18:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46655>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> The organization of the next bit is slightly confusing: we're set up to
> expect a longer lecture on the revision walker, but instead there's just
> the historical note on git-rev-list, a mention of 'revision.c',
> 'revision.h', and 'struct rev_info', and then it rapidly digresses into
> discussing builtins.

I had the same impression.

I was meaning to write a "code walkthru for git hackers and
wannabes" with target audience quite different from the
user-manual.  My idea of which areas to cover in what order
seems to match with what Johannes started.

 - sha1_name.c;

 - read_sha1_file();

 - revision.c::setup_revisions() to talk about parsing but not
   about walking yet.

 - start from builtin-merge-base.c into commit.c to talk about
   revision traversal done by get_merge_bases().  This codepath
   is much simpler than the revision.c machinery and is a good
   primer to understand the latter.

 - builtin-diff-tree.c to show one tree and two tree cases, go
   into log-tree.c then tree-diff.c to show the use of
   add_remove() and change() callbacks, and then finally talk
   about diff_flush(), without talking about diffcore
   transformations yet.

 - start from builtin-log.c to review the setup_revisions(),
   then talk about prepare_revision_walk() and get_revision()
   machinery, first pass without talking about path limiting and
   then with path limiting.

 - fetch-pack.c and upload-pack.c to talk about the native
   protocol over ssh and local forking, how revision traversal
   machinery is used, the "objects pointed by refs are complete"
   contract.

 - daemon.c to see how upload-pack is invoked.

 - read_cache(), active_cache[], active_nr and friends;

 - update-index and write-tree, including how cache-tree
   optimizes tree writing after small updates.  Advanced students
   can also look at git-apply here.

 - unpack-trees.c and builtin-read-tree.c to talk about index stages.

 - diffcore transformations, especially diffcore-rename.

 - merge-recursive
