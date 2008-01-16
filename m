From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 02:52:58 +0300
Message-ID: <20080116235257.GA2901@dpotapov.dyndns.org>
References: <478E1FED.5010801@web.de> <alpine.LSU.1.00.0801161531030.17650@racer.site> <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org> <alpine.LSU.1.00.0801161629580.17650@racer.site> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFI4c-0000L3-5K
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYAPXxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 18:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbYAPXxE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:53:04 -0500
Received: from smtp07.mtu.ru ([62.5.255.54]:51362 "EHLO smtp07.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbYAPXxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:53:01 -0500
Received: from smtp07.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp07.mtu.ru (Postfix) with ESMTP id C9E43708018;
	Thu, 17 Jan 2008 02:52:54 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-110.pppoe.mtu-net.ru [85.141.191.110])
	by smtp07.mtu.ru (Postfix) with ESMTP id 7FFDB708012;
	Thu, 17 Jan 2008 02:52:54 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JFI42-0000nE-13; Thu, 17 Jan 2008 02:52:58 +0300
Content-Disposition: inline
In-Reply-To: <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp07.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70777>


On Wed, Jan 16, 2008 at 03:39:36PM -0500, Kevin Ballard wrote:
> On Jan 16, 2008, at 11:46 AM, Jakub Narebski wrote:
>=20
> >
> >HFS+ is just _stupid_. And unfortunately Git doesn't support stupid
> >filesystems (e.g. case insensitive filesystems) well.
>=20
> There's two different ways to do filesystem encodings. One is to have=
 =20
> the fs simply not care about encoding, which is what the linux world =
=20
> seems to prefer.=20

There is no technical reason for *kernel* to care about file name
encoding. It is something that can be and should be dealt with in
the user space (except some special cases like smbfs).

> Sure, this is great in that what you create the file =20
> with is what you get back,

And also because a user space program can deal with it much more
gracefully...

> but on the other hand, given an arbitrary =20
> non-ASCII file on disk, you have absolutely no idea what the encoding=
 =20
> should be and you can't display it without making assumptions (yes yo=
u =20
> can use heuristics, but you're still making assumptions).

Wrong. If you have a policy that all file names are stored in UTF-8
encoding then there is no problem here. It should not be a kernel
problem to care about encoding, besides you cannot fully solve it
in the kernel space anyway...

> Filesystems =20
> like HFS+ that standardize the encoding,

Yeah, right... Like Microsoft likes to "standardize" everything, which
in practice means forcing on others something fundamentally broken and
that does not follow any existing standard precisely:

=3D=3D=3D
IMPORTANT:
The terms used in this Q&A, decomposed and precomposed, roughly
correspond to Unicode Normal Forms D and C, respectively. However, most
volume formats do not follow the exact specification for these normal
forms.
=3D=3D=3D
http://developer.apple.com/qa/qa2001/qa1173.html

Not to mention that the use of decomposed Unicode as the standard is
outright silly -- no sane person writes in "decomposed" Unicode...

> on the other hand, make it =20
> such that you always know what the encoding of a file should be, so =20
> you can always display and use the filename intelligently.

Somehow I have no problem with displaying non-ASCII names on Linux.
I can see both Unicode Normal Forms C and D encoded symbols without
any problem, though the kernel is completely unaware about them.

> It also =20
> means it plays much nicer in a non-ASCII world, since you don't have =
=20
> to worry about different normalizations of a given string referring t=
o =20
> different files (it's one thing to be case-sensitive, but claiming =20
> that "f=F6o" and "f=F6o" are different files

As you typed them, they both are exactly the same, and both of them are
in the Normal Forms C (which Mac calls as precomposed). So why do you
use one encoding in your writings and the other in your file names?

> just because one uses a =20
> composed character and the other doesn't is extremely user-=20
> unfriendly). On the other hand, what you create the file with may not=
 =20
> be what you read back later, since the name has been standardized. =20
> It's hard to say one is better than the other, they're just different=
 =20
> ways of doing it. However, I have noticed that everybody who's voiced=
 =20
> an opinion on this list in favor of the encoding-agnostic approach =20
> seem to be unwilling to accept that any other approach might have =20
> validity, to the extent of calling an OS/filesystem that does things =
=20
> different stupid or insane. This strikes me as extremely elitist and =
=20
> risks alienating what I expect to be a fast-growing group of users =20
> (i.e. OS X users).

I am sure everyone here is scared to death... I mean we have used to
hear such threats from some MS salespeople, but from a Mac guy? It is
really scare....

Wake up, and stop shooting this nonsense at us. If you have technical
reasons why your solution is better, let us know. So far, you do not
sound very convincing here. Why do think that the issue of encoding can
not be dealt with in the user space? Why does Mac OS X uses so-called
decomposed Unicode, which even does not follow any standard precisely?
Why does Mac OS X chose to decompose characters while it does not
solve any real issue?

> And one area that it has a problem with is the de-=20
> facto filesystem on my OS of choice.

I suppose it would be much better a subject for discussion...
At least, it would be more likely to result in that Git working
better on your OS.

> However, attempts to discuss the =20
> problem invariable end up with multiple people calling my OS stupid =20
> and insane simply because it differs in a particular design decision.=
 =20

=46irst, no one called Mac OS X insane, but case insensitive filesystem=
s,
and there are good reasons to think so, because no one has demonstrated
so far any advantage of that approach, but disadvantages are quite=20
obvious to anyone -- comparison of a stored file list with readdir()
is much more problematic, and you cannot say that you have solved the
problem with encoding if you force other people to *duplicate* some
logic that Mac OS X does in its kernel just to get things working...
So, no one thinks it is insane because it is different, but because it
requires much more efforts to do the same thing -- compare two file
lists, and this operation is important for Git to work properly...


Dmitry
