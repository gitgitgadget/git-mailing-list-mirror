From: Duane Murphy <duanemurphy@mac.com>
Subject: Pull --rebase looses merge information
Date: Thu, 06 Oct 2011 12:21:56 -0700
Message-ID: <DECF417E-50BB-4963-965C-BEF1B5C95DAC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:22:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBuSB-00045m-G8
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759186Ab1JFUV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 16:21:58 -0400
Received: from asmtpout021.mac.com ([17.148.16.96]:34406 "EHLO
	asmtpout021.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759171Ab1JFUV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:21:58 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2011 16:21:58 EDT
Received: from [192.168.1.108]
 (70-36-184-216.dsl.static.sonic.net [70.36.184.216])
 by asmtp021.mac.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPSA id <0LSN005BNSGKKO70@asmtp021.mac.com> for git@vger.kernel.org;
 Thu, 06 Oct 2011 12:21:57 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.4.6813,1.0.211,0.0.0000
 definitions=2011-10-06_07:2011-10-06,2011-10-06,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=5 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=6.0.2-1012030000
 definitions=main-1110060205
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183028>

Here is the synopsis:

$ git checkout master
$ git pull
... time passes ... 
$ git checkout topic # remote topic
$ git checkout master
$ git merge topic
$ git push
    non-fast-forward updates were rejected
$ git pull 
    merge by rebase; implied by config
$ git push

The result of this process is that the file changes are pushed but the reference back to the topic branch has been lost. This makes it appear as though the topic branch has not been merged properly.

The trigger appears to be the pull (with rebase) that occurs after the merge and before the push. This of course is caused by the repo being out of sync from the point when the merge was started. That window of time can be shortened but it can never be zero.

The problem is fixed by merging again, but it's difficult to notice that this problem has actually occurred.

It has been noted that the problem is that we are using rebase on pull. We set our configurations to always rebase on a pull from a remote branch. This makes sense as it prevents artificial merges and unusual modifications to the history with respect to the shared repository. That is, if I'm working on merging changes into a remote branch and some one beats me, my merge should be after his, not before.

I would hope that a rebase operates mostly like a merge (understanding that rebase is different). I would not expect the merge information (ie the source branch of the merge) to be lost just because of a rebase.

Is there a bug here? Is there some way to avoid this situation without sacrificing the benefits of pull --rebase?

Thanks,

 ...Duane
