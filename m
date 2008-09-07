From: Rod <armyofthepenguin@gmail.com>
Subject: A git problem with timestamps
Date: Sun, 7 Sep 2008 09:54:02 -0400
Message-ID: <200809070954.03394.armyofthepenguin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 15:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcKjy-0008Sf-0a
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 15:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbYIGNyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYIGNyL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:54:11 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:48297 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbYIGNyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 09:54:10 -0400
Received: by an-out-0708.google.com with SMTP id d40so182538and.103
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ZN/etHpbKiWAXjZjT6N/vcPCLYpP5qpRHHTK06vZ4qM=;
        b=lotvRUeLqGlr9Ha/m7iKLq4oh7mWwx9Vp+xatJnQ1MrMY2L5fTqPNUIRa5Y6PbNSEC
         BVLYw1gCPjyz95T4gq1pFpKr07t8v97SbVaaszAIt2l330rqqcCSbOymKPOKA0C3+/N/
         pOZ/40fiYYJPxDJIbHX0W79CjtK2pdu/UcCaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=pH4ooHtJorpOqw1wbEV7fMQ5q1d6jUZqjCOTp7wUjraRU6Assic+6L87TvLdfQgYja
         EUGscY00i5Q92M3gSezjLAf3j3Odm8iPd70B3b6RBtWcwp5HdOgxFQaGO01UlM3UMqlU
         S1Sy94a/h2Yo3bejelVWyAozPPQ4gMeDRrQGs=
Received: by 10.100.152.11 with SMTP id z11mr14391081and.157.1220795648695;
        Sun, 07 Sep 2008 06:54:08 -0700 (PDT)
Received: from castleroogna.localdomain ( [69.140.56.88])
        by mx.google.com with ESMTPS id i16sm230030wxd.27.2008.09.07.06.54.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 06:54:06 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95139>

I have a problem with a git repository that I'm hoping you folks can help me 
with. 

If you folks have the time here's my situation:
============================
2 persons developing together (Fred and Barney if you will). Fred's repository 
is the canonical repository, Barney cloned from Fred, and periodically has 
Fred pull Barney's work, and if it passes muster, merge it into Fred's 
master. Barney is good about pulling Fred's master into his own master 
periodically and basing his work off the master branch.

Fred starts with source code that is not his own (or under version control), 
but that he needs to clean up with help from Barney.

Now Fred is a conscientious Linux user and uses ntp to make sure his system 
date is in sync within a couple of milliseconds of UTC. Barney (that would be 
me) is a slacker too lazy to run ntpclient, or ntpd to make sure he's also 
in sync with UTC. In point of fact, Barney's clock says he's 6 hours earlier 
than Fred (i.e., when Fred's system clock say it's 6 p.m., Barney's clock say 
it's noon.).

Git has no problem keeping track of the order in which commits occurs as gitk 
clearly shows. But git log has a problem since it's ordering by time stamps, 
so it shows Fred's initial commit occurring *After* some commits pulled from 
Barney's repository. 

What's really bugging Fred and Barney is that Fred has received a new updated 
version of the original source code he was tasked to clean up. What Fred and 
Barney would like to do is to make a branch of the repository from the base 
of master, and then apply the history of master onto this branch. For 
personal reasons, they don't want to simply rebase master off this branch.

To be a little more specific, what Fred and  Barney would like to do is to 
branch master's base node (not HEAD), call it "updated_original_source_code", 
unroll the "updated" original source code in this branch, commit the diffs 
from the original source code to "updated" original source code, and then 
apply the history of master by using git-format-patch and git-am to generate 
a sequence of patches to apply onto updated_original_source_code branch. 

The problem is that the patches generated by git-format-patch are generated by 
timestamp, and since slacker Barney's timestamps are off by 6 hours, some of 
the patches would be applied in the wrong order thus borking the operation. 
Have you any suggestions for how to get around this problem? I'm sure I can't 
be the only person to have used the wrong system clock time.

Here are the git commands Fred is attempting to use:
# Branch the *base* of master
git checkout -b updated_original_source_code 345678

cp ../updated_source_code.tar.gz .
tar zxvf updated_source_code.tar.gz

# Commit all changes from original_source_code
# to updated_source_code
git -a -m "Updated original source code"

# Now apply the history of master onto this branch:
# This is where they get hosed because the timestamps
# from Barney's commits are wrong, and hence the 
# generated patches are out of order.
git format-patch 345678..master | git am -k -3

--Rod

P.s. Would a diagram help?
