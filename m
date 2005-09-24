From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Fri, 23 Sep 2005 20:04:54 -0700
Message-ID: <7vaci36u95.fsf@assigned-by-dhcp.cox.net>
References: <ud5mznc1x.fsf@peter-b.co.uk>
	<Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
	<Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 05:06:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJ0Lj-00064e-F0
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 05:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVIXDE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 23:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVIXDE5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 23:04:57 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33683 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbVIXDE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 23:04:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924030456.NJXP6728.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 23:04:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 23 Sep 2005 19:46:47 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9226>

Linus Torvalds <torvalds@osdl.org> writes:

> Looking a bit closer at the diff() usage, I actually think that we could 
> move the fork() closer to the exec - we'd just have to move it _into_ all 
> the different cases (ie you'd have two different fork() calls: one for 
> the "builtin" case, one for the external pgm case, but then the child in 
> both cases would be very simple).

Looking back at what I did in the diff.c, I actually think the
part near fork() is a total crap ;-).

Originally I intended to do more work in the child process (this
is totally opposite of what is being proposed now), for example
running prepare_temp_file() after child forked, so that the
parent process does not have to worry about using memory for
expanded blob to be written out to the temporary file and then
later forgetting to free it ;-), but it seems the parent is
doing more work than I intended to.  I honestly think that the
part of the code is ancient enough to deserve a major facelift.
