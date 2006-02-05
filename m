From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is the working directory for post-update hook?
Date: Sun, 05 Feb 2006 01:41:57 -0800
Message-ID: <7vd5i2kuqi.fsf@assigned-by-dhcp.cox.net>
References: <200602050906.52016.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 10:42:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5gPC-0003Ec-RE
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 10:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWBEJmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 04:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWBEJmA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 04:42:00 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:148 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750728AbWBEJl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 04:41:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205093849.QDZE20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 04:38:49 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200602050906.52016.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Sun, 5 Feb 2006 09:06:51 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15628>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> The document root of my website has a git repository under it (in the 
> standard .git subdirectory) and want a post update hook to checkout the 
> contents (so the web server sees it!) 
>
> I will be pushing to it via ssh.
>
> Does this mean that the post-update hook with be run with a working directory 
> of the web site's document root? or something relative (such as GIT_DIR) so 
> that I don't have to do a specific cd to an absolute path.

The current implementation happens to chdir to GIT_DIR and sets
GIT_DIR=. in the environment, so if you have something like
this:

	/var/www/myproject/
	/var/www/myproject/.git/
	/var/www/myproject/.git/HEAD
	/var/www/myproject/.git/...
        /var/www/myproject/README

Then $(pwd) would be /var/www/myproject/.git/.  Your hook would
probably be able to do "cd .."  to get to the project top.

However, there is no guarantee for future implementations.
