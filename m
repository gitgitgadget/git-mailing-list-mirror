From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v6 0/2] Add infrastructure for translating Git with gettext
Date: Thu,  3 Jun 2010 21:10:09 +0000
Message-ID: <1275599411-14413-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 23:12:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKHho-00039r-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 23:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab0FCVLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 17:11:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:45930 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab0FCVLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 17:11:55 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2323425fgb.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=TX/+pVtQHkrP4oRdadR9bKqaCYUBooh2DDCYkoQphvE=;
        b=vWKQvA9WZR5+829d1hY6vJcIpqkfdWOSqXCU/jlmPufPzlakiS6sYU/TrLoIsoQmhT
         SHTdivPhei1Qgs+J7JdFH16ldhUrY5OniRuZ2/Ip/69aG51O7U29ZmfJLIfWBkOAnDjv
         RHvMtODmTPobe/RSnEnkhTZD95rKGF0tH3VmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=YvfmUFIIWP6uVAHHx/KRVWWmzp+YufsSTaFd4SXQcW2o1UR/X0W6TxERuz9vY2dX5n
         Akn+QzDQOtSrTE1XRPGiFSSllueiq+ksd/Q7+FoWaxxXcCvZ+l3IA6Y/EmHBIVEcOa4l
         5AnY6+iYnG+sEsCxaO+3WBcLePQ3jrcTzKVHw=
Received: by 10.103.64.18 with SMTP id r18mr2752875muk.2.1275599513265;
        Thu, 03 Jun 2010 14:11:53 -0700 (PDT)
Received: from aoeu.localdomain (pD9534BE8.dip.t-dialin.net [217.83.75.232])
        by mx.google.com with ESMTPS id e9sm675707muf.10.2010.06.03.14.11.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 14:11:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.g64631
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148363>

This is version 6 of the patch series to make Git optionally
translatable with GNU gettext.

I had some time on the train so I polished it up since v5. Changes
since then:

  * Add a blurb to INSTALL about GNU libintl being a default
    requirement for building Git.

  * There's now a Test::More test for Git::I18N. That module now has
    complete test coverage.

  * git-sh-i18n.sh now has source code comments how to use it, and
    pointer to the GNU gettext manual for more.

  * Eliminate the use of a wrapper function in the Perl library in
    favor of a symbol table alias.

  * I tested the new Perl code I wrote on perl 5.6.2, it works.

  * The tests now run successfully when Git isn't built with Perl
    support, or when the system doesn't support the locales we're
    trying to test.

  * Improve the new tests by using variables defined in test-lib.sh to
    find out where the git root/po dir is instead of my own
    replacements.

  * Make the tests easier to read by reducing redundancy and using
    e.g. "test_expect_failure grep" instead of calling test_cmp on the
    results of two grep invocations.

  * Add new xgettext translator comment extraction tests.

  * Moved t/t0200-gettext/* tests to t/t0200/*. This follows the
    convention of other tests that have their own subdirs in t/.

  * Add a small (one-line) copyright notice to git-sh-i18n.sh and
    Git::I18N.

Here's the difference between v5 and v6 in git diff --stat -M format:
   =20
     INSTALL                                            |    8 ++
     Makefile                                           |    6 +-
     git-sh-i18n.sh                                     |   18 +++-
     perl/Git/I18N.pm                                   |   28 ++++--
     po/is.po                                           |    2 -
     t/t0200-gettext.sh                                 |   52 ++++----=
--
     t/{t0200-gettext =3D> t0200}/test.c                  |    0
     t/{t0200-gettext =3D> t0200}/test.perl               |    3 +
     t/{t0200-gettext =3D> t0200}/test.sh                 |    0
     ...ell-fallbacks.sh =3D> t0201-gettext-fallbacks.sh} |   12 ++-
     t/t0202-gettext-perl.sh                            |   20 ++++
     t/t0202/test.pl                                    |  104 ++++++++=
++++++++++++
     12 files changed, 203 insertions(+), 50 deletions(-)
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                   |    2 +
 INSTALL                      |    8 +++
 Makefile                     |   44 +++++++++++++-
 config.mak.in                |    1 +
 configure.ac                 |    6 ++
 gettext.c                    |   25 ++++++++
 gettext.h                    |   13 ++++
 git-pull.sh                  |   16 +++--
 git-send-email.perl          |    3 +-
 git-sh-i18n.sh               |   47 ++++++++++++++
 git.c                        |    3 +
 perl/Git/I18N.pm             |   91 ++++++++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 ++++-
 po/.gitignore                |    1 +
 po/is.po                     |   69 +++++++++++++++++++++
 t/t0200-gettext.sh           |  136 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   10 +++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   42 +++++++++++++
 t/t0202-gettext-perl.sh      |   20 ++++++
 t/t0202/test.pl              |  104 ++++++++++++++++++++++++++++++++
 t/test-lib.sh                |    1 +
 wt-status.c                  |  107 +++++++++++++++++----------------
 25 files changed, 729 insertions(+), 65 deletions(-)
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
