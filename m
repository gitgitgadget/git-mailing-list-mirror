From: Marc Branchaud <marcnarc@xiplink.com>
Subject: git svn: Supporting multiple branch subdirs?
Date: Fri, 12 Jun 2009 17:46:13 -0400
Message-ID: <4A32CCA5.7040404@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:53:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEgN-00011F-La
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 23:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763107AbZFLVw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760105AbZFLVw4
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 17:52:56 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:60060 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759470AbZFLVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 17:52:55 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2009 17:52:55 EDT
Received: from relay2.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 2D9F4E2091A
	for <git@vger.kernel.org>; Fri, 12 Jun 2009 17:46:15 -0400 (EDT)
Received: by relay2.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E28EAE2089F;
	Fri, 12 Jun 2009 17:46:13 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121454>

Hi,

I believe I need git-svn to support multiple branch subdirectories.

The motivation for this is the (partial) gitification of the FreeBSD subversion repository.  FreeBSD doesn't follow the usual branches/tags/trunk pattern.  Instead:

- FreeBSD's /trunk is called /head.

- /head is branched into /stable/X subdirs.

- Each /stable/X branch is sub-branched into /releng/X.Y subirs.

- /releng/X.Y.Z branches are tagged under /release/foo.

I'm only looking to get an updatable mirror of their repo -- I don't (yet) need to push changes back to FreeBSD.

I'd like to modify git-svn to support multiple (at least two) -b parameters, so I could import the FreeBSD repo with something like
	git svn init --trunk=head \
		--branches=stable \
		--branches=releng \
		--tags=release \
		file:///local/mirror/of/svn.freebsd.org/base/
	git svn fetch

Is this approach wise or even feasible?  A couple of possible show-stoppers I see are:

- The releng/X.Y branches are created from the stable/X  tree, where X itself doesn't exist from the start.

- FreeBSD likes to make single commits that spans multiple branches.  This is usually done as a security patch: One commit can, for example, touch /head, /stable/X, /stable/W, and several branches under /releng.

If this isn't completely off the wall, I'd appreciate some pointers on the git-svn.perl code.  I've tried searching through the code to see how the -b parameter is handled, but I got lost pretty quickly.  How does the fetch command deal with branches?

Thanks,

		M.
