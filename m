From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: running git-update-cache --refresh on different machines on a NFS share always ends up in a lot of io/cpu/time waste
Date: Sun, 22 May 2005 21:27:34 +0200
Message-ID: <20050522192734.GB23388@cip.informatik.uni-erlangen.de>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 21:27:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZw5m-0006Sx-7s
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEVT1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEVT1r
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:27:47 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:17120 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261339AbVEVT1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 15:27:41 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MJRZS8026300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 May 2005 19:27:35 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MJRYO0026297;
	Sun, 22 May 2005 21:27:34 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> It does?

Not for me at the moment:

faui03  -> NFS Server (Solaris 2.9)
faui04a -> NFS Client (Solaris 2.9)
faui01  -> NFS Client (Linux 2.4.30)

(faui03) [~/work/blastwave] date; time git-update-cache --refresh
Sun May 22 21:09:33 CEST 2005

real    1m6.362s
user    0m12.550s
sys     0m9.200s

(faui04a) [~/work/blastwave] date; time git-update-cache --refresh
Sun May 22 21:10:56 CEST 2005

real    1m20.097s
user    0m12.270s
sys     0m8.930s

(faui01) [~/work/blastwave] date; time git-update-cache --refresh;
Sun May 22 21:17:22 CEST 2005

real    0m30.617s
user    0m2.340s
sys     0m7.970s

> Can you check what 

> 	ls -li --time=atime

> shows on the different clients? Also, try "ctime".

atime is different of course different.

(faui01) [~/work/blastwave] (ls -Rli --time=atime; ls -lRi --time=ctime) > ~/faui01
(faui03) [~/work/blastwave] (ls -Rli --time=atime; ls -lRi --time=ctime) > ~/faui03
(faui04a) [~/work/blastwave] (ls -Rli --time=atime; ls -lRi --time=ctime) > ~/faui04a

(faui01) [~/work/blastwave] md5sum ~/faui0{1,3,4a}
a2c2cdb38537a54fb74613d1cf6537f0  /home/cip/adm/sithglan/faui01
67aee985bfb7514900a0a1d2c629cec9  /home/cip/adm/sithglan/faui03
67aee985bfb7514900a0a1d2c629cec9  /home/cip/adm/sithglan/faui04a
(faui01) [~/work/blastwave] diff -b -u ~/faui01 ~/faui03
--- /home/cip/adm/sithglan/faui01       2005-05-22 21:24:02.000000000 +0200
+++ /home/cip/adm/sithglan/faui03       2005-05-22 21:23:54.000000000 +0200
@@ -1,11 +1,11 @@
 .:
 total 15
 5483033 -rw-r--r--  1 sithglan icipguru  391 May 22 21:14 Makefile
-1842682 drwxr-xr-x  2 sithglan icipguru  512 May 22 21:23 packages/
-5541351 drwxr-xr-x  2 sithglan icipguru  512 May 22 21:23 public_html/
-5541339 drwxr-xr-x  2 sithglan icipguru  512 May 22 21:23 scripts/
-5482949 drwxr-xr-x  2 sithglan icipguru 8704 May 22 21:23 sources/
-5482985 drwxr-xr-x  2 sithglan icipguru 2048 May 22 21:23 specs/
+1842682 drwxr-xr-x    2 sithglan icipguru      512 May 22 21:19 packages/
+5541351 drwxr-xr-x    2 sithglan icipguru      512 May 22 21:19 public_html/
+5541339 drwxr-xr-x    2 sithglan icipguru      512 May 22 21:19 scripts/
+5482949 drwxr-xr-x    2 sithglan icipguru     8704 May 22 21:19 sources/
+5482985 drwxr-xr-x    2 sithglan icipguru     2048 May 22 21:19 specs/

 ./packages:
 total 0

If you need the files:

http://wwwcip.informatik.uni-erlangen.de/~sithglan/faui01  (58k)
http://wwwcip.informatik.uni-erlangen.de/~sithglan/faui03  (61k)
http://wwwcip.informatik.uni-erlangen.de/~sithglan/faui04a (61k)

> It _should_ be safe. It does the old lockfile thing, with a "link()" that
> should guarantee atomicity. No fcntl locking or similar that can have
> problems with networked filesystems and different UNIXes.

Is link() NFS safe? I thought only mkdir() for nfs?

	Thomas
