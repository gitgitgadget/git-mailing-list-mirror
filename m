From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [Bug?] compiler warning with gcc >= 4.2
Date: Tue, 3 Jul 2007 14:58:44 +0200
Message-ID: <20070703125844.GL12721@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:58:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hy4-0001XR-I2
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbXGCM6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 08:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756117AbXGCM6x
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:58:53 -0400
Received: from planck.djpig.de ([85.10.192.180]:4225 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127AbXGCM6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:58:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id AC23888102
	for <git@vger.kernel.org>; Tue,  3 Jul 2007 14:58:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XIh9T5M9V8AI for <git@vger.kernel.org>;
	Tue,  3 Jul 2007 14:58:44 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 6FB6888105; Tue,  3 Jul 2007 14:58:44 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51488>

Hi,

while testing for an (probably) unrelated miscompilation bug,
I got the following warning while compiling git:

gcc-4.2 -o sha1_file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>'
-DETC_GITCONFIG=3D'"/home/djpig/etc/gitconfig"' -DNO_STRLCPY sha1_file.=
c
sha1_file.c: In function =E2=80=98check_packed_git_idx=E2=80=99:
sha1_file.c:523: warning: assuming signed overflow does not occur when =
assuming that (X + c) < X is always false
sha1_file.c:523: warning: assuming signed overflow does not occur when =
assuming that (X + c) < X is always false

This comes from the new -Wstrict-overflow which warns about the fact
that with -fstrict-overflow, which is activated by default with -O2,
the if clause referenced in the warning will be optimised away.

So I would be interested to know
a) if the compiler optimising this check away (which seems to be a chec=
k
   about whether signed overflow can occour) can lead to unwanted resul=
ts
b) if not a), if it would make sense trying to suppress that warning, s=
o
   that other people don't end up wondering the same as me

The used compiler was:
$ gcc-4.2 -v
Using built-in specs.
Target: hppa-linux-gnu
Configured with: ../src/configure -v
--enable-languages=3Dc,c++,fortran,objc,obj-c++,treelang --prefix=3D/us=
r
--enable-shared --with-system-zlib --libexecdir=3D/usr/lib
--without-included-gettext --enable-threads=3Dposix --enable-nls
--with-gxx-include-dir=3D/usr/include/c++/4.2 --program-suffix=3D-4.2
--enable-clocale=3Dgnu --enable-libstdcxx-debug --enable-mpfr
--disable-libssp --disable-werror --enable-checking=3Drelease
--build=3Dhppa-linux-gnu --host=3Dhppa-linux-gnu
--target=3Dhppa-linux-gnuThread model: posix
gcc version 4.2.1 20070627 (prerelease) (Debian 4.2-20070627-1)

Gruesse,
--=20
=46rank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
