From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 00:46:23 -0800
Message-ID: <7v4ppnhkps.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 09:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHcG6-00083u-7i
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 09:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbXBOIqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 03:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbXBOIqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 03:46:25 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54798 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964978AbXBOIqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 03:46:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215084623.YVPZ21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 03:46:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PkmP1W00Y1kojtg0000000; Thu, 15 Feb 2007 03:46:24 -0500
In-Reply-To: <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Feb 2007 21:27:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39801>

Junio C Hamano <junkio@cox.net> writes:

> I am not quite sure how $GIT_CONFIG and $GIT_CONFIG_LOCAL were
> meant to be used.  Are there any *real* users?  With lack of
> information on the intended uses of these two environment
> variables, I hacked up the following tweaks on top of the above
> defined semantics, to imitate what I _think_ was the original
> intention.  The hacked one goes like this:
>
>  - $GIT_CONFIG environment, if set, names a file to be read
>    first.  We read it first.
>
>  - If $GIT_CONFIG is unset, then $GIT_CONFIG_SYSTEM (or
>    /etc/gitconfig) and $HOME/.gitconfig are read, as above.
>
>  - Next file to be read is $GIT_CONFIG_LOCAL (if set) or
>    $GIT_DIR/config.  When reading this file, if we read from
>    $GIT_CONFIG earlier, we read only "core.*" section from it.
> ...

Addendum.

Judging from the way builtin-config.c::get_value() uses it, I
think whoever invented $GIT_CONFIG_LOCAL as a parallel to
$GIT_INDEX_FILE and $GIT_OBJECT_DIRECTORY, in other words, what
usually appear under $GIT_DIR can be placed somewhere completely
different.  So I think the above "hack" I described still honors
its intended use.

I am still not sure what good GIT_CONFIG would be to completely
override everything else, though.
