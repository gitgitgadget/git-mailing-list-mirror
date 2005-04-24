From: Paul Jakma <paul@clubi.ie>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 00:25:59 +0100 (IST)
Message-ID: <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 01:23:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPqRq-0003GJ-68
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 01:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVDXX2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 19:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVDXX2H
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 19:28:07 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:54941 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262481AbVDXX1j
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 19:27:39 -0400
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id j3ONPuD0011890;
	Mon, 25 Apr 2005 00:26:00 +0100
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
X-Virus-Scanned: ClamAV 0.83/849/Fri Apr 22 16:52:53 2005 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Linus Torvalds wrote:

> NO.
>
> Guys, I will say this once more: git will not look at the signature.
>
> That means that we don't "strip them off", because dammit, they DO NOT
> EXIST as far as git is concerned. This is why a tag-file will _always_
> start with
>
> 	commit <commit-sha1>
> 	tag <tag-name>
>
> because that way we can use fsck and validate reachability and have 
> things that want trees (or commits) take tag-files instead, and git 
> will automatically look up the associated tree/commit. And it will 
> do so _without_ having to understand about signing, since signing 
> is for trust between _people_ not for git.

> And that is why I from the very beginning tried to make ti very 
> clear that the signature goes at the end. Not at the beginning, not 
> in the middle, and not in a different file. IT GOES AT THE END.

Actually, can you make the signature be detached and a seperate 
object? Ie, add a signature object in its own right, distinct from 
tag. They could then:

- be used to sign any kind of object
- allow objects to be signed by multiple people

Ideally, there'd be an index of signature objects by the SHA-1 sum of 
the object they sign, as the signed object should not refer to the 
signature (or the second of the above is not possible).

The latter of the two points would, in combination with the former, 
allow for cryptographic 'signed-off-by' chains. If a 'commit' is 
signed by $RANDOM_CONTRIBUTOR and $SUBSYSTEM_MAINTAINER and $ANDREW, 
you know its time to pull it. Would also work for things like "fixes 
only" trees, where (say) a change must be approved by X/2+1 of a 
group of X hacker providing oversight -> looking up the commit 
object's signatures would tell you whether it was approved.

No idea whether this is possible or practical. :) But it would be 
good for future flexibility to avoid including the signature in the 
object being signed.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
You give me space to belong to myself yet without separating me 
from your own life.  May it all turn out to your happiness.
 		-- Goethe
