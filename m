From: Christian <crich-ml@beronet.com>
Subject: Re: git push over http is very dangerous
Date: Sat, 21 Apr 2007 19:07:02 +0200
Message-ID: <462A44B6.30404@beronet.com>
References: <462394AC.303@beronet.com> <7vfy6uwncc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJ45-0000iR-Dt
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXDURH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXDURH6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:07:58 -0400
Received: from beronet.com ([80.244.243.34]:2883 "EHLO mail.beronet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbXDURH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 13:07:57 -0400
Received: from mail.beronet.com (localhost [127.0.0.1])
	by mail.beronet.com (Postfix) with ESMTP id CA7AC510C6D;
	Sat, 21 Apr 2007 19:16:33 +0200 (CEST)
Received: from [192.168.2.6] (port-212-202-210-130.dynamic.qsc.de [212.202.210.130])
	by mail.beronet.com (Postfix) with ESMTP id 97C09510C2D;
	Sat, 21 Apr 2007 19:16:33 +0200 (CEST)
User-Agent: Icedove 1.5.0.7 (X11/20061013)
In-Reply-To: <7vfy6uwncc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on m24s12.beronet.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45181>

I've did that ls-tree thingy again additionally an ls-tree on a working 
blob:


m24s12:/var/git/mISDN.git-backup2# git-ls-tree 
cd1aac1a43cfdac07118240f75c0ba7662eb8140
error: corrupt loose object 'cd1aac1a43cfdac07118240f75c0ba7662eb8140'
fatal: not a tree object
m24s12:/var/git/mISDN.git-backup2# ls objects/
Display all 163 possibilities? (y or n)
m24s12:/var/git/mISDN.git-backup2# ls objects/aa/
537a125359b729699b3c011fbf9d71438de90d  
d38d3dedd00107dc207190b9fa0b22f53888de
m24s12:/var/git/mISDN.git-backup2# git-ls-tree 
aa537a125359b729699b3c011fbf9d71438de90d 100644 blob 
f6998854080c88903e47d449affc891278184368    CHANGES
100644 blob 0ac604f5c8c3b3a55fd0ce50944bb6f7f85850b3    Makefile
100644 blob 7b90a319e218d962dc453c5a92b8ee11c6bb9b7d    Makefile.module
100644 blob 56617b776024936b932601697ccfb548d891dadc    Makefile.standalone
100644 blob c12695b2e27a3be524e8e2622f79abf638dd9fb1    Rules.make.ext
100644 blob 1808a7786f86bf2ad9d15d2b7a921474bef00951    add.config
040000 tree f422c9f8d89e2d5c8be05392522d79f064522d64    config
040000 tree c875ea5c0cb3a5597df481f2999f9c6dc1691829    drivers
040000 tree f1cb948bddd3a86d6a1981a903edb102bd8244cf    include
100644 blob f11f1a276f4000b7bc703c40c3ad7a959ccf9146    km_mISDN.spec
100755 blob 81c7103e38ef807e84880625ef484d50c4cc9cc3    std2kern
100755 blob 07ba5902616674ddee962e89570c85f9e75fbd4b    stddiff
m24s12:/var/git/mISDN.git-backup2# git --version
git version 1.5.1.1

but i had a 1.5.0.X version before, which emitted the same problem :(

On Friday i had access to the machine which created the corrupt object, 
then we did a new push from that machine, which again corrupted our 
central repository, i found that it seemed not http - push related, 
because i could see the push worked well.

Doing that was very unfortune, because we lost a lot of commits this 
time :( I told that guy to get a new git version (he had 1.5.0.1 or so) 
and make a fresh clone of our repository.

So i'm pretty sure this is *not* a http push problem.

Interestingly the git-ls-tree on the machine of that guy worked very 
well, as it does on my local machine, but it does not work on our 
central repository.

The central machine is a  AMD Sempron, it runs Debian Sarge (3.1)  We've 
installed git from source, because sarge has it not in its archives.

Maybe we did something wrong at building time ? or you're right and the 
debian sarge zlib does not fit good to the current git versions ?





Junio C Hamano wrote:
> Christian <crich-ml@beronet.com> writes:
>
>   
>> We found out that it was broken, because we could not do a pull or
>> clone from the central repository anymore, but we got an error message.
>>
>> Then i did a "git log" which worked well. then i wanted to "show" the
>> last 2 commits, so i did: "git show":
>>
>> error: corrupt loose object 'cd1aac1a43cfdac07118240f75c0ba7662eb8140'
>> <crich1999> error: cd1aac1a43cfdac07118240f75c0ba7662eb8140: object
>> corrupt or missing
>>     
>
> Thanks.  I extracted that "corrupt" object, but all the archived
> versions of git I have at hand can read that tree just fine.
>
>   $ ~/git-snap-v1.0.0/bin/git ls-tree cd1aac
>   100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
>   100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
>   040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
>   $ ~/git-snap-v1.2.0/bin/git ls-tree cd1aac
>   100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
>   100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
>   040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
>   $ ~/git-snap-v1.3.0/bin/git ls-tree cd1aac
>   100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
>   100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
>   040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
>   $ ~/git-snap-v1.5.0/bin/git ls-tree cd1aac
>   100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
>   100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
>   040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
>   $ ~/git-snap-v1.5.1/bin/git ls-tree cd1aac
>   100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
>   100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
>   040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
>   $ git ls-tree cd1aac ;# this is 'next'
>   100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
>   100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
>   040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
>
> I am starting to suspect that the loose object is actually Ok
> and you are suffering from something else (perhaps zlib).
>
> We had a brief period that we had a bogusly strict error check
> after calling zlib, which Linus fixed with 456cdf and ac54c2
> (these fixes are both in v1.5.1).  The breakage was 7efbff,
> which was post v1.5.0.3 breakage, but was never been part of any
> official release without the two fixes from Linus.
>
> HOWEVER (I mentioned the above paragraph to save people from
> going wild goose chase), this does not seem to be related to the
> breakage.  I specifically built that revision and ls-tree from
> it reads the loose object just fine.
>
> There is only one codepath that can emit this error message:
>
>   
>> error: corrupt loose object 'cd1aac1a43cfdac07118240f75c0ba7662eb8140'
>>     
>
> so I am reasonably sure that you are running 7efbff or later
> version, but now I am out of ideas.
>
> What version of git do you run?  And on what platform?
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   
