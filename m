From: Steffen Prohaska <prohaska@zib.de>
Subject: git-cvsserver will crash for multi-rooted history
Date: Thu, 24 Jan 2008 17:24:27 +0100
Message-ID: <5E211213-2D07-4C16-99E1-6E8E3309D062@zib.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 17:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI4ry-0008Lc-21
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 17:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYAXQXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 11:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYAXQXa
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 11:23:30 -0500
Received: from mailer.zib.de ([130.73.108.11]:49922 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbYAXQX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 11:23:29 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0OGNRls021765
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 17:23:27 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0OGNRSA021533
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 24 Jan 2008 17:23:27 +0100 (MET)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71629>

git-cvsserver in master will crash if the history has multiple
roots.  The problem is that git-merge-base might fail to find a
merge base and this situation is not handled by git-cvsserver.

Unfortunately, I'll not have time to address this immediately;
but it is a bug in current master, so I think at least you
should now.  Here is the code ...

2540                     # git-merge-base can potentially (but  
rarely) throw
2541                     # several candidate merge bases. let's assume
2542                     # that the first one is the best one.
2543                     if ($parent eq $lastpicked) {
2544                         next;
2545                     }
2546                     my $base = safe_pipe_capture('git-merge-base',
2547                                                  $lastpicked,  
$parent);

... the line above will fail.

2548                     chomp $base;
2549                     if ($base) {
2550                         my @merged;
2551                         # print "want to log between  $base  
$parent \n";
2552                         open(GITLOG, '-|', 'git-log', "$base.. 
$parent")


	Steffen
