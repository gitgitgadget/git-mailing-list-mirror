From: dev <dev@cor0.com>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Thu, 28 Aug 2014 00:54:30 -0400 (EDT)
Message-ID: <1506847499.57192.1409201670955.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827192848.GC7561@peff.net> <805178325.32077.1409168920760.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827200612.GA10469@peff.net> <597210348.36175.1409173228026.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827222803.GZ20185@google.com>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 06:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMrjS-0006Zh-6d
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 06:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbaH1Eyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 00:54:41 -0400
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:49236 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463AbaH1Eyk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 00:54:40 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7S4sU1M018826;
	Thu, 28 Aug 2014 00:54:30 -0400
In-Reply-To: <20140827222803.GZ20185@google.com>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v-
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256072>



On August 27, 2014 at 6:28 PM Jonathan Nieder <jrnieder@gmail.com>
wrote:
> Hi again,
>
> dev wrote:
>
> > So I guess I have to create a config.mak file from somewhere.
>
> Sorry, let's take a step back.
>
> What exact commands do you use to build, starting from a pristine
> extracted tarball?  What output do you get back?

$ ls $SRC/git*
/usr/local/src/git-2.0.4.tar.gz

$ gzip -dc /usr/local/src/git-2.0.4.tar.gz | tar -xf -
$ mv git-2.0.4 git-2.0.4_SunOS5.10_sparcv9.002
$ cd git-2.0.4_SunOS5.10_sparcv9.002

$ gmake CFLAGS="$CFLAGS" LDFLAGS="$LD_OPTIONS"
    * new build flags
    CC credential-store.o
    * new link flags
    CC abspath.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC argv-array.o
    * new prefix flags
    CC attr.o
    CC base85.o
    CC bisect.o
    CC blob.o
    CC branch.o
    CC bulk-checkin.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC column.o
    CC combine-diff.o
    CC commit.o
    CC compat/obstack.o
. . .
    AR xdiff/lib.a
    LINK git-credential-store
cc: Warning: Option -64 passed to ld, if ld is invoked, ignored
otherwise
cc: Warning: multiple use of -Q option, previous one discarded.
ld: warning: option -Q appears more than once, first setting taken
Undefined                       first referenced
 symbol                             in file
libiconv_close                      libgit.a(utf8.o)  (symbol belongs to
implicit dependency /usr/local/lib/libiconv.so.2)
libiconv_open                       libgit.a(utf8.o)  (symbol belongs to
implicit dependency /usr/local/lib/libiconv.so.2)
libiconv                            libgit.a(utf8.o)  (symbol belongs to
implicit dependency /usr/local/lib/libiconv.so.2)
ld: fatal: symbol referencing errors. No output written to
git-credential-store
gmake: *** [git-credential-store] Error 2
$

> Sounds like NEEDS_LIBICONV should be set on Solaris.  You can test
> this by passing NEEDS_LIBICONV=YesPlease on the gmake command line and
> seeing what happens.

That looks to be the ticket to a binary.

Entire build completes with piles of warnings but I get a git binary :

$ file git
git: ELF 64-bit MSB executable, SPARC V9, total store ordering, version
1, dynamically linked (uses shared libs), not stripped


$ ldd git
        libz.so.1 =>     /usr/local/lib/libz.so.1
        libiconv.so.2 =>         /usr/local/lib/libiconv.so.2
        libintl.so.8 =>  /usr/local/lib/libintl.so.8
        libsocket.so.1 =>        /lib/64/libsocket.so.1
        libnsl.so.1 =>   /lib/64/libnsl.so.1
        libcrypto.so.1.0.0 =>    /usr/local/ssl/lib/libcrypto.so.1.0.0
        libpthread.so.1 =>       /lib/64/libpthread.so.1
        libc.so.1 =>     /lib/64/libc.so.1
        libmp.so.2 =>    /lib/64/libmp.so.2
        libmd.so.1 =>    /lib/64/libmd.so.1
        libscf.so.1 =>   /lib/64/libscf.so.1
        libdl.so.1 =>    /lib/64/libdl.so.1
        libz.so.1 (SUNW_1.1) =>  (version not found)
        libdoor.so.1 =>  /lib/64/libdoor.so.1
        libuutil.so.1 =>         /lib/64/libuutil.so.1
        libgen.so.1 =>   /lib/64/libgen.so.1
        libm.so.2 =>     /lib/64/libm.so.2
        /platform/SUNW,T5240/lib/sparcv9/libc_psr.so.1
        /platform/SUNW,T5240/lib/sparcv9/libmd_psr.so.1


Great, a problem with some libz.so.1 that we don't even need since we
have libz in /usr/local/lib just fine.  I have to look into that.

Otherwise :

$ ./git --version
git version 2.0.4


$ elfdump -devl git

ELF Header
  ei_magic:   { 0x7f, E, L, F }
  ei_class:   ELFCLASS64          ei_data:       ELFDATA2MSB
  ei_osabi:   ELFOSABI_SOLARIS    ei_abiversion: EAV_SUNW_CURRENT
  e_machine:  EM_SPARCV9          e_version:     EV_CURRENT
  e_type:     ET_EXEC
  e_flags:    [ EF_SPARCV9_TSO EF_SPARC_SUN_US1 EF_SPARC_SUN_US3 ]
  e_entry:           0x10002d960  e_ehsize:     64  e_shstrndx:  31
  e_shoff:              0xe327d0  e_shentsize:  64  e_shnum:     32
  e_phoff:                  0x40  e_phentsize:  56  e_phnum:     5

Version Needed Section:  .SUNW_version
     index  file                        version
       [2]  libsocket.so.1              SUNW_1.4
       [3]                              SUNW_1.1             [ INFO ]
       [4]                              SUNW_0.7             [ INFO ]
       [5]  libnsl.so.1                 SUNW_0.7
       [6]                              SUNWprivate_1.1
       [7]  libpthread.so.1             SUNW_1.2
       [8]                              SUNW_0.9             [ INFO ]
       [9]  libc.so.1                   SUNW_1.22
      [10]                              SUNW_1.19            [ INFO ]
      [11]                              SUNW_1.18            [ INFO ]
      [12]                              SUNW_1.1             [ INFO ]
      [13]                              SUNW_0.9             [ INFO ]
      [14]                              SUNW_0.7             [ INFO ]
      [15]                              SUNWprivate_1.1

Dynamic Section:  .dynamic
     index  tag                value
       [0]  NEEDED            0x11ecb             libz.so.1
       [1]  NEEDED            0x11ed5             libiconv.so.2
       [2]  NEEDED            0x11ee3             libintl.so.8
       [3]  NEEDED            0x11e3b             libsocket.so.1
       [4]  NEEDED            0x11e65             libnsl.so.1
       [5]  NEEDED            0x11ef0             libcrypto.so.1.0.0
       [6]  NEEDED            0x11e81             libpthread.so.1
       [7]  NEEDED            0x11ea3             libc.so.1
       [8]  INIT              0x1003e2b88
       [9]  FINI              0x1003e2b98
      [10]  RUNPATH           0x11f03
            /usr/local/lib/$ISALIST:/usr/local/ssl/lib/$ISALIST:/usr/local/lib:/usr/local/ssl/lib:/usr/local/lib/SALIST:/usr/local/ssl/lib/SALIST:/usr/local/lib:/usr/local/ssl/lib
      [11]  RPATH             0x11f03
            /usr/local/lib/$ISALIST:/usr/local/ssl/lib/$ISALIST:/usr/local/lib:/usr/local/ssl/lib:/usr/local/lib/SALIST:/usr/local/ssl/lib/SALIST:/usr/local/lib:/usr/local/ssl/lib
      [12]  HASH              0x100000178
      [13]  STRTAB            0x100018a98
      [14]  STRSZ             0x121ab
      [15]  SYMTAB            0x100006408
      [16]  SYMENT            0x18
      [17]  CHECKSUM          0xaca0
      [18]  VERNEED           0x10002ac48
      [19]  VERNEEDNUM        0x4
      [20]  PLTRELSZ          0x12f0
      [21]  PLTREL            0x7
      [22]  JMPREL            0x10002c670
      [23]  RELA              0x10002c5f8
      [24]  RELASZ            0x1368
      [25]  RELAENT           0x18
      [26]  DEBUG             0
      [27]  FLAGS             0                   0
      [28]  FLAGS_1           0                   0
      [29]  SUNW_STRPAD       0x200
      [30]  SUNW_LDMACH       0x2b                EM_SPARCV9
      [31]  PLTGOT            0x10053d900
   [32-42]  NULL              0
$

Funny I don't see libcurl anywhere. Thought that was needed? Also the
RUNPATH
and RPATH look duplicated and slightly borked but the initial data there
is correct enough to locate all the libs except for some strange libz
issue.

What I need to do now is run some tests. Really I should keep going
to get linkage with libssh2 and libcurl as well as correct perl in
the /usr/local/bin directory. I'll have to keep tweaking with the
various magic on the "gmake" command I guess.

> But it seems odd --- was iconv once part of libc on Solaris and then
> moved out or something?

There are plenty of dependencies and therefore I have GNU libiconv thus
:

$ which iconv
/usr/local/bin/iconv

$ /usr/local/bin/iconv --version
iconv (GNU libiconv 1.14)
Copyright (C) 2000-2011 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Written by Bruno Haible.


$ ldd /usr/local/bin/iconv
        libintl.so.8 =>  /usr/local/lib/libintl.so.8
        libiconv.so.2 =>         /usr/local/lib/libiconv.so.2
        libc.so.1 =>     /lib/64/libc.so.1
        libm.so.2 =>     /lib/64/libm.so.2
        /platform/SUNW,T5240/lib/sparcv9/libc_psr.so.1


> There have been lots of people building git
> on Solaris over the years (and writing patches to fix other build
> problems) without needing to set that flag.

Well I see what I see and am extracting from a tarball and reporting
precisely what is happening. Traditionally git has been a nightmare
to build on anything but linux. That is just my experience.  Let's
not even talk about OpenBSD.  A real nightmare.

dev
