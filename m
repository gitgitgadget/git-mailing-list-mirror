From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 16:12:09 +0200
Message-ID: <20090605141209.GA764@atjola.homenet>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 05 16:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCa9c-0006fX-Uj
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 16:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbZFEOMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 10:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbZFEOML
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 10:12:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:55760 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbZFEOMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 10:12:10 -0400
Received: (qmail invoked by alias); 05 Jun 2009 14:12:11 -0000
Received: from i59F5600C.versanet.de (EHLO atjola.local) [89.245.96.12]
  by mail.gmx.net (mp042) with SMTP; 05 Jun 2009 16:12:11 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Z5Ts0FpOZNbWUfpZZTtsS5Oeu4D/QOJmmiWkp7s
	dZiIyHm/y6cwNp
Content-Disposition: inline
In-Reply-To: <20090605132126.GB11035@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120774>

On 2009.06.05 15:21:26 +0200, Bj=F6rn Steinbrink wrote:
> On 2009.06.05 14:24:44 +0200, Bj=F6rn Steinbrink wrote:
> > Hi,
> >=20
> > can't make any sense out of this at all:
> >=20
> > doener@atjola:git (master) $ git reset --hard HEAD@{1}
> > HEAD is now at b11cf09 Merge branch 'da/pretty-tempname'
> > doener@atjola:git (master) $ git update-ref refs/remotes/origin/mas=
ter HEAD
> >=20
> > doener@atjola:git (master) $ git pull
> > >From git://git.kernel.org/pub/scm/git/git
> >    b11cf09..6096d75  master     -> origin/master
> > Updating b11cf09..6096d75
> > Fast forward
> >  Documentation/RelNotes-1.6.3.2.txt     |   12 +++++-------
> >  Documentation/git.txt                  |    7 ++++++-
> >  contrib/completion/git-completion.bash |   12 ++++++++++--
> >  grep.c                                 |    6 +++++-
> >  4 files changed, 26 insertions(+), 11 deletions(-)
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > doener@atjola:git (master) $ git diff-index --name-only --cached HE=
AD
> >=20
> > *wait a minute, doing nothing*
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > Documentation/RelNotes-1.6.3.2.txt
> > Documentation/git.txt
> > contrib/completion/git-completion.bash
> > grep.c
>=20
> Hm, looks like this is not a git bug. Went back to 1.5.4, and even th=
at
> shows the error. So I actually looked at the files, and indeed, the f=
ile
> in the working tree gets modified. stat(1) shows:
>=20
> Right after the merge:
>   File: `grep.c'
>   Size: 16274           Blocks: 32         IO Block: 4096   regular f=
ile
> Device: fd03h/64771d    Inode: 5933481     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/  doener)   Gid: ( 1000/  doen=
er)
> Access: 2009-06-05 15:02:14.000000000 +0200
> Modify: 2009-06-05 15:02:14.000000000 +0200
> Change: 2009-06-05 15:02:14.000000000 +0200
>=20
> 60 seconds later:
>   File: `grep.c'
>   Size: 16274           Blocks: 32         IO Block: 4096   regular f=
ile
> Device: fd03h/64771d    Inode: 5933481     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/  doener)   Gid: ( 1000/  doen=
er)
> Access: 2009-06-05 15:02:14.000000000 +0200
> Modify: 2009-06-05 15:02:14.000000000 +0200
> Change: 2009-06-05 15:02:48.000000000 +0200
>=20
> So the ctime got modified. I don't have any fancy indexing stuff
> running, and inotify doesn't see any events either while the ctime is
> changed.
>=20
> The only thing I changed lately was upgrading to 2.6.30-rc8 and going
> from ext3 to ext4. As the ctime change always seems to happen around =
30
> seconds after the real change, I kind of suspect ext4 to be guilty.
> Ted, is that possible?
>=20
> FS is mounted as:
> /dev/mapper/vg0-home on /home type ext4 (rw,noatime,nodiratime,barrie=
r=3D0)

Hm, yup, seems to be ext4 related, doesn't happen on tmpfs.

Bj=F6rn
