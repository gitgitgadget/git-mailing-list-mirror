From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 22:13:58 -0400
Message-ID: <426C5266.6050200@dwheeler.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>       <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>       <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>       <20050423175422.GA7100@cip.informatik.uni-erlangen.de>       <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1> <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com> <Pine.LNX.4.62.0504250212200.14200@sheen.jakma.org>
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
X-From: git-owner@vger.kernel.org Mon Apr 25 04:08:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPt1M-0007rv-Ui
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 04:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVDYCMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 22:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVDYCMF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 22:12:05 -0400
Received: from aibo.runbox.com ([193.71.199.94]:59294 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262445AbVDYCLx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 22:11:53 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DPt4X-0000N1-79; Mon, 25 Apr 2005 04:11:41 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DPt4W-0000MR-Pr; Mon, 25 Apr 2005 04:11:41 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.62.0504250212200.14200@sheen.jakma.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jakma wrote:
> On Sun, 24 Apr 2005, David A. Wheeler wrote:
> Hmm, what do you mean by "repeating what gets signed"?

Forget it, irrelevant.  I vaguely remembered some problem with
gpg's detached signatures, but it was probably either a really
early alpha version or someone was using "--clearsign" instead
of "--armor".  I just did a quick check with:
  gpg --armor --detach -o junk.sig junk.c
and it worked "as expected"; no repeat of the data.

>> Yes, and see my earlier posting.  It'd be easy to store signatures in
>> the current objects directory, of course.  The trick is to be able
>> to go from signed-object to the signature;
> Two ways:
> 1. An index of sigs to signed-object.
> (or more generally: objects to referring-objects)

Right.  I suggested putting it in the same directory as the objects,
so that rsync users get them "for free", but a separate directory
has its own advantages & that'd be fine too.
In fact, the more I think about it, I think it'd be cleaner
to have it separate.   You could prepend on top of the signature
(if signatures are separate from assertions) WHAT got signed so
that the index could be recreated from scratch when desired.

> 2. Just give people the URI of the signature, let them (or their
>    tools) follow the 'parent' link to the object of interest

If you mean "the signatures aren't stored with the objects", NO.
Please don't! If the signatures are not stored in the database,
then over time they'll get lost.  It's important to me to
store the record of trust, as well as what changed, so that
ANYONE can later go back and verify that things are as they're
supposed to be, or exactly who trusted what.

> I think it might be more useful just to provide a general index to 
> lookup 'referring' objects (if git does not already - I dont think it 
> does, but I dont know enough to know for sure).

git definitely doesn't have this currently, though you could run the
fsck tools which end up creating a lot of the info (but it's then
thrown away).

 > So you could ask "which
> {commit,tag,signature,tree}(s) refer(s) to this object?" - that general 
> concept will always work.

Yes. The problem is that maintaining the index is a pain.
It's probably worth it for signatures, because the primary use
is the other direction ("who signed this?"); it's not clear that
the other direction is common for other data.

--- David A. Wheeler
