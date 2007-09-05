From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 00:09:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISp16-0005ni-5I
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbXIEHJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbXIEHJb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:09:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48293 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754179AbXIEHJa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 03:09:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8579S1H020065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 00:09:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8579RV3026831
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 00:09:28 -0700
X-Spam-Status: No, hits=-2.743 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57672>


So we had a git bof at linux.conf.eu yesterday, and I leart something 
new: even people who have been using git for a long time apparently don't 
necessarily realize the importance of repacking.

James Bottomley (the Linux SCSI maintainer) is an old-time BK user, and 
very comfy using git. But when he was demonstrating things on his poor old 
laptop, simple things like "git branch" literally took a long time, and 
James didn't seem to realize that the fact that he had apparently never 
ever repacked his repository was a big deal.

The kernel archive is a 190MB pack for me fully repacked (I just checked - 
I had actually thought that it was somewhat larger than that), but because 
James hadn't repacked, his .git directory was over a gigabyte in size, and 
his laptop wasn't able to cache anything at all effectively as a result.

Repacking it took over an hour, simply because everything was *so* 
unpacked, and James' kernel repository had something like 92 thousand 
loose objects, and several hundred packfiles. Simple operations that 
really take much less than a second for me ("git branch" takes 0.022s on 
my laptop, which has the same 512M that James had on his) took many many 
seconds as a result, and James seemed to think that this was all normal.

And James didn't even want to repack, because it was so expensive (which 
he knew - he claims to have never ever repacked at all, but maybe he had 
started it and just control-C'd it when it was really slow at some point).

Now, it may be that James didn't realize how important the occasional 
garbage collect is exactly *because* he is an old-timer and used BK long 
before he used git, and just continued using git simply as a BK 
replacement, but it did make me wonder whether maybe this lack of 
repacking awareness is fairly common. 

I've been against automatic repacking, but that was really based on what 
appears to be potentially a very wrong assumption, namely that people 
would do the manual repack on their own. If it turns out that people don't 
do it, maybe the right thing for git to do really is to at least notify 
people when they have way too many pack-files and/or loose objects.

I personally repack everything way more often than is necessary, and I had 
kind of assumed that people did it that way, but I was apparently wrong. 
Comments?

		Linus
