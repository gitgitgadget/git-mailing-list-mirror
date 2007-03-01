From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/8] Add contrib/stg-fold-files-from: pick selected changes
	from a patch above current one
Date: Fri, 02 Mar 2007 00:03:50 +0100
Message-ID: <20070301230350.32459.10496.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuJr-00041v-DF
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbXCAXEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbXCAXEB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:04:01 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49838 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161208AbXCAXEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:04:00 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 40B213887;
	Fri,  2 Mar 2007 00:03:59 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3EDE91F084;
	Fri,  2 Mar 2007 00:03:50 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41145>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-fold-files-from |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-fold-files-from b/contrib/stg-fold-files-from
new file mode 100755
index 0000000..bfb4a1f
--- /dev/null
+++ b/contrib/stg-fold-files-from
@@ -0,0 +1,31 @@
+#!/bin/sh
+set -e
+
+# stg-fold-files-from - picks changes to one file from another patch.
+# Only supports picking from one file, but allows to select any range
+# of hunks from the file, using the -# flag to filterdiff.
+# Use together with "filterdiff --annotate" in your diff pager, to
+# identify hunk numbers easily.
+
+# usage: stg-fold-files-from <patch> [-#<n>[-<n>][,<n>]...] <file>
+
+# Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+PATCH="$1"
+shift
+
+filtercmd=cat
+hunks=
+foldflags=
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+	-\#*) hunks="$1"; shift ;;
+	-t) foldflags="-t"; shift ;;
+	-*) { echo >&2 "unknown flag '$1'"; exit 1; } ;;
+	*) break ;;
+    esac
+done
+[ "$#" = 1 ] || { echo >&2 "supports one file only"; exit 1; }
+
+stg show "$PATCH" | filterdiff -p1 $hunks -i "$1" | stg fold $foldflags
