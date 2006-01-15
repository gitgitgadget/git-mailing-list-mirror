From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Cogito support for simple subprojects
Date: Sun, 15 Jan 2006 11:15:40 -0800
Message-ID: <7vk6d1480z.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de> <20060115150721.GE28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sun Jan 15 20:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyDLt-0003yy-Lv
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 20:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWAOTPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 14:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWAOTPm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 14:15:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54493 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750791AbWAOTPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 14:15:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115191309.FKKV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 14:13:09 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060115150721.GE28365@pasky.or.cz> (Petr Baudis's message of
	"Sun, 15 Jan 2006 16:07:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14701>

Petr Baudis <pasky@suse.cz> writes:

> ... I currently don't
> think a recursive cg-merge is a particularily good idea, for one.
> I think the good default is to make all read-only commands by default
> recursive and all modifying commands by default non-recursive. (And
> it might be useful to be able to mark some subprojects read-only.)

All sounds sane and simple.  Good job!

Especially because this does not even try to let the project
express its version dependencies on its subprojects, I like it
for its simplicity (which makes it very easy to explain, to my
mind that is the biggest plus).  However, I fear that others
might complain to say that the contained things do not deserve
to be called "subprojects" if there is no version linkage [*1*].

I think something like this is greatly helpful for people (like
me) as "an end user who builds from source out of SCM not from
tarballs."

If you go this route, one minor concern is what the format of
the $GIT_DIR/subproject should be (and if they do not deserve to
be called "subproject" then what the name of the file be),
because this may likely be a "nice if they were compatible" item
across Porcelains.  The list of names separated with LF has two
very big pluses:

 - it is certainly the easiest to parse.

 - it can readily be used as --exclude-from file, as long as you
   do not care about another directory with a same name
   somewhere other than the subproject itself.

Even if the limitation to the latter becomes a real issue, a
separate exclude-from file could easily be generated on the fly
(prefix them with '/' to force "not anywhere in the subtree but
only here" matching, perhaps with escaping shell glob pattern
while you are at it), which does not sound so bad.


[Footnote]

*1* I do not personally care about version linkage; this is me
being lazy to avoid core side support ;-).  Yesterday I was
mucking with rev-list code to see how gitlink and/or bind commit
would affect what it needs to do (especially wrt its --objects
flag), and I did not like the potential code impact I saw there.
