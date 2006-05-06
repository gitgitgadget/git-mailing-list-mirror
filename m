From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-patch: understand old <his> notation
Date: Sat, 06 May 2006 14:41:16 -0700
Message-ID: <7viroirfur.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 23:41:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUWi-0004aS-HQ
	for gcvg-git@gmane.org; Sat, 06 May 2006 23:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWEFVlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWEFVlS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 17:41:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37314 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932078AbWEFVlR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 17:41:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506214117.CLKO18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 17:41:17 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 6 May 2006 22:56:38 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19672>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When calling "git fmt-patch HEAD~5", you now get the same as if you would
> have said "git fmt-patch HEAD~5..". This makes it easier for my fingers
> which are so used to the old syntax.

While this would be easier on _my_ fingers as well, I have a
suspicion that it might make more sense to make this "single
ref" case to mean "HEAD~5^..HEAD~5" (if we _were_ designing a
new command that is called format-patch today, that would be
more natural).  But probably it is too late to break it by now.

> 	I wonder: would it make sense to make add_pending_object() and 
> 	get_reference() in revision.c non-static?

I'd rather not expose such revision.c internals too much.  An
alternative approach would be to give instruction to revision.c
(read: another flag like rev.no_walk) to tell it to do something
special when the user has only one commit, but I think what you
did in your patch is cleaner and sufficient.

Also we probably would want to default the diff options to show
the root commit diff (rev.show_root_diff).
