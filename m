From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 15:13:20 -0600
Message-ID: <17875.31600.643352.808533@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<Pine.LNX.4.64.0702140958440.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRS6-00069u-PS
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbXBNVOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbXBNVOH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:14:07 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60357 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932604AbXBNVOG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:14:06 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1ELDR019508;
	Wed, 14 Feb 2007 15:13:27 -0600
In-Reply-To: <Pine.LNX.4.64.0702140958440.3604@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39748>

On Wednesday, February 14, 2007 at 10:19:53 (-0800) Linus Torvalds writes:
>On Wed, 14 Feb 2007, Bill Lear wrote:
>> fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27
>
>implies that the pack really is corrupt.
>...
>   (b) it might be interesting for others (if you can make those 
>       pack-files available) to try to figure out what exactly the 
>       corruption was. We've done it before, when it turned out to be a 
>       single-bit error.

If you could tell me who I should contact about this, I will.

> - if you have other git archives or just back-ups of everything, just use 
>   them, and throw the corrupt one away entirely (but see above on why 
>   it's nice to have an archive of the corruption for posterity anyway)

I would prefer to help straighten this out --- I have a company repo
to fall back on, I have git 1.4 and other repos to fall back on, so
I'm safe.

> - if you don't, you can try "git unpack-objects -r". See the man-page on 
>   why you need to first _move_ the pack-file away:
>
>	mv <bad-pack-file> .git/bad-pack.pack
>	mv <bad-pack-index> .git/bad-index.index
>
>	git unpack-objects -r < .git/bad-pack.pack

Since I can reproduce the error fairly readily, I can do this later.

>Finally: it would be very interesting to hear if you do something strange 
>or unusual that could have made your chances of getting corruption higher.
>
>Have you ever seen random SIGSEV's or strange oopses, which could be a 
>sign of memory corruption on your machine? Do you do a lot of things over 
>NFS? (which really can corrupt things, especially in circumstances with 
>dodgy ethernet chips: the UDP checksums are very weak, and some ethernet 
>cards do not do a good job of checking the ethernet CRC's!).

No NFS, but I checked /var/log/messages.  I see segfaults from git,
that I missed somehow (don't remember seeing anything awry on the
terminal):

Feb 14 10:05:07 lisa kernel: git[21648]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
Feb 14 10:05:43 lisa kernel: git[21710]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
Feb 14 10:06:28 lisa kernel: git[21858]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
Feb 14 10:10:04 lisa kernel: git[22385]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
Feb 14 11:01:56 lisa kernel: git[24446]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc888 error 4
Feb 14 11:02:34 lisa kernel: git[24479]: segfault at 0000000000000000 rip 0000003f5eb70a40 rsp 0000007fbfffc868 error 4
Feb 14 11:02:40 lisa kernel: git[24700]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc868 error 4
Feb 14 11:07:51 lisa kernel: git[24844]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc128 error 4
Feb 14 11:07:52 lisa kernel: git[24855]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc128 error 4
Feb 14 11:08:01 lisa kernel: git[24886]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc128 error 4
Feb 14 11:08:06 lisa kernel: git[24897]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc118 error 4
Feb 14 11:08:09 lisa kernel: git[24908]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc118 error 4
Feb 14 11:08:27 lisa kernel: git[24939]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4

10:05 is just before I posted my first note of this to the git list, and
the first instance of a segfault that I see.

>And if you can make the git history available to outsiders, I'd love to 
>see the corrupt tar-file (it doesn't have to be *public*, if you just can 
>trust me and perhaps a few other people with the data).

Again, please let me know who to contact about helping on this.


Bill
