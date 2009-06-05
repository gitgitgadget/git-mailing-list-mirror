From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 17:02:12 +0200
Message-ID: <20090605150212.GC764@atjola.homenet>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet> <20090605145508.GA6442@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 05 17:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCaw5-000198-Uq
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 17:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbZFEPCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZFEPCP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 11:02:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:56753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750893AbZFEPCO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 11:02:14 -0400
Received: (qmail invoked by alias); 05 Jun 2009 15:02:15 -0000
Received: from i59F5600C.versanet.de (EHLO atjola.local) [89.245.96.12]
  by mail.gmx.net (mp029) with SMTP; 05 Jun 2009 17:02:15 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18LFTxkAu8L+aIlB6FlUNCa8MWgtK+nYoKJFkUEAa
	tokqMynUb6DcZt
Content-Disposition: inline
In-Reply-To: <20090605145508.GA6442@mit.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120777>

On 2009.06.05 10:55:08 -0400, Theodore Tso wrote:
> On Fri, Jun 05, 2009 at 03:21:26PM +0200, Bj=F6rn Steinbrink wrote:
> > So the ctime got modified. I don't have any fancy indexing stuff
> > running, and inotify doesn't see any events either while the ctime =
is
> > changed.
> >=20
> > The only thing I changed lately was upgrading to 2.6.30-rc8 and goi=
ng
> > from ext3 to ext4. As the ctime change always seems to happen aroun=
d 30
> > seconds after the real change, I kind of suspect ext4 to be guilty.
> > Ted, is that possible?
> >=20
> > FS is mounted as:
> > /dev/mapper/vg0-home on /home type ext4 (rw,noatime,nodiratime,barr=
ier=3D0)
> >=20
>=20
> I agree it sounds like it's ext4 related, but I'm not able to
> reproduce it (using 2.6.30-rc8 with the patches planned for the 2.6.3=
1
> merge window).  This should show the problem, you were seeing, do you
> agree?

Yeah, that should do I guess. See my other mail for a simpler, less
time consuming way to test. And as noted in there, it seems to happen
only on ext3 filesystems mounted using ext4.

> <tytso@closure> {/usr/projects/linux/misc}  [master]
> 547% git reset --hard HEAD^
> HEAD is now at b63254c Merge branch 'drm-fixes' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/airlied/drm-2.6
> <tytso@closure> {/usr/projects/linux/misc}  [master]
> 548% git pull
> Updating b63254c..b87297f
> Fast forward
>  drivers/gpu/drm/i915/i915_gem.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> <tytso@closure> {/usr/projects/linux/misc}  [master]
> 549% stat drivers/gpu/drm/i915/i915_gem.c;sleep 60 ; stat drivers/gpu=
/drm/i915/i915_gem.c
>   File: `drivers/gpu/drm/i915/i915_gem.c'
>   Size: 117594		Blocks: 232        IO Block: 4096   regular file
> Device: fe00h/65024d	Inode: 2643071     Links: 1
> Access: (0644/-rw-r--r--)  Uid: (15806/   tytso)   Gid: (15806/   tyt=
so)
> Access: 2009-06-05 10:50:05.466966433 -0400
> Modify: 2009-06-05 10:50:05.466966433 -0400
> Change: 2009-06-05 10:50:05.466966433 -0400
>   File: `drivers/gpu/drm/i915/i915_gem.c'
>   Size: 117594		Blocks: 232        IO Block: 4096   regular file
> Device: fe00h/65024d	Inode: 2643071     Links: 1
> Access: (0644/-rw-r--r--)  Uid: (15806/   tytso)   Gid: (15806/   tyt=
so)
> Access: 2009-06-05 10:50:05.466966433 -0400
> Modify: 2009-06-05 10:50:05.466966433 -0400
> Change: 2009-06-05 10:50:05.466966433 -0400
>=20
> Hmm, can you send me the output of dumpe2fs -h for your /home
> filesystem?

dumpe2fs 1.41.6 (30-May-2009)
=46ilesystem volume name:   <none>
Last mounted on:          <not available>
=46ilesystem UUID:          4cc724c1-e366-41d7-8dee-baa6624bd04c
=46ilesystem magic number:  0xEF53
=46ilesystem revision #:    1 (dynamic)
=46ilesystem features:      has_journal resize_inode dir_index filetype
                          needs_recovery sparse_super large_file
=46ilesystem flags:         signed_directory_hash=20
Default mount options:    (none)
=46ilesystem state:         clean
Errors behavior:          Continue
=46ilesystem OS type:       Linux
Inode count:              15548416
Block count:              31095808
Reserved block count:     0
=46ree blocks:              19016208
=46ree inodes:              15221178
=46irst block:              0
Block size:               4096
=46ragment size:            4096
Reserved GDT blocks:      1016
Blocks per group:         32768
=46ragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
=46ilesystem created:       Tue May 15 19:50:48 2007
Last mount time:          Thu Jun  4 21:31:36 2009
Last write time:          Thu Jun  4 21:31:36 2009
Mount count:              17
Maximum mount count:      21
Last checked:             Tue Mar 24 15:15:08 2009
Check interval:           15552000 (6 months)
Next check after:         Sun Sep 20 16:15:08 2009
Lifetime writes:          37 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
=46irst inode:              11
Inode size:               128
Journal inode:            8
Default directory hash:   tea
Directory Hash Seed:      55e920c6-f31f-4761-b9d3-3ab558dc5746
Journal backup:           inode blocks
Journal size:             128M

Thanks,
Bj=F6rn
