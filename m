From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 21:01:28 -0400
Message-ID: <426C4168.6030008@dwheeler.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>       <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>       <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>       <20050423175422.GA7100@cip.informatik.uni-erlangen.de>       <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1> <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 02:54:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPrs7-0001ri-5U
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVDYA7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 20:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVDYA7h
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 20:59:37 -0400
Received: from aibo.runbox.com ([193.71.199.94]:15250 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262390AbVDYA70 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 20:59:26 -0400
Received: from [10.9.9.16] (helo=lassie.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DPrwP-0001gj-7h; Mon, 25 Apr 2005 02:59:13 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by lassie.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DPrwO-0007LJ-F8; Mon, 25 Apr 2005 02:59:13 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org




On Sat, 23 Apr 2005, Linus Torvalds wrote:
>> That means that we don't "strip them off", because dammit, they DO NOT
>> EXIST as far as git is concerned. This is why a tag-file will _always_
>> start with
>>
>>     commit <commit-sha1>
>>     tag <tag-name>
>>
>> because that way we can use fsck and validate reachability and have 
>> things that want trees (or commits) take tag-files instead, and git 
>> will automatically look up the associated tree/commit. And it will do 
>> so _without_ having to understand about signing, since signing is for 
>> trust between _people_ not for git.
 >
 >> And that is why I from the very beginning tried to make ti very clear
 >> that the signature goes at the end. Not at the beginning, not in the
 >> middle, and not in a different file. IT GOES AT THE END.

It may be better to have them as simple detached signatures, which are
completely separate files (see gpg --detached).
Yeah, gpg currently implements detached signatures
by repeating what gets signed, which is unfortunate,
but the _idea_ is the right one.


Paul Jakma wrote:
> Ideally, there'd be an index of signature objects by the SHA-1 sum of 
> the object they sign, as the signed object should not refer to the 
> signature (or the second of the above is not possible).

Yes, and see my earlier posting.  It'd be easy to store signatures in
the current objects directory, of course.  The trick is to be able
to go from signed-object to the signature; this could be done
just by creating a subdirectory using a variant of
the name of the signed-object's file, and in that directory store the
hash values of the signatures.  E.G.:
  00/
     3b128932189018329839019          <- object to sign
     3b128932189018329839019.d/
     0143709289032890234323451
  01/
     43709289032890234323451          <- signature

> The latter of the two points would, in combination with the former, 
> allow for cryptographic 'signed-off-by' chains. If a 'commit' is signed 
> by $RANDOM_CONTRIBUTOR and $SUBSYSTEM_MAINTAINER and $ANDREW, you know 
> its time to pull it. Would also work for things like "fixes only" trees, 
> where (say) a change must be approved by X/2+1 of a group of X hacker 
> providing oversight -> looking up the commit object's signatures would 
> tell you whether it was approved.

Right.  Lots of tricks you can do once the signatures are there,
such as checking to counter repository subversion
(did everything get signed), finding out who introduced a malicious
line of code (& "proving" what key signed it first), etc.
There are LOTS of reasons for storing signatures so that they can
be checked later on, just like there are lots of reasons for storing
old code... they give you evidence that the reputed history is true
(and if you doubt it, they give you a way to limit the doubt).

--- David A. Wheeler
