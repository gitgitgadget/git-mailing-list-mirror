From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Sun, 26 Oct 2014 19:59:55 +0100
Message-ID: <544D44AB.1080305@web.de>
References: <20141020115943.GA27144@gmail.com> <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com> <20141020222809.GB223410@vauxhall.crustytoothpaste.net> <CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com> <54461483.9010600@drmicha.warpmail.net> <xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com> <54477C18.5060806@drmicha.warpmail.net> <20141023010927.GE312818@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 26 20:00:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiT3E-0002HO-U5
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 20:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbaJZTAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2014 15:00:25 -0400
Received: from mout.web.de ([212.227.17.11]:54803 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbaJZTAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 15:00:24 -0400
Received: from [192.168.178.27] ([79.250.186.219]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MHY1o-1XfAjP1jUS-003OzX; Sun, 26 Oct 2014 20:00:19
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141023010927.GE312818@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:X1uM9x2D1EquwKLyujOw7mY2jS+NqV3sn/xVoRjJrPGpKCI3sVy
 eh/q/CWeeZJLoLC8ybaH9CDfMab9FZHeQkGyNVLjYqp2m67I+4JCyDtWuoFMFrHZeEH6Bk5
 RvnFtOBW0nZbs2pfygbloafiqav8evYIaVkf0lfd51Hq6PZHtzdVRvx8cMk6n3ZzuANzoO1
 RkXreQVLvd4vQP9mMXIwQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.2014 um 03:09 schrieb brian m. carlson:
> On Wed, Oct 22, 2014 at 11:42:48AM +0200, Michael J Gruber wrote:
>> Junio C Hamano schrieb am 21.10.2014 um 20:14:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>> Unfortunately, the git archive doc clearly says that the umask is
>>>> applied to all archive entries.
>>>
>>> Is an extended pax header "an archive entry"?  I doubt it, and the
>>> above is not relevant.  The mode bits for the archive entry that it
>>> applies to does not come from there.
>>
>> The problem seem to be old tar versions which mis-take the extension=
s
>> for archive entries, aren't they?
>
> Yes.  POSIX isn't clear on how unknown entries are to be handled.  I'=
ve
> seen some Windows tar implementations extract GNU longlink extensions=
 as
> files, which leads to a lot of pain.

That's by design -- extended headers are meant to be extracted as plain=
=20
files by implementations that do not understand them.

http://pubs.opengroup.org/onlinepubs/009695399/utilities/pax.html says:=
=20
"If a particular implementation does not recognize the type, or the use=
r=20
does not have appropriate privilege to create that type, the file shall=
=20
be extracted as if it were a regular file if the file type is defined t=
o=20
have a meaning for the size field that could cause data logical records=
=20
to be written on the medium [...]."

>> My question to Brian still stands which existing users he was trying=
 to
>> cater for with his patch. If there indeed are no existing affected u=
sers
>> besides the KUP users (as you seem to assume) it's a clear case. Pun
>> intended ;)
>
> The pax format is an extension of the tar format.  All of the pax
> implementations I've seen on Linux (OpenBSD's and MirBSD's) don't
> actually understand the pax headers and emit them as files.  7zip doe=
s
> as well.  I expect there are other Unix systems where tar itself does=
n't
> understand pax headers, although I don't have access to anything othe=
r
> than Linux and FreeBSD.

NetBSD's tar does as well.

It's surprising and sad to see *pax* implementations not supporting pax=
=20
extended headers in 2014, though.  It seems long file names etc. are no=
t=20
common enough.  Or perhaps pax is simply not used that much.

> Since it's very common to extract tar archives in /tmp, I didn't want=
 to
> leave world-writable files in /tmp (or anywhere else someone might ge=
t
> to them).  While the contents probably aren't sensitive, a malicious
> user might fill someone's quota by "helpfully" appending /dev/zero to
> the file.  And yes, users do these things.

The extracted files are only world-writable if umask & 2 =3D=3D 0 or if=
 -p=20
(preserve permissions) has been used, no?

Ren=E9
