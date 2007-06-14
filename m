From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [CORRECTED PATCH] Introduce file with the common default build-time items.
Date: Thu, 14 Jun 2007 23:07:39 +0400
Message-ID: <20070614190739.GA3779@void.codelabs.ru>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru> <20070614150929.GA18491@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 21:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyufl-000261-Ij
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 21:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXFNTH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbXFNTH4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 15:07:56 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:50255 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbXFNTHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 15:07:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=ciHx3u1ZVZq7SBmIfr9vuBjO57UY7bdhKFzm8MBFD9A8blDh9fKVNnEne3u3L/geeaVn7pRQM938l/NwVfYfYNYrO0eYyXUj8c+K+klLwLFySECoLuDDlJygtGw6PCxGMyrjfX+tO9jduPeLFnCm5iMFhE8Id7TTDdRFwLscNS4=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HyufY-0000bo-A5; Thu, 14 Jun 2007 23:07:53 +0400
Content-Disposition: inline
In-Reply-To: <20070614150929.GA18491@spearce.org>
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50217>

Shawn,

Thu, Jun 14, 2007 at 11:09:29AM -0400, Shawn O. Pearce wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> No, because Junio has already stated a desire to remove git-gui.git
> from git.git and convert it to a proper subproject by the time of
> Git 1.6.  That means the git-gui/ subdirectory will become optional,
> though I imagine most git-gui users will still have it.  But not
> all Git users are git-gui users.  ;-)

OK, it means that git-gui will be totally separated from the
git.git?  And one will download it as the separate tarball?

> The best we can do is let the user pick their TCL_PATH and
> TCLTK_PATH up in git's own Makefile, and have it pass down into
> git-gui's Makefile when git-gui is being built from within git.
> That is the arrangement we currently have.

OK, fine, thanks for the explanations.  The corrected patch follows.

-----

Words 'wish' and 'tclsh' are scattered across at least three files,
but they are tied to the same entities.  To ease the maintenance
and remove errors, these configuration items were gathered into the
separate file named 'common-make-vars.def'.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Makefile             |   17 +++++++++++------
 common-make-vars.def |   11 +++++++++++
 configure.ac         |    4 +++-
 3 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 common-make-vars.def

diff --git a/Makefile b/Makefile
index 6cd9ea2..e98f16b 100644
--- a/Makefile
+++ b/Makefile
@@ -116,16 +116,21 @@ all::
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
 # used to optimize git-gui for your system.  Only used if NO_TCLTK
-# is not set.  Defaults to the bare 'tclsh'.
+# is not set.  Defaults to the value of the __GIT_DEFAULT_TCLSH_NAME
+# from common-make-vars.def.
 #
-# The TCLTK_PATH variable governs the location of the Tcl/Tk interpreter.
-# If not set it defaults to the bare 'wish'. If it is set to the empty
-# string then NO_TCLTK will be forced (this is used by configure script).
+# The TCLTK_PATH variable governs the location of the Tcl/Tk
+# interpreter.  If not set it defaults to the value of the
+# __GIT_DEFAULT_TCLTK_NAME from common-make-vars.def.  If it is set
+# to the empty string then NO_TCLTK will be forced (this is used
+# by configure script).
 #
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
+# Default values
+-include common-make-vars.def
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
@@ -177,8 +182,8 @@ AR ?= ar
 TAR ?= tar
 INSTALL ?= install
 RPMBUILD ?= rpmbuild
-TCL_PATH ?= tclsh
-TCLTK_PATH ?= wish
+TCL_PATH ?= $(__GIT_DEFAULT_TCLSH_NAME)
+TCLTK_PATH ?= $(__GIT_DEFAULT_TCLTK_NAME)
 
 export TCL_PATH TCLTK_PATH
 
diff --git a/common-make-vars.def b/common-make-vars.def
new file mode 100644
index 0000000..43a3a8b
--- /dev/null
+++ b/common-make-vars.def
@@ -0,0 +1,11 @@
+# This file is meant to be sourced from the autoconf script
+# and included from the Makefile.  It carries the default values
+# to eliminate their redundancy across the files.  The syntax
+# is 'name=value' without extra spaces across the '=' sign to
+# make shell happy.  Symbols '#' are starting comments ;))
+
+# Default Tcl/Tk interpreter name
+__GIT_DEFAULT_TCLTK_NAME=wish
+
+# Default Tcl interpreter name
+__GIT_DEFAULT_TCLSH_NAME=tclsh
diff --git a/configure.ac b/configure.ac
index 50d2b85..fd1d241 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,6 +12,8 @@ config_in=config.mak.in
 
 echo "# ${config_append}.  Generated by configure." > "${config_append}"
 
+## Defaults
+source common-make-vars.def
 
 ## Definitions of macros
 # GIT_CONF_APPEND_LINE(LINE)
@@ -97,7 +99,7 @@ AC_CHECK_PROGS(TAR, [gtar tar])
 if test -z "$NO_TCLTK"; then
   if test "$with_tcltk" = ""; then
   # No Tcl/Tk switches given. Do not check for Tcl/Tk, use bare 'wish'.
-    TCLTK_PATH=wish
+    TCLTK_PATH=${__GIT_DEFAULT_TCLTK_NAME}
     AC_SUBST(TCLTK_PATH)
   elif test "$with_tcltk" = "yes"; then
   # Tcl/Tk check requested.
-- 
1.5.2.1
