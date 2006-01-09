From: Junio C Hamano <junkio@cox.net>
Subject: Re: undoing changes with git-checkout -f
Date: Mon, 09 Jan 2006 13:46:38 -0800
Message-ID: <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
References: <43C2D2C4.2010904@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 09:50:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Dd1-0008NK-G3
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 09:46:15 +0100
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id k09LrbSs059354
	for <gcvg-git@gmane.org>; Mon, 9 Jan 2006 22:53:52 +0100 (CET)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWAIVqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 16:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWAIVql
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 16:46:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44437 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750779AbWAIVqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 16:46:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109214439.FUUI26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 16:44:39 -0500
To: lamikr <lamikr@cc.jyu.fi>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15395>

lamikr <lamikr@cc.jyu.fi> writes:

> 1) I clone git repo by using command
>
>     git-clone rsync://source.mvista.com/git/linux-omap-2.6.git
> linux-omap-2.6

Please do not use rsync:// transport if possible (mvista might
only pubilsh via rsync:// and not git://, so it may not be your
fault).

> 2) I go to cloned repo and create there a new file
>     cd linux-omap-2.6
>     echo "test" > 1.txt
>
> 3) I want to undo the creation of 1.txt by using command
>     git-checkout -f
>
> but for some reason the 1.txt is still displayed in the root of
> linux-omap-2.6 directory. (I have also tried "git-reset --hard" but
> seems to have same effect)
> What am I doing wrong?

Nothing.  After the second step, git does not know anything
about 1.txt; if it is a part of something you wanted to
eventually commit, or it is some notes you took while perusing
the source and is precious even when you switch branches (even
though you would not commit it as part of the project) , so it
does not touch it.  After running "make", "checkout -f" does not
do "make clean" for you to remove *.o files either, for exactly
the same reason.

"git status" would tell you the file is "untracked".

If you did something like this:

	$ edit 1.txt
        $ git add 1.txt
        $ git reset --hard

"git reset --hard" would remove it, while "git checkout -f"
would leave the file behind.

BTW, please do not set Reply-To: (or Mail-Followup-To: for that
matter) to the list.  When I (or somebody else) want to reply
to you, especially in private, your Reply-To: header forces me
to manually rewrite the To: header MUA prepares for me.

I know why you do it --- you are on the list and otherwise you
would get duplicate messages, one from me directly and another
from the list.  I've seen other people do it, but IMNSHO it is a
bad practice.  Filter them on your end, and do not put extra
burden to others, please.  The only case mucking with the
addressee headers may be acceptable is to remove yourself from
CC: list when a list you are on is on the CC: list.
