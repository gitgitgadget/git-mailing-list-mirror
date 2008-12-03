From: Pete Wyckoff <pw@padd.com>
Subject: git alias always chdir to top
Date: Wed, 3 Dec 2008 11:08:52 -0500
Message-ID: <20081203160852.GA3773@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 17:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7uIm-0000it-J9
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 17:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYLCQIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 11:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYLCQIz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 11:08:55 -0500
Received: from marge.padd.com ([99.188.165.110]:42877 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYLCQIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 11:08:54 -0500
Received: from oink.padd.com (oink.padd.com [69.36.12.13])
	by marge.padd.com (Postfix) with ESMTPSA id D884510F81C5
	for <git@vger.kernel.org>; Wed,  3 Dec 2008 08:07:31 -0800 (PST)
Received: by oink.padd.com (Postfix, from userid 7770)
	id E85E5FD4167; Wed,  3 Dec 2008 11:08:52 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102269>

I have a git alias that takes a relative file name argument,
and would like to know from where in the tree it was invoked,
especially if inside a subdirectory of the git tree.

Consider .git/config:

    [alias]
	pwd = !/bin/pwd

Then a git tree:

    /home/me
	topdir/
	    .git/
	    subdir/
		subdir-y.c
	    topdir-x.c

Then inside /home/me/topdir, all is well:

    $ pwd
    /home/me/topdir
    $ git pwd
    /home/me/topdir

But inside /home/me/topdir/subdir, the pwd alias is invoked in the wrong
dir:

    $ pwd
    /home/me/topdir/subdir
    $ git pwd
    /home/me/topdir

The implication of this is that I call an alias command like:

    $ pwd
    /home/me/topdir/subdir
    $ git myalias subdir-y.c
    myalias: No such file subdir-y.c

It looks like handle_alias() uses setup_git_directory_gently() to
find the .git, which chdir()s up until it gets there.  Is there a
way to do this without changing the process current working
directory instead?  I could even handle an environment variable
saving the original cwd, but that's ickier.

		-- Pete
