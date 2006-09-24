From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sun, 24 Sep 2006 12:17:49 -0700
Message-ID: <7vac4p846a.fsf@assigned-by-dhcp.cox.net>
References: <200609212356.31806.jnareb@gmail.com>
	<20060923032948.GE8259@pasky.or.cz>
	<200609231034.49545.jnareb@gmail.com>
	<20060923121134.GM13132@pasky.or.cz>
	<7veju2s6bi.fsf@assigned-by-dhcp.cox.net> <ef44r4$km0$1@sea.gmane.org>
	<7v4puys3ye.fsf@assigned-by-dhcp.cox.net> <ef5jkv$gep$1@sea.gmane.org>
	<ef6c42$h1b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 21:17:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRZUA-0007tG-Ke
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 21:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbWIXTRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 15:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWIXTRv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 15:17:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:666 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1752148AbWIXTRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 15:17:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924191750.FNIX13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 15:17:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SKHr1V00g1kojtg0000000
	Sun, 24 Sep 2006 15:17:52 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ef6c42$h1b$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	24 Sep 2006 18:35:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27690>

Jakub Narebski <jnareb@gmail.com> writes:

> Yet another question is how to deal with commit message specific
> "syntax highlighting". Currently, parsing commit message line by line,
> we treat specially signoff lines (syntax highlighting, and removing
> trailing empty lines after signoff), empty lines (we collapse consecutive
> empty lines); the rest goes through format_log_line_html... and committags.

Actually I was hoping that my bright idea(tm) of passing the
whole message to a chain of tag markers would solve that
automatically.  You define a std marker whose purpose is _not_ 
to add anchor elements leading to other URLs but mark up
sign-off lines and stuff.  Put that at the beginning or at the
end of the chain as you see fit and it would do its work just
like other real tag markers would do.

For example, one of the things it would do is to unhighlight
the Signed-off-by: lines.  It would match and split with

	/(.*?)^(Signed-off-by: .*?)$(.*)/ms

then add:

	( $1, # pass as literal we did not touch
          \'<span class="signoff">', # unhighlight
          $2, # give chance to muck with e-mail address to downstream
	      # markers
          \'</span>'
        )

to its output buffer and process the rest ($3).  A downstream
tag maker may match e-mail address the above left and might mark
it up with mailto: URL.


          

	
