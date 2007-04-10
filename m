From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: git fsck and new repos / backup repos
Date: Tue, 10 Apr 2007 18:27:05 +0000 (UTC)
Message-ID: <loom.20070410T200901-466@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 03:46:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbL3x-0008R8-4O
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 20:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031397AbXDJS1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 14:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031398AbXDJS1Z
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 14:27:25 -0400
Received: from main.gmane.org ([80.91.229.2]:59128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031397AbXDJS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 14:27:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HbL3h-0003qX-FL
	for git@vger.kernel.org; Tue, 10 Apr 2007 20:27:13 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 20:27:13 +0200
Received: from scallegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 20:27:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20060601 Firefox/2.0.0.3 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44161>

Hi, 
just posting a very very minor thing, that anyway might be easy to improve...

consider the following cases:

1) Empty repo

mkdir Foo
cd Foo
git --bare init
git --bare fsck

error: HEAD is not a symbolic ref
error: No default references

Should this be an error...?  Of course fsck is not happy: HEAD points to master,
but master does not exist.  However, the newbie might find it weird that git
complains over a brand new repo it has just made.

BTW also gitk dies badly in this case.

2) Backup repo

mkdir Foo-Backup
cd Foo-Backup
git --bare init

cd <path>/Foo-Workingtree
git config --add remote.foobackup.url <url pointing to Foo Backup>
git config --add remote.foobackup.push +refs/heads/*:refs/remotes/workplace1/*
git push foobackup

cd <path>/Foo-Backup
git --bare fsck
error: HEAD is not a symbolic ref

Of course... again head points to master, but master does not exist.



Should maybe git init not just set up HEAD pointing to master, but also master
pointing to 000000000000000000000000000 and then fsck recognize that
000000000000000000000000000 is a valid pointer to nothing, namely the starting
point of a new branch?
