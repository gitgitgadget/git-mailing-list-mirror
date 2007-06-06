From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 06 Jun 2007 13:07:24 -0700
Message-ID: <7vfy543kzn.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
	<81b0412b0706060852y4ab6b794m5fed0484c63159e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw1nJ-0008Ls-DE
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 22:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbXFFUH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbXFFUH0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 16:07:26 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43627 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXFFUHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 16:07:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606200724.HOGR12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 16:07:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8L7Q1X00l1kojtg0000000; Wed, 06 Jun 2007 16:07:25 -0400
In-Reply-To: <81b0412b0706060852y4ab6b794m5fed0484c63159e4@mail.gmail.com>
	(Alex Riesen's message of "Wed, 6 Jun 2007 17:52:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49309>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Otherwise ".git" is removed from every remote path which has it,
> including "/some/path/somename.git".

I was very tempted to apply this patch, but after re-reading it
once more, I decided to drop it.

I do not mind keeping the extra .git/ suffix in the -v output in
your example, as the message is just "verbose information":

  $ git fetch -v
    * refs/heads/origin: same as branch 'master' of /home/user/linux
      commit: 5ecd310

But the same output is used by log messages for the merge
commits; indeed, the primary purpose of this output is to
prepare messages for merge commits.  From the beginning we
deliberately omitted .git suffix to keep the resulting log
message short and sweet.  Keeping .git suffix goes against it.

A repository "git://$site/repo.git" can be accessed with
"git://$site/repo".  Repository owners _can_ confuse their users
by having both repo and repo.git, but I honestly do not see a
reason to encourage that.

Earlier you mentioned you know of a case where "$URL/repo.git"
exists and "$URL/repo" does not, and the current clone fails to
set up the target repository after cloning from "$URL/repo"
correctly?  I admit I haven't reproduced nor debugged it, but if
that is the case that needs to be fixed.
