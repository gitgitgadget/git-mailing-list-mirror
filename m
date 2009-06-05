From: Theodore Tso <tytso@mit.edu>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 10:55:08 -0400
Message-ID: <20090605145508.GA6442@mit.edu>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 16:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCapK-0004uf-U2
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 16:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZFEOzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 10:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZFEOzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 10:55:16 -0400
Received: from THUNK.ORG ([69.25.196.29]:58736 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbZFEOzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 10:55:15 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MCap3-0002nB-Qs; Fri, 05 Jun 2009 10:55:09 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MCap2-0002UN-MR; Fri, 05 Jun 2009 10:55:08 -0400
Content-Disposition: inline
In-Reply-To: <20090605132126.GB11035@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120776>

On Fri, Jun 05, 2009 at 03:21:26PM +0200, Bj=F6rn Steinbrink wrote:
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
>=20

I agree it sounds like it's ext4 related, but I'm not able to
reproduce it (using 2.6.30-rc8 with the patches planned for the 2.6.31
merge window).  This should show the problem, you were seeing, do you
agree?

<tytso@closure> {/usr/projects/linux/misc}  [master]
547% git reset --hard HEAD^
HEAD is now at b63254c Merge branch 'drm-fixes' of git://git.kernel.org=
/pub/scm/linux/kernel/git/airlied/drm-2.6
<tytso@closure> {/usr/projects/linux/misc}  [master]
548% git pull
Updating b63254c..b87297f
=46ast forward
 drivers/gpu/drm/i915/i915_gem.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)
<tytso@closure> {/usr/projects/linux/misc}  [master]
549% stat drivers/gpu/drm/i915/i915_gem.c;sleep 60 ; stat drivers/gpu/d=
rm/i915/i915_gem.c
  File: `drivers/gpu/drm/i915/i915_gem.c'
  Size: 117594		Blocks: 232        IO Block: 4096   regular file
Device: fe00h/65024d	Inode: 2643071     Links: 1
Access: (0644/-rw-r--r--)  Uid: (15806/   tytso)   Gid: (15806/   tytso=
)
Access: 2009-06-05 10:50:05.466966433 -0400
Modify: 2009-06-05 10:50:05.466966433 -0400
Change: 2009-06-05 10:50:05.466966433 -0400
  File: `drivers/gpu/drm/i915/i915_gem.c'
  Size: 117594		Blocks: 232        IO Block: 4096   regular file
Device: fe00h/65024d	Inode: 2643071     Links: 1
Access: (0644/-rw-r--r--)  Uid: (15806/   tytso)   Gid: (15806/   tytso=
)
Access: 2009-06-05 10:50:05.466966433 -0400
Modify: 2009-06-05 10:50:05.466966433 -0400
Change: 2009-06-05 10:50:05.466966433 -0400

Hmm, can you send me the output of dumpe2fs -h for your /home
filesystem?

						- Ted
