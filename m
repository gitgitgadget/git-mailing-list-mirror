From: Jan Holesovsky <kendy@suse.cz>
Subject: Yet another SVN to git conversion tool
Date: Mon, 8 Jun 2009 16:32:15 +0200
Message-ID: <200906081632.15343.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 16:32:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDfth-0003mO-TV
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 16:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbZFHOcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZFHOcO
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 10:32:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38604 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbZFHOcO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 10:32:14 -0400
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A9B5E8640B
	for <git@vger.kernel.org>; Mon,  8 Jun 2009 16:32:15 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121077>

Hi,

Recently I needed to convert the Gnome ooo-build repository from the Gnome SVN 
to git [1], and also create a regularly updated git mirror of the 
OpenOffice.org SVN repository [2].  Unfortunately I did not find a tool that 
would suffice my needs - git-svn was unable to handle more branches, and 
http://repo.or.cz/w/svn-all-fast-export.git had a Qt4 dependency that made it 
problematic to even compile, not to mention the syntax of the repository 
description file(s) that I did not really understand - so I decided to create 
a new tool based on svn-fast-export.c [3]:

http://cgit.freedesktop.org/ooo-build/contrib/svn-to-git

I made it for our needs, so there is just a simple Makefile, the code might be 
hacky here and there [and is C++ ;-)], but it seems to work really well - at 
least for us [4] :-)

Features:

- perfect import of trunk (master), branches and tags
  - even when you svn cp things around like
    svn cp branches/blah/bleh trunk/foo/bar
  - when there are commits to the tags

- change login names to real names and email addresses

- converts ChangeLog-like commit messages to git-like (optionally)

- allows you to split one SVN tree to multiple git trees
  - based on regexps

- allows you to convert leading tabs to spaces in files you choose
  - (fixes a terrible pain in the OOo sources where tab is set to 4 spaces,
    and leading tabs and spaces are combined in nearly every source file!)

- allows you to ignore broken tags/commits

- and is really fast
  - the OOo SVN with ~270000 commits in < 1hr on the right H/W ;-)

Documentation is a bit lacking, but basically you need to create one file 
containing the description of the repositories, and one with the names/emails 
of the svn login names, and you are ready to start ./svn-to-git.sh.  
Description files I used for the ooo-build and OOo conversions are included.

So - if you are interested, and have a SVN repository to convert, give it a 
try.  And if you have patches, please send them to me :-)

Regards,
Kendy

[1] http://cgit.freedesktop.org/ooo-build/ooo-build
[2] http://cgit.freedesktop.org/ooo-build except ooo-build, website and 
contrib/
[3] from http://repo.or.cz/w/fast-export.git
[4] http://www.go-oo.org
