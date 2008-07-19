From: Nick Andrew <nick@nick-andrew.net>
Subject: Out-of-repository file remove error
Date: Sat, 19 Jul 2008 18:23:14 +1000
Message-ID: <20080719082314.GA15419@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 10:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK7kY-00084e-91
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 10:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYGSIXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 04:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYGSIXV
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 04:23:21 -0400
Received: from vps1.tull.net ([66.180.172.116]:56938 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751592AbYGSIXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 04:23:20 -0400
Received: (qmail 6081 invoked by uid 1015); 19 Jul 2008 18:23:18 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Sat, 19 Jul 2008 18:23:18 +1000
Received: (qmail 15543 invoked by uid 1000); 19 Jul 2008 18:23:14 +1000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89103>

git rm seems to have a problem with removing a file from a repository
when the repository .git and working tree are not in the current
directory. It leaves an index.lock file.

Here's a script to show the bug:

mkdir Bugtest
cd Bugtest
git init
date > newfile
git add newfile
git commit -m 'Added' newfile
cd ..
git --git-dir=Bugtest/.git --work-tree=Bugtest rm newfile
ls -l Bugtest/.git/index.lock

Output:

Initialized empty Git repository in .../Bugtest/.git/
Created initial commit 43dec15: Added
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 newfile
rm 'newfile'
fatal: Unable to write new index file
-rw-r--r-- 1 nick nick 32 Jul 19 18:20 Bugtest/.git/index.lock

I tested on:

git version 1.5.6.2
git version 1.5.6.3.440.g9d8f

Nick.
