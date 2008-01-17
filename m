From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 08:43:25 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 17:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFXqc-00047B-En
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 17:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYAQQng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 11:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbYAQQng
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 11:43:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41663 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751074AbYAQQnf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 11:43:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HGhRed014382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 08:43:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HGhPpS002008;
	Thu, 17 Jan 2008 08:43:26 -0800
In-Reply-To: <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.414 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_55
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70871>


On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>
> (the day I have two files in the same directory called "M=E4rchen" an=
d=20
> want to specify one of them on the command line I'll worry about that=
=20
> when I come to it).

Side note: the thing is, the reason people shouldn't worry about it is=20
that this is a *trivial* thing to handle. You really don't even need to=
=20
know what you're doing. And you can test it today, easily.

Having two (differently encoded) files like that is really no different=
=20
from the traditional UNIX FAQ of "how do I remove a file starting with=20
'-'" or even more closely "how do I remove a file that has a character =
in=20
it that I cannot get at the keyboard".

In other words, on a bog-standard UNIX (and yes, in this case, I bet OS=
 X=20
works fine too for this test), just try this

	filename1=3D$(echo -e "hello\002there")
	filename2=3D$(echo -e "hello\003there")
	echo Odd file > "$filename1"
	echo Another odd file > "$filename2"

and now you have a filename that is actually rather hard to type on the=
=20
command line. In fact, for me they even *look* the same:

	[torvalds@woody ~]$ ll hello*
	-rw-rw-r-- 1 torvalds torvalds  9 2008-01-17 08:23 hello?there
	-rw-rw-r-- 1 torvalds torvalds 17 2008-01-17 08:23 hello?there

See?

Even in my graphical browser, those two filenames look 100% *identical*=
=2E I=20
could give you a screen-shot, but I'm lazy. Just take my word for it, o=
r=20
just fire up konqueror on Linux (but it may well depend on the particul=
ar=20
font you're using).

[ And yes, for other browsers, you might have something that shows them=
 as=20
  different characters - depending on the font, it might show up as a=20
  small box with [00 02] vs [00 03] in it, for example. But that's also=
=20
  actually 100% true of the two different encodings of '=E4' - you coul=
d=20
  easily have a file broswer that shows the multi-character as a=20
  multi-character, exactly to distinguish them and show that one of the=
m=20
  isn't "normalized"!

  The point is, once the filesystem doesn't corrupt the data, it's alwa=
ys=20
  easy to get at, and there is never any ambiguity. ]

How is this different from "M=E4rchen" spelled with two different encod=
ings=20
for that "=E4"?

I'll tell you: it's not at all different. It's 100% the exact same issu=
e.

And does that make you perhaps go "Hunh? How do I remove it, or open it=
?"

And the fact is, those "idential looking" filenames (and thus they must=
 be=20
the same, and something should have normalized them to the same thing,=20
no?) are obviously two different files, and they are *really*easy* to e=
dit=20
and look at.

=46ire up that graphical browser again, and it doesn't even matter whet=
her=20
the filename looks identical or not, it shows up as two different files=
,=20
and you can drag them around independently, rename them there, and at=20
least my file browser shows clearly which is which, because I get a sma=
ll=20
icon with a preview in it, so I directly see which one is the "Odd file=
"=20
and which one is the "Another odd file".

So the whole "but they _look_ the same" argument is just total BS. In j=
ust=20
about all character encodings there has always been unique and differen=
t=20
"characters" that _look_ the same on screen, and it has never really ma=
de=20
them actually *be* the same, and it has never been a valid argument for=
=20
them being considered the same.

Because even when they *look* the same, that file browser that didn't s=
how=20
the difference in names visually, still showed them correctly as two=20
separate files, and I could still just rename them by hand by=20
right-clicking on them and picking "rename".=20

So "look the same" is really not a new thing, nor is it even a really h=
ard=20
thing. Yes, people can get confused by it, but hey, people can get=20
confused by *anything*. People get confused by filenames starting with =
a=20
"-", yet nobody sane really says that filenames cannot start with a das=
h.

			Linus
