From: Russell King <rmk@arm.linux.org.uk>
Subject: [RFC] Order of push/pull file transfers
Date: Thu, 23 Jun 2005 11:12:55 +0100
Message-ID: <20050623111255.A1162@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 23 12:22:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlOr2-0005T6-Ih
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 12:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVFWKW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVFWKRl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 06:17:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34062 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262550AbVFWKNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 06:13:00 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DlOhd-000088-Bw
	for git@vger.kernel.org; Thu, 23 Jun 2005 11:12:57 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DlOhb-0000Nb-TV
	for git@vger.kernel.org; Thu, 23 Jun 2005 11:12:55 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I'd like to start a discussion on the ordering of the various git files
being transferred.

Last night, I pulled Linus' kernel tree from k.o, but Linus was in the
middle of pushing an update to it.  The way cogito works, it grabs the
HEAD first, and then rsyncs the objects.

However, this retrieved the updated HEAD, and only some of the objects.
cogito happily tried to merge the result, and failed.  A later pull
and git-fsck-cache confirmed everything was fine _in this instance_.

Therefore, may I suggest the following two changes in the way git
works:

1. a push updates HEAD only after the rsync/upload of all objects is
   complete.  This means that any pull will not try to update to the
   new head with a partial object tree.

2. a pull only tries to fetch objects if HEAD has been updated since
   the last pull.

This gives a pull-er an additional safety margin which ensures that
merges will not be attempted when a simultaneous pull and push occurs
at the same time.

-- 
Russell King

