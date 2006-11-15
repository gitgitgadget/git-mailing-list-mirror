X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Troy Telford" <ttelford.groups@gmail.com>
Subject: git-svn bug?
Date: Wed, 15 Nov 2006 14:05:37 -0700
Message-ID: <op.ti2svo0ozidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 21:06:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=JCIzyaMphCfR3S05GNCFyUbSaPL5qaITrRub8qNAO5dYrT5ehFL4JIoXdwa5IDZ936wjpRsHrYV8eNILNCGpPdIMbGar/RU6rG/9eKasPUBlHRM/1P7sX8a+ga2QPIPpbhty8ABfurDF8bJemvfIO/XK+yOiQQVYkKbgVD1xv1M=
User-Agent: Opera Mail/9.10 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31496>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRxQ-0007t7-HK for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030997AbWKOVFx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031002AbWKOVFx
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:05:53 -0500
Received: from hu-out-0506.google.com ([72.14.214.230]:47498 "EHLO
 hu-out-0506.google.com") by vger.kernel.org with ESMTP id S1030997AbWKOVFw
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:05:52 -0500
Received: by hu-out-0506.google.com with SMTP id 36so1362106hui for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 13:05:50 -0800 (PST)
Received: by 10.67.19.13 with SMTP id w13mr3672447ugi.1163624749754; Wed, 15
 Nov 2006 13:05:49 -0800 (PST)
Received: from rygel.lnxi.com ( [63.145.151.2]) by mx.google.com with ESMTP
 id k1sm1464905ugf.2006.11.15.13.05.47; Wed, 15 Nov 2006 13:05:49 -0800 (PST)
To: "git@vger.kernel.org" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I've got a repository I've converted over to git from svn.  (using  
git-svn.  since there's only been one branch, I figured I could skip  
git-svnimport).

For quite a while, all I did was fetch/rebase from the svn repository to  
my git repository; all of my own work was committed to the git repository;  
none of the changes were commited to the svn repository.

Then came the time to commit changes from my git repository to the svn  
repository.

Being somewhat cautious, I created an empty 'dummy' svn repository and  
familiarize myself with using git-svn to commit from git -> svn.

I ran:
git-svn fetch
git-svn rebase remotes/git-svn (already updated)
git-svn dcommit (to push my changes to the svn repository)

Everything seemed to work fine with the dummy repository.

Encouraged, I did the same with the 'real' repository, and received the  
following error:
(Using git 1.4.3.5, svn 1.4.0 on a Gentoo box)
fatal: Not a valid object name 92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1
32768 at /usr/lib64/perl5/5.8.8/Memoize.pm line 269

(using git 1.4.4, svn 1.3.0 on a SLES 9 SP3 box)
fatal: Not a valid object name 92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1
32768 at /usr/lib/perl5/5.8.3/Memoize.pm line 269

(using git 1.4.4, svn 1.3.1 on a SLES 10 box)
fatal: Not a valid object name 92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1
32768 at /usr/lib/perl5/5.8.8/Memoize.pm line 269

I had NFS mounted the git repository, so the SLES 9 was local the other  
two were NFS.  In any event, the error seems to be essentially identical  
on every platform I've tried.

Additionally, I had created three branches for the purpose of pushing my  
changes to svn:
master (used for my own development)
svn (created using git checkout -b svn remotes/git-svn -- basically only  
what is in svn)
merge (git checkout -b merge svn; git rebase master)

`git diff-tree merge master | wc -l` returns 0 (which I assume means no  
changes)
`git diff-tree svn merge | wc -l` returns 44 (again, I assume this means  
44 changes)

I couldn't find an object named  
"92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1" in .git/

Aside from my cluelessness, is there anything else wrong?
-- 
