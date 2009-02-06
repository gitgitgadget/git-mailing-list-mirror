From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit] aborting tg create leafs deleted .top* files in index
Date: Fri, 6 Feb 2009 20:03:58 +0100
Message-ID: <36ca99e90902061103u24d4f38eua52d9259cb8d34d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	martin f krafft <madduck@debian.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:06:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVW1T-0008A6-3e
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZBFTEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZBFTEB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:04:01 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:36970 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZBFTEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:04:00 -0500
Received: by ey-out-2122.google.com with SMTP id 25so260199eya.37
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 11:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=gL9xKjaLvWcdYbw56jefwsWGvyaCfi9SfnO9OD08WTo=;
        b=CP8GCa9t83i5r7AOJkat1EJdttuJKzYgniH2tW0CDyxXEl6FdihAj1+jSwOxQNDuUm
         kOiy/OIvI9u6aDWxUVDbzEUZlafCedKzg0QosGUyvM11C4KN4mDrQViehT+vDlcZRePS
         ujdouVXum9u4m+Qp24ZIei4OOfYSttTL4wM/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=pMFK5X39+DIpY5l2q5hvZl52HozHqyGmG5QfOPIXjjQdzAsK0IFcDEiDZPW48tcJFi
         1y84qtT4ZHP/0dJfFXmo0z10zwvPKMHuCGITtaYzAG+uezHL9+s+0ExMgDTWi5VTw8HV
         R/qk8f4OKMWCRAa0aA6LUnZMSAu1lx82CuHM8=
Received: by 10.210.45.17 with SMTP id s17mr1539081ebs.74.1233947038265; Fri, 
	06 Feb 2009 11:03:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108769>

Hi,

after executing the abort commands to remove a just created new topic
branch, the .top* files from the previous branch are markes as
deleted.

To reproduce:

$ md g
$ cd g
$ git --version
git version 1.6.1.rc4
$ git init
Initialized empty Git repository in /home/bertw/tmp/g/.git/
$ touch file
$ git add file
$ git commit -m init
[master (root-commit)]: created 2155efd: "init"
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file
$ tg create t/test1
tg: Automatically marking dependency on master
tg: Creating t/test1 base from master...
Switched to a new branch "t/test1"
tg: Topic branch t/test1 set up. Please fill .topmsg now and make
initial commit.
tg: To abort: git rm -f .top* && git checkout master && tg delete t/test1
$ git commit -m "topic test1"
[t/test1]: created 3cb4fbf: "topic test1"
 2 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100644 .topdeps
 create mode 100644 .topmsg
$ tg create t/test2
tg: Automatically marking dependency on t/test1
tg: Creating t/test2 base from t/test1...
Switched to a new branch "t/test2"
tg: Topic branch t/test2 set up. Please fill .topmsg now and make
initial commit.
tg: To abort: git rm -f .top* && git checkout t/test1 && tg delete t/test2
$ git rm -f .top* && git checkout t/test1 && tg delete t/test2
rm '.topdeps'
rm '.topmsg'
D       .topdeps
D       .topmsg
Switched to branch "t/test1"
$ git status
# On branch t/test1
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    .topdeps
#       deleted:    .topmsg
#
$


Regards,
Bert Wesarg
