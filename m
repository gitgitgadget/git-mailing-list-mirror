From: "Art Haas" <ahaas@airmail.net>
Subject: Problems importing SVN repo via git-svnimport
Date: Sat, 26 May 2007 07:55:53 -0500
Message-ID: <20070526125553.GC10324@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrvoq-0000rk-Pk
	for gcvg-git@gmane.org; Sat, 26 May 2007 14:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXEZM4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 08:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbXEZM4U
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 08:56:20 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:64246 "EHLO
	ms-smtp-04.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXEZM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 08:56:20 -0400
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-04.texas.rr.com (8.13.6/8.13.6) with ESMTP id l4QCuIA9029080
	for <git@vger.kernel.org>; Sat, 26 May 2007 07:56:18 -0500 (CDT)
Received: (qmail 8691 invoked by uid 1000); 26 May 2007 12:55:53 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48470>

Hi.

I'm attempting to convert the Subversion repo of my project PythonCAD
(shameless plug http://www.pythoncad.org) into git, and have not had
much luck so far. Yesterday I installed an up-to-date set of SVN::Perl
modules and began trying to do the import.

On my local machine the repo is file:///mnt/src/svnrepo, and the
structure inside is 'pythoncad/trunk', 'pythoncad/branches', and
'pythoncad/tags'. For those playing at home, you can access the
public repo via http://subversion.pythoncad.org:9000/svn and you
should see the same layout. Way back when I started, though, the
initial directory was called 'pycad', and it lasted up through
revision 113, when in revision 114 it became 'pythoncad'. The next
eight or nine revisions involve me moving files around into the
new directory path. I don't remember exactly why I did the rename
right now (it's more than four years ago) but I think it was because I
found other 'pycad' projects/companies on the internet.

So, with 'git-svnimport' I've tried a number of different commands to
pull my data into git, and have only succeeded in getting a log history
into git but none of the actual file data makes it in. In my newly
built git repo I can do 'git log' and read all the checkin comments that
I made using 'svn commit'; git imports this data without problem. My
actual files, however, never appear. I poked around the git-svnimport
code a bit, added a few print statements here and there, and found that
the commit subroutine is failing. Specifically, during the loop where
the actions listed in the log output are scanned (around line 690),
the tests to determine the node_kind are always returning
$SVN::Node::none, not $SVN::Node::file or $SVN::Node::dir, so my
tree never gets populated with files and directories.

I tried importing only the first 114 revisions (the 'pycad' set) with
the following command:

$ git svnimport -C /tmp/pycad.git -l 114 -A authors -T pycad/trunk \
-b pycad/branches -t pycad/tags -v file:///mnt/src/svnrepo /pycad

I've also tried starting at rev 114 and going to the end (the
'pythoncad' set) but the end result is a git repo with a log file but no
file content.

I'm happy to dive into the perl code in svnimport and make changes to
help debug this problem, if there is actually a problem and not user
error on my part. Any help from 'svnimport' experts will be greatly
appreciated. The public repo listed above has the same contents as my
local repo, so feel free to poke around it to see how things are
structured.

Thanks in advance.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
