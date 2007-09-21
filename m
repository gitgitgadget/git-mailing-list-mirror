From: Eric Blake <ebb9@byu.net>
Subject: cvsimport bug on branches [was: conversion to git]
Date: Thu, 20 Sep 2007 19:17:47 -0600
Message-ID: <46F31BBB.1040901@byu.net>
References: <loom.20070920T010842-272@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: m4-patches@gnu.org, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 03:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYX9A-0007kg-JA
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 03:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXIUBR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXIUBR0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 21:17:26 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:65532 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbXIUBRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 21:17:25 -0400
Received: from [192.168.0.103] (c-67-166-125-73.hsd1.co.comcast.net[67.166.125.73])
          by comcast.net (sccrmhc14) with ESMTP
          id <2007092101172401400rjgcle>; Fri, 21 Sep 2007 01:17:24 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <loom.20070920T010842-272@post.gmane.org>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58817>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 9/19/2007 5:13 PM:
> I'm working on converting M4 to git.
> 
> The initial git conversion is complete.  Feel free to check it out:
> 
> http://git.savannah.gnu.org/gitweb/?p=m4.git

Unfortunately, after publishing this repository, I noticed that there is a
bug in git-cvsimport, when a vendor branch is created that contains fewer
files than the point it branched from.  Those files were not removed from
the commit on the new branch, which means the git repository contains too
many files compared to what the CVS repository had for any checkout along
the branch.

For example, look at the m4-1.4.1 tag.  In CVS,

http://cvs.savannah.gnu.org/viewvc/m4/?root=m4&hideattic=0&pathrev=m4-1_4_1

shows the following:
ABOUT-NLS (dead) 	No revisions exist on m4-1_4_1

and for the file ChangeLog, the predecessor of m4-1_4_1 (rev 1.1.1.1.2.1)
was m4-1_4 (rev 1.1.1.1):

http://cvs.savannah.gnu.org/viewvc/m4/ChangeLog?hideattic=0&view=log&root=m4&pathrev=m4-1_4_1


But after git-cvsimport (using git 1.5.3), tag m4-1.4.1 is shown on the
branch-1_4 branch, but with unrelated m4-1.4ppre2 as parent, instead of
the correct m4-1.4:

http://git.sv.gnu.org/gitweb/?p=m4.git;a=shortlog;h=ab2ce6be

and as a result, the tree includes ABOUT-NLS (which was correctly a part
of the m4-1.4ppre2 tag on the master branch):

http://git.sv.gnu.org/gitweb/?p=m4.git;a=tree;h=ab2ce6bec48;hb=ab2ce6bec4


Now that the repository is published, what's the best way to correct the
history for the git m4-1.4.1 tag, to correctly pick the m4-1.4 commit as
its parent, and to omit the files that were intentionally omitted from the
CVS branch it was imported from?

What needs to be done to git-cvsimport to make it recognize files that
were omitted from CVS branch creation points, to avoid this problem in the
first place?

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG8xu684KuGfSFAYARAjd8AJ0eOWw1TFGt4zpQKIDFTGRjxzI/cgCghBpM
W91wfRwc8Q2hoMO1WCWYtzM=
=zzNR
-----END PGP SIGNATURE-----
