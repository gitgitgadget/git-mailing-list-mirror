From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge into branch currently not active / checked out
Date: Sun, 17 Jun 2007 02:27:50 -0700
Message-ID: <7vmyyzylpl.fsf@assigned-by-dhcp.pobox.com>
References: <20070617072225.GF23473@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 11:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzr38-0000Ne-TU
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 11:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062AbXFQJ1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 05:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756970AbXFQJ1w
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 05:27:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62872 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbXFQJ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 05:27:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070617092751.RHCY2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 17 Jun 2007 05:27:51 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CZTq1X00E1kojtg0000000; Sun, 17 Jun 2007 05:27:50 -0400
In-Reply-To: <20070617072225.GF23473@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Sun, 17 Jun 2007 09:22:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50344>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> Hello,
> is it possible to merge into a branch currently not active/checked out?
> I have the following scenario:
>
>         - One branch per feature (cstatus, headers, mutt-collapse-flags, small-fixes)
>         - One upstream branch (master)
>         - One branch that has every feature branch (tg)
>
> (faui00u) [~/work/mutt/mutt] git branch
>   cstatus
>   headers
>   master
>   mutt-collapse-flags
>   small-fixes
> * tg
>
> I want to merge master in every of the feature branches. Is that possible or
> just bullshit because I don't have a working tree to handle conflicts?

Exactly.  Merge would want to have working tree, so merging into
the current branch is not just the default but the only mode of
operation.

In general, I would recommend against merging 'master' to topic
branches, if you can avoid it.

There are two reasons you would ever want to merge 'master' to
them.

 (1) You notice that 'master' has new stuff.  It does not
     necessarily conflict with the changes you made to your
     topic branches, and it often doesn't, if the project is
     well modularized.  Still, you want to make sure that your
     topic branches are compatible with it.  IOW to see if the
     changes in the master did not break your topic.

 (2) You notice that 'master' actually have new change that
     actively interact with what you set out to do in some of
     your toipcs.

If you plan to eventually ask somebody who integrates the
'master' to pull from you, and keep the resulting development
history clean, (1) is _NOT_ a good reason to merge 'master' into
your topics.  Because after your topic finally is finished, when
'master' pulls it, it will see many "senseless" merges from
itself.

Such "an integration testing" is better done, instead, by
forking a 'test' (perhaps throw-away) branch from 'master', and
merging all your topics into it.

On the other hand, (2) is a valid reason to resolve conflict
(both textual and semantic) early before you eventually present
your work for inclusion to 'master'.

Also, if you do not publish your work-in-progress topics, you
might want to consider rebasing on top of 'master', instead of
'merging'.  Rebase can take the topic branch name and switch
your current branch for you when you give it, like so:

	$ git rebase master topic1
        $ git rebase master topic2
        ...
