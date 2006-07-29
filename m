From: Junio C Hamano <junkio@cox.net>
Subject: Re: log and diff family: honor config even from subdirectories
Date: Fri, 28 Jul 2006 18:54:24 -0700
Message-ID: <7v3bclkwfj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 03:54:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6e2C-0004sI-0j
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 03:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWG2By0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 21:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWG2By0
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 21:54:26 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:16792 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752062AbWG2By0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 21:54:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060729015425.ERBZ12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 21:54:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 28 Jul 2006 18:17:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24407>

Linus Torvalds <torvalds@osdl.org> writes:

> I'd actually _like_ to do the setup unconditionally inside the git wrapper 
> (early - to make sure that we don't have this bug), but some things (at 
> least "init-db", "clone" and "ls-remote") are obviously not supposed to do 
> it, since they work outside of a git directory. So either we need to do it 
> in each builtin command separately, or we'd need to add a flag in the 
> command descriptor array.
>
> Any clever ideas?
>
> 		Linus

No clever ideas, but I agree it would be _very_ nice if we could
do the setup unconditionally and early.  Some commands that call
setup want to know prefix, so we would need to introduce a
global to hold the prefix for them.

I do not do this myself, but it is conceivable that you might
want to be able to set GIT_DIR to point at somewhere outside
your working tree hierarchy, _and_ still work in a subdirectory.
The current setup does not allow you to do that; we could
introduce GIT_PROJECT_ROOT environment variable, and when
GIT_PROJECT_ROOT exists difference between getcwd() and the
project root could become the value of prefix.
