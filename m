From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Recent gits corrupts repository
Date: Thu, 27 Oct 2011 08:50:44 +0200
Message-ID: <CAA787rnrG-mLRpq_a3xbbUyYuHz1kfdOzMqHQpxhBwc0rjt3Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 08:50:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJJnf-0000aa-7f
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 08:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab1J0Guq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 02:50:46 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:58277 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1J0Guo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 02:50:44 -0400
Received: by pzk36 with SMTP id 36so6636849pzk.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=8oKB8rBSXTQfgOnAmDmuPPN+I+24k6dzw7kUOtj4+lc=;
        b=LV8hOw1NmSjohmBW6/uRbBQxqnBzuyR70it8js+OzwuvX2AhrPFi1nZzeRvZlqzopt
         bsgfI7YYx4AmwuQvP3C8/wnrDjsmI2sv33iCMHSMQ1U+8mkjiThmQIRN7p1usBBqGMC7
         a7cFhfXhW1Ld2wRtyCF+yCadKcqgeSR3MRdcc=
Received: by 10.68.64.169 with SMTP id p9mr12655564pbs.116.1319698244318; Wed,
 26 Oct 2011 23:50:44 -0700 (PDT)
Received: by 10.142.135.5 with HTTP; Wed, 26 Oct 2011 23:50:44 -0700 (PDT)
X-Google-Sender-Auth: RQnWJ8UQCU0glkAec15tixFintI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184284>

Something really weird is happening to a repository I'm working on, and
it's only a problem in recent Gits. A bisect shows that from
v1.7.6-1-g2548183 ("fix phantom untracked files when core.ignorecase is
set") and newer, this happens:

  $ git clone git://gitorious.org/tz/tzfiles.git
  Cloning into tzfiles...
  remote: Counting objects: 358, done.
  remote: Compressing objects: 100% (352/352), done.
  remote: Total 358 (delta 8), reused 343 (delta 3)
  Receiving objects: 100% (358/358), 44.15 MiB | 3.76 MiB/s, done.
  Resolving deltas: 100% (8/8), done.

  $ cd tzfiles/

  $ git status
  git: malloc.c:3096: sYSMALLOc: Assertion `(old_top =3D=3D (((mbinptr)
(((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struct
malloc_chunk, fd)))) && old_size =3D=3D 0) || ((unsigned long) (old_siz=
e)
>=3D (unsigned long)((((__builtin_offsetof (struct malloc_chunk,
fd_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t)))
- 1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end &
pagemask) =3D=3D 0)' failed.
  Aborted

  $ git status
  *** glibc detected *** git: free(): invalid next size (normal): 0x089=
f5588 ***
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/tls/i686/cmov/libc.so.6(+0x6b591)[0xb74d3591]
  /lib/tls/i686/cmov/libc.so.6(+0x6cde8)[0xb74d4de8]
  /lib/tls/i686/cmov/libc.so.6(cfree+0x6d)[0xb74d7ecd]
  /lib/tls/i686/cmov/libc.so.6(+0x5c410)[0xb74c4410]
  /lib/tls/i686/cmov/libc.so.6(fopen64+0x2c)[0xb74c69ec]
  git[0x80c1fdd]
  git[0x811b82b]
  git[0x80637ea]
  git[0x804bc87]
  git[0x804be93]
  /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe6)[0xb747ebd6]
  git[0x804b521]
  =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
  08048000-08160000 r-xp 00000000 ca:00 2474445
/usr/local/varprg/git.master.v1.7.7-419-g87009ed/bin/git
  08160000-08161000 r--p 00117000 ca:00 2474445
/usr/local/varprg/git.master.v1.7.7-419-g87009ed/bin/git
  08161000-08166000 rw-p 00118000 ca:00 2474445
/usr/local/varprg/git.master.v1.7.7-419-g87009ed/bin/git
  08166000-081b0000 rw-p 00000000 00:00 0
  089ec000-08a0d000 rw-p 00000000 00:00 0          [heap]
  b7300000-b7321000 rw-p 00000000 00:00 0
  b7321000-b7400000 ---p 00000000 00:00 0
  b7444000-b7461000 r-xp 00000000 ca:00 24591      /lib/libgcc_s.so.1
  b7461000-b7462000 r--p 0001c000 ca:00 24591      /lib/libgcc_s.so.1
  b7462000-b7463000 rw-p 0001d000 ca:00 24591      /lib/libgcc_s.so.1
  b7463000-b7464000 rw-p 00000000 00:00 0
  b7464000-b7466000 r-xp 00000000 ca:00 1679643
/lib/tls/i686/cmov/libdl-2.11.1.so
  b7466000-b7467000 r--p 00001000 ca:00 1679643
/lib/tls/i686/cmov/libdl-2.11.1.so
  b7467000-b7468000 rw-p 00002000 ca:00 1679643
/lib/tls/i686/cmov/libdl-2.11.1.so
  b7468000-b75bb000 r-xp 00000000 ca:00 25961
/lib/tls/i686/cmov/libc-2.11.1.so
  b75bb000-b75bc000 ---p 00153000 ca:00 25961
/lib/tls/i686/cmov/libc-2.11.1.so
  b75bc000-b75be000 r--p 00153000 ca:00 25961
/lib/tls/i686/cmov/libc-2.11.1.so
  b75be000-b75bf000 rw-p 00155000 ca:00 25961
/lib/tls/i686/cmov/libc-2.11.1.so
  b75bf000-b75c3000 rw-p 00000000 00:00 0
  b75c3000-b75d8000 r-xp 00000000 ca:00 1679654
/lib/tls/i686/cmov/libpthread-2.11.1.so
  b75d8000-b75d9000 r--p 00014000 ca:00 1679654
/lib/tls/i686/cmov/libpthread-2.11.1.so
  b75d9000-b75da000 rw-p 00015000 ca:00 1679654
/lib/tls/i686/cmov/libpthread-2.11.1.so
  b75da000-b75dc000 rw-p 00000000 00:00 0
  b75dc000-b7714000 r-xp 00000000 ca:00 2007508
/lib/i686/cmov/libcrypto.so.0.9.8
  b7714000-b771c000 r--p 00137000 ca:00 2007508
/lib/i686/cmov/libcrypto.so.0.9.8
  b771c000-b772a000 rw-p 0013f000 ca:00 2007508
/lib/i686/cmov/libcrypto.so.0.9.8
  b772a000-b772e000 rw-p 00000000 00:00 0
  b772e000-b7741000 r-xp 00000000 ca:00 24635      /lib/libz.so.1.2.3.3
  b7741000-b7742000 r--p 00012000 ca:00 24635      /lib/libz.so.1.2.3.3
  b7742000-b7743000 rw-p 00013000 ca:00 24635      /lib/libz.so.1.2.3.3
  b774b000-b774f000 rw-p 00000000 00:00 0
  b774f000-b776a000 r-xp 00000000 ca:00 25083      /lib/ld-2.11.1.so
  b776a000-b776b000 r--p 0001a000 ca:00 25083      /lib/ld-2.11.1.so
  b776b000-b776c000 rw-p 0001b000 ca:00 25083      /lib/ld-2.11.1.so
  bfc1b000-bfc3c000 rw-p 00000000 00:00 0          [stack]
  f57fe000-f57ff000 r-xp 00000000 00:00 0          [vdso]
  Aborted

  $

Reverting 2548183 fixes the problem.

It also seems that the behaviour is not consistent. Sometimes, after
running the second "git status", this happens:

  $ git st
  error: index uses  extension, which we do not understand
  fatal: index file corrupt

And no, this is not memory corruption or something like that, the same
thing happens on my laptop.

Another curious thing: When using an earlier git (for example v1.7.6 in
the example below) on this repo after a "git status" with a recent git,
it segfaults. This indicates that recents Gits messes up something so
even old gits won't work in that repo anymore. This is the last lines o=
f
an strace:

  open(".git/objects/pack",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) =3D 3
  getdents64(3, /* 4 entries */, 32768)   =3D 192
  access(".git/objects/pack/pack-b9b05d1e8fed49138c1ffda8f0f2b7d7a8d31c=
6a.keep",
=46_OK) =3D -1 ENOENT (No such file or directory)
  stat64(".git/objects/pack/pack-b9b05d1e8fed49138c1ffda8f0f2b7d7a8d31c=
6a.pack",
{st_mode=3DS_IFREG|0444, st_size=3D46297839, ...}) =3D 0
  getdents64(3, /* 0 entries */, 32768)   =3D 0
  close(3)                                =3D 0
  open(".git/objects/info/alternates", O_RDONLY|O_LARGEFILE|O_NOATIME)
=3D -1 ENOENT (No such file or directory)
  open(".git/objects/pack/pack-b9b05d1e8fed49138c1ffda8f0f2b7d7a8d31c6a=
=2Eidx",
O_RDONLY|O_LARGEFILE|O_NOATIME) =3D 3
  fstat64(3, {st_mode=3DS_IFREG|0444, st_size=3D11096, ...}) =3D 0
  mmap2(NULL, 11096, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xb76e1000
  close(3)                                =3D 0
  getrlimit(RLIMIT_NOFILE, {rlim_cur=3D1024, rlim_max=3D1024}) =3D 0
  open(".git/objects/pack/pack-b9b05d1e8fed49138c1ffda8f0f2b7d7a8d31c6a=
=2Epack",
O_RDONLY|O_LARGEFILE|O_NOATIME) =3D 3
  fstat64(3, {st_mode=3DS_IFREG|0444, st_size=3D46297839, ...}) =3D 0
  fcntl64(3, F_GETFD)                     =3D 0
  fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
  read(3, "PACK\0\0\0\2\0\0\1f", 12)      =3D 12
  _llseek(3, 46297819, [46297819], SEEK_SET) =3D 0
  read(3, ",j\212\0375c\335\0k\244)\256\376\24\v\344\6]0\230", 20) =3D =
20
  mmap2(NULL, 33554432, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xb53fc000
  open(".git/info/grafts", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT (No such
file or directory)
  open(".git/shallow", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT (No such fil=
e
or directory)
  brk(0x977e000)                          =3D 0x977e000
  open("/proc/meminfo", O_RDONLY)         =3D 4
  fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
  mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) =3D 0xb76e0000
  read(4, "MemTotal:        1028684 kB\nMemF"..., 1024) =3D 1024
  close(4)                                =3D 0
  munmap(0xb76e0000, 4096)                =3D 0
  access(".git/info/exclude", R_OK)       =3D 0
  open(".git/info/exclude", O_RDONLY|O_LARGEFILE) =3D 4
  fstat64(4, {st_mode=3DS_IFREG|0644, st_size=3D240, ...}) =3D 0
  read(4, "# git ls-files --others --exclud"..., 240) =3D 240
  close(4)                                =3D 0
  access("/home/sunny/src/git/home-sunny/.gitexclude", R_OK) =3D 0
  open("/home/sunny/src/git/home-sunny/.gitexclude", O_RDONLY|O_LARGEFI=
LE) =3D 4
  fstat64(4, {st_mode=3DS_IFREG|0644, st_size=3D86, ...}) =3D 0
  read(4, "\n# ~/.gitexclude\n# File ID: bcf6"..., 86) =3D 86
  close(4)                                =3D 0
  open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) =3D =
4
  getdents64(4, /* 7 entries */, 32768)   =3D 216
  open(".gitignore", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT (No such file
or directory)
  --- SIGSEGV (Segmentation fault) @ 0 (0) ---
  +++ killed by SIGSEGV +++

Complete strace dump is stored at https://gist.github.com/1318830 .

I'm currently using 1.7.7.419.g87009 , compiled with a regular "make"
from the master branch. A quick test with newest master
(v1.7.7.1-475-g997a194) shows the same error. Not installed properly,
though, as I haven't run the test suite yet.

System info:

  Ubuntu 10.04.3 LTS
  gcc (Ubuntu 4.4.3-4ubuntu5) 4.4.3
  GNU ld (GNU Binutils for Ubuntu) 2.20.1-system.20100303

Same thing happens with Ubuntu 10.10 on my laptop.

Even when creating a bundle and recloning, this happens. Also when
initialising a new, clean repo and fetching from the original local
clone, same story.

The repository was created on 2011-10-08 06:54:00 +0200, and because I
create a tag everytime I compile (using
<https://github.com/sunny256/utils/blob/master/build-git>), I know the
repository was created with git v1.7.7-138-g7f41b6b.

Because Gmail probably will wrap long lines, a copy of this message is
stored at <https://gist.github.com/1318935>.

Regards,
=C3=98yvind
