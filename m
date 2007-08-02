From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 3/6] Add -O flag to stg-fold-files-from.
Date: Thu, 02 Aug 2007 22:18:26 +0200
Message-ID: <20070802201826.16614.19867.stgit@gandelf.nowhere.earth>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh9M-0007HH-62
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759938AbXHBUTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759931AbXHBUTb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55100 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759407AbXHBUTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:30 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A7A358B3A;
	Thu,  2 Aug 2007 22:19:29 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 956618658;
	Thu,  2 Aug 2007 22:19:29 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4EAEB1F06F;
	Thu,  2 Aug 2007 22:18:26 +0200 (CEST)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54595>

From: Yann Dirson <yann.dirson@sagem.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-fold-files-from |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/stg-fold-files-from b/contrib/stg-fold-files-from
index 53d3d02..806a157 100755
--- a/contrib/stg-fold-files-from
+++ b/contrib/stg-fold-files-from
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 set -e
 
 # stg-fold-files-from - picks changes to one file from another patch.
@@ -6,8 +6,9 @@ set -e
 # of hunks from the file, using the -# flag to filterdiff.
 # Use together with "filterdiff --annotate" in your diff pager, to
 # identify hunk numbers easily.
+# Use "-O -U<n>" to get finer hunk granularity for -#<n>.
 
-# usage: stg-fold-files-from <patch> [-#<n>[-<n>][,<n>]...] <file-pattern>
+# usage: stg-fold-files-from <patch> [-O <stg-show-flags>] [-#<n>[-<n>][,<n>]...] <file-pattern>
 
 # Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
@@ -18,14 +19,17 @@ shift
 filtercmd=cat
 hunks=
 foldflags=
+showflags=()
 while [ "$#" -gt 0 ]; do
     case "$1" in
-	-\#*) hunks="$1"; shift ;;
-	-t) foldflags="-t"; shift ;;
+	-\#*) hunks="$1" ;;
+	-t) foldflags="-t" ;;
+	-O) showflags+=(-O "$2"); shift ;;
 	-*) { echo >&2 "unknown flag '$1'"; exit 1; } ;;
 	*) break ;;
     esac
+    shift
 done
 [ "$#" = 1 ] || { echo >&2 "supports one file only"; exit 1; }
 
-stg show "$PATCH" | filterdiff -p1 $hunks -i "$1" | stg fold $foldflags
+stg show "${showflags[@]}" "$PATCH" | filterdiff -p1 $hunks -i "$1" | stg fold $foldflags
