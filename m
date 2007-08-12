From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 22:04:05 +0200
Message-ID: <85k5s0msei.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
	<854pj4o8k5.fsf@lola.goethe.zz>
	<20070812195126.GA17914@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJff-0004BF-Ml
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181AbXHLUEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 16:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757012AbXHLUEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:04:09 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:37461 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756206AbXHLUEI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 16:04:08 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9B770336886;
	Sun, 12 Aug 2007 22:04:06 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 7E9815BD63;
	Sun, 12 Aug 2007 22:04:06 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 24BFF8C463;
	Sun, 12 Aug 2007 22:04:06 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C2BD91C3C79D; Sun, 12 Aug 2007 22:04:05 +0200 (CEST)
In-Reply-To: <20070812195126.GA17914@informatik.uni-freiburg.de> ("Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig=22's?= message of "Sun\, 12 Aug 2007
 21\:51\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55716>

Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> writes:

> David Kastrup wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> > On Sun, 12 Aug 2007, Linus Torvalds wrote:
>> >>=20
>> >> A newsreader is mis-designed for all the same reasons SVN is misd=
esigned:=20
>> >> it sees the messages (commits) as a _tree_.
>> >
>> > Side note: the lack of this bug is what makes showing large
>> > histories graphically be expensive in the first place.
>>=20
>> Not really.
>>=20
>> dak@lola:/home/tmp/emacs$ time git-rev-list --parents --topo-order -=
-all>/dev/null
>>=20
>> real    0m9.042s
>> user    0m8.801s
>> sys     0m0.168s
>>=20
>> This does not even start to _think_ of swapping.
> rev-list doesn't try to draw a line from each commit to its parents.

Well, that's what --topo-order is somewhat about, but it might
actually not do much together with --all.

> That's the really intensive part.  So when gitk reads
>
> 	d56871cb0e6ceeca8e5435ff95409d78bed014f0 a046fe0cb8697bc97993b2e6096=
88ff5e89e3e9
>
> it must remember this line at least until it sees a line starting wit=
h
> a046fe0cb8697bc97993b2e609688ff5e89e3e9.

20 bytes of payload for a commit number.  Make a usable hashing data
structure for it, adds perhaps another 20 bytes.  Links to all parents
are 4 bytes each.  All in all, we won't need more than 64 bytes per
commit.  Take 100000 of them, and you are at 6.4MB.  And that is not
taking into account that you can let git-name-rev cut the information
retrieval down much much more, and just get the rest of the
information when it is actually moved on-screen.  I don't actually
_want_ to see 50 parallel lines from bottom to top of screen obscuring
my branch display and taking away all the screen estate: that is
completely useless information.  Pack the branches away into a cable
pipe and let them come out isolated again only when they are actually
involved on the screen.

There is no necessity to prerender/layout 50 yards of graphing.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
