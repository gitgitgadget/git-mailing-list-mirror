From: Jason Gross <jasongross9@gmail.com>
Subject: *** glibc detected *** git: double free or corruption (fasttop):
 0x0000000001fab820 ***
Date: Tue, 4 Jun 2013 11:46:55 -0400
Message-ID: <CAKObCardgmTiuuE_LbzjD2fCmqwMHXbN-6-xZV_uUV=fjcBs3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 17:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjtSP-0000Dl-0R
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 17:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab3FDPr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 11:47:29 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:45916 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab3FDPr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 11:47:27 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so844834lbd.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=box5PrEv3bKRwYUqRhHxMEA8b5/mtBx7O5Z+N2+2cjw=;
        b=KOZPdcffZ2AP6MAL8BsVjtavrvGo8rMRlSBNSiaxv+to9U0udVHRc40HRXLpVlnZae
         /MtAz+Bii8KNJZsm1G15gw09WF65Q1ZyvtSplMIoXQZNifYbaXh9Es9dybNvjqdhxZLp
         LoHKIXf6YQVtyfiF1Bmd0cX2cyGgpugKpr1I3XFHxLefcREdEUvjdyx/xypZMcBgk+Wl
         Se2hI86yXiSpi4Gl1oZbwJAlpkEz50gNrqmidq+G7nDyTy2xzJPsH3X++4exZF4ptvSG
         I8TQ7yeMJed8U8IhPvYMQWSTJg+OS+xJ/3Zwi4ViLH4hcJ++k+dJiXyoSL+2kLRQHCkD
         Pg5A==
X-Received: by 10.112.137.99 with SMTP id qh3mr13170058lbb.119.1370360846036;
 Tue, 04 Jun 2013 08:47:26 -0700 (PDT)
Received: by 10.114.173.179 with HTTP; Tue, 4 Jun 2013 08:46:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226369>

I get "*** glibc detected *** git: double free or corruption
(fasttop): 0x0000000001fab820 ***" reliably on the following set of
commands.  I'm working on a remote machine where I don't have
administrative privileges, so I can't update from git 1.7.2.5 to a
newer version.  I figured I'd report it, even though I haven't checked
to see if it still happens in a newer version of git.

jgross@dr-wily:/tmp$ uname -a
Linux dr-wily 2.6.32-5-xen-amd64 #1 SMP Mon Feb 25 02:51:39 UTC 2013
x86_64 GNU/Linux
jgross@dr-wily:/tmp$ git --version
git version 1.7.2.5
jgross@dr-wily:/tmp$ git clone git://github.com/JasonGross/barnowl.git
Cloning into barnowl...
remote: Counting objects: 16064, done.
remote: Compressing objects: 100% (8172/8172), done.
remote: Total 16064 (delta 8517), reused 14679 (delta 7321)
Receiving objects: 100% (16064/16064), 8.69 MiB | 3.44 MiB/s, done.
Resolving deltas: 100% (8517/8517), done.
jgross@dr-wily:/tmp$ cd barnowl
jgross@dr-wily:/tmp/barnowl$ git checkout git-bug
Branch git-bug set up to track remote branch git-bug from origin.
Switched to a new branch 'git-bug'
jgross@dr-wily:/tmp/barnowl$ git shortlog | grep : | grep -v '' | less
*** glibc detected *** git: double free or corruption (fasttop):
0x00000000023fa800 ***
======= Backtrace: =========
/lib/libc.so.6(+0x71e16)[0x7fe7ed258e16]
/lib/libc.so.6(cfree+0x6c)[0x7fe7ed25db8c]
git[0x48b125]
git[0x4b7e08]
git[0x4577c2]
git[0x458151]
git[0x404671]
git[0x40484d]
/lib/libc.so.6(__libc_start_main+0xfd)[0x7fe7ed205c8d]
git[0x404009]
======= Memory map: ========
00400000-0050e000 r-xp 00000000 ca:01 541613
  /usr/bin/git
0070d000-00714000 rw-p 0010d000 ca:01 541613
  /usr/bin/git
00714000-00760000 rw-p 00000000 00:00 0
023fa000-025b5000 rw-p 00000000 00:00 0                                  [heap]
7fe7e8000000-7fe7e8021000 rw-p 00000000 00:00 0
7fe7e8021000-7fe7ec000000 ---p 00000000 00:00 0
7fe7ec721000-7fe7ec737000 r-xp 00000000 ca:01 655372
  /lib/libgcc_s.so.1
7fe7ec737000-7fe7ec936000 ---p 00016000 ca:01 655372
  /lib/libgcc_s.so.1
7fe7ec936000-7fe7ec937000 rw-p 00015000 ca:01 655372
  /lib/libgcc_s.so.1
7fe7ec937000-7fe7ed1e7000 r--p 00000000 ca:03 136990
  /tmp/barnowl/.git/objects/pack/pack-67364344f941243318353ed78170fd5d35869d1f.pack
7fe7ed1e7000-7fe7ed340000 r-xp 00000000 ca:01 659512
  /lib/libc-2.11.3.so
7fe7ed340000-7fe7ed53f000 ---p 00159000 ca:01 659512
  /lib/libc-2.11.3.so
7fe7ed53f000-7fe7ed543000 r--p 00158000 ca:01 659512
  /lib/libc-2.11.3.so
7fe7ed543000-7fe7ed544000 rw-p 0015c000 ca:01 659512
  /lib/libc-2.11.3.so
7fe7ed544000-7fe7ed549000 rw-p 00000000 00:00 0
7fe7ed549000-7fe7ed560000 r-xp 00000000 ca:01 659507
  /lib/libpthread-2.11.3.so
7fe7ed560000-7fe7ed75f000 ---p 00017000 ca:01 659507
  /lib/libpthread-2.11.3.so
7fe7ed75f000-7fe7ed760000 r--p 00016000 ca:01 659507
  /lib/libpthread-2.11.3.so
7fe7ed760000-7fe7ed761000 rw-p 00017000 ca:01 659507
  /lib/libpthread-2.11.3.so
7fe7ed761000-7fe7ed765000 rw-p 00000000 00:00 0
7fe7ed765000-7fe7ed77c000 r-xp 00000000 ca:01 527676
  /usr/lib/libz.so.1.2.3.4
7fe7ed77c000-7fe7ed97b000 ---p 00017000 ca:01 527676
  /usr/lib/libz.so.1.2.3.4
7fe7ed97b000-7fe7ed97c000 rw-p 00016000 ca:01 527676
  /usr/lib/libz.so.1.2.3.4
7fe7ed97c000-7fe7ed99a000 r-xp 00000000 ca:01 659508
  /lib/ld-2.11.3.so
7fe7edaef000-7fe7edb5e000 r--p 00000000 ca:03 136991
  /tmp/barnowl/.git/objects/pack/pack-67364344f941243318353ed78170fd5d35869d1f.idx
7fe7edb5e000-7fe7edb61000 rw-p 00000000 00:00 0
7fe7edb75000-7fe7edb99000 rw-p 00000000 00:00 0
7fe7edb99000-7fe7edb9a000 r--p 0001d000 ca:01 659508
  /lib/ld-2.11.3.so
7fe7edb9a000-7fe7edb9b000 rw-p 0001e000 ca:01 659508
  /lib/ld-2.11.3.so
7fe7edb9b000-7fe7edb9c000 rw-p 00000000 00:00 0
7fffd3766000-7fffd377b000 rw-p 00000000 00:00 0                          [stack]
7fffd37ff000-7fffd3800000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
  [vsyscall]


-Jason
