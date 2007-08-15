From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 15:52:05 -0700 (PDT)
Message-ID: <801552.56844.qm@web52810.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILRin-0007IP-E0
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762493AbXHOWwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762873AbXHOWwI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:52:08 -0400
Received: from web52810.mail.re2.yahoo.com ([206.190.48.253]:37404 "HELO
	web52810.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760451AbXHOWwH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:52:07 -0400
Received: (qmail 57086 invoked by uid 60001); 15 Aug 2007 22:52:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=4uO+z7+IORfm1Ue2u/uazzoplmvqdblwzilgfvY/F/9KhnVuW/z7gBOHCtaaOczKrz6gOepADTSn54Ya4+XYfEEQ9VTY94xN2PFRReAdTS7DYWb49H6OYE1iHLKk53oTM7DwDwrVoxb1dy+fG5iI1E6GqxY/1M46lP6z95R5Gg4=;
X-YMail-OSG: itJepP4VM1kSQSdQIlxmkcKW5VlnsSTVKJdADdJOXByJT_GgHwW1rKBdMFiXf5r0VA--
Received: from [216.52.12.233] by web52810.mail.re2.yahoo.com via HTTP; Wed, 15 Aug 2007 15:52:05 PDT
X-Mailer: YahooMailRC/651.48 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55964>


Well, this is my first time using git-bisect (which seems like a VERY cool tool), but iterating through, using 
$ make clean ; make -j 4 ; cd t ; sh t1000-read-tree-m-3way.sh ; cd ..

The first bad commit is:

933bf40a5c6328b6c022b636f45a6f2c48c3838e is first bad commit
commit 933bf40a5c6328b6c022b636f45a6f2c48c3838e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Aug 9 22:21:29 2007 -0700

    Start moving unpack-trees to "struct tree_desc"
    
    This doesn't actually change any real code, but it changes the interface
    to unpack_trees() to take an array of "struct tree_desc" entries, the same
    way the tree-walk.c functions do.
    
    The reason for this is that we would be much better off if we can do the
    tree-unpacking using the generic "traverse_trees()" functionality instead
    of having to the special "unpack" infrastructure.
    
    This really is a pretty minimal diff, just to change the calling
    convention. It passes all the tests, and looks sane. There were only two
    users of "unpack_trees()": builtin-read-tree and merge-recursive, and I
    tried to keep the changes minimal.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 a3b17a3bd913d628d70ee625ec8b1808d3b200fa 1967d100f28d70e588fde618aa7ed4a10b76ee1d M      builtin-read-tree.c
:100644 100644 c8539ec0bafce5e238d97d6397a9d08c2c92a09c f7d1b84999d401887e4a4eba091d53f5fe7294c8 M      merge-recursive.c
:100644 100644 dfd985b0ef0193ce311ea77e8c8cb11fc7b1c3e3 5d1ffd1a32a56bdcf4f64b545abd6aa951914ffe M      unpack-trees.c
:100644 100644 fee7da43822b63e5b1f24444e5c51c43d3ff5760 9cd39a28a907ef6f0eedc764bbae586353ec2ca5 M      unpack-trees.h


I'll install the newest Xcode and see if that fixes things. 

Perrin

----- Original Message ----
From: Junio C Hamano <gitster@pobox.com>
To: Perrin Meyer <perrinmeyer@yahoo.com>
Cc: git@vger.kernel.org
Sent: Wednesday, August 15, 2007 3:05:18 PM
Subject: Re: 1.5.3-rc5 regression on OS X?

Perrin Meyer <perrinmeyer@yahoo.com> writes:

> Nothing has changed,, I just did a git checkout v1.5.2.4; make clean; make ; make test, and that same test passes. Then I did a git checkout v1.5.3-rc5 ; make clean ; make ; make test, and the same test fails. 
>
> I'll try updating to a newer version of Xcode and see if that helps. 

Before doing so, perhaps bisect between v1.5.2.4 and v1.5.3-rc5
woudl be very helpful.
