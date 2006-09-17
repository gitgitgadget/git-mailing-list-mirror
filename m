From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb:  Make git_get_refs_list do work of git_get_references
Date: Sat, 16 Sep 2006 18:22:09 -0700
Message-ID: <7vodtf8eym.fsf@assigned-by-dhcp.cox.net>
References: <200609170226.39330.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 03:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOlMN-0003HM-3w
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 03:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWIQBWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 21:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWIQBWM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 21:22:12 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31150 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964899AbWIQBWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 21:22:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917012210.WIRH26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 Sep 2006 21:22:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PDMx1V00W1kojtg0000000
	Sat, 16 Sep 2006 21:21:58 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609170226.39330.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 17 Sep 2006 02:26:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27146>

Jakub Narebski <jnareb@gmail.com> writes:

> Make git_get_refs_list do also work of git_get_references, to avoid
> calling git-peek-remote twice. It now returns either list of refs as
> before in scalar context, or references hash and list of refs in list
> context.

I do not think we want to have too many functions that return
different things depending on contexts.  Forcing callers to
remember what the function does in which context is bad.  You
seem to like writing:

	my $value = that_function(@args)

but I'd
rather see all callers to say:

	my ($value) = that_function(@args);

even when they expect just one value from the function.  One
less thing to remember, and one less source of surprises.

Especially for this particular case, you are not even avoiding
extra computation when you are only returning list, so I do not
think making the return value depend on the calling context is
buying you much.
