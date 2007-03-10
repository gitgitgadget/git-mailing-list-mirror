From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adjust reflog filemode in shared repository
Date: Fri, 09 Mar 2007 16:53:50 -0800
Message-ID: <7vd53h3om9.fsf@assigned-by-dhcp.cox.net>
References: <11734799371637-git-send-email-matthias@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Sat Mar 10 01:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPpqf-00081s-61
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 01:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767687AbXCJAxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767688AbXCJAxy
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 19:53:54 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49682 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767687AbXCJAxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 19:53:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310005352.DMLB24587.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 19:53:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Yotq1W00n1kojtg0000000; Fri, 09 Mar 2007 19:53:51 -0500
In-Reply-To: <11734799371637-git-send-email-matthias@spinlock.ch> (Matthias
	Kestenholz's message of "Fri, 9 Mar 2007 23:38:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41826>

Thanks, will apply to 'maint' to be included in v1.5.0.4 (and
also in 'master' to be in v1.5.1).

We should add tests whenever we found this kind of breakage.
For core.sharedrepository, we would want to have something like
this:

 (1) Initialize a repository
 (2) set core.sharedrepository
 (3) set umask to 077
 (4) perform various git operations in the repository
 (5) "find .git" to see if there is anything unreadable by group
     members; if you find any, you found a bug.

That is the "feature" test -- check if a feature works as
intended.

At the same time, we need to have a corresponding "regression"
test to make sure that a feature does not overstep its boundary
and affect cases where it is not enabled:

 (1) Initialize a repository
 (2) unset core.sharedrepository
 (3) set umask to 077
 (4) perform various git operations in the repository
 (5) "find .git" to see if there is anything readable by group
     members; if you find any, you found a bug.

We would need such "regression" tests for existing tests too,
but that is a separate issue.
