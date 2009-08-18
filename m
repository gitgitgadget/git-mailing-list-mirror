From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH] stash: accept options also when subcommand 'save' is omitted
Date: Tue, 18 Aug 2009 14:46:07 +0200
Message-ID: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 14:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdO7x-0004AK-9r
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 14:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862AbZHRMtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 08:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758848AbZHRMtQ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 08:49:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:63785 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758810AbZHRMtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 08:49:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7IClmcp015511
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 14:47:48 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdO4t-0007lw-6I; Tue, 18 Aug 2009 14:46:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdO4t-0008BS-53; Tue, 18 Aug 2009 14:46:15 +0200
X-Mailer: git-send-email 1.6.4.173.g0591
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Aug 2009 14:47:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126388>

This allows in particular 'git stash --keep-index' which is shorter than
'git stash save --keep-index', and not ambiguous.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Does this sound right?

I'm so used to 'git stash' (without saying 'save') that I keep typing
'git stash --keep-index', and get a usage string as an error message.

 Documentation/git-stash.txt |    2 +-
 git-stash.sh                |    8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2f5ca7b..6f251e7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--keep-index] [-q|--quiet] [<message>]]
+'git stash' [save] [--keep-index] [-q|--quiet] [<message>]
 'git stash' clear
 'git stash' create
 
diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..2599410 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save] [--keep-index] [-q|--quiet] [<message>]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -302,6 +302,12 @@ apply_to_branch () {
 	drop_stash $stash
 }
 
+case "$1" in
+    -*)
+	set "save" "$@"
+	;;
+esac
+
 # Main command set
 case "$1" in
 list)
-- 
1.6.4.173.g0591
