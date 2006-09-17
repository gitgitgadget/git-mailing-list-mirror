From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: fix warnings from dd70235f5a81e (PATH_INFO)
Date: Sun, 17 Sep 2006 14:34:12 -0700
Message-ID: <7vfyeq2n57.fsf@assigned-by-dhcp.cox.net>
References: <20060916210832.GV17042@admingilde.org>
	<20060917121408.GA19860@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:34:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP4HM-0008OT-0c
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWIQVeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWIQVeQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:34:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60630 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965115AbWIQVeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 17:34:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917213413.NSDT22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 17:34:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PZa01V00H1kojtg0000000
	Sun, 17 Sep 2006 17:34:01 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060917121408.GA19860@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 17 Sep 2006 14:14:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27207>

Matthias Lederhofer <matled@gmx.net> writes:

> We really need a gitweb test target.

Yes, really.  Any takers who cares truly about gitweb?

> Something else I noted:
>> +	while ($project && !-e "$projectroot/$project/HEAD") {
> Evaluating $project boolean value leads to problems if a repository is
> named "0" (I dunno if there are other strings than "" and "0" which
> evaluate to false in perl).  There are multiple places where this is
> used so I did not change it in this patch (even added one more).
> Should this be changed?

Yes, there are tons of places that says if ($foo) and/or while
($bar) and fail miserably when $foo or $bar _can_ be "0".  For
project names "0" is probably not something people would want to
use but there is no inherent reason to forbid it.

How many places, like this, that we should say "defined()"
instead in the current code I wonder?

> -	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
> +	} elsif ($project && $path_info =~ m,^$project/([^/]+)$,) {
