X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Advice on converting to git from versioning-by-directory
Date: Thu, 23 Nov 2006 09:16:44 +0000
Message-ID: <200611230916.46415.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 09:17:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jzqrsthc97UkOxPvU+PsycA5u+sGRiH075ySRZJMkkMlsWSM+LRRx4YABDZglDmAXovAz72RhTh1iUf6HDH2nisdBVIjuX5s+lKHaTLwq3oe5/Mn9vfMrIPU81aFxBR/lQqGl+a4DeMkKSDq8/VKGEDTSNO+Fl7uu+aFGmuk1pA=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32125>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnAhs-0001pA-I5 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933394AbWKWJQx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 04:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbWKWJQx
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:16:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55355 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933394AbWKWJQv
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 04:16:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so386437uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 01:16:50 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr4738387ugi.1164273409816; Thu, 23
 Nov 2006 01:16:49 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id s7sm12817752uge.2006.11.23.01.16.49; Thu, 23 Nov 2006 01:16:49 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

This is an overly long email, please don't waste your time unless you're 
interested in git-based puzzles.  I'm only really trying to solve the problem 
for fun. (This is what I do for fun now?  Oh dear).

I'm in the process of converting a colleague to using git for his project.  
Previously it was stored in subversion - but was only really used as a backup 
system, history is entirely linear and there are no merges and no branches.  
Branching was effectively done by copying directories.  So the history went 
like this:

 * version1/ created and worked on with regular commits
 * version2/ created as a copy of version 1
 * version2/ worked on with regular commits
 * occasional commits in version1/
 * version3/ created as a copy of version2/ and worked on
 * version4/ created as a copy of version2/ and worked on

I simply converted the subversion repository to git and then used a bit of 
rebase and cherry-pick work to put each commit in a particular directory in 
its correct branch.

 * -- * -- * -- * -- * version1
            \
             * -- * -- * version2
                       |\
                       | * -- * version3
                        \
                         * -- * version4
                          
This is pretty good.  It's certainly a huge improvement over what there was.  
However, it's still not quite what I want.  The problem is that I haven't 
done any directory reorganising so now this is a mixed version-by-directory 
and version-by-branch repository.  For example the version4 branch, because 
it came from version2, which came from version1 contains directories 
version1/, version2/ and version4/.

This makes merging changes impossible, a bug fix in version1, when pulled into 
version4 simply goes in version4's version1/ directory - obviously not what 
would be wanted.

Phew; still with me?  Obviously what I would like is to remove each 
subdirectory, and have all the branching done using git.  However, I'd like 
to keep the history so far for each branch.

What should I do?  I've thought of a number of things:
 * Recreate the whole lot by hand, the repository isn't huge and I could 
manually apply each commit as a patch in the correct place.  It would be a 
bit time-consuming but would mean I'd have what I wanted
 * Keep the current history and move and remove files out of each branch to 
make it look like I want it now, and allow history to be a bit of a mess.
 * As I make each branch reorganise it early on, _then_ apply the history of 
each branch to the right branch.

I'm tempted to go with recreate by hand, as that has the fewest compromises.  
Before I did that though I thought I'd ask you clever chaps to see if you had 
any amazing ideas :-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
