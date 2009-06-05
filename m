From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 7/8] Makefile: introduce SANE_TOOL_PATH for prepending required elements to PATH
Date: Fri,  5 Jun 2009 18:36:15 -0500
Message-ID: <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHMfucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCixr-0002dR-DP
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbZFEXgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZFEXgf
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:36:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51663 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbZFEXge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:36:34 -0400
Received: by mail.nrlssc.navy.mil id n55NaS17019262; Fri, 5 Jun 2009 18:36:30 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:28.0567 (UTC) FILETIME=[72D0AA70:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120842>

From: Junio C Hamano <gitster@pobox.com>

Some platforms (like SunOS and family) have kept their common binaries at
some historical moment in time, and introduced new binaries with modern
features in a special location like /usr/xpg4/bin or /usr/ucb.  Some of the
features provided by these modern binaries are expected and required by git.
If the featureful binaries are not in the users path, then git could end up
using the less featureful binary and fail.

So provide a mechanism to prepend elements to the users PATH at runtime so
the modern binaries will be found.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile        |   14 ++++++++++++++
 git-sh-setup.sh |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1239a3c..ca09572 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,11 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
+#
+# Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
+# to PATH if your tools in /usr/bin are broken.
+#
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
@@ -710,6 +715,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
+	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
@@ -881,6 +887,13 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifdef SANE_TOOL_PATH
+BROKEN_PATH_FIX = s|^. @@PATH@@|PATH=$(SANE_TOOL_PATH)|
+PATH := $(SANE_TOOL_PATH):${PATH}
+else
+BROKEN_PATH_FIX = d
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -1291,6 +1304,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e '/^# @@PATH@@/$(BROKEN_PATH_FIX)' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8382339..7802581 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,6 +11,8 @@
 # exporting it.
 unset CDPATH
 
+# @@PATH@@:$PATH
+
 die() {
 	echo >&2 "$@"
 	exit 1
-- 
1.6.3.1.24.g152f4
