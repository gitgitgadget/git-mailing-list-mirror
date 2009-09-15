From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [RFC/PATCH v3 00/14] Build Git with MSVC
Date: Tue, 15 Sep 2009 15:44:03 +0200
Message-ID: <cover.1253021221.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Sep 15 15:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYKw-0007Be-9d
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbZIONoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 09:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbZIONog
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:44:36 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40504 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbZIONof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:44:35 -0400
Received: by ewy2 with SMTP id 2so473419ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=P1W4xabASJvvYeKBObIkFBNdlqCez38SoJa5uNLbgSQ=;
        b=Pl5w6KhObH49afADeNiNK1nyKT7VZM7yCx7e3kAN+QLQceB+Viwjvx9Yl8uwpzKmJl
         gxRemmv7y7bIu9PnEJBQD3rRZ0PY2VHrz7yo46tDr5b6FgEnT/RPaP0huj59eYhIE/7x
         DXyCNZw3PLei6IEfGnCP9L1Z4+uR4Jba3EsnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ISgKva3rFb9sPimIxrNElcbvkuw02iOKEYlhdHek0GYVWNEl3dATnzAq+rsxHX/xjG
         hO77YQA0pZEodzIl2xKnOrxf1SQxXOQfnlP41ycxdslUVJyMTBjU7Gx32HNQfQz56ZnM
         3TBiX84RHsG5FLJBNOR5iZCfKg6Bfhi7bw3y8=
Received: by 10.211.139.17 with SMTP id r17mr8472232ebn.88.1253022275328;
        Tue, 15 Sep 2009 06:44:35 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 06:44:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128544>

=== V3 2009.09.15 ===

1) Reworded patch 01: s/Microsoft Visual C++/MSVC/
2) Nuked patch 02
3) Merged patch 03 into path 08
4) Rewrote patch 06 to set _fmode instead for both MinGW and MSVC
5) Fix patch 07 to use __stdcall for thread functions instead of WINAPI
6) Rewrote patch 14 to rather use a define to _chsize
7) Fix patch 15 to use "-o $@" instead of "-o git.o"

Think that's it..

=== V2 2009.09.14 ===

Here's a second roll of the series for supporting compilation of Git
using Visual C++ (MSVC). (Sorry for the long delay on a followup, time
is in short supply these days)

There's no guarantee that the compiled result will work as well as the
current MinGW compile, or at all. However, I think it's important to
get the Git repo to a compilable state with MSVC as quickly as
possible, to further enable contributions from the Windows developers
which we are sorely lacking at the moment.
I hope that a repo which compiles successfully with the tools they are
accustomed to (also a very good debugger) will entice them to send more
patches.

In addition to this series, I have also setup a repo with binaries of
the required libs to compile Git with MSVC. Only 32bit versions for now.
So, the developer can choose to either use that, or Frank's source code
repo to build Git with MSVC. You'll find the binary repo here:
    http://repo.or.cz/w/msvcgit.git

Note that the binaries will still require the msysgit environment for
execution, due to the non-binary components of Git. (Scripts, gitk,
git-gui, etc). You'll find that repo here:
    http://repo.or.cz/w/msysgit.git

1) Rebased ontop on current git.git 'next'.
2) Fixed code and commit msgs based on the previous feedback.
   Let me know if I forgot anything!
3) Added a proper Makefile patch for MSVC support.
   You now compile with 'make MSVC=1'.
4) Added perl scripts (contrib) which uses GNU Make output to generate
   MSVC IDE (.sln & .vcproj) projects and QMake projects, and picking
   up the project settings from the Makefile, so it's all in one place.
5) Added necessary patches to make things compile ontop of current
   'next'.

=== V1 2009.08.21 ===
So, Frank Li started this series, and I took it upon my self to help
out a bit; cleaning, reorganizing, rebasing the series. Hopefully
we're now a bit closer to including the series into mainline..

Here's a summary of what has happend:
1) This series is rebased ontop of git.git 'next', which needed an
   extra patch to avoid a non-constant array creation, which
   mscv doesn't like.
2) I've polished (tied to anyways) the commit messages a bit.
3) I've applied much of the feedback provided to the first round of
   the patches.
4) I've split, merged and reordered some of the patches, so things
   that belong together are in the same commits, and in a order of
   'importance'
5) I've removed the
       #define func _func
   stuff, as it's not needed and Microsoft cannot really kill the
   compatibility functions anyways. So, adding the define
       _CRT_NONSTDC_NO_DEPRECATE
   will kill the warnings seen without the defines above.
6) ..probably much more as well, but I forget..

Note: I did not sign off on the last two commits, which involve the
adding of the vcproj files, since I don't agree on adding them as is.
We need a Makefile way of compiling primarily, and second, a script
to generate the vcproj, as already discussed. But the commits are
included for completeness, at to let others compile and play with it.

I've kept the original author as is, and just signed the patches..
Thanks for watching, now bring on the comments!



Frank Li (6):
  Avoid declaration after statement
  Change regerror() declaration from K&R style to ANSI C (C89)
  Fix __stdcall placement and function prototype
  Test for WIN32 instead of __MINGW32_
  Add MinGW header files to build git with MSVC
  Add platform files for MSVC porting

Marius Storm-Olsen (8):
  Add define guards to compat/win32.h
  Set _O_BINARY as default fmode for both MinGW and MSVC
  Add empty header files for MSVC port
  Make usage of windows.h lean and mean
  Define strncasecmp and ftruncate for MSVC
  Add MSVC to Makefile
  Add README for MSVC build
  Add scripts to generate projects for other buildsystems (MSVC vcproj,
    QMake)

 .gitignore                                |   11 +
 Makefile                                  |   54 +++-
 compat/mingw.c                            |   20 +-
 compat/mingw.h                            |    9 +
 compat/msvc.c                             |   35 ++
 compat/msvc.h                             |   50 +++
 compat/regex/regex.c                      |    7 +-
 compat/snprintf.c                         |   10 +-
 compat/vcbuild/README                     |   50 +++
 compat/vcbuild/include/alloca.h           |    1 +
 compat/vcbuild/include/arpa/inet.h        |    1 +
 compat/vcbuild/include/dirent.h           |  128 ++++++
 compat/vcbuild/include/grp.h              |    1 +
 compat/vcbuild/include/inttypes.h         |    1 +
 compat/vcbuild/include/netdb.h            |    1 +
 compat/vcbuild/include/netinet/in.h       |    1 +
 compat/vcbuild/include/netinet/tcp.h      |    1 +
 compat/vcbuild/include/pwd.h              |    1 +
 compat/vcbuild/include/sys/ioctl.h        |    1 +
 compat/vcbuild/include/sys/param.h        |    1 +
 compat/vcbuild/include/sys/poll.h         |    1 +
 compat/vcbuild/include/sys/select.h       |    1 +
 compat/vcbuild/include/sys/socket.h       |    1 +
 compat/vcbuild/include/sys/time.h         |    1 +
 compat/vcbuild/include/sys/utime.h        |   34 ++
 compat/vcbuild/include/sys/wait.h         |    1 +
 compat/vcbuild/include/unistd.h           |   92 ++++
 compat/vcbuild/include/utime.h            |    1 +
 compat/vcbuild/scripts/clink.pl           |   48 +++
 compat/vcbuild/scripts/lib.pl             |   26 ++
 compat/win32.h                            |    7 +
 compat/winansi.c                          |    1 -
 contrib/buildsystems/Generators.pm        |   42 ++
 contrib/buildsystems/Generators/QMake.pm  |  189 +++++++++
 contrib/buildsystems/Generators/Vcproj.pm |  639 +++++++++++++++++++++++++++++
 contrib/buildsystems/engine.pl            |  353 ++++++++++++++++
 contrib/buildsystems/generate             |   29 ++
 contrib/buildsystems/parse.pl             |  228 ++++++++++
 git-compat-util.h                         |    9 +
 help.c                                    |    5 +-
 pager.c                                   |    4 +-
 run-command.c                             |   12 +-
 run-command.h                             |    2 +-
 setup.c                                   |    2 +-
 thread-utils.c                            |    5 +-
 45 files changed, 2084 insertions(+), 33 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h
 create mode 100644 compat/vcbuild/README
 create mode 100644 compat/vcbuild/include/alloca.h
 create mode 100644 compat/vcbuild/include/arpa/inet.h
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/grp.h
 create mode 100644 compat/vcbuild/include/inttypes.h
 create mode 100644 compat/vcbuild/include/netdb.h
 create mode 100644 compat/vcbuild/include/netinet/in.h
 create mode 100644 compat/vcbuild/include/netinet/tcp.h
 create mode 100644 compat/vcbuild/include/pwd.h
 create mode 100644 compat/vcbuild/include/sys/ioctl.h
 create mode 100644 compat/vcbuild/include/sys/param.h
 create mode 100644 compat/vcbuild/include/sys/poll.h
 create mode 100644 compat/vcbuild/include/sys/select.h
 create mode 100644 compat/vcbuild/include/sys/socket.h
 create mode 100644 compat/vcbuild/include/sys/time.h
 create mode 100644 compat/vcbuild/include/sys/utime.h
 create mode 100644 compat/vcbuild/include/sys/wait.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/include/utime.h
 create mode 100644 compat/vcbuild/scripts/clink.pl
 create mode 100644 compat/vcbuild/scripts/lib.pl
 create mode 100644 contrib/buildsystems/Generators.pm
 create mode 100644 contrib/buildsystems/Generators/QMake.pm
 create mode 100644 contrib/buildsystems/Generators/Vcproj.pm
 create mode 100644 contrib/buildsystems/engine.pl
 create mode 100644 contrib/buildsystems/generate
 create mode 100644 contrib/buildsystems/parse.pl
