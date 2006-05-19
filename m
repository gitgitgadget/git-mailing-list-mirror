From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] built-in tar-tree and remote tar-tree
Date: Fri, 19 May 2006 15:56:16 -0700
Message-ID: <7vbqtthbe7.fsf@assigned-by-dhcp.cox.net>
References: <7v7j4ik1fr.fsf@assigned-by-dhcp.cox.net>
	<20060519214318.38240.qmail@web25910.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 00:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhDtN-0006i1-Dx
	for gcvg-git@gmane.org; Sat, 20 May 2006 00:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWESW4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWESW4S
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 18:56:18 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:38587 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751417AbWESW4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 18:56:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519225617.BMRQ27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 18:56:17 -0400
To: Sven Ekman <svekman@yahoo.se>
In-Reply-To: <20060519214318.38240.qmail@web25910.mail.ukl.yahoo.com> (Sven
	Ekman's message of "Fri, 19 May 2006 23:43:18 +0200 (CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20363>

Sven Ekman <svekman@yahoo.se> writes:

> Thanks for your answer. I'm looking forward to try the
> remote tar-tree at the weekend.

A word of caution.  This obviously needs the updated stuff on
both ends.  The downloader needs to have updated tar-tree, and
the other end needs the new command upload-tar.

> Is there a simple way to retrieve a single object or a
> list of objects _without_ any of their parents?

The thing is, I do not think that is what you really want.

If you do not have the necessary parents, many of the benefit
you list as "why do I want kernel from git repo" would not work.
The next fetch will try to see where the common ancestry commit
is, in order to download only from that one, for example. For
that you would need a well formed repositories on both ends.

Obviously bisect and anything that deal with the traversal of
ancestry chain would break, and while you would say "I accept
that some things may not work", their failure mode do not even
consider that the user might start from such an incomplete
repositories to begin with, so one thing is that the user would
be very confused, and another thing is that I would not be
surprised if some operations further "corrupt" such an already
incomplete repository (fsck, prune and probably bisect when it
tries to rewind the bisection branch -- your branch head may
point at nowhere and the user might need to do manual update-ref
instead of "git checkout master" to recover from it), causing
further grief.

In other words, to support such partial/incomplete repositories
properly, you are talking about a major major surgery.  I just
do not want to think about it right now.

On the other hand, the primary point of my patch is that the
result does _not_ pretend it is a proper git repository, so we
do not have to worry about all the above issues.
