From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix naming scheme for configure cache variables.
Date: Mon, 19 Jan 2009 21:34:36 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090119203436.GB3539@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 21:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP0qq-00073y-8x
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 21:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbZASUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbZASUek
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 15:34:40 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:59679 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbZASUej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 15:34:39 -0500
Received: from localhost.localdomain (xdsl-87-78-65-140.netcologne.de [87.78.65.140])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 00B6E400038B9
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 21:34:37 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1LP0pQ-00024I-ME
	for git@vger.kernel.org; Mon, 19 Jan 2009 21:34:36 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106389>

In order to be cached, configure variables need to contain the
string '_cv_', and they should begin with a package-specific
prefix in order to avoid interfering with third-party macros.
Rename ld_dashr, ld_wl_rpath, ld_rpath to git_cv_ld_dashr etc.
---

This avoids a warning with newer autoconf versions about the naming of
the cache variables, and makes the caching work for them.

As to the 'git_' prefix, it could be argued that the other cache
variables used in configure.ac should also be renamed s/ac_/git_/
If you like, I can provide a patch for those, too.

Thanks,
Ralf

 configure.ac |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0a5fc8c..363547c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -114,31 +114,31 @@ AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
 # which switch to pass runtime path to dynamic libraries to the linker
-AC_CACHE_CHECK([if linker supports -R], ld_dashr, [
+AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
    SAVE_LDFLAGS="${LDFLAGS}"
    LDFLAGS="${SAVE_LDFLAGS} -R /"
-   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_dashr=yes], [ld_dashr=no])
+   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
    LDFLAGS="${SAVE_LDFLAGS}"
 ])
-if test "$ld_dashr" = "yes"; then
+if test "$git_cv_ld_dashr" = "yes"; then
    AC_SUBST(CC_LD_DYNPATH, [-R])
 else
-   AC_CACHE_CHECK([if linker supports -Wl,-rpath,], ld_wl_rpath, [
+   AC_CACHE_CHECK([if linker supports -Wl,-rpath,], git_cv_ld_wl_rpath, [
       SAVE_LDFLAGS="${LDFLAGS}"
       LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
-      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_wl_rpath=yes], [ld_wl_rpath=no])
+      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_wl_rpath=yes], [git_cv_ld_wl_rpath=no])
       LDFLAGS="${SAVE_LDFLAGS}"
    ])
-   if test "$ld_wl_rpath" = "yes"; then
+   if test "$git_cv_ld_wl_rpath" = "yes"; then
       AC_SUBST(CC_LD_DYNPATH, [-Wl,-rpath,])
    else
-      AC_CACHE_CHECK([if linker supports -rpath], ld_rpath, [
+      AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
          SAVE_LDFLAGS="${LDFLAGS}"
          LDFLAGS="${SAVE_LDFLAGS} -rpath /"
-         AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_rpath=yes], [ld_rpath=no])
+         AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_rpath=yes], [git_cv_ld_rpath=no])
          LDFLAGS="${SAVE_LDFLAGS}"
       ])
-      if test "$ld_rpath" = "yes"; then
+      if test "$git_cv_ld_rpath" = "yes"; then
          AC_SUBST(CC_LD_DYNPATH, [-rpath])
       else
          AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
-- 
1.6.1.137.g3d9e8
