From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sun, 24 Sep 2006 03:34:31 -0700
Message-ID: <7vy7s9bljc.fsf@assigned-by-dhcp.cox.net>
References: <200609212356.31806.jnareb@gmail.com>
	<20060923032948.GE8259@pasky.or.cz>
	<200609231034.49545.jnareb@gmail.com>
	<20060923121134.GM13132@pasky.or.cz>
	<7veju2s6bi.fsf@assigned-by-dhcp.cox.net> <ef44r4$km0$1@sea.gmane.org>
	<7v4puys3ye.fsf@assigned-by-dhcp.cox.net> <ef5jkv$gep$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 12:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRJw-0004Lk-UE
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 12:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWIXKed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 06:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWIXKed
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 06:34:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:23718 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751761AbWIXKed (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 06:34:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924103432.EBEK12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 06:34:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SAaa1V0071kojtg0000000
	Sun, 24 Sep 2006 06:34:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ef5jkv$gep$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	24 Sep 2006 11:37:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27650>

Jakub Narebski <jnareb@gmail.com> writes:

> Don't forget about final s,\n,<br/>\n,gm if we parse it as a whole,
> and not line by line. 

Yes, the driver and individual tag markers need to have a
convention on who is responsible for doing <br />.
One reasonable convention would be to make the driver side
responsible for taking \n and turns it into <br /> in plain
strings, and make the tag markers responsible for doing so in
their marked-up output.

For example, when bugzilla_tagger is annotating this commit
message:

    This rewrites frotz() routine to work around Bug
    #22574.  The fix was confirmed by Xyzzy.

    Thanks for everybody who helped with this rewrite.

it would match with a regexp /\b(?i:bug)\s*#?(\d+)/s
to pick up "Bug\n#22574", extract 22574, and produce:

    ('This rewrites frotz() routine to work around ',
     \'<a href="/cgi-bin/bugzilla.cgi?id=22574">Bug<br/>#22574</a>',
     '.  The fix was confirmed by Xyzzy.\n\nThanks for everybody...')
