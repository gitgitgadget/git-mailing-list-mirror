From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Thu, 17 Nov 2005 16:49:52 -0800
Message-ID: <7voe4ird8v.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.428785C7FA@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 01:51:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcuS4-0007vZ-Sf
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 01:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVKRAtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 19:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKRAtz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 19:49:55 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40100 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751315AbVKRAty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 19:49:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118004857.JWBH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 19:48:57 -0500
To: exon@op5.se (Andreas Ericsson)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12181>

exon@op5.se (Andreas Ericsson) writes:

> Everything that worked earlier still works insofar as I have
> remembered testing it.

Hmph...

> @@ -152,45 +140,17 @@ static int set_dir(const char *dir)
>  	 * We want a readable HEAD, usable "objects" directory, and
>  	 * a "git-daemon-export-ok" flag that says that the other side
>  	 * is ok with us doing this.

Well, not anymore about HEAD as far as I can tell...  Maybe in
enter_repo ([PATCH 1/5]) we need to do something like what
setup.c::is_toplevel_directory() does?

> -static int upload(char *dir)
> -{
> -	/* Try paths in this order */
> -	static const char *paths[] = { "%s", "%s/.git", "%s.git", "%s.git/.git", NULL };

I think this list was added relatively recently as a usability
measure.  Maybe we would want an equivalent in enter_repo()?
Under strict-path, I think not doing any DWIM like this is fine,
but otherwise I suspect changing this would break existing
remotes/origin file people may have.  In addition enter_repo()
as posted does its own DWIM to chdir to ".git" unconditionally
as I pointed out...

Needs a bit more thought, but I think otherwise the basic idea
is right.
