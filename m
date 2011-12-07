From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [linux@arm.linux.org.uk: Re: [GIT PULL] Identity mapping changes for
 3.3]
Date: Wed, 7 Dec 2011 21:06:40 +0100
Message-ID: <20111207200640.GK4585@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@fluxnic.net>,
	Will Deacon <will.deacon@arm.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 21:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNlS-0007bx-8q
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 21:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341Ab1LGUGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 15:06:45 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59288 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758326Ab1LGUGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 15:06:44 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1RYNlL-0008Vq-54; Wed, 07 Dec 2011 21:06:43 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.77)
	(envelope-from <ukl@pengutronix.de>)
	id 1RYNlI-0008Ll-7z; Wed, 07 Dec 2011 21:06:40 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186497>

Hello,

Just FYI ...

Best regards
Uwe

----- Forwarded message from Russell King - ARM Linux <linux@arm.linux.=
org.uk> -----

Date: Wed, 7 Dec 2011 19:48:26 +0000
=46rom: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradea=
d.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] Identity mapping changes for 3.3
Message-ID: <20111207194826.GB14542@n2100.arm.linux.org.uk>

On Tue, Dec 06, 2011 at 11:25:47PM -0500, Nicolas Pitre wrote:
> Make sure the repo on that machine is nicely packed.  Running "git gc=
"=20
> (gc as in garbage collect) once in a while is a good thing to do,=20
> especially that you now have the smart HTTP protocol enabled.  That w=
ill=20
> bring the memory usage way down, and serving requests will be much=20
> faster too.  It is safe to put that in a cron job once a week or so,=20
> even if concurrent requests are being serviced.

Well, I tried an experiment.  On my laptop, if I run git fsck, it takes
around about 20 minutes to complete.

On ZenIV, I started this, this morning:

$ GIT_DIR=3Dlinux-2.6-arm.git git fsck

and it's now (this evening) some 10 hours after, its still going.  This
is the exact same repository (as it's an rsync'd copy of the git object=
s
and packs which are on the laptop.)

$ ps aux | grep git
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAN=
D
rmk      26731  1.4  1.0 382716 22036 pts/71   D+   08:37   9:13 git fs=
ck
apache   29810  1.0 10.0 793288 206564 ?       Sl   09:24   6:09 git pa=
ck-objects --revs --all --stdout --progress --delta-base-offset
apache   30923  1.0 10.0 790560 206260 ?       Sl   09:39   5:53 git pa=
ck-objects --revs --all --stdout --progress --delta-base-offset

So, it's consumed 9h of CPU time, the git pack-objects have taken some
5-6 hours...

$ vmstat 10
procs ------------memory---------- ---swap-- -----io---- --system-- ---=
--cpu-----
 r  b    swpd   free   buff  cache   si   so    bi    bo   in   cs  us =
sy id wa st
 0  4 2502200  45568   8252 125912   50   16    37    62    1    1  1  =
1 91  7  0
 0  4 2502068  46056   8176 126016   44    0 23858     9 2231 1216  1  =
4  1 94  0
 0  4 2501724  45100   8188 126764   76    0 22160     6 2269 1196  1  =
4  4 91  0

$ iostat 10
=2E..
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.88    0.00    4.10   91.71    0.00    3.32

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
sdf               1.20        10.40         4.80        104         48
sde               0.70        16.00         0.00        160          0
sdd              16.00       432.00        90.40       4320        904
sdg             126.00     12614.40         0.00     126144          0
md0               3.90        26.40         4.80        264         48
sda             139.90     12292.80         0.00     122928          0
sdb             136.10     12393.60         0.00     123936          0
sdc             113.70     12238.40         0.00     122384          0
md1             628.20     49643.20         0.00     496432          0

The repository resides on md1 (sdg, sda, sdb, sdc), the swap partially
on sdd and partially on md0 (sdf and sde).

If I kill all git processes, the disks fall back to about 2MB/s over 10
seconds of analysis.

As you can see, git fsck seems to be pulling data at around 50MB/s,
presumably for 9 hours - this is rediculous because there's only 500MB
of git data for it to read!

What are the top six users of system memory?

rmk      26731  1.4  1.0 380600 21348 pts/71   D+   08:37   9:17 git fs=
ck
named    30776  0.4  1.4 130804 29212 ?        Ssl  Oct08 386:55 /usr/s=
bin/named-sdb
root      2475  0.6  2.0  58940 41376 ?        S    10:40   3:38 spamd =
child
exim      2148  0.0  4.4 160228 91100 ?        Ssl  Jun24 183:50 clamd.=
exim
apache   29810  1.0 10.2 794312 210816 ?       Sl   09:24   6:27 git pa=
ck-objects
apache   30923  1.0 10.3 794656 213536 ?       Sl   09:39   6:10 git pa=
ck-objects

and lower down there's the bunch of apache httpd processes.

What this is saying to me is that git can't run sensibly on a dual-core
P4, 3GHz machine with 2G of RAM and 4G swap, with a disk IO subsystem
capable of about 50MB/s - basically, git is driving ZenIV into the grou=
nd
(and I believe git was also responsible for ZenIV having a load average
hitting a few hundred several months ago which resulted in us having to
have it rebooted.)

Last bit of information - from /proc/29810/maps:
0012b000-00148000 r-xp 00000000 08:33 179255     /lib/ld-2.13.so
00148000-00149000 r--p 0001c000 08:33 179255     /lib/ld-2.13.so
00149000-0014a000 rw-p 0001d000 08:33 179255     /lib/ld-2.13.so
0014c000-002cf000 r-xp 00000000 08:33 179409     /lib/libc-2.13.so
002cf000-002d0000 ---p 00183000 08:33 179409     /lib/libc-2.13.so
002d0000-002d2000 r--p 00183000 08:33 179409     /lib/libc-2.13.so
002d2000-002d3000 rw-p 00185000 08:33 179409     /lib/libc-2.13.so
002d3000-002d6000 rw-p 00000000 00:00 0
00304000-0031b000 r-xp 00000000 08:33 179711     /lib/libpthread-2.13.s=
o
0031b000-0031c000 r--p 00016000 08:33 179711     /lib/libpthread-2.13.s=
o
0031c000-0031d000 rw-p 00017000 08:33 179711     /lib/libpthread-2.13.s=
o
0031d000-0031f000 rw-p 00000000 00:00 0
00328000-0033c000 r-xp 00000000 08:33 179755     /lib/libz.so.1.2.5
0033c000-0033d000 rw-p 00013000 08:33 179755     /lib/libz.so.1.2.5
006da000-006db000 r-xp 00000000 00:00 0          [vdso]
08047000-08171000 r-xp 00000000 08:32 600804     /usr/libexec/git-core/=
git
08171000-08176000 rw-p 0012a000 08:32 600804     /usr/libexec/git-core/=
git
08176000-081be000 rw-p 00000000 00:00 0
0a06a000-0f1b0000 rw-p 00000000 00:00 0          [heap]
80a74000-90836000 rw-p 00000000 00:00 0
986bc000-9a6bc000 r--p 00000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
9a6bc000-9c6bc000 r--p 0b000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
9c6bc000-9e6bd000 rw-p 00000000 00:00 0
a0330000-a0331000 ---p 00000000 00:00 0
a0331000-a0d31000 rw-p 00000000 00:00 0
a0d31000-a0d32000 ---p 00000000 00:00 0
a0d32000-a1732000 rw-p 00000000 00:00 0
a1e72000-a3e72000 r--p 08000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
a3e72000-a5e72000 r--p 12000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
a5e72000-a7e72000 r--p 02000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
a8732000-a9e72000 r--p 1a000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
a9e72000-abe72000 r--p 05000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
abe72000-ac6fd000 rw-p 00000000 00:00 0
ac6fd000-ae6fd000 r--p 06000000 09:01 106316459  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.pack
ae6fd000-af3fb000 rw-p 00000000 00:00 0
af946000-af947000 rw-p 00000000 00:00 0
afb00000-afbb3000 rw-p 00000000 00:00 0
afbb3000-afc00000 ---p 00000000 00:00 0
afcc1000-b1652000 rw-p 00000000 00:00 0
b1800000-b1900000 rw-p 00000000 00:00 0
b1ae8000-b1af0000 r--p 00000000 09:01 88555537   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-60ee04b368ada02=
ba788d17a537c71bad7471a7a.idx
b1af0000-b1af3000 r--p 00000000 09:01 106318826  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-87f106a487c4238=
09976c6868ec7f1e9fc12e676.idx
b1af3000-b1af6000 r--p 00000000 09:01 88555528   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-1a10fd87008d0e0=
6d2ce83efff9bf4ba7abb12e8.idx
b1af6000-b1b03000 r--p 00000000 09:01 88555566   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-6ed1c32d2ec8e0c=
f20c9ef7d8b813e1f63f67203.idx
b1d00000-b1de8000 rw-p 00000000 00:00 0
b1de8000-b1e00000 ---p 00000000 00:00 0
b1e00000-b1e51000 rw-p 00000000 00:00 0
b1e51000-b1f00000 ---p 00000000 00:00 0
b1f00000-b1ffe000 rw-p 00000000 00:00 0
b1ffe000-b2000000 ---p 00000000 00:00 0
b2000000-b20e5000 rw-p 00000000 00:00 0
b20e5000-b2100000 ---p 00000000 00:00 0
b2100000-b21fc000 rw-p 00000000 00:00 0
b21fc000-b2200000 ---p 00000000 00:00 0
b2200000-b22fd000 rw-p 00000000 00:00 0
b22fd000-b2300000 ---p 00000000 00:00 0
b2300000-b23d7000 rw-p 00000000 00:00 0
b23d7000-b2400000 ---p 00000000 00:00 0
b2400000-b24fd000 rw-p 00000000 00:00 0
b24fd000-b2500000 ---p 00000000 00:00 0
b2500000-b25ea000 rw-p 00000000 00:00 0
b25ea000-b2600000 ---p 00000000 00:00 0
b2600000-b26e4000 rw-p 00000000 00:00 0
b26e4000-b2700000 ---p 00000000 00:00 0
b2700000-b27ee000 rw-p 00000000 00:00 0
b27ee000-b2800000 ---p 00000000 00:00 0
b2800000-b28ec000 rw-p 00000000 00:00 0
b28ec000-b2900000 ---p 00000000 00:00 0
b2900000-b29f3000 rw-p 00000000 00:00 0
b29f3000-b2a00000 ---p 00000000 00:00 0
b2b00000-b2cfe000 rw-p 00000000 00:00 0
b2cfe000-b2d00000 ---p 00000000 00:00 0
b2d00000-b2dfd000 rw-p 00000000 00:00 0
b2dfd000-b2e00000 ---p 00000000 00:00 0
b2f00000-b2ff4000 rw-p 00000000 00:00 0
b2ff4000-b3000000 ---p 00000000 00:00 0
b3100000-b31fe000 rw-p 00000000 00:00 0
b31fe000-b3200000 ---p 00000000 00:00 0
b3300000-b33f1000 rw-p 00000000 00:00 0
b33f1000-b3400000 ---p 00000000 00:00 0
b3500000-b35f6000 rw-p 00000000 00:00 0
b35f6000-b3600000 ---p 00000000 00:00 0
b3600000-b36f3000 rw-p 00000000 00:00 0
b36f3000-b3700000 ---p 00000000 00:00 0
b3700000-b37f9000 rw-p 00000000 00:00 0
b37f9000-b3800000 ---p 00000000 00:00 0
b3900000-b39f3000 rw-p 00000000 00:00 0
b39f3000-b3a00000 ---p 00000000 00:00 0
b3b03000-b76ab000 r--p 00000000 09:01 106316443  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-895bab46ff2e2e3=
d88eb2ebb8919a86104e6f59e.idx
b76ab000-b76b1000 r--p 00000000 09:01 106316389  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-742507456b81724=
d4b1b7c62a9c7b1a08dea788c.idx
b76b1000-b76b3000 r--p 00000000 09:01 88555543   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-01d8e6a80f43c48=
3b170f252a63549c3f3177435.idx
b76b3000-b76b5000 r--p 00000000 09:01 106316378  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-22db475e3babd50=
2f5462dbd53b0083f63054da8.idx
b76b5000-b76b7000 r--p 00000000 09:01 106319097  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-81e9156c16956b1=
ca13d0786f26c57da8a8c4d00.idx
b76b7000-b76b9000 r--p 00000000 09:01 106316404  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-02bd0e7dcc0d4f9=
ba1faef6cb90d3080451223ab.idx
b76b9000-b76be000 r--p 00000000 09:01 106320451  /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-64a9ef29c0dd71c=
0ada102c21a6d3297715b5ec0.idx
b76be000-b76c0000 r--p 00000000 09:01 88555532   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-cf138203ddca320=
52979b5eadc8b03fa8d9f6313.idx
b76c0000-b76c2000 r--p 00000000 09:01 88555522   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-08c44c7f1884253=
73f8ecb95e4bb342ee40d340e.idx
b76c2000-b76cb000 r--p 00000000 09:01 88555534   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-1fd3ce5f1145636=
ad725dec83f5ef91b80ec1cf3.idx
b76cb000-b76cf000 r--p 00000000 09:01 88555545   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-0e5768a969e7c4e=
f4f3406a129b1271971ee5342.idx
b76cf000-b76d4000 r--p 00000000 09:01 88555547   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-92592ad40e58a75=
d3d1b30a0a46e7ad63817637b.idx
b76d4000-b76d6000 r--p 00000000 09:01 88555549   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-5b26c4eb6fed3ce=
5b26e921aee548a7f3259a11e.idx
b76d6000-b76d9000 r--p 00000000 09:01 88555551   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-4a9b526f37540b1=
8dd2ff4e97ec94fcb49c0aeb6.idx
b76d9000-b76dd000 r--p 00000000 09:01 88555553   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-1a7d19bf1f4aa63=
bb54b0f7e77f5df8889099e3f.idx
b76dd000-b76e0000 r--p 00000000 09:01 88555558   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-7da553217dc96aa=
89cdcf50fe45615143aa01089.idx
b76e0000-b76e6000 r--p 00000000 09:01 88555555   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-e795f1594ea70cc=
a88a97ad23d2d62da06941038.idx
b76e6000-b76ea000 r--p 00000000 09:01 88555560   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-4c79da67fb0435e=
3a4a7440a714fb9d617995387.idx
b76e6000-b76ea000 r--p 00000000 09:01 88555560   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-4c79da67fb0435e=
3a4a7440a714fb9d617995387.idx
b76ea000-b76ef000 r--p 00000000 09:01 88555563   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-63e7f343a0aa5f8=
f6841c81211db00ce95adbe76.idx
b76ef000-b76f1000 rw-p 00000000 00:00 0
b76f5000-b76fa000 r--p 00000000 09:01 88555565   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-b37609403c59702=
e384e42a9df4bc16e2b3c1072.idx
b76fa000-b76fc000 r--p 00000000 09:01 88555542   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-23f0d9e30ada6f8=
29f6743a395bcb6f229c1453b.idx
b76fc000-b7700000 r--p 00000000 09:01 88555571   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-d073eba6bd4143e=
405ec9db4172d4406fa08ace8.idx
b7700000-b7702000 r--p 00000000 09:01 88555574   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-b2481dc10cc7222=
6ff396e864e4a6d7e2c26137d.idx
b7702000-b7704000 r--p 00000000 09:01 88555577   /archive/ftp/pub/linux=
/arm/kernel/git-cur/linux-2.6-arm.git/objects/pack/pack-866787d1e38a3c7=
c9ac0ab7057935bf5970bf319.idx
b7704000-b7705000 rw-p 00000000 00:00 0
bf8dc000-bf8fd000 rw-p 00000000 00:00 0          [stack]

It's worth noting that Linus tree currently has 19 pack files, my tree
has an additional 9 on that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


----- End forwarded message -----

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
