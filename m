From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [PATCH] Makefile: add uninstall target.  Fixes elementary good
 cleaning manners.
Date: Wed, 18 Nov 2009 13:29:49 +0100
Organization: www.AvatarAcademy.nl
Message-ID: <1258547389.25909.101.camel@heerbeest>
References: <1257945756.26362.79.camel@heerbeest>
	 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 13:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAjg0-000482-Fq
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 13:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbZKRM3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 07:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZKRM3w
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 07:29:52 -0500
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:50758 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbZKRM3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 07:29:51 -0500
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 82632121D37;
	Wed, 18 Nov 2009 13:29:54 +0100 (CET)
Received: from [127.0.0.1] (heerbeest [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 19A66DC1AC;
	Wed, 18 Nov 2009 13:29:50 +0100 (CET)
In-Reply-To: <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133165>

Op woensdag 11-11-2009 om 15:08 uur [tijdzone +0100], schreef Tomas
Carnecky:

> > Greetings,
> > Jan.  -- who just finds out the uninstall target is missing?!?
> > 	 See attached.
>=20
> Next time please send patches inline, it's easier to review them that=
 =20
> way.

Sorry.  Let me retry that.  See below.

Greetings,
Jan.

--=20
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesett=
er
Avatar=C2=AE: http://AvatarAcademy.nl    | http://lilypond.org
>From f260a4dcf0b42088eb1da74aee49f49ac4b0c55b Mon Sep 17 00:00:00 2001
=46rom: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Wed, 11 Nov 2009 14:19:00 +0100
Subject: [PATCH] Makefile: add uninstall target.  Fixes elementary good=
 cleaning manners.

   * Modified     Makefile
   * Modified     gitk-git/Makefile
   * Modified     perl/Makefile
   * Modified     templates/Makefile

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 Makefile           |   18 +++++++++++++++++-
 gitk-git/Makefile  |    2 ++
 perl/Makefile      |    2 +-
 templates/Makefile |    5 +++++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5d5976f..135c3ac 100644
--- a/Makefile
+++ b/Makefile
@@ -1781,7 +1781,23 @@ quick-install-man:
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
=20
+bindir_PROGRAMS =3D git$X git-upload-pack$X git-receive-pack$X git-upl=
oad-archive$X git-shell$X git-cvsserver
=20
+uninstall:
+ifndef NO_TCLTK
+	$(MAKE) -C gitk-git uninstall
+	$(MAKE) -C git-gui gitexecdir=3D'$(gitexec_instdir_SQ)' uninstall
+endif
+ifndef NO_PERL
+	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' uni=
nstall
+endif
+	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' uninstall
+	$(RM) $(ALL_PROGRAMS:%=3D'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	$(RM) $(BUILT_INS:%=3D'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	$(RM) $(OTHER_PROGRAMS:%=3D'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	-rmdir -p '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(RM) $(bindir_PROGRAMS:%=3D'$(DESTDIR_SQ)$(bindir_SQ)'/%)
+	-rmdir -p '$(DESTDIR_SQ)$(bindir_SQ)'
=20
 ### Maintainer's dist rules
=20
@@ -1857,7 +1873,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
=20
-.PHONY: all install clean strip
+.PHONY: all install uninstall clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
 .PHONY: .FORCE-GIT-BUILD-OPTIONS
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..d68f19a 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -47,6 +47,8 @@ install:: all
 uninstall::
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(not=
dir $p) &&) true
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	-rmdir -p '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	-rmdir -p '$(DESTDIR_SQ)$(msgsdir_SQ)'
=20
 clean::
 	$(RM) gitk-wish po/*.msg
diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..25fc304 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -10,7 +10,7 @@ ifndef V
 	QUIET =3D @
 endif
=20
-all install instlibdir: $(makfile)
+all install instlibdir uninstall: $(makfile)
 	$(QUIET)$(MAKE) -f $(makfile) $@
=20
 clean:
diff --git a/templates/Makefile b/templates/Makefile
index 408f013..f4048d9 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -51,3 +51,8 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof =
-)
+
+uninstall:
+	-(cd blt && find . -type f) | (cd '$(DESTDIR_SQ)$(template_instdir_SQ=
)' && xargs $(RM))
+	-(cd blt && find . -mindepth 1 -type d) | (cd '$(DESTDIR_SQ)$(templat=
e_instdir_SQ)' && xargs rmdir)
+	-rmdir -p '$(DESTDIR_SQ)$(template_instdir_SQ)'
--=20
1.6.3.3
