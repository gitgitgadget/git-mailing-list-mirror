From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to enhance merge commit message ?
Date: Mon, 29 Jan 2007 20:45:36 -0800
Message-ID: <7v8xfl6s27.fsf@assigned-by-dhcp.cox.net>
References: <200701301032.24917.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 05:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBksV-0000Hr-5N
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 05:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXA3Epr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 23:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbXA3Epr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 23:45:47 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42379 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXA3Eph (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 23:45:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130044537.KDJ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Mon, 29 Jan 2007 23:45:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HGlw1W00A1kojtg0000000; Mon, 29 Jan 2007 23:45:56 -0500
In-Reply-To: <200701301032.24917.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Tue, 30 Jan 2007 10:32:24 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38121>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> git's git repo contains a lot of merges with nice commit message, 
> like this (d96497b8d):
> ....
> How can I made the same messages using git pull . <branch> ?

$ grep -A2 '^merge\.summary' Documentation/config.txt
merge.summary::
	Whether to include summaries of merged commits in newly created
	merge commit messages. False by default.

This is a good option if you are doing the top-level "bundling
of others' work -- people will base their further work on this"
merges.  On the other hand, if you are merging from your uplevel
because your work depends on something that was updated recently,
having the merge summary is often pointless (because the merge
would bring in many mostly unrelated commits, in addition to that
something your work depends on).  I think Linus has explicitly
asked this option not enabled by people he pulls from for this
reason.

We might want to have a per-branch option to control this
behaviour at finer grained level.  I would enable it for my four
primary integration branches (maint, master, next, and pu) but
not for topic branches.  That way, if a topic needs a fix that
happened on the master since it forked, the tip of the master
will be merged back to the topic without the merge summary
message (I would describe why that merge in an unusual direction
was needed in the commit message anyway).
