From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 0/7] Add internationalization support to Git
Date: Tue,  1 Jun 2010 23:39:50 +0000
Message-ID: <1275435597-4017-1-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 01:40:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJb4I-00063r-Qf
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 01:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab0FAXkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 19:40:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33347 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab0FAXkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 19:40:13 -0400
Received: by fxm8 with SMTP id 8so1461027fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=G0j/ch+h/hIsIRu+tl1niQP0NZhJQN1EiBgvKO+0gDw=;
        b=SGUs4iqGnZQ3Ho3bg6JVret/Z13mxa/p1/oeQ0VV56oM+Z5KHic6EguGVww/mRx0cQ
         8jhVtmvwyhKpdnWIHXpDpPVKFttqu8ULkE5lv7ZLXC+pTlK4vWVk99TgqoMqfWTdTRsf
         PfCDbOkzX1tTJOYO2kACmkQpyMskrfZiaWffw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hFSaUTGaH/l2FulV88gyLdGS71T63ZWKOoXKR6YfoUlU53MfiJV2muKYJFOZwxVZaS
         qPL0Ma4SSJCXJlJsZ+SQOHmpdKoHncG0WGqIdwPkeJiRMaMCfUZ2Sm3W7BRLtgODvjG1
         ZMdFVLMdbb3TaWT2xfE0Nlq6svh8qEH2bifmc=
Received: by 10.223.46.135 with SMTP id j7mr7777118faf.105.1275435611435;
        Tue, 01 Jun 2010 16:40:11 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id z12sm49391227fah.9.2010.06.01.16.40.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 16:40:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.248.gb7713.dirty
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148166>

Here's version 3 of the patch series begun by Jeff Epler to make Git
optionally translatable with GNU gettext.

This version contains a lot of fixes to issues pointe out by Jakub
Narebski, and other misc.

Since the last RFC:

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
  gettext: Basic sanity tests for Git's Gettext support
  gettext: Add a skeleton po/is.po

 .gitignore          |    1 +
 Makefile            |   43 ++++++++-
 config.mak.in       |    1 +
 configure.ac        |    6 +
 gettext.c           |   25 +++++
 gettext.h           |   13 +++
 git-pull.sh         |   15 ++--
 git-send-email.perl |    3 +-
 git-sh-setup.sh     |   33 ++++++
 git.c               |    3 +
 perl/Git/I18N.pm    |   73 +++++++++++++
 perl/Makefile       |    3 +-
 perl/Makefile.PL    |   14 +++-
 po/.gitignore       |    1 +
 po/is.po            |  282 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200-gettext.sh  |   28 +++++
 wt-status.c         |  129 ++++++++++++------------
 17 files changed, 597 insertions(+), 76 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
