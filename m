From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: general protection faults with "git grep" version 1.7.7.1
Date: Mon, 24 Oct 2011 22:11:53 +0200
Message-ID: <20111024201153.GA1647@x4.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 22:12:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIQsN-0000Tc-GL
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 22:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab1JXUL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 16:11:58 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:57506 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab1JXUL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 16:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:subject:message-id:mime-version:content-type:
	content-transfer-encoding; q=dns/txt; s=beta; bh=5Isrm5xGayveEVi
	/X2q+osqQW0hNXy88/Fa87pBRDtM=; b=Q8RVpGOtcO+TtUcAeSOJQm6Y8072Mcf
	wvUfULHr8fKrMdZcxy51N0hQB9auB3XHmdDHNPYZOIw0yih57SIOLkwg4OeAWzc1
	GdGln+E2E3krDYWRc5NVqXWgv0WZTzt6+VXnS/0CUPvgjmv6hUic/sVbqViXc4GU
	OZEwfD5hlV6E=
Received: (qmail 14282 invoked from network); 24 Oct 2011 22:11:54 +0200
Received: from unknown (HELO x4.trippels.de) (ud10?360p3@91.64.56.160)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 24 Oct 2011 22:11:54 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184184>

Suddenly I'm getting strange protection faults when I run "git grep" on
the gcc tree:

git[4245] general protection ip:7f291f01461f sp:7fff5618a8b0 error:0 in=
 libc-2.14.90.so[7f291ef9a000+15d000]

 % gdb git
GNU gdb (Gentoo 7.3.1 p1) 7.3.1
Copyright (C) 2011 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
=2Ehtml>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copyi=
ng"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
=46or bug reporting instructions, please see:
<http://bugs.gentoo.org/>...
Reading symbols from /usr/bin/git...done.
(gdb) run grep composite_pointer_type
Starting program: /usr/bin/git grep composite_pointer_type
warning: no loadable sections found in added symbol-file system-supplie=
d DSO at 0x7ffff7ffa000
[Thread debugging using libthread_db enabled]
[New Thread 0x7ffff7859700 (LWP 18367)]
[New Thread 0x7ffff7058700 (LWP 18368)]
[New Thread 0x7ffff6857700 (LWP 18369)]
[New Thread 0x7ffff6056700 (LWP 18370)]
[New Thread 0x7ffff5855700 (LWP 18371)]
[New Thread 0x7ffff5054700 (LWP 18372)]
[New Thread 0x7ffff4853700 (LWP 18373)]
[New Thread 0x7ffff4052700 (LWP 18374)]

Program received signal SIGSEGV, Segmentation fault.
_int_malloc (av=3D0x7ffff7bbb600, bytes=3D21) at malloc.c:3463
3463        while ((pp =3D catomic_compare_and_exchange_val_acq (fb, vi=
ctim->fd, victim))
(gdb) bt
#0  _int_malloc (av=3D0x7ffff7bbb600, bytes=3D21) at malloc.c:3463
#1  0x00007ffff78d7300 in __GI___libc_malloc (bytes=3D21) at malloc.c:2=
924
#2  0x00007ffff78dc692 in __GI___strdup (s=3D0x7ffff2665760 "gcc/ada/i-=
cexten.ads") at strdup.c:43
#3  0x00000000004d5069 in xstrdup (str=3D0x7ffff2665760 "gcc/ada/i-cext=
en.ads") at wrapper.c:23
#4  0x000000000042c448 in grep_file_async (filename=3D0x7ffff2665760 "g=
cc/ada/i-cexten.ads", name=3D0x59fee0 "gcc/ada/i-cexten.ads",=20
    opt=3D<optimized out>) at builtin/grep.c:148
#5  grep_file (opt=3D0x7fffffffbfc0, filename=3D0x7ffff2665760 "gcc/ada=
/i-cexten.ads") at builtin/grep.c:459
#6  0x000000000042ddb0 in grep_cache (cached=3D0, pathspec=3D0x7fffffff=
bf70, opt=3D0x7fffffffbfc0) at builtin/grep.c:528
#7  cmd_grep (argc=3D<optimized out>, argv=3D0x7ffff2665760, prefix=3D0=
x0) at builtin/grep.c:1062
#8  0x00000000004045b0 in run_builtin (argv=3D0x7fffffffe110, argc=3D2,=
 p=3D0x536ba0) at git.c:308
#9  handle_internal_command (argc=3D2, argv=3D0x7fffffffe110) at git.c:=
466
#10 0x00000000004047ac in run_argv (argv=3D0x7fffffffdfa0, argcp=3D0x7f=
ffffffdfac) at git.c:512
#11 main (argc=3D2, argv=3D0x7fffffffe110) at git.c:585
(gdb)=20

or:

 % git grep composite_pointer_type
*** glibc detected *** git: double free or corruption (fasttop): 0x0000=
000001919800 ***
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
/lib64/libc.so.6(+0x792b6)[0x7f6ad1d392b6]
git[0x42bebb]
/lib64/libpthread.so.0(+0x7c9e)[0x7f6ad202ec9e]
/lib64/libc.so.6(clone+0x6d)[0x7f6ad1d99b8d]
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
00400000-00536000 r-xp 00000000 08:12 2310166                          =
  /usr/bin/git
00536000-0053d000 rw-p 00136000 08:12 2310166                          =
  /usr/bin/git
0053d000-0058b000 rw-p 00000000 00:00 0
01906000-01927000 rw-p 00000000 00:00 0                                =
  [heap]
=2E..

And strange output:
=2E..
gcc/cp/typeck.c:        result_type =3D composite_pointer_type (type0, =
type1, op0, op1,
gcc/cp/typeck.c:        result_type =3D composite_pointer_type (type0, =
type1, op0, op1,
error: 'gcc/testsuite/ada/acats/tests/c5/c54a24a.ada': short read No su=
ch file or directory
error: 'gcc/testsuite/ada/acats/tests/c5/c54a13a.ada': short read No su=
ch file or directory
error: 'gcc/testsuite/ada/acats/tests/c6/c64104m.ada': short read No su=
ch file or directory
error: 'gcc/testsuite/ada/acats/tests/cd/cd7101f.dep': short read No su=
ch file or directory
error: 'gcc/testsuite/ada/acats/tests/ce/ce3904a.ada': short read No su=
ch file or directory
error: 'gcc/testsuite/g++.dg/abi/pr39188-3b.C': short read No such file=
 or directory
error: '<90>=C7=B2^A': short read Is a directory

Note that all the above files actually exist.
All of this started with version v1.7.7.1, which I installed today. I
never had any problems with git before.
Any ideas what might be going on?
--=20
Markus
