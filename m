From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 0/5] Add internationalization support to Git
Date: Sat, 29 May 2010 22:45:20 +0000
Message-ID: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 00:46:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIUnJ-0006Bn-3b
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab0E2Wpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 18:45:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61205 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668Ab0E2Wps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 18:45:48 -0400
Received: by fxm10 with SMTP id 10so1533810fxm.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MXsT4S1EoZtOsnZVqIQqwKFAlVwCttgz8yMABSM94Z4=;
        b=a2NzD198PwViwPkZLl1w8aQup77VRybYwANiEXPxNYLCumw6fE2okQleBw/GyUr6Oy
         zcfgHtO5djnTaEHecRx8NYfaCQH+D79M8lmDVOb9HgbYDlyRrHSQOrh8AzGVxPkrOsLr
         thkcMaoT8ErUDLa+k8Msg2rmjJKOa8jOPieos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=fNLK8ymBpbAeYVjB+rMBN/GirDgyQcpbX/7u18Ju2gDUoMBPUMasJcFozz6KDtYA74
         BQ9qtAlWkskNPAfJxYmFkQvQpbefJJF3UcBezUbgwzWwcjkAWAaVAsWrYLb3pPY2u8I8
         mKAOVuVDXlHhVLR3PlJqZV3GNY2LYZTBiJg/g=
Received: by 10.223.98.5 with SMTP id o5mr2753312fan.64.1275173146443;
        Sat, 29 May 2010 15:45:46 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm24351890faj.17.2010.05.29.15.45.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 15:45:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.ge2b63.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147973>

Here's an updated version of the patch series begun by Jeff Epler to
make Git optionally translatable with GNU gettext. I'm submitting it
now because I'd like to get some comments on the approach, and
specifically whether something like this is likely to be accepted into
Git.

Changes since the initial submission:

  * Merged in changes to wt-status.c from the master branch

  * Made Gettext play nice with the build system (.gitignore & make
    clean)

  * Added support for making Git's shell scripts translatable by
    importing the gettext functions in git-sh-setup.sh, or supplying
    replacements if they don't work. Comments from shellscript-savy
    list members about whether the fallbacks work on odd non-GNU
    shells are especially welcome.

    I made three strings in git-pull.sh translatable as a proof of
    concept. One problem that I ran into is that xgettext(1) seems
    very particular when picking up translation strings. It accepts
    this:

        gettext "hello world"; echo

    but not this:

        die gettext "hello world"; die

    or this:

        gettext <<"END";
hello world
END

    Maybe there's a way to make it play nice. But I just used a large
    multiline string as a workaround. I don't know what to do about
    'die gettext' other than define a 'die_gettext' wrapper function
    and use `xgettext --keyword=3Ddie_gettext'.

  * There's now a skeleton is.po file. It just has one string
    translated. I can't figure out what to call any of the Git core
    concepts so I'm stuck :)

Next up:

  * Perl support. I haven't yet found what the best way of using
    libintl from Perl would be. GNU recommends Locale::TextDomain, but
    Debian only seems to have Locale::gettext which is a more
    lightweight wrapper.

    In any case I can write a wrapper for those/the shell command and
    fall back on the hardcoded strings like the C/Shell code does.

Most importantly. If there are any interested list members that want
to translate Git, it's now ready for translators. You just have to add
a po/$lang.po file with your favorite editor and Git's build system
will install it.

One thing I haven't done is to try to go ahead and make massive
changes to the Git source code to make everything translatable. Due to
their nature it's a big headache to maintain changes like that if
anything moves upstream.

Of course that's subject to change if other people are interested in
contributing.

=46or reference, here's the branch on GitHub I'm hacking this in,
patches welcome:

    http://github.com/avar/git/compare/master...topic/git-gettext

Jeff Epler (1):
  Add infrastructure for translating Git with gettext

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  gitignore: Ignore files generated by gettext
  Makefile: Remove Gettext files on make clean
  gettext: Add a skeleton po/is.po
  Add infrastructure to make shellscripts translatable

 .gitignore      |    1 +
 Makefile        |   35 +++++++-
 gettext.c       |   17 ++++
 gettext.h       |   15 +++
 git-pull.sh     |   15 ++--
 git-sh-setup.sh |   33 +++++++
 git.c           |    3 +
 po/.gitignore   |    1 +
 po/is.po        |  288 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 wt-status.c     |  129 +++++++++++++------------
 10 files changed, 465 insertions(+), 72 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
