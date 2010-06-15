From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 0/2] Gettext support for Git
Date: Tue, 15 Jun 2010 02:11:44 +0000
Message-ID: <1276567906-17652-1-git-send-email-avarab@gmail.com>
References: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Wiegley <johnw@newartisans.com>,
	Graham Anderson <graham.anderson@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 04:12:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOLdy-0001xV-0K
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 04:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab0FOCMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 22:12:18 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40317 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab0FOCMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 22:12:17 -0400
Received: by wwb18 with SMTP id 18so4390394wwb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fqwBG1s/DHTGv1QexFb5E/ri7ExjdIMLdKmSHq/QXpQ=;
        b=ckVN+hS2PSF6c8RAL4CnjgEQaLNxh75sJJVFSc9vDp0leWDEK0gAnlR3bIZnguU7iI
         CHfXUHyFShL8nklpuz3qB6dE2m24SPNe0L398+S1Bf6qmmHdGf3fUKotY47f/mSEmsfm
         NATjntqj1NahtpAETX0N4bZaCk0EH0kmRpg7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cT4s5Vxzi5hcbnhAbusN2DwagBttMTvBPq6ILBsWGKJh0ier4zvwqx900FP8NOik5N
         nlBSSpIrSuDIcR1o69Ichdv6up5whT2ObSkyy1B7NNRsB1l2Rvy9GAYKeOk0PRwZEb+F
         c6XZ7THMI+UOx+i7KOZ/X8W+VO6PEvSZDBBDw=
Received: by 10.227.146.75 with SMTP id g11mr6551610wbv.130.1276567935062;
        Mon, 14 Jun 2010 19:12:15 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id t15sm41739662wbc.11.2010.06.14.19.12.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 19:12:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149150>

This patch series implements gettext support for git, making it
possible to localize it. This should really be v2, but PATCH 1/2 had a
trivial typo fix as v2, so I'm bumping the version of the whole series
to v3 to avoid dual v3/v2 confusion.

Changes since v1:

  * Fixed all the things that Junio pointed out:

    - Tests that are too fragile to run everywhere (depend on
      locale/OS/implementation combinations) are now skipped unless
      TEST_GIT_GETTEXT_EXHAUSTIVE=3D1 is set.

    - fantasy-locale / real-locale filenames now make sense with
      respect to their tests.

    - Use `! test' instead of `test_expect_failure test`

    - Use the `>foo' redirection style instead of `> foo'.

  * Don't use `. gettext.sh' but `type gettext.sh && . gettext.sh'.

    The former failed on dash and Solaris's ksh.

  * Now compatible with the SunOS gettext implmentation, this needed:

    - #include <locale.h> in gettext.c, which is a good idea
       anyway. GNU libintl.h included it indirectly.

    - Define a Shell fallback that uses gettext(1). SunOS doesn't have
      gettext.sh, but it has a gettext command that shellscipts should
      use. It also needed a custom eval_gettext() wrapper.

    - Updating of INSTALL and Makefile docs to mention this.

  * The Perl tests can now be run with TEST_GIT_GETTEXT_EXHAUSTIVE=3D1
    through the t0202-gettext-perl.sh wrapper. The original patch
    didn't set GIT_TEXTDOMAINDIR, and I always ran the test.pl script
    manually.

  * Updated commit messages to reflect the changes above, and fixed a
    typo or two.

The changes since v1 in diff -w --stat format:

 INSTALL                      |   10 ++++--
 Makefile                     |    4 +-
 gettext.c                    |    1 +
 git-sh-i18n.sh               |   36 ++++++++++++++++++----
 t/t0200-gettext.sh           |   68 ++++++++++++++++++++++++----------=
-------
 t/t0201-gettext-fallbacks.sh |   10 +++++-
 t/t0202-gettext-perl.sh      |    3 ++
 t/t0202/test.pl              |    4 +-
 8 files changed, 94 insertions(+), 42 deletions(-)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                   |    2 +
 INSTALL                      |    8 ++
 Makefile                     |   69 +++++++++++++++++-
 config.mak.in                |    2 +
 configure.ac                 |   12 +++
 daemon.c                     |    3 +
 fast-import.c                |    3 +
 gettext.c                    |   22 ++++++
 gettext.h                    |   18 +++++
 git-pull.sh                  |   16 ++--
 git-send-email.perl          |    3 +-
 git-sh-i18n.sh               |   71 ++++++++++++++++++
 git.c                        |    3 +
 http-backend.c               |    3 +
 http-fetch.c                 |    3 +
 http-push.c                  |    3 +
 imap-send.c                  |    3 +
 perl/Git/I18N.pm             |   91 +++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 +++-
 po/.gitignore                |    1 +
 po/is.po                     |   70 ++++++++++++++++++
 shell.c                      |    3 +
 show-index.c                 |    3 +
 t/t0200-gettext.sh           |  166 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   13 +++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   50 +++++++++++++
 t/t0202-gettext-perl.sh      |   23 ++++++
 t/t0202/test.pl              |  104 ++++++++++++++++++++++++++
 t/test-lib.sh                |    2 +
 upload-pack.c                |    3 +
 wt-status.c                  |  107 ++++++++++++++-------------
 34 files changed, 860 insertions(+), 65 deletions(-)
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
