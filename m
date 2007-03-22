From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 22 Mar 2007 14:30:50 -0700
Message-ID: <7vvegtrmnp.fsf@assigned-by-dhcp.cox.net>
References: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net>
	<7v3b4x9sst.fsf@assigned-by-dhcp.cox.net>
	<7v8xed5mex.fsf@assigned-by-dhcp.cox.net>
	<7vr6rtle8o.fsf@assigned-by-dhcp.cox.net>
	<4602B810.40504@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUUs3-0006GM-Vw
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 22:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965371AbXCVVaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965405AbXCVVaw
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 17:30:52 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57545 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965371AbXCVVav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 17:30:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322213051.RBPT748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Mar 2007 17:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dxWq1W00E1kojtg0000000; Thu, 22 Mar 2007 17:30:50 -0400
In-Reply-To: <4602B810.40504@midwinter.com> (Steven Grimm's message of "Thu,
	22 Mar 2007 10:08:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42882>

Steven Grimm <koreth@midwinter.com> writes:

> Will you be applying your patch for the "checkout fails if something
> is a file in one branch and a directory in another" problem? I realize
> it's not a complete solution, but it's at least a significant
> improvement over the current behavior, and I don't imagine it breaks
> anything else.

If I understand correctly, the patch is already broken.  Rather,
the patch itself may be correct but it exposes more breakages
that currently is hidden only because we do not replace bunch of
files in a subdirectory with a single file in the index thanks
to the "too strict" check that is bothering you.  Lifting that
check with the previous patch would make it either fail to
notice other local changes (which is worse), or mistakenly say
there is a local change when there is none (which is not better
but not worse).  In particular, I think it is highly suspicious
what the current code with the patch does to paths that
immediately follow the directory to be removed, although I
stopped looking into this issue, as we already said this will
not be dealt with in 1.5.1.

In short, I do not think the patch is suitable for production,
as the cure seems worse than the disease.

That does not mean anybody is forbidden to look into a fix in
the meantime.  I am just saying I do not expect it to happen
before 1.5.1.
