From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up the SunOS Makefile rule
Date: Wed, 02 Nov 2005 12:56:12 -0800
Message-ID: <7voe52py4z.fsf@assigned-by-dhcp.cox.net>
References: <20051102192730.GA17706@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Peter Eriksen" <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:59:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPef-0005Zd-HJ
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVKBU4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVKBU4S
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:56:18 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33162 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965238AbVKBU4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 15:56:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102205551.ZBDY4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 15:55:51 -0500
To: git@vger.kernel.org
In-Reply-To: <20051102192730.GA17706@ebar091.ebar.dtu.dk> (Peter Eriksen's
	message of "Wed, 2 Nov 2005 20:27:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11042>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> Don't set a non-standard CURLDIR as default, and fix an error
> in Solaris 10 by setting NEEDS_LIBICONV.

Just to make it clear to everybody, these platform defines are
just to give default that is intended to help majority of the
users.  You do not have to cover everybody on that platform.
Giving *one* default CURLDIR, as long as it helps major portion
of the user base, would be helpful.  In other words, it is OK as
long as the user can say:

	solaris$ gmake CURLDIR=/I/have/my/curl/here

to override what you chose, and /opt/sfw/ is where *many* (if
not most) of the Solaris installations have curl.  I do not have
access to many different flavours of Solaris boxes, but one
machine I have at work (5.9) seems to have it installed there.

Could Solaris users on the list help us out, as Peter asks?  How
many of you have curl in /opt/sfw?  How many others have curl in
somewhere else and think that somewhere else would be more
appropriate default?  If this user poll results in either a
default location better than /opt/sfw, or diverse locations with
no clear majority, then it would make sense to remove the
current default, but otherwise I would say we do not need to
drop it.

People who built curl library and installed at random places
themselves do not count -- they know what they are doing and are
perfectly capable of overriding whatever we say in our Makefile
from the comand line.

Although I think always requiring LIBICONV is OK there, and it
probably is needed on *all* Solaris boxes, but in principle,
NEEDS_LIBICONV is similar.  If the user cannot say:

	solaris$ gmake NEEDS_LIBICONV= ;# No thanks, on my Solaris

to disable -liconv, and if some Solaris installations do not
want -liconv, then that is a problem.  But GNU make seems to do
the right thing; ifdef NEEDS_LIBICONV seems to evaluate to false
if your user overrides it to be empty from the command line.
