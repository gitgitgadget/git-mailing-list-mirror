From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Add --index to git-commit: just commit current index
Date: Thu, 15 Mar 2007 17:23:39 -0700
Message-ID: <7vird2yr1w.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703150243h6a5f036aye8f115d82e11e883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 01:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS0ER-0003gG-Ri
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 01:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbXCPAXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 20:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbXCPAXl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 20:23:41 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62859 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbXCPAXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 20:23:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316002340.OXML2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Mar 2007 20:23:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bCPg1W00F1kojtg0000000; Thu, 15 Mar 2007 20:23:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42305>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> First use of new --quiet :)

You do not need to say --exit-code if you use --quiet.

> Refreshing index takes a long time on big repositories with
> many files, especially if the developer was unlucky enough to
> stick to a slow filesystem or a broken OS. In this situation
> explicit git-update-index with git-commit --index will speedup
> the workflow.

Does it?

A typical workflow would go something like this:

	- repeat from here
	- "edit foo"
        - "edit bar"
        - "git diff" to help me see what I changed
        - "git add foo" as the change is sane
        - test and see breakage
        - "git diff HEAD" to help me see what I broke
        - go back to 'here' to fix it up
        - "git diff HEAD" to help me see what I changed
        - "git add foo bar" to include what I changed
        - "git commit"

If I have a large project on a filesystem with slow lstat(2), I
would imagine your development is slowed anyway because you
would use diff far more often than commit.  I wonder if it may
be a better idea to use (and extend if needed) existing 'assume
unchanged' on such a system, exactly because "diff" side would
take more time than final "commit", and if you do use 'assume
unchanged', then it also makes --refresh a no-op.

In any case, I think your --index is a misnomer, as we do commit
the current index.  If the sole purpose of your patch is to omit
refreshing it, then it should be named as such.
