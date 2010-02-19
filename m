From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [BUG] girocco + git-svn: trunk is not propagated to master
Date: Fri, 19 Feb 2010 16:22:07 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100219132206.GA13734@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Feb 19 14:24:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiSqe-0000yY-EP
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 14:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab0BSNYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 08:24:43 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37137 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab0BSNYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 08:24:42 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NiSqI-0005SI-Bi; Fri, 19 Feb 2010 16:24:26 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NiSo3-0003c0-1j; Fri, 19 Feb 2010 16:22:07 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140448>

Hello Petr, Miklos, All,

Recently I've setup an svn mirror on repo.or.cz for docutils projects[1].
Automatic regular updates by `git svn fetch` seem to work, so first
thanks for the service.

However master is not updated at all, and also refs/heads/* are not
populated from refs/remotes/* it seems.

In Girocco's taskd/clone.sh[2] and jobd/update.sh[3], I see there is a
nice setup for master to be bound to trunk and also refs/remotes/heads/*
to be propagates to refs/remotes/*:

---- taskd/clone.sh ----
svn://*)
    GIT_DIR=. git svn fetch
    # Neat Trick suggested by Miklos Vajna
    GIT_DIR=. git config remote.origin.url .
    GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
    GIT_DIR=. git config remote.origin.fetch +refs/remotes/trunk:refs/heads/master
    GIT_DIR=. git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
    GIT_DIR=. git fetch

---- jobd/update.sh ----
svn://*)
        GIT_DIR=. bang git svn fetch
        GIT_DIR=. bang git fetch


But it seems it does not work. First I see there is a need for quoting,
so e.g. 

-   GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
+   GIT_DIR=. git config remote.origin.fetch '+refs/remotes/heads/*:refs/heads/*'

but I'm not sure it will fix the problem.

Can we do something about it please?


Thanks beforehand,
Kirill


[1] http://repo.or.cz/w/docutils.git
[2] http://repo.or.cz/w/girocco.git/blob/HEAD:/taskd/clone.sh#l25
[3] http://repo.or.cz/w/girocco.git/blob/HEAD:/jobd/update.sh#l41
