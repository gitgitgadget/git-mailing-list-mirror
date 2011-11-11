From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH] i18n back from the dead
Date: Fri, 11 Nov 2011 01:09:22 +0100
Message-ID: <1320970164-31694-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 01:09:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROegu-0001io-EI
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 01:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab1KKAJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 19:09:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41316 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1KKAJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 19:09:50 -0500
Received: by fagn18 with SMTP id n18so1191204fag.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=22r3qI2/dvvrTu6Jv/lDoO5Frct08vYOqs9n+4+xF2o=;
        b=XKWxoFecJl4lluOMYkA7YtTNgD1uoF8FGSS9f1N/3rE5Jd/7Lmqo95f9CT6nBQ3MHh
         l88npVRO16ukQkXqNogccieK/S2ISoLbyCydaRpHUakaMQQ31lfYlm1BdUnSGwMnHJPv
         QVGRXzPI6xC3qDDzq2MAW9L0AF9NuoJllbH3s=
Received: by 10.223.61.131 with SMTP id t3mr15205428fah.26.1320970189589;
        Thu, 10 Nov 2011 16:09:49 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.136])
        by mx.google.com with ESMTPS id k26sm13296917fab.8.2011.11.10.16.09.47
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 16:09:48 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185247>

Or, a patch so huge it needs it own cover letter.

After looking at my dormant i18n series I found that it was spread out
over so many pieces that even I didn't understand it anymore.

So here's an attempt to fix that. I've squashed everything we'll need
to get i18n working in Git down to one patch. Much of the previous
complexity came about because I was adding little things to it
incrementally, and I kept carrying around commits that were
effectively bugfixes on top of the original code.

Now it's all in one big patch, and while the diffstat looks scary at
first a lot of it is tests, documentation and a giant comment.

It's an RFC because there are bound to be bugs in there that I haven't
spotted, and po/README is out of date, I haven't updated it for some
of the new C and Shell functions we now have.

But it seems to function just fine. I've tested it on two Linux boxes
and a Solaris box and it works as intended, but review and testing on
other platforms would be most welcome.

This is all we need to start using PO files that are dropped in po/,
which I don't think is all that shabby for 1300 lines changed.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  i18n: add infrastructure for translating Git with gettext

 .gitignore                          |    1 +
 Documentation/CodingGuidelines      |    7 +
 INSTALL                             |   12 ++
 Makefile                            |   81 +++++++++++++-
 config.mak.in                       |    3 +
 configure.ac                        |   19 +++
 daemon.c                            |    2 +
 fast-import.c                       |    2 +
 gettext.c                           |  116 +++++++++++++++++++
 gettext.h                           |   25 ++++-
 git-sh-i18n.sh                      |  100 ++++++++++++-----
 git.c                               |    2 +
 http-backend.c                      |    2 +
 http-fetch.c                        |    2 +
 http-push.c                         |    2 +
 imap-send.c                         |    2 +
 perl/Git/I18N.pm                    |   89 +++++++++++++++
 perl/Makefile                       |    3 +-
 perl/Makefile.PL                    |   14 ++-
 po/README                           |  209 +++++++++++++++++++++++++++=
++++++++
 po/is.po                            |   93 ++++++++++++++++
 shell.c                             |    1 +
 show-index.c                        |    2 +
 t/lib-gettext.sh                    |   55 +++++++++
 t/t0200-gettext-basic.sh            |  108 ++++++++++++++++++
 t/t0200/test.c                      |   23 ++++
 t/t0200/test.perl                   |   14 +++
 t/t0200/test.sh                     |   14 +++
 t/t0201-gettext-fallbacks.sh        |   20 +++-
 t/t0202-gettext-perl.sh             |   27 +++++
 t/t0202/test.pl                     |  110 ++++++++++++++++++
 t/t0203-gettext-setlocale-sanity.sh |   26 +++++
 t/t0204-gettext-reencode-sanity.sh  |   78 +++++++++++++
 t/t0205-gettext-poison.sh           |   36 ++++++
 t/test-lib.sh                       |    3 +
 upload-pack.c                       |    2 +
 wrap-for-bin.sh                     |    3 +-
 37 files changed, 1269 insertions(+), 39 deletions(-)
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/README
 create mode 100644 po/is.po
 create mode 100644 t/lib-gettext.sh
 create mode 100755 t/t0200-gettext-basic.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
 create mode 100755 t/t0203-gettext-setlocale-sanity.sh
 create mode 100755 t/t0204-gettext-reencode-sanity.sh
 create mode 100755 t/t0205-gettext-poison.sh

--=20
1.7.6.3
