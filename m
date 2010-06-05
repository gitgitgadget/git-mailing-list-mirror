From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v8 0/2] Gettext support for Git
Date: Sat,  5 Jun 2010 21:12:51 +0000
Message-ID: <1275772373-26718-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 23:13:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL0gI-0003xp-HO
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869Ab0FEVNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 17:13:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:3783 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702Ab0FEVNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 17:13:21 -0400
Received: by fg-out-1718.google.com with SMTP id l26so531540fgb.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ldjOv29meyL2NPBXn53yqvKlVpvlm4dWdzyuXCpT22s=;
        b=aeZPIUr4Y4GNJHsl9jwbYBP9V4DSAoqS+WqezlIB6E3k34IhNDOwBsZDNeHvOCxppJ
         D5AUIDhe0wNmYe/vvDaYMceORJdnnNTSvduPrd/4xUtklni2oOJ3ysLaGZqcGHl4h4Ue
         eWX1NiuYUxp9Lr5I/qyaSlCts4GLmry8isRWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=H/oT15BSGbJzhNT3+ZjI4idv8h9hhXFxlsp3SvXHayIfMU6RSfHh0Bm7zpYMXfh3Is
         gAoZZ0+bMPbHKRlgyisAR935yk9eaV0L+kzbbpYfO/G+dq21HewujVer+Nosxuw+n1YC
         JXD+WUY9FRPu4YJRKNISHYZzlmQUTdTeYdoG0=
Received: by 10.102.16.19 with SMTP id 19mr4419619mup.111.1275772400045;
        Sat, 05 Jun 2010 14:13:20 -0700 (PDT)
Received: from aoeu.localdomain (pD9537C21.dip.t-dialin.net [217.83.124.33])
        by mx.google.com with ESMTPS id b9sm3889013mug.37.2010.06.05.14.13.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 14:13:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148496>

This is version 8 of the series to make Git optionally translatable
with GNU gettext.

Changes since version 7:

   Incorporated a bunch of suggestions and fixes from Jonathan Nieder
   and Jakub Narebski, thanks for those. Added some changes of my own
   too.

   * Don't compile gettext.c at all when NO_GETTEXT is defined. Just
     define a stub function in gettext.h

   * Add back support (and a new test) for the no-op N_() macro. This
     is used for marking translations for later use, e.g.:
       =20
        const char help[] =3D
        	N_("See 'git help COMMAND' for more information on a specific =
command.");
       =20
        int main(void)
        {
            puts(_(help));

   * Define NEEDS_LIBINTL depending on whether gettext is in the C
     library when running the autoconf script. Tested on Debian and
     FreeBSD.

   * Add the git_setup_gettext() initialization function to all
     $(PROGRAM_OBJS). This enables translation of git-imap-send,
     git-daemon and others that don't use git.c's main function.

   * Define git_setup_gettext as returning `extern void' instead of
     `void' as suggested by Jonathan Nieder.

   * Update is.po whose comments hadn't been updated for the t/
     directory renaming done in an earlier patch version.

   * rebase the series so that the two two patches now work
     stand-alone. Some tests meant for the second patch had crept into
     the first one during earlier rebases.

Here's the diff --stat since v7:
   =20
     Makefile           |    4 +++-
     config.mak.in      |    1 +
     configure.ac       |    6 ++++++
     daemon.c           |    3 +++
     fast-import.c      |    3 +++
     gettext.c          |    6 +-----
     gettext.h          |    7 ++++++-
     http-backend.c     |    3 +++
     http-fetch.c       |    3 +++
     http-push.c        |    3 +++
     imap-send.c        |    3 +++
     po/is.po           |   25 +++++++++++++------------
     shell.c            |    3 +++
     show-index.c       |    3 +++
     t/t0200-gettext.sh |    6 +++++-
     t/t0200/test.c     |    4 ++++
     upload-pack.c      |    3 +++
     17 files changed, 66 insertions(+), 20 deletions(-)
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                   |    2 +
 INSTALL                      |    8 ++
 Makefile                     |   69 ++++++++++++++++++-
 config.mak.in                |    2 +
 configure.ac                 |   12 +++
 daemon.c                     |    3 +
 fast-import.c                |    3 +
 gettext.c                    |   21 ++++++
 gettext.h                    |   18 +++++
 git-pull.sh                  |   16 +++--
 git-send-email.perl          |    3 +-
 git-sh-i18n.sh               |   47 +++++++++++++
 git.c                        |    3 +
 http-backend.c               |    3 +
 http-fetch.c                 |    3 +
 http-push.c                  |    3 +
 imap-send.c                  |    3 +
 perl/Git/I18N.pm             |   91 +++++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 ++++-
 po/.gitignore                |    1 +
 po/is.po                     |   70 +++++++++++++++++++
 shell.c                      |    3 +
 show-index.c                 |    3 +
 t/t0200-gettext.sh           |  154 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   14 ++++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   42 +++++++++++
 t/t0202-gettext-perl.sh      |   20 ++++++
 t/t0202/test.pl              |  104 ++++++++++++++++++++++++++++
 t/test-lib.sh                |    2 +
 upload-pack.c                |    3 +
 wt-status.c                  |  107 +++++++++++++++--------------
 34 files changed, 813 insertions(+), 65 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0201-gettext-fallbacks.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
