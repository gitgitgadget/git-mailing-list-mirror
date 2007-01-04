From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/5] Add contrib/stg-fold-files-from: pick selected changes from a patch above current one
Date: Fri, 05 Jan 2007 00:46:53 +0100
Message-ID: <20070104234653.13580.65088.stgit@gandelf.nowhere.earth>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2cJk-0004Jk-B8
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbXADXsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbXADXsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:48:09 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:50441 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030291AbXADXsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:48:08 -0500
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 38B3274744A
	for <git@vger.kernel.org>; Fri,  5 Jan 2007 00:48:07 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0B8C99B5EA;
	Fri,  5 Jan 2007 00:47:06 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H2cIZ-0001l9-20; Fri, 05 Jan 2007 00:47:03 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35965>




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
