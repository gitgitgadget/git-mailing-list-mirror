From: Jing Xue <jingxue@digizenstudio.com>
Subject: file deletion in index lost after checkout -b
Date: Sun, 31 Aug 2008 23:44:14 -0400
Message-ID: <20080901034414.GR6619@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 05:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka0SY-0005m8-Rl
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 05:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYIADvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 23:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbYIADvD
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 23:51:03 -0400
Received: from k2smtpout01-01.prod.mesa1.secureserver.net ([64.202.189.88]:40211
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750927AbYIADvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 23:51:00 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Aug 2008 23:51:00 EDT
Received: (qmail 3317 invoked from network); 1 Sep 2008 03:44:20 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-01.prod.mesa1.secureserver.net (64.202.189.88) with ESMTP; 01 Sep 2008 03:44:20 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 06D5D100A22
	for <git@vger.kernel.org>; Mon,  1 Sep 2008 03:44:20 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0lQ0ghmfGuj for <git@vger.kernel.org>;
	Sun, 31 Aug 2008 23:44:15 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-133-176.dc.dc.cox.net [70.174.133.176])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 3763810007A
	for <git@vger.kernel.org>; Sun, 31 Aug 2008 23:44:15 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 5748548E9A; Sun, 31 Aug 2008 23:44:14 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94527>

In Git 1.6.0 the following sequence:

$ git init
$ echo 'abcdefgh' >1.txt
$ echo '12345678' >2.txt
$ git add 1.txt 2.txt
$ git commit -m 'init'
$ git rm 2.txt
$ echo 'qwertyuiop' >>1.txt
$ git add 1.txt
$ echo 'asdfghjkl;' >3.txt
$ git add 3.txt
$ git status
$ git checkout -b foo
$ git status

produces this output:

Initialized empty Git repository in /home/jingxue/workspace/sandboxes/test.git/.git/
Created initial commit 918f3c6: init
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 1.txt
 create mode 100644 2.txt
rm '2.txt'
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   1.txt
#       deleted:    2.txt
#       new file:   3.txt
#
M       1.txt
A       3.txt
Switched to a new branch "foo"
# On branch foo
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   1.txt
#       new file:   3.txt
#

The deletion of 2.txt appears lost during 'checkout -b foo', while the
modification and addition were both brought over. Is it a bug?

Cheers.
-- 
Jing Xue
