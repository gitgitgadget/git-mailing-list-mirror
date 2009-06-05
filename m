From: Theodore Tso <tytso@mit.edu>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 14:06:30 -0400
Message-ID: <20090605180630.GC6442@mit.edu>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet> <20090605145508.GA6442@mit.edu> <20090605150212.GC764@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 20:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCdoS-0007OG-IR
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbZFESGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 14:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbZFESGd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 14:06:33 -0400
Received: from THUNK.ORG ([69.25.196.29]:52102 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbZFESGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 14:06:32 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MCdoF-0004da-Sa; Fri, 05 Jun 2009 14:06:32 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MCdoE-0006Z7-Vx; Fri, 05 Jun 2009 14:06:30 -0400
Content-Disposition: inline
In-Reply-To: <20090605150212.GC764@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120816>

On Fri, Jun 05, 2009 at 05:02:12PM +0200, Bj=F6rn Steinbrink wrote:
> On 2009.06.05 10:55:08 -0400, Theodore Tso wrote:
> > On Fri, Jun 05, 2009 at 03:21:26PM +0200, Bj=F6rn Steinbrink wrote:
> > > So the ctime got modified. I don't have any fancy indexing stuff
> > > running, and inotify doesn't see any events either while the ctim=
e is
> > > changed.
> > >=20
> > > The only thing I changed lately was upgrading to 2.6.30-rc8 and g=
oing
> > > from ext3 to ext4. As the ctime change always seems to happen aro=
und 30
> > > seconds after the real change, I kind of suspect ext4 to be guilt=
y.
> > > Ted, is that possible?
> > >=20
> > > FS is mounted as:
> > > /dev/mapper/vg0-home on /home type ext4 (rw,noatime,nodiratime,ba=
rrier=3D0)
> > >=20
> >=20
> > I agree it sounds like it's ext4 related, but I'm not able to
> > reproduce it (using 2.6.30-rc8 with the patches planned for the 2.6=
=2E31
> > merge window).  This should show the problem, you were seeing, do y=
ou
> > agree?
>=20
> Yeah, that should do I guess. See my other mail for a simpler, less
> time consuming way to test. And as noted in there, it seems to happen
> only on ext3 filesystems mounted using ext4.

> Filesystem features:      has_journal resize_inode dir_index filetype
>                           needs_recovery sparse_super large_file

Yeah, so you haven't turned on any of the ext4 filesystem features, I
assume because you wanted to be easily go back to ext3 if you ran into
problems?  OK, that's a good starting point.

I'm guessing it's the presence or absence of one of the ext4-specific
filesystem features, most probably the extents feature (which is why I
had asked you to to send me your dumpe2fs -h output). =20

So the next step is to create an ext3 filesystem with a git repository
on it, and then to gradually turn on various ext4 specific features
and see when the bug ends up getting replicated.  If I had to guess
it's the lack (or absense) of the extents feature, but I'll have to
run the test and find out for sure.

Thanks for reporting the bug.  Let me see what I can find.

       	   	     	       	      	  - Ted
