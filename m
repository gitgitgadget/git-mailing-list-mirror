From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 04 Jun 2007 15:29:32 +0200
Message-ID: <466413BC.1080007@dawes.za.net>
References: <20070603114843.GA14336@artemis> <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org> <20070603201632.GF30347@artemis> <20070603230702.GC16637@admingilde.org> <4663DC16.8080309@dawes.za.net> <20070604102037.GB7758@.intersec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Rogan Dawes <lists@dawes.za.net>,
	Martin Waitz <tali@admingilde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 15:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvCdE-0007Uq-LM
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 15:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbXFDN3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 4 Jun 2007 09:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbXFDN3y
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 09:29:54 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:38116 "EHLO
	spunkymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752196AbXFDN3x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 09:29:53 -0400
X-Greylist: delayed 14248 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2007 09:29:53 EDT
Received: from [192.168.201.100] (dsl-146-26-199.telkomadsl.co.za [165.146.26.199])
	by spunkymail-a5.g.dreamhost.com (Postfix) with ESMTP id 7C6E714D6AB;
	Mon,  4 Jun 2007 06:29:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070604102037.GB7758@.intersec.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49101>

Pierre Habouzit wrote:

>   For that part, as the "right" way to deal with bugs is IMHO through
> mail, my heart balance between a ${bug_sha1}.mbox or a ${bug_sha1}/
> maildir. The former avoids to bloat the files, the latter avoids
> painless merges (chance to have a conflict in the comments is near ze=
ro
> through maildirs) but would see 3 directories (cur new tmp) be spoile=
d.

One downside of using maildir (which I agree has several desirable=20
properties), is that the filenames include characters that are illegal=20
on various platforms (specifically ":" in Windows). This is quite=20
unfortunate.

>   In addition to that a ${bug_sha1}.status (or alike) flat file would=
 be
> needed to store metadata about the bug (who it is assigned to, which
> module/category it's in, ...).
>=20
>   Note that mails are mostly textual, flat, and allow attachments,
> signature, whatever... and are IMHO very well suited for a bugtrackin=
g
> use.

I think it would be very neat to be able to use the built-in mechanisms=
=20
in mail clients for threading, etc, and handling attachments, sorting=20
and filtering. Tracking things like who a bug is assigned to wouldn't=20
work too well, but I imagine that many kernel developers have fine tune=
d=20
their email clients to such a degree that it wouldn't be impossible :-)

I'm not familiar with how messages move around in {cur,new,tmp}, but I=20
suspect that if we simply make a convention that all mails are created=20
as "read", then we won't have clashes between developers holding some=20
bugs as unread, etc while others have already read them.

>> Closed bugs would be deleted from the filesystem, but would obviousl=
y be=20
>> available via the history.
>=20
>   IMHO we should keep the .status file for closed bugs, and use the
> history to lookup for the content of the mail{box,dir} if needed.

Maybe.

>   Merging is also easy, it's just a matter of merging the "mails".

Yes.

>   Cloning bugs is just a matter of copying a report.
>=20
>   etc=85 every usual BTS operation is mapped trivially on FS/git
> operations. And that's not really surprising, as bugs are contents, a=
nd
> git actually tracks contents right :)
>=20
>> Indexes or categories could be implemented by means of symlinks/symr=
efs=20
>> in a different set of "index directories". e.g.
>>
>> /categories/drivers/deadbeef -> ../../bugs/de/adbeef
>> /assignedto/joe@example.org/deadbeef -> ../../bugs/de/adbeef
>>
>> or similar. These might not be strictly necessary, since all that=20
>> information will be in the report anyway. Perhaps the indexes would =
be=20
>> stored simply as cached data, and rebuilt if out of date.
>=20
>   IMHO that should be in a cache, all valuable information would be i=
n
> the *.status files anyway, it's just a way to index them. FWIW I thin=
k
> this should be dealt with in a higher level tool. What is needed firs=
t
> for the developer is a way to deal with a bug he knows is here. Deali=
ng
> with large collection of bugs must be built on top of that, and is ea=
sy
> to keep up to date through proper hooks.

Yes, hooks might be the right approach for this.

>   IMHO the sole features it should provide and design specifically ar=
e:=20
>   * the efficient linking with the rest of the repository (through
>     annotations, decorations, or whichever implementation) ;
>   * the storage backend, in a supple enough way to allow usual
>     operations (threading, answers, attachments, use through mail or
>     {web,G}ui, ...)
>   * versioning of the BTS datas.
> The rest can just be built on top of that.

Agreed.

Rogan
