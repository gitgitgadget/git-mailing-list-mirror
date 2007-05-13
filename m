From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Sun, 13 May 2007 10:17:07 -0700
Message-ID: <20070513171707.GA14024@muzzle>
References: <vpq7irfengj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 13 19:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnHh7-00051Z-SY
	for gcvg-git@gmane.org; Sun, 13 May 2007 19:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbXEMRRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 13:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757324AbXEMRRK
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 13:17:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53435 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754019AbXEMRRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 13:17:09 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D59797DC0A3;
	Sun, 13 May 2007 10:17:07 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 10:17:07 -0700
Content-Disposition: inline
In-Reply-To: <vpq7irfengj.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47152>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Hi,
> 
> I'm using git-svn, which usually works fine, but I occasionally get
> this:
> 
> $ git-svn dcommit           
>         A       file1
>         A       file2
> Network connection closed unexpectedly: Connection closed unexpectedly at /path/to/git-svn line 401
> $
> 
> The failure seems to depend on the commit's I'm pushing, since this is
> reproducible when running several times "dcommit" for the same commit,
> but the same command also usually works fine on the same repositories
> (same git repo, same svn target).
> 
> The svn repository is accessed with svn+ssh://user@machine/path/.

Does the patch in
  http://permalink.gmane.org/gmane.comp.version-control.git/47126
help?

If so, I'm not sure why it should be failing sometimes and not
all the time.  If your local username the same as the username
you're using for svn it shouldn't fail for the reason that patch
above is needed.

Using the native svn or svn+ssh protocol is definitely flakier in my
experience, and there are still known issues with connections closing
during *fetch*.  dcommit is actually a lot more straightforward
as it only connects once, whereas fetch can reconnect to different
parts of the repo for --follow-parent.

> exporting the patch, applying it to an svn checkout, and "svn commit"
> works fine.
> 
> Let me know if I can provide any other usefull information for
> debugging.
> 
> Thanks,
> 
> Debian etch (stable)
> Reproducible with both git 1.5.1.1 and the latest from git:
> 
> $ git-svn --version
> git-svn version 1.5.2.rc3.3.ge347 (svn 1.4.2)

Which version of SVN is running on the server?

-- 
Eric Wong
