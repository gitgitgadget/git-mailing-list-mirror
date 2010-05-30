From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 0/6] Add internationalization support to Git
Date: Sun, 30 May 2010 20:54:11 +0000
Message-ID: <1275252857-21593-1-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 22:54:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIpX0-0007aX-TX
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab0E3Uyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 16:54:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64466 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab0E3Uyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:54:43 -0400
Received: by fxm10 with SMTP id 10so1964029fxm.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LGDf8fqaOIgsIULg4rmZ/hQn4Xv7DqdY512xOo+4UvI=;
        b=GgYJ3v6J2M0Cu/rZrQwQV2OgOizq9mhMu1mMD2LMJLjqV9wQFk+sKtrvwVSKTa4YUU
         v/KNyYJ/xks40B3ksNo+ujj83fWIlggIw4icqgdONkKYp7x5xdT7GQdmQUcU+dS1JhPI
         qH/onErrrEwj/Cf3Hynk3DNPzjTM4Szacyi1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H0drsU9EAcd8lMWFuggzXpW+owq/8FrOsjZ0rjQUrAdMq3uVG4U2MLi54mDDw3B3NH
         XsozIOJidZHxANjGLo2CDx2kgGLUMD/K2Wb8DJXU1HRd23bma0RfpQAZM9pGiaMcSP87
         zCzw8/dp2vBF5b0YVyfT8ph806VDypHa7bUtc=
Received: by 10.223.65.73 with SMTP id h9mr4279697fai.75.1275252881806;
        Sun, 30 May 2010 13:54:41 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r12sm33459492fah.8.2010.05.30.13.54.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 13:54:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.gde05d
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148018>

Here's version 2 of the patch series begun by Jeff Epler to make Git
optionally translatable with GNU gettext.

Due to an error of mine only the cover letter of the previous series
had "PATCH/RFC" in the subject line. That's rectified in this series.

Aside from making sure the test suite always runs under LC_ALL=3DC,
sanity tests for the translations, "how to translate" documentation,
and the Perl Makefile issue noted below, this series is pretty much
ready for inclusion in my opinion. Perl support was the last missing
piece for translating all of the core C+Shell+Perl code.

New stuff:

  * Perl scripts are now translatable through the Gettext
    facility. Like the shellscript facility I added this has a
    graceful fallback if the prerequisite libraries aren't installed.

    I'm using the libintl-perl library which provides
    Locale::Messages. I could also have used liblocale-gettext-perl
    which provides Locale::gettext. Debian seems to prefer the latter,
    but the former is recomended by GNU. The new Git::Gettext library
    could probably be modified to try both.

    It works 100% for me. Aside from this bit:
   =20
    	# TODO: How do I make the sed replacements in the top level
    	# Makefile reach me here?
    	#our $TEXTDOMAINDIR =3D q|@@LOCALEDIR@@|;
    	our $TEXTDOMAINDIR =3D q</usr/local/share/locale>;

    I couldn't figure out how to make the sed substitution the core
    /Makefile does for e.g. @@GIT_VERSION@@ work for the hybrid
    Makefile / perl.mak setup in perl/.

    Suggestions from contributors more familiar with Git's build
    system welcome.

  * Another thing to note regarding Perl. We have some Perl code
    that's obviously intended to work with perls as old as 5.6. It
    would be preferable to translation support if the minimum were
    bumped to 5.8. Here's why:

        $ perl -e 'printf "%2\$s the %1\$s has\n", ("Clone War", "Begun=
")'
        Begun the Clone War has

    Perl 5.6's printf doesn't support that printf syntax, which means
    that translators would have to make do with the word order of the
    English messages.

    I haven't seen any documentation about Perl coding guidelines or
    Perl versions that we aim to support in Documentation/, so I don't
    know if 5.6 is supposed to be supported or whether the support is
    just incidental.

    Note that this 5.8 could only be a requirement if the user was
    using a translation with positional printf formats. Users
    interested in running the English-only version could still do so
    on 5.6.

  * Updated is.po. It now contains example translations for C, Shell
    and Perl programs as a proof of concept.

  * Rewrote the commit message of the shell script support commit to
    use use the gettext: prefix.
   =20
Jeff Epler (1):
  Add infrastructure for translating Git with gettext

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  gitignore: Ignore files generated by gettext
  Makefile: Remove Gettext files on make clean
  gettext: Add a Gettext interface for shell scripts
  gettext: Add a Gettext interface for Perl
  gettext: Add a skeleton po/is.po

 .gitignore          |    1 +
 Makefile            |   37 +++++++-
 gettext.c           |   17 +++
 gettext.h           |   15 +++
 git-pull.sh         |   15 ++--
 git-send-email.perl |    3 +-
 git-sh-setup.sh     |   33 ++++++
 git.c               |    3 +
 perl/Git/Gettext.pm |   83 +++++++++++++++
 perl/Makefile.PL    |    5 +-
 po/.gitignore       |    1 +
 po/is.po            |  282 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 wt-status.c         |  129 ++++++++++++------------
 13 files changed, 550 insertions(+), 74 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 perl/Git/Gettext.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
