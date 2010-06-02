From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v5 0/2] Add infrastructure for translating Git with gettext
Date: Wed,  2 Jun 2010 22:33:11 +0000
Message-ID: <1275517993-23093-1-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 00:34:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJwVr-00076U-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 00:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837Ab0FBWeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 18:34:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55745 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758103Ab0FBWeI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 18:34:08 -0400
Received: by fxm8 with SMTP id 8so2317385fxm.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=tRdPiHSXzY9spNW/tp1iKwBLqArrlWWHuE82g+yBYo4=;
        b=ClFQ+XmblVTP9PUPUfCw6CufZhB2R/WolT6mN2MGvUfgsHuCFmL5VHQAgMKwq7mNah
         Nt4rUp0zScUFOkuTcFkYh6Afws3dV2xtjklqZb+FvWqrv58BJKNSACaqUrztgebQibmt
         LnXHqAItH1nUzzzTzvhHD9COGgy9GeFKRl/ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LHhhLMcqX9ENEFfzs2j0vnhkJhPWbjCLUma+an8WtC3vAV2NfeQWcOD+L6WwurE95c
         Gg2TgFNhvM3L/GU+nonZD+eXiE4tuTIp5A00bllfvYP2hIrOnhf4Q4SWcIkWbXsz+CiW
         VFZQo+3nOITQfdUjb73dzpKC0/XX76hJpeBl8=
Received: by 10.223.18.67 with SMTP id v3mr9310906faa.93.1275518044487;
        Wed, 02 Jun 2010 15:34:04 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r12sm54317663fah.20.2010.06.02.15.34.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 15:34:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.g290e3.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148273>

This is version 5 of the patch series to make Git optionally
translatable with GNU gettext.

I split and squashed the whole thing down into just two patches. The
first commit adds all the needed core infrastructure, and the second
commit contains an initial stab at starting translation for the core
tools, along with some tests that could be added as a result.

The changes this time around are:

  * Testing testing & more testing. Including testing for xgettext
    message extraction, that .po files are generated correctly etc.

  * There's now a git-sh-i18n library for the shell, so gettext.sh
    isn't loaded as part of git-sh-setup.

  * Shell portability fixes suggested by Johannes Sixt

  * Other misc suggestions and fixes Jakub Narebski, Peter Krefting,
    and Jonathan Nieder pointed out were incorporated.

  * I did not change over to Locale::TextDomain for Perl. I wrote a
    version of Git::I18N in it and found that it was more trouble than
    it was worth

I think (this time around, really) that this series is ready for
inclusion unless some issue is raised that I've missed. But to play
devil's advocate this is what might prevent it from being included.

  * gettext is on by default. I think that's a feature, but Git won't
    build by default on e.g. Solaris unless the packager adds
    NO_GETTEXT=3DYesPlease to the make arguments. Of course if they use
    ./configure it'll detect if libintl.h exists and act
    appropriately.

    I think gettext on by default is a feature, it's equivalent to
    what we do for our other /*/po/ stuff. But pending discussion of
    this I haven't updated e.g. INSTALL. Comments welcome.

  * There isn't documentation on how to use this from a developer and
    maintainer standpoint. And there's no docs for translators.

    Where would the developer/maintainer docs belong? But for most of
    the things such a documentation would include I think other
    existing resources would do fine, e.g. the GNU gettext manual.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                         |    2 +
 Makefile                           |   44 ++++++++++-
 config.mak.in                      |    1 +
 configure.ac                       |    6 ++
 gettext.c                          |   25 ++++++
 gettext.h                          |   13 +++
 git-pull.sh                        |   16 ++--
 git-send-email.perl                |    3 +-
 git-sh-i18n.sh                     |   33 ++++++++
 git.c                              |    3 +
 perl/Git/I18N.pm                   |   77 +++++++++++++++++++
 perl/Makefile                      |    3 +-
 perl/Makefile.PL                   |   14 +++-
 po/.gitignore                      |    1 +
 po/is.po                           |   71 +++++++++++++++++
 t/t0200-gettext.sh                 |  146 ++++++++++++++++++++++++++++=
++++++++
 t/t0200-gettext/test.c             |   10 +++
 t/t0200-gettext/test.perl          |   11 +++
 t/t0200-gettext/test.sh            |   14 ++++
 t/t0201-gettext-shell-fallbacks.sh |   40 ++++++++++
 t/test-lib.sh                      |    1 +
 wt-status.c                        |  107 +++++++++++++-------------
 22 files changed, 576 insertions(+), 65 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
 create mode 100644 t/t0200-gettext/test.c
 create mode 100644 t/t0200-gettext/test.perl
 create mode 100644 t/t0200-gettext/test.sh
 create mode 100755 t/t0201-gettext-shell-fallbacks.sh
