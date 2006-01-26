From: Junio C Hamano <junkio@cox.net>
Subject: Re: git describe fails without tags
Date: Thu, 26 Jan 2006 00:07:57 -0800
Message-ID: <7vmzhjif8i.fsf@assigned-by-dhcp.cox.net>
References: <20060125074725.GA2768@informatik.uni-freiburg.de>
	<7vek2wws61.fsf@assigned-by-dhcp.cox.net>
	<20060126074421.GA2941@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 09:08:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F22Am-0001Bn-SV
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 09:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWAZIH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 03:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWAZIH7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 03:07:59 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55029 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750902AbWAZIH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 03:07:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126080549.BWAA17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 03:05:49 -0500
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060126074421.GA2941@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Thu, 26 Jan 2006 08:44:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15151>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> Yes, I wrote a script that automatically build git and install it to
> ${HOME}/usr/stow/git-`git describe HEAD` and then stow(8)s it.  Writing
> a similar script for sparse cannot use git describe because there are no
> tags ...
> ...
> It's a pity your not particularly interested, I like that patch's idea.
> git describe dies with an error here in a situation where there is the
> possibility to do something sensible.

I think I understand the problem pretty well, and actually I am
sympathetic to the cause.

Having said that, I do not agree with the approach of your
patch.  It makes it inconvenient for scripts to tell describable
and indescribable revs apart by checking the exit status from
the command.

In other words, I think a sensible thing can be done more sanely
in your script.  Something like this?

	#!/bin/sh
	project=git ;# or 'sparse'
	version=`git describe HEAD` ||
		version=untagged-g`git rev-parse --abbrev HEAD`
	$(MAKE) prefix=$HOME/usr/stow/$project-$version

If you want to squelch the error message from indescribable rev,
you could do:

	version=`git describe HEAD 2>/dev/null` ||

of course.
