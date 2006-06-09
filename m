From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 12:51:23 -0700
Message-ID: <7v1wtynm4k.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795782F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 21:51:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fon0y-0004LX-2F
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 21:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWFITvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWFITvZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 15:51:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53980 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030442AbWFITvY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 15:51:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060609195123.PIJW5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 15:51:23 -0400
To: "Post, Mark K" <mark.post@eds.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21544>

"Post, Mark K" <mark.post@eds.com> writes:

> I'm trying to set up a git repository for mainframe Linux developers to
> use at git390.osdl.marist.edu.  Everything _seemed_ to go well, until
> Martin Schwidefsky started actually pushing changes back to the
> repository.  When he does that, the projects disappear from the web page
> that gitweb.cgi is generating.

> As far as I can tell, the problem is happening because these files are
> being written out with file permissions of 640, and since Apache is
> running as user wwwrun, it can't read them:
> -rw-r-----  1 sky git  5490 Jun  9 03:35 ./linux-2.6.git/info/refs
> -rw-r-----  1 sky git    54 Jun  9 03:35
> ./linux-2.6.git/objects/info/packs
> -rw-r-----  1 sky git    41 Jun  9 03:35

First of all, it is not git-daemon that is updating these refs.
The daemon is a read only facility.

And you have checked the suggestion by Linus to set the umask to
world readable, which brings me to the next question.  

How did Martin actually "push changes back"?

Was it over git protocol over SSH, or the webdav thing over http
push?  The comment by Linus is about the former and I do not
know offhand who webdav thing runs as or how it handles the
permissino bits.

It could be that your ssh daemon installation bypasses .bashrc
and uses its own .ssh/environment, in which case your user would
may need to do umask there as well.
