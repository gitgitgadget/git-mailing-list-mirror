From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 14:50:35 -0600
Message-ID: <m1y7wpde1w.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 22:51:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjMnz-0001Bw-Cy
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWEYUvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWEYUvg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:51:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15010 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030410AbWEYUvg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 16:51:36 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4PKoa64012211;
	Thu, 25 May 2006 14:50:36 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4PKoaLR012210;
	Thu, 25 May 2006 14:50:36 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3beyuffg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 25 May 2006 11:28:51 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20763>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Thu, 25 May 2006, Eric W. Biederman wrote:
>>> 
>>> My basic argument is that starting a pull with a commit that is not a
>>> reference is no worse than staring a pull from a broken repository.  The
>>> same checks that protects us should work in either case.
>>
>> I think Junio reacted to the subject line, which was somewhat badly 
>> phrased. You're not looking to transfer random objects, you're looking to 
>> _start_ a branch at any arbitrary known point.
>
> I realize that now.  From Eric's original message:
>
>   To be accurate of his source Andrew records the sha1 of the commit
>   and the git tree he pulled from.  Which looks like:
>
>   GIT b307e8548921c686d2eb948ca418ab2941876daa \
>    git+ssh://master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
>   So I figured I would transform the above line into the obvious
>   git-pull command:
>
>    git-pull \
>     git+ssh://master.kernel.org/pub/scm/.../torvalds/linux-2.6.git \
>     b307e8548921c686d2eb948ca418ab2941876daa
>
> With the limitation of the current tool, we could do:
>
>   git-fetch master.kernel.org:/pub/scm/.../torvalds/linux-2.6.git \
> 	refs/heads/master:refs/remotes/linus/master
>   git merge 'whatever merge message' HEAD b307e854
>
> assuming that b307e854 is reachable from your tip.  So it might
> be just a matter of giving a convenient shorthand to do the
> above two commands, instead of mucking with upload-pack.

If we conclude the fetch by sha1 path is not practical certainly.

There are a couple of problems with the just use the tool as
is approach.
- I don't know which branch I need to fetch.
  Although it looks like Andrew has kept that information when it was not the
  default branch so I can probably use that.
- Fetching a branch that I just want a subset of is wasteful.
- It feels really weird when everything else allows me to use sha1s
  for git-fetch to deny them.

Then there is the big hole in my plan to get better changelog information
that it appears that after Andrew pulls a branch he resolves some
merge conflicts.  If that is right I need to figure out how to address
that before I can improve git-quiltimport.sh.

To get a slightly better feel of the problem below is the complete list of git
trees that Andrew pulled in for 2.6.17-rc4-mm3.

Eric


GIT d684de2c4a498ec4edf4e6c3420b008c62be394c git+ssh://master.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test
GIT 34ec52e3356245e9a13dfcbc8460635e675f13cf git+ssh://master.kernel.org/pub/scm/linux/kernel/git/davej/agpgart.git
GIT 08e66777d094d93091a914a8746a9b93599e14a9 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/perex/alsa-current.git
GIT 0ef744735f0d82d90809935586a0d1043f7f09b5 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/viro/audit-current.git#master.b13
GIT cca5d8ad1f58f188500b9fb12ba6d98643a4cf49 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git#for-linus
GIT b3b6a155c2b85d436b192d74e459f837eab0944e git+ssh://master.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git#cfq
GIT 8ba86486650c59f969c589c7d6c3dd4da734c75a git+ssh://master.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
GIT 2a1db55336a9e99f5dd7ee64e42fa4cbb509ea6a git+ssh://master.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
GIT 639b4408a9e8e014878c7538859f33f852c23882 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git#devel
GIT d2f222e6310b073ae3d91b8d3d676621fae1314e git+ssh://master.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git
GIT 3ac6c7b44560fdf2ea8865536bd52d4ff038107e git://git.infradead.org/hdrcleanup-2.6.git
GIT 12415e45ab0429a88412f4af365515adbe0bdd68 git://git.infradead.org/hdrinstall-2.6.git
GIT 155f23d603727fcb2af6c69ff77b74d1d4eb5bde git+ssh://master.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git#test
GIT ba9cfd16a13a932f0603a7f65b3881738a698ae1 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git#for-mm
GIT 51d797474f87b375819d084f7583a2864c5656c4 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6#i915fb
GIT c32217fdc98292dbafd5f51d3f43337081b01c29 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git
GIT 9fe74aaa1dc55100d20d9b7be2ccbf84ad26ce84 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git#ALL
GIT 864fdc881dd9e0077f9ed11191055e3eabf3b2a5 git://www.linux-mips.org/pub/scm/upstream.git#for-akpm
GIT 0d25971d7c969debf76f9fab6d6b37cb62408f55 git://git.infradead.org/mtd-2.6.git
GIT b748b7167cbeb11e729c6f9c3472165903dd115e git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL
GIT c4bdea3ce8b1d9b9d8dc44223542b3ebbe3a3020 git://git.linux-nfs.org/pub/linux/nfs-2.6.git
GIT f8b4c6027275d9b2d5004726a6d1bb818a13ddef git://oss.oracle.com/home/sourcebo/git/ocfs2.git/#ALL
GIT 35b86edf75270176310cb9507745d8c02b9e6592 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git/
GIT 3c06da5ae5358e9d325d541a053e1059e9654bcc git+ssh://master.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
GIT aa783a8f31c79f493bd49ba926b171b79b9839fb git://git.infradead.org/users/dwmw2/rbtree-2.6.git
GIT ee69d3f20b23250eae98a4cb20236196694f0b81 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jejb/aic94xx-sas-2.6.git
GIT 9f434d4f84a235f6b61aec6e691d6b07bc46fc24 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
GIT 0df298d180556450cbe5edf12c1e890f6ac6ea97 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-target-2.6.git
GIT f1d282724317895f73c4c182041ab4385126c026 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git#stex
GIT 19932e4d7d2002bc956d1636e1c3a1d4455049fa git+ssh://master.kernel.org/pub/scm/linux/kernel/git/viro/bird.git#frv.b14
GIT 6ea79eadeba9b0d0ab08dcf7ee16df13e1fdadae git+ssh://master.kernel.org/pub/scm/linux/kernel/git/viro/bird.git#m32r.b14
GIT c3d6ecc77e8e5d4ac82c3bf27ed02b8c0d83d41d git+ssh://master.kernel.org/pub/scm/linux/kernel/git/viro/bird.git#m68k.b14
GIT e7dd49b206624021c23a27512d2a31503f5207f2 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/viro/bird.git#upf.b14
GIT ea0d175136582dff6e3591368b1da472ef3870b8 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/viro/bird.git#volatile.b14
GIT b29527edccbbc53a908bc34a910df3601061c950 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog-mm.git
GIT b307e8548921c686d2eb948ca418ab2941876daa git+ssh://master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
