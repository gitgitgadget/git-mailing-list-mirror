From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Git very slow ?
Date: Sun, 8 Mar 2015 23:31:54 +0000
Message-ID: <20150308233154.GB3792@milliways>
References: <20150307013007.GA13250@milliways>
 <20150308155136.GA6273@vps892.directvps.nl>
 <20150308190244.GA32504@milliways>
 <CA+55aFwn9vOWAL_9eHQt+kQN16j3+nQLeibWos86g5T_RZEizg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin D <me@ikke.info>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 00:32:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUkfx-0006oz-FO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 00:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbbCHXb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 19:31:57 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:58809
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbbCHXb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 19:31:56 -0400
Received: from localhost.localdomain ([81.106.150.188])
	by know-smtprelay-7-imp with bizsmtp
	id 1BXu1q0264481jl01BXugW; Sun, 08 Mar 2015 23:31:54 +0000
X-Originating-IP: [81.106.150.188]
X-Spam: 0
X-Authority: v=2.1 cv=cpwVkjIi c=1 sm=1 tr=0 a=DGj713NdaxKrsjjgQne7PA==:117
 a=DGj713NdaxKrsjjgQne7PA==:17 a=J0QyKEt1u0cA:10 a=IkcTkHD0fZMA:10
 a=NLZqzBF-AAAA:8 a=emO1SXQWCLwA:10 a=U_S0rIq7L049Zy-7SVAA:9 a=QEXdDO2ut3YA:10
Received: by localhost.localdomain (Postfix, from userid 500)
	id 8AEE8885A3; Sun,  8 Mar 2015 23:31:54 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CA+55aFwn9vOWAL_9eHQt+kQN16j3+nQLeibWos86g5T_RZEizg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265119>

On Sun, Mar 08, 2015 at 12:39:10PM -0700, Linus Torvalds wrote:
> On Sun, Mar 8, 2015 at 12:02 PM, Ken Moffat <zarniwhoop@ntlworld.com>=
 wrote:
> >
> > The comments on git bisect were for linus'skernel tree, on a local
> > disk.  2.3GB of repo, just under 57000 files.
>=20
> Ugh. I hope you are talking about checked-out size.
>=20
>     [torvalds@i7 linux]$ du -sh .git
>    850M .git
>=20
> because otherwise it sounds like that repo hasn't been repacked in fo=
rever.
>=20

 Yes - I had finished bisecting, with the build still present.

> To really pack things (which can slow things down for old history as
> people said, but on the whole it tends to be a big win due to less
> IO), do
>=20
>    git repack -adf --window=3D200 --depth=3D200
>=20
> and go away for a while. Oh, and make sure your machine has enough
> memory and CPU to make that "for a while" not be *too* long.
>=20

 For that, many thanks - this desktop has about 7GB (integrated
graphics steal a bit), current AMD desktop, and the repack of my
scripts repo took about 56 seconds.  I'll do that on my copy of
the kernel tomorrow (it's on another machine).

> You should have a few hundred files (just a few tens of files directl=
y
> after the repack) and that roughly 850MB of space for the repository
> information itself.
>=20
> But yeah, fully checked out and built with all the modules etc, you
> would have much more.
>=20
> That said, if you have something fairly that is consistently really
> slow (like the "git commit" you mentioned), *before* doing the repack=
,
> do
>=20
>    strace -o ../trace-file -Ttt git commit
>=20
> and we can get a much better guess about why it's so slow. Send it to
> me in private email if you don't want to make it public, and I can
> take a look.

 I don't think you need to look - it was taking most of the time
(about 8 seconds) looping through the many files below .git/objects.
The trace was just over 9000 lines, repeating after the repack was
less than 1300 lines.  It's available (97K after using xz) if you
think it would be useful, but I think you have already diagnosed the
problem and solution.
>=20
> > ping between them gives times of 0.25 to 0.3 seconds
>=20
> .. and I *really* hope that was not seconds, but ms. Otherwise your
> nfsv3 setup is going to be really really painful.
>=20
>                           Linus

 Yes, I'm not always good at knowing the right units.  Thanks for the
help.

=C4=B8en
--=20
Nanny Ogg usually went to bed early. After all, she was an old lady.
Sometimes she went to bed as early as 6 a.m.
