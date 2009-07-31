From: Yakup Akbay <yakbay@ubicom.com>
Subject: Feature Request: Capability to save and load the workspace
Date: Fri, 31 Jul 2009 11:45:16 +0300
Message-ID: <4A72AF1C.1020500@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 10:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWnqo-00058n-Vv
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 10:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZGaIwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 04:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZGaIwW
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 04:52:22 -0400
Received: from server70b.appriver.com ([74.205.4.150]:3604 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751335AbZGaIwV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 04:52:21 -0400
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-44/SG:2 7/31/2009 4:50:59 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.659205 p=-0.833333 Source Normal
X-Signature-Violations: 0-0-0-4926-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 114 115 116 117 121 122 217 
X-Note: Mail Class: VALID
X-Note: Headers Injected
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 100392754 for git@vger.kernel.org; Fri, 31 Jul 2009 04:51:35 -0400
Received: from [172.18.200.110] ([172.18.200.110]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Jul 2009 01:43:02 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
X-OriginalArrivalTime: 31 Jul 2009 08:43:02.0828 (UTC) FILETIME=[EA7006C0:01CA11BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124513>

I'm not sure whether such a feature exists or not. But let me explain my
concern.

Say, we have different profiles for different products. When I work on a
profile (edit, configure, build etc.) I can't switch to another profile
before I distclean the existing one. So, when I have to work on 2
projects at the same time, I have to have 2 copies of the same source
tree. This might be OK for 2, but if the repository is around 3 gigs
this is not quite suitable for more than 2 profiles.

IT WOULD BE NICE to have a feature in git that allows us to save the
current workspace then work on a different profile on a clean
environment. Then save that profile and switch back to the previous
profile at any time without losing the environment.

Currently, I'm doing this myself using some scripts like:


work on foo

$ ./project-save foo
work on bar
$ ./project-save bar
$ ./project-load foo
keep working on foo
etc.


where, project-save looks like:
1. BRANCH=<current branch>
2. echo $BRANCH > .BRANCH
3. git checkout -q -b foo
4. git add -f .
5. git commit -q -m 'Save foo'
6. git checkout -q $BRANCH

This simply forks a new branch 'foo' then adds/commits all untracked +
gitignore'd files to 'foo'. In addition, it stores the current branch
name in a temporary file (.BRANCH). (All binary files and even temporary
file are committed.)


and, project-load looks like:
1. git checkout -q -f foo -- .BRANCH
2. BRANCH=`cat .BRANCH`
3. git checkout -q -f $BRANCH
4. git checkout -q -f foo -- .
5. git reset -q
6. rm -f .BRANCH

This gets the target branch name from the file .BRANCH in 'foo',
switches to that branch and checks out all files from 'foo'. At the end
it removes .BRANCH file. 

If I want to completely remove the project foo, then I simply remove the
branch 'foo'.
---

The problem is that this works way too slow  :-(  (this has some other
problems as well). I believe, such a feature could be implemented more
efficiently in the core, but I'm so familiar with core git.
 

What do you think?

Yakup


 
