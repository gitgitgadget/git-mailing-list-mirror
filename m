From: Petr Baudis <pasky@ucw.cz>
Subject: How to clone-pack the HEAD?
Date: Thu, 15 Dec 2005 01:44:40 +0100
Message-ID: <20051215004440.GM22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 01:46:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmhEs-0005TY-Rf
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 01:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVLOAow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 19:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVLOAov
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 19:44:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19688 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965130AbVLOAov (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 19:44:51 -0500
Received: (qmail 12332 invoked by uid 2001); 15 Dec 2005 01:44:40 +0100
To: junkio@cox.net
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13666>

  Hello,

  I'd like to make cg-clone use git-clone-pack instead of git-fetch-pack
so that it gets actually usable on large repositories, but I'm hitting
problems:

  (i) git-clone-pack url HEAD doesn't work

	If .git/HEAD already exists, it will panick because of the
	write_one_ref()'s O_CREAT|O_EXCL. If .git/HEAD doesn't exist,
	git-clone-pack refuses to do anything since it doesn't run
	with valid GIT repository.

  (ii) git-clone-pack has hardcoded assumptions about refs/heads/master

	The problem is, git-clone-pack doesn't seem to care about what
	ref does HEAD point to at the remote side, it just starts to
	panic and do weird things if it isn't master, which seems
	"really really wrong". Also, because git-clone-pack ... HEAD
	doesn't work, I think I have no way to clone the actual HEAD
	ref of the remote repository.

  Overally, I think what I really need is git-fetch-pack (with it
outputting the ref info which I can write on my own, DTRT'ing from
the Cogito POV), just with the option not to unpack the pack.

  I'd be very happy if fixing this would be possible before 1.0 so that
I can fix Cogito's fetching over git and ssh ASAP - git-clone-pack's
architecture seems to be way too much hardcoded to carry over head names
to the cloned repository (which is fine for the GIT porcelainish, but
not for Cogito philosophy).

  PS: Sorry if this mail is a bit incoherent - I'm already falling
asleep over the keyboard, but I don't want to see GIT 1.0 fly by during
the night. ;-) BTW, Junio, do you have any timeline (more precise than
"in the coming week(s)") for the release, or are you just waiting for
"n days without big problem" or something like that?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
