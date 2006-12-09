X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core. Call with explicit path.
Date: Sat, 09 Dec 2006 13:35:15 -0800
Message-ID: <7v1wn8ah2k.fsf@assigned-by-dhcp.cox.net>
References: <elc6g3$v1m$1@sea.gmane.org> <20061208193718.GA11906@soma>
	<7v3b7qi0b4.fsf@assigned-by-dhcp.cox.net> <457AB54B.8070107@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 21:35:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33836>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt9qs-0005JF-Ut for gcvg-git@gmane.org; Sat, 09 Dec
 2006 22:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757216AbWLIVfS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 16:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757289AbWLIVfS
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 16:35:18 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40752 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1757216AbWLIVfR (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 16:35:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209213516.DZYA4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 16:35:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wlbS1V00z1kojtg0000000; Sat, 09 Dec 2006
 16:35:27 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> And how about coding the path of git-sh-setup (in <prefix>/bin/git-sh-setup) 
> in the shell scripts? This will ensure that the sh-setup is the one
> from the right package, but still retain backward compatibility for 
> scripts.

Hardcoding $(bin)/git-sh-setup is a non-starter; it breaks
GIT_EXEC_PATH convention to allow users to override it.

You would need to make sure the following:

 - If you are moving git-sh-setup out of the way, I think you
   would need to do the same for git-parse-remote while you are
   at it.  There might be other scriptlets whose sole purpose is
   to be sourced via "." (I haven't checked recently).

 - It should be arranged so that "make test" would test the
   version from the source tree, even when you have an installed
   version of git-sh-setup and friends elsewhere on your PATH.

 - People who build but do not install should be able to
   continue using git from the build location with appropriate
   environment settings (look for place that talks about PATH
   and GIT_EXEC_PATH in INSTALL -- if you need something else,
   you should document new requirements there).

I haven't looked closely, but I suspect your patch might have
broken the latter two.

Having said that, I still do not see the point of doing this.

Was there ever a case that you typed git-sh-setup on the command
line by mistake (in which case it might be a valid desire to
prevent the mistake from happening again)?  Command complettion
might offer git-sh-setup when you say "git-<TAB>", which might
irritate you --- but these days you can use Shawn's completion
and say "git <TAB>" or "git somecommand<TAB>", which is way
nicer, and makes it not really an issue either.

In other words, I do not know what real problem you are trying
to solve.
