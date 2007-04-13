From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: FW: Alternative to 'git bisect visualize'?
Date: Fri, 13 Apr 2007 17:18:25 -0400
Organization: Connect Tech Inc.
Message-ID: <000001c77e11$45a91080$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 23:32:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcTNF-00046H-3M
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 23:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXDMVbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 17:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbXDMVbu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 17:31:50 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:4912 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030502AbXDMVbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 17:31:48 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Apr 2007 17:31:48 EDT
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id l3DLKuvJ019123
	for <git@vger.kernel.org>; Fri, 13 Apr 2007 17:20:56 -0400 (EDT)
	(envelope-from stuartm@connecttech.com)
Received: from stuartm (stuartm.connecttech.com [206.130.75.41]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id l3DLKRP07708 for <git@vger.kernel.org>; Fri, 13 Apr 2007 17:20:27 -0400 (EDT)
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44433>

I recently had a small discussion on LKML about a text-based
alternative to git bisect visualize. The email below was exactly what
I needed.

Would it be possible to have this series of steps wrapped up into a
new git command? Steps 1-3 and 5 are easily done with a shell script,
step 4 would be an ncurses- (menuconfig-) style app.

Ideally, I'd like to have
# git bisect visualize --mode=ncurses   (or =text)
which pops open a window with the list of GOOD..BAD commits with the
current commit centered vertically and highlighted. Keys or mousing
scrolls around and selects another commit, which is them confirmed and
the tree is reset to it.

..Stu

From: Paolo Ornati [mailto:ornati@fastwebnet.it] 
> Sent: April 10, 2007 4:04 AM
> To: Stuart MacDonald
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Alternative to 'git bisect visualize'?
> 
> 
> On Mon, 9 Apr 2007 17:10:23 -0400
> "Stuart MacDonald" <stuartm@connecttech.com> wrote:
> 
> > My problem is that I don't have wish/tk installed. Is there a
> > text-based alternative to visualize that I can use? Or is there a
> > different method to locate a nearby commit?
> > 
> > The answer may involve something as simple as looking at some git
> > state; I am a git newbie, and reading the docs hasn't 
> helped any, so I
> > won't be surprised to find out I'm overlooking something really
> > obvious.
> 
> I think this should work:
> 
> 1) look at "git-bisect log" and take the last good/bad pair
> 
> 2) "cat .git/refs/heads/bisect" to see where you are now
> 
> 3) git-log --pretty=oneline GOOD..BAD
> 
> 4) search for the current commit (found in #2) with "/CURRENT_COMMIT",
> now move around and choose another commit to test
> 
> 5) git-reset --hard COMMIT_TO_TEST
> 
> 
> Example:
> 
> $ git-bisect start
> $ git-bisect good v2.6.17
> $ git-bisect bad v2.6.18
> Bisecting: 3400 revisions left to test after this
> [2a2ed2db353d949c06b6ef8b6913f65b39111eab] Merge 
> git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild
> 
> # 2a2ed2db353d949c06b6ef8b6913f65b39111eab doesn't compile/boot ?
> 
> $ git-bisect log
> git-bisect start
> # good: [8ba130df4b67fa40878ccf80d54615132d24bc68] Linux v2.6.17
> git-bisect good 8ba130df4b67fa40878ccf80d54615132d24bc68
> # bad: [119248f4578ca60b09c20893724e10f19806e6f1] Linux v2.6.18. Arrr!
> 
> $ git-log --pretty=oneline 
> 8ba130df4b67fa40878ccf80d54615132d24bc68..119248f4578ca60b09c2
> 0893724e10f19806e6f1
> 
> search for "2a2ed2db353d949c06b6ef8b6913f65b39111eab":
> 
> aa4148cfc7b3b93eeaf755a7d14f10afaffe9a96 [PATCH] devfs: 
> Remove devfs support from the serial subsystem
> bdaf8529385d5126ef791e8f1914afff8cd59bcf [PATCH] devfs: 
> Remove devfs from the init code
> a29641883f57f36424e3219ae9ff48dd6cd34de0 [PATCH] devfs: 
> Remove devfs from the partition code
> 5c3927dc3468f47b803c9e1bb82cbed2bbd411ab [PATCH] devfs: 
> Remove devfs documentation from the kernel tree
> d8deac5094988c7ad1127ee61f52c59a952fcabb [PATCH] devfs: 
> Remove devfs from the kernel tree
> 5fd571cbc13db113bda26c20673e1ec54bfd26b4 [PATCH] Array 
> overrun in drivers/infiniband/core/cma.c
> 09c0dc68625c06f5b1e786aad0d5369b592179e6 Revert "[PATCH] 
> kthread: update loop.c to use kthread"
> 6e58f5c9a841e59233c5997df082e93329ea61e0 [ARM] 3656/1: 
> S3C2412: Add S3C2412 and S3C2413 documenation
> >>> 2a2ed2db353d949c06b6ef8b6913f65b39111eab Merge 
> git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild
> 972d19e837833b93466c6f6a8ef2a7d653000aa3 Merge 
> master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6
> cdf4f383a4b0ffbf458f65380ecffbeee1f79841 Merge 
> master.kernel.org:/pub/scm/linux/kernel/git/dtor/input
> 954b36d48b495afed2880320750858a2eae312c9 [PATCH] m68knommu: 
> use configurable RAM setup page_offset.h
> 12ddae3348def8808fb755b23225b18fc4adfbe3 [PATCH] m68knommu: 
> use configurable RAM setup in start up code
> 73e2fba8dc1e0a686073a5183be1a99e9285d2ac [PATCH] m68knommu: 
> use configurable RAM setup in linker script
> 63e413d19db0018e443a43c6c7a482993edf79cf [PATCH] m68knommu: 
> create configurable RAM setup
> d2f386d7c182c1420f797093d67bb09a7251f113 [PATCH] m68knommu: 
> remove unused vars from generic 68328 start code
> 2ae9cb6bd4c23616b229b135ea57a93a6a24e13a [PATCH] m68knommu: 
> remove __ramvec from 68328/pilot start code
> 
> # pick another one...
> 
> $ git-reset --hard aa4148cfc7b3b93eeaf755a7d14f10afaffe9a96
> 
> -- 
> 	Paolo Ornati
> 	Linux 2.6.21-rc6-gc2481cc4 on x86_64
> 
