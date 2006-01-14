From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Question on empty commit
Date: Fri, 13 Jan 2006 18:18:00 -0800 (PST)
Message-ID: <20060114021800.4688.qmail@web31803.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jan 14 03:18:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExazY-0007qx-BF
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 03:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945979AbWANCSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 21:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945980AbWANCSE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 21:18:04 -0500
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:21433 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1945979AbWANCSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 21:18:03 -0500
Received: (qmail 4690 invoked by uid 60001); 14 Jan 2006 02:18:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TkEY8RNYRPZ151LU8LECakm6Fyz3ee8AQaNZmjQyPh4cKsGpTfxtJz+gW/l47PFnJlN4CrtL+zPj+0u4udiAC/8tjc/hRtZbMeW4+ch5YfPjxsV9aMkX2HLPMm1FaZJ/ZxiFDnER1yJ4nBrOBWcemGd4CXrfBM2f82/3/Hf5zNk=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Fri, 13 Jan 2006 18:18:00 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14658>

Hi,

Scenario:

trunk remote
  |
  \/
trunk local
     \
      `--> tree A
               \
                `--> tree B

         Figure 1.

This is the dependecny since project B depends on project A
introduced in tree A.  And merging is done as follows
(branch per directory; everything but HEAD and index is shared):

cd trunk && git pull trunk
cd ../treeA && git merge "merge trunk" HEAD trunk
cd ../treeB && git merge "merge tree A" HEAD treeA

But this isn't the only way to do it since tree B depends
only on the introduced into tree A project A, and both
project A and project B depend on the trunk, as follows:

trunk remote
  |
  \/
trunk local
  \  \
   \  `--> tree A
    \          \
     `--------> `--> tree B

         Figure 2.

So at point in time t where tree B had been synced with tree A,
and tree A had been synced with trunk, but trunk had _not_ been
synced with remote trunk, a merge was done following Figure 2:

cd trunk && git pull trunk
cd ../treeA && git merge "merge trunk" HEAD trunk
cd ../treeB && git merge "merge trunk" HEAD trunk
git merge "merge tree A" HEAD treeA

Now the last merge introduced an empty commit, since
tree A and tree B had been in sync (only local and
remote trunk had been out of sync).  While it was expected
that no commit would be introduced since they were in sync.

Was the empty commit correct behavior?

Thanks,
   Luben
