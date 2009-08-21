From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [RFC/PATCH 00/14] Build git with MSVC
Date: Fri, 21 Aug 2009 15:30:32 +0200
Message-ID: <cover.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE2-00012X-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbZHUNbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbZHUNbF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:05 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:45328 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbZHUNbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:04 -0400
Received: by ey-out-2122.google.com with SMTP id 22so190370eye.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TgBOsG/0B4+t8gNvNrgKMz6ByPyNrmFS4eS3k5snzcM=;
        b=q3LSdEDUVkUqDSpWLOYCJGrEEyOSpI6XDMU3tRxwATk02qp/cRqpE8mQqXsawjXb0p
         swyYd1jFslsVcAp2neLn/0W0Y5NvN2oRxrHK3JLL2o76RK9W02x/FvLaKAvaHzygHJaI
         0uIhk9VCftHJuMdeTYhFavyWWLBNN7ti0W1Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=t9XWeD1sSQ6m9EcYsBPWkEQBdmQ84h4s1E0AiRIVNxLqQO/da3d5I4IthAvIWMvOm6
         hesbvb3EU2nany5RsTO1BlCU3xBK2MXP1oxFCSHc9qSnc6nHE+O7pSBm3cfaeDR4z7GA
         RQGxVC7gu9xyxIC+WkNP6jqxgOwlXgUGpkTaw=
Received: by 10.210.116.3 with SMTP id o3mr1227965ebc.21.1250861464533;
        Fri, 21 Aug 2009 06:31:04 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.30.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126713>

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

Frank Li (11):
  Avoid declaration after statement
  Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
  Change regerror() declaration from K&R style to ANSI C (C89)
  mingw.c: Use the O_BINARY flag to open files
  Fix __stdcall/WINAPI placement and function prototype
  Test for WIN32 instead of __MINGW32_
  Avoid including windows.h in winansi.c for MSVC build
  Add MinGW header files to build git with MSVC
  Add platform files for MSVC porting
  Add MSVC project files
  Add README and gitignore file for MSVC build

Marius Storm-Olsen (3):
  Fix non-constant array creation
  Add define guards to compat/win32.h
  Add empty header files for MSVC port

 builtin-apply.c                      |    3 +-
 compat/mingw.c                       |   20 +-
 compat/msvc.c                        |   35 +
 compat/msvc.h                        |  102 +++
 compat/regex/regex.c                 |    7 +-
 compat/snprintf.c                    |    2 +-
 compat/vcbuild/.gitignore            |    3 +
 compat/vcbuild/README                |   13 +
 compat/vcbuild/git/git.vcproj        |  197 +++++
 compat/vcbuild/include/arpa/inet.h   |    1 +
 compat/vcbuild/include/dirent.h      |  128 ++++
 compat/vcbuild/include/grp.h         |    1 +
 compat/vcbuild/include/inttypes.h    |    1 +
 compat/vcbuild/include/netdb.h       |    1 +
 compat/vcbuild/include/netinet/in.h  |    1 +
 compat/vcbuild/include/netinet/tcp.h |    1 +
 compat/vcbuild/include/pwd.h         |    1 +
 compat/vcbuild/include/sys/ioctl.h   |    1 +
 compat/vcbuild/include/sys/param.h   |    1 +
 compat/vcbuild/include/sys/poll.h    |    1 +
 compat/vcbuild/include/sys/select.h  |    1 +
 compat/vcbuild/include/sys/socket.h  |    1 +
 compat/vcbuild/include/sys/time.h    |    1 +
 compat/vcbuild/include/sys/utime.h   |   34 +
 compat/vcbuild/include/sys/wait.h    |    1 +
 compat/vcbuild/include/unistd.h      |   92 +++
 compat/vcbuild/include/utime.h       |    1 +
 compat/vcbuild/libgit/libgit.vcproj  | 1359 ++++++++++++++++++++++++++++++++++
 compat/win32.h                       |    5 +
 compat/winansi.c                     |    2 +
 git-compat-util.h                    |    3 +
 help.c                               |    5 +-
 pager.c                              |    4 +-
 run-command.c                        |   12 +-
 run-command.h                        |    2 +-
 setup.c                              |    2 +-
 36 files changed, 2020 insertions(+), 25 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/README
 create mode 100644 compat/vcbuild/git/git.vcproj
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
 create mode 100644 compat/vcbuild/libgit/libgit.vcproj
