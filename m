From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: What is the working directory for post-update hook?
Date: Sun, 5 Feb 2006 10:58:26 +0000
Message-ID: <200602051058.26570.alan@chandlerfamily.org.uk>
References: <200602050906.52016.alan@chandlerfamily.org.uk> <7vd5i2kuqi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 11:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5hbM-0006XX-58
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 11:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWBEK6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 05:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWBEK6X
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 05:58:23 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:7364
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751449AbWBEK6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 05:58:23 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F5hb4-00019H-BW; Sun, 05 Feb 2006 10:58:22 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <7vd5i2kuqi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15630>

On Sunday 05 February 2006 09:41, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> > The document root of my website has a git repository under it (in the
> > standard .git subdirectory) and want a post update hook to checkout the
> > contents (so the web server sees it!)
> >
> > I will be pushing to it via ssh.
> >
> > Does this mean that the post-update hook with be run with a working
> > directory of the web site's document root? or something relative (such as
> > GIT_DIR) so that I don't have to do a specific cd to an absolute path.
>
> The current implementation happens to chdir to GIT_DIR and sets
> GIT_DIR=. in the environment, so if you have something like
> this:
>
> 	/var/www/myproject/
> 	/var/www/myproject/.git/
> 	/var/www/myproject/.git/HEAD
> 	/var/www/myproject/.git/...
>         /var/www/myproject/README
>
> Then $(pwd) would be /var/www/myproject/.git/.  Your hook would
> probably be able to do "cd .."  to get to the project top.
>

I did get it to work doing a cd .. - although you also have to unset GIT_DIR, 
because its is literally "." and not the directory that was "." at the time 
of setting, so a cd .. ; checkout -f then fails with an invalid repository.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
