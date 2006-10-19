From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 14:28:54 -0700
Message-ID: <87fydkj8q1.fsf@penguin.cs.ucla.edu>
References: <87vemgn1s2.fsf@rho.meyering.net>
	<7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
	<878xjckw7x.fsf@rho.meyering.net>
	<7vk62wruum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	bug-diffutils@gnu.org
X-From: git-owner@vger.kernel.org Thu Oct 19 23:30:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GafSb-0005e9-B2
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 23:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946519AbWJSV3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946521AbWJSV3c
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 17:29:32 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:28311 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S1946519AbWJSV3b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 17:29:31 -0400
Received: from penguin.cs.ucla.edu (Debian-exim@Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.13.7+Sun/8.13.7/UCLACS-6.0) with ESMTP id k9JLSsAd013176;
	Thu, 19 Oct 2006 14:28:54 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1GafRe-0008HX-92; Thu, 19 Oct 2006 14:28:54 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk62wruum.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 19 Oct 2006 12:03:45 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29383>

Junio C Hamano <junkio@cox.net> writes:

> I see no good reason, other than saving a single byte from the
> output stream perhaps.

That wasn't the motivation.  Rather, it was to support the
style where people use editors that highlight trailing
blanks, since trailing blanks can cause trouble in some
contexts (e.g., they can change the semantics of C programs
and Makefiles).  When examining unified diffs, any added or
removed trailing blanks will be easy to spot with such an
editor, but only if "diff -u" doesn't output any trailing
blanks of its own.

You can read more about this at the thread that inspired
the diffutils change, rooted here:

http://lists.gnu.org/archive/html/bug-gnu-utils/2006-09/msg00005.html

> Does that mean if you have a line that has only one TAB (perhaps
> caused by broken autoindent in the editor), that is "input data"
> and is output as "SP TAB LF"?

Yes, that's correct.  In the highlighting-editor scenario,
such a line would be highlighted, but the people who want to
see trailing white space highlighted will indeed want the
highlighting here, so it's fine.

This change was not motivated by broken MUAs.  Broken MUAs
are a problem that GNU 'patch' has already had to deal with,
for many years.  The change was motivated by a desire to
make significant trailing white space easier to find, when
people are examining text that contains some diffs and some
other stuff.
