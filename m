From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 0/7] Add internationalization support to Git
Date: Wed,  2 Jun 2010 01:05:57 +0000
Message-ID: <1275440764-26153-1-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPT-0004eW-8l
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab0FBBGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:06:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab0FBBGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:13 -0400
Received: by fxm8 with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YuEdprNNKJXzuFspSVbBsrfGUBbJZw9FNG7WLGi9Y5c=;
        b=PByASet+bsQnBSPWMYvW6V6wJzu5IulxcyiiyTjQL3w2w1XXktBRUQ9rQgswd09EtQ
         0BfWjW8t4SSTe6JC2g0Rt+P8RXpD0sOZ9/AnV8OBk6jlqqwE4InvmT+/uSvlv6/NSiD2
         wHrIGFDpW6yHTylsHsCS6xRFDideMcrElsD7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H1GJhbzQMlogfb/dHscAHHD5pR5MkSlqh57T7/tWOw4NP0Xtzm0/ibzE/IZ5nHpycJ
         CKkAC1LDTIphZwH0s0CERvjUQRkrUibQgx25i3Hfv9PzT54jXQeuD0u8TIIPet4J2n5O
         hz9Xi+rUfahoUHdicOPhGbfkeaZm62Js4K4B4=
Received: by 10.223.5.13 with SMTP id 13mr7880848fat.68.1275440771218;
        Tue, 01 Jun 2010 18:06:11 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148182>

Here's version 4 of the patch series begun by Jeff Epler to make Git
optionally translatable with GNU gettext.

It's like the version 4 I submitted an ~hour ago, sans the annoying
errors I made and lots of tests:

Changes from v3 to v4:

  * Fix typos and removal of GIT_TEXTDOMAINDIR that I rewrote out with
    some rebase mistakes.

  * Add meaningful testing. The C, Shell and Perl wrappers are now
    tested as part of a new t/t0200-gettext.sh test file. Put under
    the t/t0* namespace because it's a core feature, and using a new
    t02 prefix because there'll probably be a lot of Gettext tests
    down the line.

Changes from v2 to v3:

  * Squashed some infrastructure patches into the initial commit.

  * Added basic sanity testing for the Gettext support

  * .mo files aren't installed on `make install` time if NO_GETTEXT
    was specified during the build.

    In C gettext support isn't compiled in. But this happens
    implicitly in Shell/Perl because the locale files won't be there
    on the system.

  * NO_GETTEXT is now set correctly depending on whether libintl.h
    exists when autoconf is used to build Git. Whether this is the
    best approach to gettext detection with autoconf is being
    discussed in the "[PATCH/RCF] autoconf: Check if <libintl.h>
    exists and set NO_GETTEX" thread.

  * The localedir is now passed to the Perl code via Makefile
    trickery. It's no longer hardcoded to /usr/local/share/locale

  * Add `--keyword=3D` to all xgettext invocations. This way we make
    sure that only our gettext functions are extracted, not the
    defaults xgettext.

  * Git::Gettext is now called Git::I18N

  * Remove LICENSE from I18N.pm. It was a boilerplate that shouldn't
    have been there.

  * Use qw() not qw< > in Perl code.

  * Changed the interface to Git::I18N. Now it exports all its
    functions by default. If something's using the module it's going
    to want to import everything anyway. This makes the issue of '@{
    $EXPORT_TAGS{'all'} }' being ugly syntax moot since it isn't used
    anymore.

    Users can still import selectively by specifying arguments to
    import().

  * The GIT_TEXTDOMAINDIR environment variable can be set to override
    where the C/Perl/Shell locale files are found. This is intended to
    be set by the test suite.

  * The boolean test for whether gettext.sh was successfully loaded
    was inverted (oops!)

Things that haven't changed:

  Jakub pointed out some things that I might want to change that I
  didn't yet. Mostly because I didn't have time yet.

  * Git::I18N still uses Locale::Messages, not Locale::TextDomain.

    I'm still not convinced that the low-level Locale::Messages
    interface isn't a better fit for us. But I didn't get
    Locale::TextDomain working at all today so I'm still using
    Locale::Messages.

  * Perl still uses gettext($), not __($) (see above).

  * use Exporter 'import': Subclassing Exporter instead since we
    apparently need Perl 5.6 compatibility.

Jeff Epler (1):
  Add infrastructure for translating Git with gettext

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
  gettext: Add a Gettext interface for shell scripts
  gettext: Add a Gettext interface for Perl
  Makefile: Don't install Gettext .mo files if NO_GETTEXT
  Makefile: Override --keyword=3D for all languages
  gettext: Sanity tests for Git's Gettext support
  gettext: Add a skeleton po/is.po

 .gitignore          |    1 +
 Makefile            |   43 ++++++++-
 config.mak.in       |    1 +
 configure.ac        |    6 +
 gettext.c           |   25 +++++
 gettext.h           |   13 +++
 git-pull.sh         |   15 ++--
 git-send-email.perl |    3 +-
 git-sh-setup.sh     |   38 +++++++
 git.c               |    3 +
 perl/Git/I18N.pm    |   73 +++++++++++++
 perl/Makefile       |    3 +-
 perl/Makefile.PL    |   14 +++-
 po/.gitignore       |    1 +
 po/is.po            |  282 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200-gettext.sh  |   73 +++++++++++++
 wt-status.c         |  129 ++++++++++++------------
 17 files changed, 647 insertions(+), 76 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
