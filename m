From: Eric Blake <ebb9@byu.net>
Subject: Problem with case-insensitive file cleanup
Date: Thu, 03 May 2007 06:49:41 -0600
Message-ID: <4639DA65.3030401@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib <bug-gnulib@gnu.org>
To: git@vger.kernel.org
X-From: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org Thu May 03 14:48:43 2007
Return-path: <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-gnulib@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjajf-0007Rx-13
	for gnu-bug-gnulib@m.gmane.org; Thu, 03 May 2007 14:48:39 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1HjaqA-00083b-Qt
	for gnu-bug-gnulib@m.gmane.org; Thu, 03 May 2007 08:55:22 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Hjapq-0007vB-Hp
	for bug-gnulib@gnu.org; Thu, 03 May 2007 08:55:02 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Hjapo-0007uW-CN
	for bug-gnulib@gnu.org; Thu, 03 May 2007 08:55:02 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Hjapo-0007uQ-1R
	for bug-gnulib@gnu.org; Thu, 03 May 2007 08:55:00 -0400
Received: from alnrmhc13.comcast.net ([206.18.177.53])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <ebb9@byu.net>) id 1HjajH-0005SQ-5K
	for bug-gnulib@gnu.org; Thu, 03 May 2007 08:48:15 -0400
Received: from [192.168.0.103]
	(c-71-199-58-92.hsd1.ut.comcast.net[71.199.58.92])
	by comcast.net (alnrmhc13) with ESMTP
	id <20070503124813b1300dq8qie>; Thu, 3 May 2007 12:48:13 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
	rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.94.3.0
X-detected-kernel: NetCache Data OnTap 5.x
X-BeenThere: bug-gnulib@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Gnulib discussion list <bug-gnulib.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-gnulib>
List-Post: <mailto:bug-gnulib@gnu.org>
List-Help: <mailto:bug-gnulib-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=subscribe>
Sender: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Errors-To: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46083>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Right now, the gnulib repository is mastered in CVS but mirrored by git (I
am still awaiting the day that Jim decides that his hooks are adequate
enough that git can be the master and CVS provided by git-cvsserver).
Earlier this week, I reported a problem when two case-insensitive files
were created, which is a no-no for checkouts on Mac HFS+ or Windows-based
platforms [1].  The problem was quickly corrected in CVS (note that
_Exit.texi now lives in the attic [2]).  But somehow the git repository
still thinks that _Exit.texi belongs to the current tree [3], which leads
to this confusing state on a case-insensitive clone:

$ git pull
Already up-to-date.
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   doc/functions/_Exit.texi
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git reset --hard HEAD
HEAD is now at 7464768... Merge branch 'master' of git://git.sv.gnu.org/gnulib
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   doc/functions/_exit.texi
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git reset --hard HEAD
HEAD is now at 7464768... Merge branch 'master' of git://git.sv.gnu.org/gnulib
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   doc/functions/_Exit.texi
#
no changes added to commit (use "git add" and/or "git commit -a")

What needs to happen to get rid of the _Exit.texi listing in the git
repository, so that case insensitive file systems can clone the gnulib.git
repository?

[1]http://lists.gnu.org/archive/html/bug-gnulib/2007-05/msg00012.html
[2]http://cvs.savannah.gnu.org/viewcvs/gnulib/doc/functions/Attic/_Exit.texi?rev=1.3&root=gnulib&view=log
[3]http://git.sv.gnu.org/gitweb/?p=gnulib.git;a=tree;f=doc/functions;hb=a71ea03e4262db77dd90eaf35bad5fee6f79d15e

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOdpl84KuGfSFAYARAhyEAJ9RFH9anyBa69uksVmG+0XetFJlvgCeNBsf
t1ppuGgwxq/kGr0G6qZGV6g=
=vS7d
-----END PGP SIGNATURE-----
