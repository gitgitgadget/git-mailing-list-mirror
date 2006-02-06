From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sun, 05 Feb 2006 16:56:39 -0800
Message-ID: <7vek2hcnjs.fsf@assigned-by-dhcp.cox.net>
References: <20060203114133.GA11499@kvasir.watson.ibm.com>
	<20060205174422.GG31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Amos Waterland <apw@us.ibm.com>, junkio@cox.net,
	git@vger.kernel.org, boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Mon Feb 06 01:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5ugQ-0005v9-Em
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 01:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWBFA4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 19:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWBFA4n
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 19:56:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60571 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbWBFA4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 19:56:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206005509.ZZSR20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 19:55:09 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15646>

Petr Baudis <pasky@suse.cz> writes:

> Cogito solves this by [ -t ] and just doing cat instead of $EDITOR if
> the input is not a terminal. Couldn't Junio just do
>
> 	emacsclient | cg^H^Hgit commit
>
> in that case? (Note that I'm totally clueless about what emacsclient's
> usage actually is.)

It works just like other editors you can sanely use as EDITOR or
VISUAL.  Takes list of files to edit on the command line, lets
the user interact with it and modify the files, writes out the
results to the files and exits.

So you could have suggested something like this:

	$ ( $EDITOR tmpfile && cat tmpfile ) | cg commit

I think "git commit -F -" reads from stdin so an equilvalent can
be done with "git commit", but I suspect a sane user would
rather do this instead if he uses a temporary file:

	$ $EDITOR tmpfile
        $ git commit -F tmpfile
