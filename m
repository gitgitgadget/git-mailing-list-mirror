From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 19:33:55 +0200
Message-ID: <20071014173355.GB2776@steel.home>
References: <20071014143628.GA22568@atjola.homenet> <20071014163702.GA2776@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 19:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7Ls-0003IU-LF
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175AbXJNRd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 13:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758172AbXJNRd7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:33:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:30369 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758165AbXJNRd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:33:58 -0400
Received: from tigra.home (Fc8ce.f.strato-dslnet.de [195.4.200.206])
	by post.webmailer.de (fruni mo31) (RZmta 13.4)
	with ESMTP id e02db3j9ECGZJd ; Sun, 14 Oct 2007 19:33:56 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 11342277AE;
	Sun, 14 Oct 2007 19:33:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E7DA856D22; Sun, 14 Oct 2007 19:33:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071014163702.GA2776@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0sy8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60880>

Alex Riesen, Sun, Oct 14, 2007 18:37:02 +0200:
> Bj=C3=B6rn Steinbrink, Sun, Oct 14, 2007 16:36:28 +0200:
> > Hi Junio,
> >=20
> > git blame just decided to crash on me, when I tried to use it while
> > resolving a merge conflict. Interesting is probably, that it crashe=
s
> > when given the filename of a file that is not _directly_ affected b=
y the
> > merge, but contains code that originates from a file that caused
> > conlicts.
> >=20
> > Error message is:
> > fatal: internal error: ce_mode is 0
> >=20
>=20
> It is not crashing. It is just not handling unexpected situation
> properly:
>=20
>     $ testcase.sh
>     ...
>     Switched to branch "foo"
>     CONFLICT (delete/modify): file1 deleted in HEAD and modified in m=
aster. Version master of file1 left in tree.
>     Automatic merge failed; fix conflicts and then commit the result.
>     fatal: internal error: ce_mode is 0
>     $ git ls-files --cached --stage
>     100644 72139f38953679bd19b3a7938c479d73c1aa7b59 1       file1
>     100644 3181f904ce3f9364b08524edd262a7a2ac766c9c 3       file1
>     100644 24e1ea80d6dcc497f60597b2a6d7cf65ecaa958a 0       file2
>=20
> See? There is an unresolved merge.
>=20
> The question is, what's the problem...
>=20

=46WIW, backtrace. I'm giving up for today. Anyone?

(gdb) bt
#0  0x080b6ac5 in die_builtin (err=3D0x80f3b92 "internal error: ce_mode=
 is %o",=20
    params=3D0xbfd91c34 "") at usage.c:24
#1  0x080b6b84 in die (err=3D0x80f3b92 "internal error: ce_mode is %o")
    at usage.c:76
#2  0x080a3883 in ce_match_stat_basic (ce=3D0xb7f6a00c, st=3D0xbfd91cb8=
)
    at read-cache.c:153
#3  0x080a398f in ie_match_stat (istate=3D0x81342e0, ce=3D0xb7f6a00c,=20
    st=3D0xbfd91cb8, options=3D0) at read-cache.c:208
#4  0x080c87f3 in reuse_worktree_file (name=3D0x814c698 "file1",=20
    sha1=3D0x814c668 "r\023\2378\2256y=EF=BF=BD\031=EF=BF=BD=EF=BF=BD\2=
23\214G\235s=EF=BF=BD{Y\230=EF=BF=BD024\b",=20
    want_file=3D0) at diff.c:1499
#5  0x080c8a6f in diff_populate_filespec (s=3D0x814c668, size_only=3D1)
    at diff.c:1565
#6  0x080d0ab2 in is_exact_match (src=3D0x814c668, dst=3D0x814ca20, con=
tents_too=3D1)
    at diffcore-rename.c:108
#7  0x080d13aa in diffcore_rename (options=3D0xbfd91edc) at diffcore-re=
name.c:335
#8  0x080ccaef in diffcore_std (options=3D0xbfd91edc) at diff.c:3120
#9  0x08054c33 in find_rename (sb=3D0xbfd921e8, parent=3D0x81377c0,=20
    origin=3D0x814c5e0) at builtin-blame.c:427
#10 0x080563a3 in pass_blame (sb=3D0xbfd921e8, origin=3D0x814c5e0, opt=3D=
0)
    at builtin-blame.c:1216
#11 0x08056d09 in assign_blame (sb=3D0xbfd921e8, revs=3D0xbfd92068, opt=
=3D0)
    at builtin-blame.c:1501
#12 0x0805942a in cmd_blame (argc=3D2, argv=3D0xbfd92404, prefix=3D0x0)
    at builtin-blame.c:2414
#13 0x0804b7d8 in run_command (p=3D0x80fa8d0, argc=3D2, argv=3D0xbfd924=
04)
    at git.c:284
#14 0x0804b97a in handle_internal_command (argc=3D2, argv=3D0xbfd92404)
    at git.c:398
#15 0x0804ba52 in main (argc=3D2, argv=3D0xbfd92404) at git.c:435
(gdb)
