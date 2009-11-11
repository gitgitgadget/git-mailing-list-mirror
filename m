From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 14:22:36 +0100
Organization: www.AvatarAcademy.nl
Message-ID: <1257945756.26362.79.camel@heerbeest>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xK3v8gOjVHrvCmiUeIHy"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 14:54:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8DeI-0005eH-Na
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 14:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbZKKNyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 08:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbZKKNyD
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 08:54:03 -0500
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:58667 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZKKNyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 08:54:01 -0500
X-Greylist: delayed 1884 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2009 08:54:01 EST
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id AF86D67E7B;
	Wed, 11 Nov 2009 14:22:41 +0100 (CET)
Received: from [127.0.0.1] (heerbeest [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id F2ACDDC1AC;
	Wed, 11 Nov 2009 14:22:36 +0100 (CET)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132653>


--=-xK3v8gOjVHrvCmiUeIHy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

git pull -r*) URL says:

    If you often merge with the same branch, you may want to
    configure the following variables in your configuration
    file:

        branch.master.remote = <nickname>
        branch.master.merge = <remote-ref>
        remote.<nickname>.url = <url>
        remote.<nickname>.fetch = <refspec>

and after cut-and-pasting that into .git/config, replacing
<foo> with values, I get

    $ git pull -r http://github.com/../../master
    fatal: bad config file line 17 in .git/config

where line 17 is [without any indentation]

    branch.master.remote = eddy

This is with git version version 1.6.3.3

Greetings,
Jan.  -- who just finds out the uninstall target is missing?!?
	 See attached.

*) I've been wondering why GIT lacks a "update", ie
   pull-without-merge command.  You almost never want
   to git pull /without/ -r?

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
Avatar®: http://AvatarAcademy.nl    | http://lilypond.org

--=-xK3v8gOjVHrvCmiUeIHy
Content-Disposition: attachment; filename*0=0001-Makefile-add-uninstall-target.-Fixes-elementary-good.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Makefile-add-uninstall-target.-Fixes-elementary-good.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 5b5107e2887b11cab3a391bd550d30c7df68242f Mon Sep 17 00:00:00 2001
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Wed, 11 Nov 2009 14:19:00 +0100
Subject: [PATCH] Makefile: add uninstall target.  Fixes elementary good cleaning manners.

   * Modified     Makefile
   * Modified     gitk-git/Makefile
   * Modified     perl/Makefile
   * Modified     templates/Makefile
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
 
+bindir_PROGRAMS = git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver
 
+uninstall:
+ifndef NO_TCLTK
+	$(MAKE) -C gitk-git uninstall
+	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' uninstall
+endif
+ifndef NO_PERL
+	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' uninstall
+endif
+	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' uninstall
+	$(RM) $(ALL_PROGRAMS:%='$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	$(RM) $(BUILT_INS:%='$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	$(RM) $(OTHER_PROGRAMS:%='$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	-rmdir -p '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(RM) $(bindir_PROGRAMS:%='$(DESTDIR_SQ)$(bindir_SQ)'/%)
+	-rmdir -p '$(DESTDIR_SQ)$(bindir_SQ)'
 
 ### Maintainer's dist rules
 
@@ -1857,7 +1873,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
 
-.PHONY: all install clean strip
+.PHONY: all install uninstall clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
 .PHONY: .FORCE-GIT-BUILD-OPTIONS
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..d68f19a 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -47,6 +47,8 @@ install:: all
 uninstall::
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	-rmdir -p '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	-rmdir -p '$(DESTDIR_SQ)$(msgsdir_SQ)'
 
 clean::
 	$(RM) gitk-wish po/*.msg
diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..25fc304 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -10,7 +10,7 @@ ifndef V
 	QUIET = @
 endif
 
-all install instlibdir: $(makfile)
+all install instlibdir uninstall: $(makfile)
 	$(QUIET)$(MAKE) -f $(makfile) $@
 
 clean:
diff --git a/templates/Makefile b/templates/Makefile
index 408f013..f4048d9 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -51,3 +51,8 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
+
+uninstall:
+	-(cd blt && find . -type f) | (cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && xargs $(RM))
+	-(cd blt && find . -mindepth 1 -type d) | (cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && xargs rmdir)
+	-rmdir -p '$(DESTDIR_SQ)$(template_instdir_SQ)'
-- 
1.6.3.3


--=-xK3v8gOjVHrvCmiUeIHy--
