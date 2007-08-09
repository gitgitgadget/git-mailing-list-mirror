From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsserver: Fix for work trees
Date: Wed, 08 Aug 2007 22:45:48 -0700
Message-ID: <7v1wedz2er.fsf@assigned-by-dhcp.cox.net>
References: <1186633570700-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 07:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ0qI-0005aE-44
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 07:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763373AbXHIFpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 01:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762739AbXHIFpu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 01:45:50 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48622 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763304AbXHIFpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 01:45:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809054548.XGRU1335.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 9 Aug 2007 01:45:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zhlo1X00Q1kojtg0000000; Thu, 09 Aug 2007 01:45:49 -0400
In-Reply-To: <1186633570700-git-send-email-bdowning@lavos.net> (Brian
	Downing's message of "Wed, 8 Aug 2007 23:26:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55409>

Hmmmmm....

This is a good fix to adjust to the new world order introduced
by Dscho's rewrite of work-tree stuff, where the rules are:

 * When GIT_DIR is set and GIT_WORK_TREE is not, GIT_DIR is used
   to read config file, to figure out core.worktree.  When
   core.worktree is not set, a complicated algorithm is used to
   figure out the top of the working tree based on the value of
   GIT_DIR, and this can sometimes figure out that you are in a
   subdirectory of the working tree.  In such a case, you are in
   the working tree, but not necessarily at the top.

 * Otherwise, commands that require to have working tree now
   barf.  Earlier they always and consistently treated that your
   $cwd is the top of working tree and did not barf.

This new world order is probably an improvement, and if the
rules were like this from the beginning, it would have been
much nicer.  However, this _is_ a change of semantics in the
middle of the road, and probably we will see many fallouts like
this.  Unfortunate...  I am torn between a cleaner semantics and
the short-term pain...
