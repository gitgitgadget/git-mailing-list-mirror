From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: make install rewrites source files
Date: Mon, 23 Jan 2012 15:28:39 -0500
Message-ID: <4F1DC2F7.2070502@ubuntu.com>
References: <hbf.20120123bz2f@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Jan 23 21:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpQVS-0007YO-RU
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 21:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab2AWU2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 15:28:42 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:16819 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab2AWU2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 15:28:41 -0500
X-Authority-Analysis: v=2.0 cv=adPjbGUt c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=seg9fo12g4kA:10 a=1jw1B5Ym_9AA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=xe8BsctaAAAA:8 a=DJ29HrvqniOuVWWjLpIA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:53251] helo=[10.1.1.230])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 0C/6B-15128-7F2CD1F4; Mon, 23 Jan 2012 20:28:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <hbf.20120123bz2f@bombur.uio.no>
X-Enigmail-Version: 1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189011>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/23/2012 9:18 AM, Hallvard Breien Furuseth wrote:
> INSTALL says we can install a profiled Git with $ make profile-all 
> # make install prefix=...

prefix should be an argument to configure, not make.

> This does not work: 'make install' notices that the build flags
> has changed and rebuilds Git - presumably without using the profile
> info. The patch below fixes this.

make install implicitly includes make all; it is supposed to rebuild
anything that needs rebuilt.

> However, make install should not write to the source directory in
> any case.  That fails as root if root lacks write access there, due
> to NFS mounts that map root to nobody etc.  At least git-instaweb
> and GIT-BUILD-OPTIONS are rewritten.  You can simulate this with su
> nobody -s /bin/bash -c 'make -k install' after configuring with
> prefix=<directory owned by nobody>.

If you want to build locally from a read only nfs mount, then you
should run the configure script in a local directory:

mkdir /tmp/build
cd /tmp/build
/path/to/nfs/source/configure
make
make install

> Index: Makefile --- Makefile~	2012-01-19 01:36:02.000000000 +0100 
> +++ Makefile	2012-01-23 14:44:56.554980323 +0100

Hrm... Makefile should itself be a generated file from Makefile.in or
Makefile.am, but it appears that git isn't doing this.  Perhaps that
should be fixed.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPHcL3AAoJEJrBOlT6nu759U8IANCtJDWnCizSDWrJAFWe3ISr
FemiFgW347qjLcWlJS036nPfKnrxrJ88rF2e9+8Tj/hfPojNwCmyvN7rz+guI0uA
qqOfk9uN38Qd/jwfW5gv/7raKP4eUyRZ9ioptX3NqQtP5Co4TFuajOfswpN8f/DL
QiU7os62Df5HWW2U8A3XT9KiU9oWRala8dcrp5EJkEOfYDvQG2o3e1N/D91KC4el
lAyVEnzrvoLr5NzHCnFe7dQqvAB2S3PE/NP4anZHyNRp3SDLu1iZbD9MKC21Bd3n
BmCn9Vh7U+reC/NBMq8qaM69jLRk2Dx12brFoyY5/cjdQuaLj+n6h1nN9MqSKYI=
=/qLy
-----END PGP SIGNATURE-----
