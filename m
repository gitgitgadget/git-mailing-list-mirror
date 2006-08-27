From: Junio C Hamano <junkio@cox.net>
Subject: git-apply --reject
Date: Sun, 27 Aug 2006 16:03:40 -0700
Message-ID: <7vac5pvl0z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 28 01:03:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHTey-000670-V6
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 01:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWH0XDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 19:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWH0XDL
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 19:03:11 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50667 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751239AbWH0XDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 19:03:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827230310.SUYQ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 19:03:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FB361V00h4Noztg0000000
	Sun, 27 Aug 2006 19:03:07 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26127>

The git-apply program in "next" has had a few additional options
for some time: --reject and --verbose.  I've been using this
after a failed "git am" attempt:

	git apply --reject --verbose .dotest/patch

This, instead of the usual "patch does not apply so I would not
touch any of your working tree files" behaviour, applies hunks
that are applicable and leaves *.rej files the rejected hunks,
and it reports what it is doing. With --index, files with a
rejected hunk do not get their index entries updated at all, so
"git diff" will show the hunks that successfully got applied.

This seems to be working rather nicely, so I intend to make it
graduate to "master".  I made a mistake of adding the man page
that already talks about these options to "master", but with an
incorrect the description for --reject (earlier I planned to
send the rejected hunks to stdout which is still what the
documentation describes), so the documentation will be updated
accordingly.

I initially made --reject without --verbose not talk about
anything that applied cleanly, but as the above example usage
shows, I find myself always using --verbose when using --reject.
Without --verbose to remind the user that the patch updated some
other paths cleanly, it is very easy to lose track of the status
of the working tree.  So I'll make the final adjustment to make
it imply --verbose before pushing it out.
